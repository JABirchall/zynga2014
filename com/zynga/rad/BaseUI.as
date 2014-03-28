package com.zynga.rad
{
   import flash.display.MovieClip;
   import com.zynga.logging.ILogger;
   import flash.utils.Dictionary;
   import com.zynga.rad.containers.IMutable;
   import com.zynga.rad.tooltips.ITooltip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   import flash.events.Event;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public dynamic class BaseUI extends MovieClip
   {
      
      public function BaseUI() {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         this.m_mcToStopFrame = new Dictionary();
         super();
         stop();
         if(this.hasOwnProperty("minHeight"))
         {
            _loc1_ = this["minHeight"] as MovieClip;
            if(_loc1_)
            {
               removeChild(_loc1_);
               this.m_minHeight = _loc1_.height;
            }
         }
         if(this.hasOwnProperty("minWidth"))
         {
            _loc2_ = this["minWidth"] as MovieClip;
            if(_loc2_)
            {
               removeChild(_loc2_);
               this.m_minWidth = _loc2_.width;
            }
         }
         if(this.hasOwnProperty("maxHeight"))
         {
            _loc3_ = this["maxHeight"] as MovieClip;
            if(_loc3_)
            {
               removeChild(_loc3_);
               this.m_maxHeight = _loc3_.height;
            }
         }
         if(this.hasOwnProperty("maxWidth"))
         {
            _loc4_ = this["maxWidth"] as MovieClip;
            if(_loc4_)
            {
               removeChild(_loc4_);
               this.m_maxWidth = _loc4_.width;
            }
         }
      }
      
      public static const BIDI_UNSET:int = -1;
      
      public static const BIDI_LTR:int = 0;
      
      public static const BIDI_RTL:int = 1;
      
      public static var logger:ILogger;
      
      private var m_rtl:int = -1;
      
      protected var m_enabled:Boolean = true;
      
      private var m_mcToStopFrame:Dictionary;
      
      private var m_isRenderable:Boolean = true;
      
      private var m_parentContainer:IMutable;
      
      public var parentDialogName:String = null;
      
      protected var m_minHeight:Number = 0;
      
      protected var m_minWidth:Number = 0;
      
      protected var m_maxHeight:Number = 2147483647;
      
      protected var m_maxWidth:Number = 2147483647;
      
      protected var m_tooltip:ITooltip;
      
      protected var m_uiEnabled:Boolean = true;
      
      public function get uiEnabled() : Boolean {
         return this.m_uiEnabled;
      }
      
      public function set uiEnabled(param1:Boolean) : void {
         this.m_uiEnabled = param1;
      }
      
      protected function handleEnabled() : Boolean {
         var _loc1_:* = true;
         if(!this.m_uiEnabled)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function set tooltip(param1:ITooltip) : void {
         if(this.m_tooltip)
         {
            this.m_tooltip.destroyTooltip();
         }
         this.m_tooltip = param1;
         if(param1 != null)
         {
            this.m_tooltip.initTooltip(this);
         }
      }
      
      public function get tooltip() : ITooltip {
         return this.m_tooltip;
      }
      
      protected function assert(param1:Boolean, param2:String) : void {
         if(!param1)
         {
            if(logger)
            {
               logger.error("Assertion failed for " + this.name + ": " + param2);
            }
            throw new Error("Assertion failed: " + param2);
         }
         else
         {
            return;
         }
      }
      
      protected function removeAllChildren() : void {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      protected function fitToTarget(param1:DisplayObject, param2:DisplayObjectContainer, param3:Boolean=false) : void {
         var _loc4_:Rectangle = param1.getBounds(param1);
         var _loc5_:Number = param2.width / _loc4_.width;
         var _loc6_:Number = param2.height / _loc4_.height;
         param1.x = -_loc4_.x;
         param1.y = -_loc4_.y;
         var _loc7_:Number = Math.min(_loc5_,_loc6_);
         if(_loc7_ < 1 || (param3))
         {
            param1.scaleX = param1.scaleY = _loc7_;
         }
         param2.addChild(param1);
      }
      
      public function playAnimation(param1:MovieClip, param2:String) : void {
         this.m_mcToStopFrame[param1] = param2 + " stop";
         this.gotoAndPlay(param2);
         param1.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc2_:MovieClip = MovieClip(param1.target);
         var _loc3_:String = this.m_mcToStopFrame[_loc2_];
         if(_loc2_.currentLabel == _loc3_)
         {
            delete this.m_mcToStopFrame[[_loc2_]];
            _loc2_.gotoAndStop(_loc3_);
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      public function addChildren(... rest) : void {
         var _loc2_:DisplayObject = null;
         for each (_loc2_ in rest)
         {
            addChild(_loc2_);
         }
      }
      
      override public function get enabled() : Boolean {
         return this.m_enabled;
      }
      
      override public function set enabled(param1:Boolean) : void {
         this.m_enabled = param1;
         if((this.m_tooltip) && !this.m_enabled)
         {
            this.m_tooltip.onTooltipRollOut();
         }
      }
      
      public function destroy() : void {
         if(this.m_tooltip)
         {
            this.m_tooltip.destroyTooltip();
         }
         this.m_tooltip = null;
         this.m_parentContainer = null;
         this.m_mcToStopFrame = null;
         this.removeAllChildren();
      }
      
      public function removeFromParentContainer() : void {
         if(this.parent is IMutable)
         {
            this.m_parentContainer = this.parent as IMutable;
            IMutable(this.parent).removeItem(this);
         }
      }
      
      public function addToParentContainer() : void {
         if(this.m_parentContainer)
         {
            this.m_parentContainer.addItem(this);
         }
      }
      
      protected function cloneAsBitmap(param1:DisplayObject, param2:Boolean=true) : BitmapData {
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true);
         var _loc4_:Matrix = new Matrix();
         _loc4_.scale(param1.scaleX,param1.scaleY);
         _loc3_.draw(param1,_loc4_,null,null,null,true);
         return _loc3_;
      }
      
      public function get rtl() : int {
         var _loc1_:int = this.m_rtl;
         if(_loc1_ != BIDI_UNSET)
         {
            return _loc1_;
         }
         var _loc2_:DisplayObjectContainer = this.parent;
         while(_loc1_ == BIDI_UNSET && !(_loc2_ == null) && _loc2_ is BaseUI)
         {
            _loc1_ = BaseUI(_loc2_).m_rtl;
            _loc2_ = _loc2_.parent;
         }
         if(_loc1_ == BIDI_UNSET && !(RadManager.instance.config == null))
         {
            _loc1_ = RadManager.instance.config.rtl;
         }
         return _loc1_;
      }
      
      public function set rtl(param1:int) : void {
         this.m_rtl = param1;
      }
   }
}
