package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class AtTableEraseLossPopupEvent extends PopupEvent
   {
      
      public function AtTableEraseLossPopupEvent(param1:String) {
         super(param1,true);
      }
      
      override public function clone() : Event {
         return new AtTableEraseLossPopupEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("AtTableEraseLossPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
