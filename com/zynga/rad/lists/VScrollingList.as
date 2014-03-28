package com.zynga.rad.lists
{
   import com.zynga.rad.BaseUI;
   import flash.display.MovieClip;
   import com.zynga.rad.scrollbars.VScrollBar;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import com.zynga.rad.RadManager;
   import flash.events.Event;
   import __AS3__.vec.*;
   import flash.geom.Rectangle;
   
   public class VScrollingList extends BaseUI
   {
      
      public function VScrollingList() {
         this.m_items = new Vector.<DisplayObject>(0);
         this.m_target = new Sprite();
         super();
         addChild(this.m_target);
         var _loc1_:Rectangle = new Rectangle();
         _loc1_ = _loc1_.union(this.backing.getBounds(this));
         _loc1_ = _loc1_.union(this.scrollBar.getBounds(this));
         this.scrollRect = _loc1_;
         this.scrollBar.backing.height = this.backing.height;
         this.scrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onFocusIn);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onFocusOut);
      }
      
      public var backing:MovieClip;
      
      public var scrollBar:VScrollBar;
      
      private var m_items:Vector.<DisplayObject>;
      
      private var m_target:Sprite;
      
      private function onFocusIn(param1:MouseEvent) : void {
         RadManager.instance.config.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onFocusOut(param1:MouseEvent) : void {
         RadManager.instance.config.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void {
         var _loc2_:int = param1.delta;
         var _loc3_:Number = this.scrollBar.position;
         this.scrollBar.position = _loc3_ - _loc2_ * 0.02;
         this.onScrollBarChange();
      }
      
      private function onScrollBarChange(param1:Event=null) : void {
         this.position = this.scrollBar.position;
      }
      
      public function addItem(param1:DisplayObject) : void {
         param1.addEventListener(Event.CHANGE,this.onResize);
         this.m_items.push(param1);
         param1.y = this.m_target.height;
         this.m_target.addChild(param1);
         this.position = this.scrollBar.position;
      }
      
      private function onResize(param1:Event) : void {
         this.updateDisplay();
         if(this.m_target.y < -(this.m_target.height - this.backing.height))
         {
            this.m_target.y = Math.max(0,this.m_target.height - this.backing.height);
         }
      }
      
      public function updateDisplay() : void {
         var _loc2_:DisplayObject = null;
         var _loc1_:Number = 0;
         for each (_loc2_ in this.m_items)
         {
            _loc2_.y = _loc1_;
            _loc1_ = _loc1_ + _loc2_.height;
         }
      }
      
      public function clear() : void {
         var _loc1_:DisplayObject = null;
         for each (_loc1_ in this.m_items)
         {
            if(_loc1_.parent == this.m_target)
            {
               this.m_target.removeChild(_loc1_);
            }
         }
         this.m_items.length = 0;
         this.scrollBar.position = 0;
         this.onScrollBarChange();
      }
      
      public function set position(param1:Number) : void {
         var _loc2_:Number = Math.max(this.m_target.height - this.backing.height,0);
         this.m_target.y = -_loc2_ * param1;
      }
   }
}
