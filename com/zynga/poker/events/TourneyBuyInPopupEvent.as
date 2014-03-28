package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class TourneyBuyInPopupEvent extends PopupEvent
   {
      
      public function TourneyBuyInPopupEvent(param1:String, param2:int) {
         super(param1);
         this.sit = param2;
      }
      
      public var sit:int;
      
      override public function clone() : Event {
         return new TourneyBuyInPopupEvent(this.type,this.sit);
      }
      
      override public function toString() : String {
         return formatToString("TourneyBuyInPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
