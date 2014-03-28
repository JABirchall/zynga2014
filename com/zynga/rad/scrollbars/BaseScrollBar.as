package com.zynga.rad.scrollbars
{
   import com.zynga.rad.BaseUI;
   import flash.display.MovieClip;
   import com.zynga.rad.buttons.ZButton;
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import com.zynga.rad.RadManager;
   
   public dynamic class BaseScrollBar extends BaseUI
   {
      
      public function BaseScrollBar() {
         super();
         assert(!(this.scrollButton == null),"A child named scrollButton must be present");
         this._enterFrameRef = 0;
         this.scrollButton.addEventListener(ZButtonEvent.PRESS,this.onScrollButtonPress);
         this.scrollButton.addEventListener(ZButtonEvent.RELEASE,this.onScrollButtonRelease);
         this.scrollButton.addEventListener(ZButtonEvent.RELEASE_OUTSIDE,this.onScrollButtonRelease);
         this._isMouseDownBacking = false;
         if(this.backing !== null)
         {
            this.backing.addEventListener(MouseEvent.MOUSE_DOWN,this.onBackingMouseDown);
            this.backing.addEventListener(MouseEvent.MOUSE_UP,this.onBackingMouseUp);
            if(!(RadManager.instance.config == null) && !(RadManager.instance.config.stage == null))
            {
               RadManager.instance.config.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageRelease,false,0,true);
            }
         }
      }
      
      public var backing:MovieClip;
      
      public var scrollButton:ZButton;
      
      protected var m_position:Number = 0;
      
      private var _isMouseDownBacking:Boolean;
      
      protected var _enterFrameRef:int;
      
      public function get position() : Number {
         return this.m_position;
      }
      
      public function set position(param1:Number) : void {
      }
      
      protected function onScrollButtonPress(param1:ZButtonEvent) : void {
         this.setEnterFrame(true);
      }
      
      private function onScrollButtonRelease(param1:ZButtonEvent) : void {
         this.setEnterFrame(false);
      }
      
      protected function onBackingMouseDown(param1:MouseEvent) : void {
         this._isMouseDownBacking = true;
         this.setEnterFrame(true);
      }
      
      private function onBackingMouseUp(param1:MouseEvent) : void {
         this._isMouseDownBacking = false;
         this.setEnterFrame(false);
      }
      
      private function onStageRelease(param1:MouseEvent) : void {
         if(this._isMouseDownBacking === true)
         {
            this.onBackingMouseUp(param1);
         }
      }
      
      private function setEnterFrame(param1:Boolean) : void {
         if(param1 === true)
         {
            if(this._enterFrameRef === 0)
            {
               addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
            this._enterFrameRef++;
         }
         else
         {
            this._enterFrameRef--;
            if(this._enterFrameRef < 0)
            {
               this._enterFrameRef = 0;
            }
            if(this._enterFrameRef === 0)
            {
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
         }
      }
      
      protected function onEnterFrame(param1:Event) : void {
      }
   }
}
