package com.zynga.rad.scrollbars
{
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public dynamic class VScrollBar extends BaseScrollBar
   {
      
      public function VScrollBar() {
         super();
      }
      
      private var y_offset:Number;
      
      override protected function onScrollButtonPress(param1:ZButtonEvent) : void {
         super.onScrollButtonPress(param1);
         this.y_offset = scrollButton.mouseY;
      }
      
      override protected function onBackingMouseDown(param1:MouseEvent) : void {
         super.onBackingMouseDown(param1);
         this.y_offset = scrollButton.height >> 1;
      }
      
      override protected function onEnterFrame(param1:Event) : void {
         scrollButton.y = this.mouseY - this.y_offset;
         if(scrollButton.y < backing.y)
         {
            scrollButton.y = backing.y;
         }
         else
         {
            if(scrollButton.y + scrollButton.height > backing.y + backing.height)
            {
               scrollButton.y = backing.y + backing.height - scrollButton.height;
            }
         }
         m_position = (scrollButton.y - backing.y) / (backing.height - scrollButton.height);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override public function set position(param1:Number) : void {
         if(_enterFrameRef === 0)
         {
            param1 = Math.max(Math.min(1,param1),0);
            m_position = param1;
            scrollButton.y = m_position * (backing.height - scrollButton.height) + backing.y;
         }
      }
   }
}
