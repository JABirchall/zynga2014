package com.zynga.rad.scrollbars
{
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public dynamic class HScrollBar extends BaseScrollBar
   {
      
      public function HScrollBar() {
         super();
      }
      
      private var x_offset:Number;
      
      override protected function onScrollButtonPress(param1:ZButtonEvent) : void {
         super.onScrollButtonPress(param1);
         this.x_offset = scrollButton.mouseX;
      }
      
      override protected function onBackingMouseDown(param1:MouseEvent) : void {
         super.onBackingMouseDown(param1);
         this.x_offset = scrollButton.width >> 1;
      }
      
      override protected function onEnterFrame(param1:Event) : void {
         scrollButton.x = this.mouseX - this.x_offset;
         if(scrollButton.x < backing.x)
         {
            scrollButton.x = backing.x;
         }
         else
         {
            if(scrollButton.x + scrollButton.width > backing.x + backing.width)
            {
               scrollButton.x = backing.x + backing.width - scrollButton.width;
            }
         }
         m_position = (scrollButton.x - backing.x) / (backing.width - scrollButton.width);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override public function get position() : Number {
         return m_position;
      }
      
      override public function set position(param1:Number) : void {
         if(_enterFrameRef === 0)
         {
            param1 = Math.max(Math.min(1,param1),0);
            m_position = param1;
            scrollButton.x = m_position * (backing.width - scrollButton.width) + backing.x;
         }
      }
   }
}
