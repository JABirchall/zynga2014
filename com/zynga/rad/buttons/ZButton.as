package com.zynga.rad.buttons
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.ILayout;
   import flash.text.TextField;
   import flash.display.*;
   import __AS3__.vec.*;
   import flash.events.*;
   import flash.text.TextFormat;
   import com.zynga.rad.RadManager;
   import com.zynga.rad.util.ZuiUtil;
   
   public dynamic class ZButton extends BaseUI implements ILayout
   {
      
      public function ZButton() {
         this.m_framesInStates = {};
         super();
         stop();
         assert(!(this.up == null),"Button must include an up state");
         assert(!(this.over == null),"Button must include an over state");
         assert(!(this.down == null),"Button must include an down state");
         assert(!(this.disabled == null),"Button must include an disabled state");
         this.init();
         if(this.label)
         {
            this.label.mouseEnabled = false;
         }
         this.up.mouseChildren = false;
         this.over.mouseChildren = false;
         this.down.mouseChildren = false;
         this.disabled.mouseChildren = false;
         this.enabled = true;
      }
      
      private static const SPACING:int = 8;
      
      public var up:MovieClip;
      
      public var over:MovieClip;
      
      public var down:MovieClip;
      
      public var disabled:MovieClip;
      
      public var label:TextField;
      
      protected var m_mouseDown:Boolean = false;
      
      protected var m_states:Array;
      
      protected var m_stateControllers:Vector.<ButtonState>;
      
      protected var m_text:String;
      
      protected var m_originalWidth:Number;
      
      private var m_autoSize:String = "none";
      
      private var m_fieldToScale:String = "label";
      
      private var m_originalCenter:Number;
      
      private var m_originalLeft:Number;
      
      private var m_originalRight:Number;
      
      protected var m_originalScaleX:Number;
      
      public var data:Object;
      
      public function set fieldToScaleByName(param1:String) : void {
         this.m_fieldToScale = param1;
      }
      
      public function init() : void {
         this.m_originalWidth = this.width;
         this.m_originalLeft = this.x;
         this.m_originalRight = this.m_originalLeft + this.m_originalWidth;
         this.m_originalCenter = this.m_originalLeft + 0.5 * this.m_originalWidth;
         this.m_originalScaleX = this.scaleX;
         this.scaleX = 1;
         this.wrapStates();
      }
      
      protected function wrapStates() : void {
         var _loc1_:MovieClip = null;
         this.m_states = [this.up,this.over,this.down,this.disabled];
         this.m_stateControllers = new Vector.<ButtonState>(0);
         for each (_loc1_ in this.m_states)
         {
            this.m_stateControllers.push(new ButtonState(_loc1_,this.m_originalScaleX,this));
         }
      }
      
      public function set autoSize(param1:String) : void {
         this.m_autoSize = param1;
         this.checkAutoSize();
      }
      
      public function click() : void {
         this.onRelease(new MouseEvent(MouseEvent.CLICK));
         this.over.visible = false;
         this.up.visible = true;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.RELEASE));
      }
      
      public function get text() : String {
         return this.m_text;
      }
      
      public function set text(param1:String) : void {
         var _loc2_:ButtonState = null;
         if(param1 == null)
         {
            param1 = "";
         }
         this.m_text = param1;
         for each (_loc2_ in this.m_stateControllers)
         {
            _loc2_.text = param1;
         }
         this.checkAutoSize();
      }
      
      public function setTextFormat(param1:TextFormat) : void {
         var _loc2_:ButtonState = null;
         for each (_loc2_ in this.m_stateControllers)
         {
            if(_loc2_.label)
            {
               _loc2_.label.setTextFormat(param1);
            }
         }
      }
      
      private var m_framesInStates:Object;
      
      public function goToFrameInMovieClip(param1:String, param2:String) : void {
         var _loc3_:MovieClip = null;
         this.m_framesInStates[param1] = param2;
         for each (_loc3_ in this.m_states)
         {
            if((_loc3_.hasOwnProperty(param1)) && _loc3_[param1] is MovieClip)
            {
               if(this.hasFrame(_loc3_[param1],param2))
               {
                  _loc3_[param1].gotoAndStop(param2);
               }
            }
         }
      }
      
      private function hasFrame(param1:MovieClip, param2:String) : Boolean {
         var _loc3_:FrameLabel = null;
         for each (_loc3_ in param1.currentLabels)
         {
            if(_loc3_.name == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setTextByName(param1:String, param2:String) : void {
         var _loc3_:ButtonState = null;
         for each (_loc3_ in this.m_stateControllers)
         {
            _loc3_.setTextByName(param1,param2);
         }
         this.checkAutoSize();
      }
      
      protected function checkAutoSize() : void {
         var _loc1_:ButtonState = null;
         for each (_loc1_ in this.m_stateControllers)
         {
            if(this.m_autoSize == ZButtonAutoSize.NONE)
            {
               _loc1_.isFixed = true;
            }
            else
            {
               _loc1_.isFixed = false;
            }
         }
         switch(this.m_autoSize)
         {
            case ZButtonAutoSize.NONE:
               this.x = this.m_originalLeft;
               break;
            case ZButtonAutoSize.CENTER:
               this.x = this.m_originalCenter - 0.5 * this.width;
               break;
            case ZButtonAutoSize.LEFT:
               this.x = this.m_originalLeft;
               break;
            case ZButtonAutoSize.RIGHT:
               this.x = this.m_originalRight - this.width;
               break;
         }
         
      }
      
      public function playAllStates() : void {
         var _loc1_:MovieClip = null;
         for each (_loc1_ in this.m_states)
         {
            _loc1_.play();
         }
      }
      
      public function gotoAndStopAllStates(param1:Object) : void {
         var _loc2_:MovieClip = null;
         for each (_loc2_ in this.m_states)
         {
            _loc2_.icon.gotoAndStop(param1);
         }
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         buttonMode = m_enabled;
         useHandCursor = m_enabled;
         this.up.visible = m_enabled;
         this.over.visible = false;
         this.down.visible = false;
         this.disabled.visible = !m_enabled;
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
         if(!(RadManager.instance.config == null) && !(RadManager.instance.config.stage == null))
         {
            RadManager.instance.config.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageRelease);
            RadManager.instance.config.stage.removeEventListener(Event.MOUSE_LEAVE,this.onStageLeave);
         }
         if(m_enabled)
         {
            this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverInternal);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
            if(!(RadManager.instance.config == null) && !(RadManager.instance.config.stage == null))
            {
               RadManager.instance.config.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageRelease,false,0,true);
               RadManager.instance.config.stage.addEventListener(Event.MOUSE_LEAVE,this.onStageLeave,false,0,true);
            }
         }
      }
      
      protected function onStageRelease(param1:MouseEvent) : void {
         if(!m_enabled || !this.m_mouseDown)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         while(_loc2_ != null)
         {
            if(_loc2_ == this)
            {
               this.onRelease(param1);
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.onReleaseOutside(param1);
      }
      
      public function addIcon(param1:Bitmap) : void {
         var _loc2_:MovieClip = null;
         var _loc3_:Bitmap = null;
         var _loc4_:MovieClip = null;
         for each (_loc2_ in this.m_states)
         {
            _loc3_ = ZuiUtil.createBitmap(param1.bitmapData);
            _loc3_.width = param1.width;
            _loc3_.height = param1.height;
            if(_loc2_.icon)
            {
               (_loc2_.icon as MovieClip).removeChildren();
               (_loc2_.icon as MovieClip).addChild(_loc3_);
               (_loc2_.icon as MovieClip).scaleX = 1;
               (_loc2_.icon as MovieClip).scaleY = 1;
            }
            else
            {
               _loc4_ = new MovieClip();
               _loc4_.addChild(_loc3_);
               if(this is ZReversibleButton && rtl == BaseUI.BIDI_RTL)
               {
                  _loc4_.x = this.width - this.x - _loc4_.width;
               }
               _loc2_.addChild(_loc4_);
            }
         }
      }
      
      protected function onReleaseOutside(param1:MouseEvent) : void {
         this.m_mouseDown = false;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.RELEASE_OUTSIDE));
      }
      
      protected function onRollOut(param1:MouseEvent) : void {
         this.doRollOut();
      }
      
      protected function onRelease(param1:MouseEvent) : void {
         this.m_mouseDown = false;
         this.up.visible = false;
         this.over.visible = true;
         this.down.visible = false;
         this.disabled.visible = false;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.RELEASE));
      }
      
      protected function onRollOverInternal(param1:MouseEvent) : void {
         if(this.m_mouseDown)
         {
            this.onDragOver(param1);
         }
         else
         {
            this.onMouseOver(param1);
         }
      }
      
      protected function onDragOver(param1:MouseEvent) : void {
         if(!m_enabled)
         {
            return;
         }
         this.up.visible = false;
         this.over.visible = false;
         this.down.visible = true;
         this.disabled.visible = false;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.DRAG_OVER));
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         if((m_tooltip) && (m_tooltip.canShowTooltip()))
         {
            m_tooltip.onTooltipRollOver();
         }
         if(!m_enabled)
         {
            return;
         }
         this.up.visible = false;
         this.over.visible = true;
         this.down.visible = false;
         this.disabled.visible = false;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.ROLL_OVER));
      }
      
      protected function onMousePress(param1:MouseEvent) : void {
         var _loc2_:Object = param1.target;
         while(_loc2_ is DisplayObjectContainer)
         {
            if(_loc2_ == this)
            {
               break;
            }
            if(_loc2_ is ZButton)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.m_mouseDown = true;
         this.up.visible = false;
         this.over.visible = false;
         this.down.visible = true;
         this.disabled.visible = false;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.PRESS));
      }
      
      protected function onStageLeave(param1:Event) : void {
         if((this.up) && !this.up.visible)
         {
            this.doRollOut();
         }
      }
      
      protected function doRollOut() : void {
         if(m_tooltip)
         {
            m_tooltip.onTooltipRollOut();
         }
         if(m_enabled)
         {
            this.up.visible = true;
            this.over.visible = false;
            this.down.visible = false;
            this.disabled.visible = false;
         }
         if((this.m_mouseDown) && (m_enabled))
         {
            dispatchEvent(new ZButtonEvent(ZButtonEvent.DRAG_OUT));
         }
         else
         {
            dispatchEvent(new ZButtonEvent(ZButtonEvent.ROLL_OUT));
         }
      }
      
      override public function destroy() : void {
         var _loc1_:ButtonState = null;
         for each (_loc1_ in this.m_stateControllers)
         {
            _loc1_.destroy();
         }
         if(this.m_stateControllers != null)
         {
            this.m_stateControllers.length = 0;
         }
         this.m_stateControllers = null;
         if(this.m_states != null)
         {
            this.m_states.length = 0;
         }
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverInternal);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
         if(RadManager.instance.config.stage != null)
         {
            RadManager.instance.config.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageRelease);
            RadManager.instance.config.stage.removeEventListener(Event.MOUSE_LEAVE,this.onStageLeave);
         }
         super.destroy();
      }
      
      override public function gotoAndStop(param1:Object, param2:String=null) : void {
         var _loc3_:String = null;
         super.gotoAndStop(param1,param2);
         if((this.up) && (this.over) && (this.down) && (this.disabled))
         {
            this.up.visible = m_enabled;
            this.over.visible = false;
            this.down.visible = false;
            this.disabled.visible = !m_enabled;
            this.wrapStates();
            if(this.m_text)
            {
               this.text = this.m_text;
            }
            for (_loc3_ in this.m_framesInStates)
            {
               this.goToFrameInMovieClip(_loc3_,this.m_framesInStates[_loc3_]);
            }
         }
      }
      
      public function doLayout() : void {
         var _loc1_:ButtonState = null;
         for each (_loc1_ in this.m_stateControllers)
         {
            _loc1_.doLayout();
         }
      }
   }
}
