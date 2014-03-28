package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class TourneyCongratsPopupEvent extends PopupEvent
   {
      
      public function TourneyCongratsPopupEvent(param1:String, param2:Number, param3:Number) {
         super(param1);
         this.place = param2;
         this.win = param3;
      }
      
      public var place:Number;
      
      public var win:Number;
      
      override public function clone() : Event {
         return new TourneyCongratsPopupEvent(this.type,this.place,this.win);
      }
      
      override public function toString() : String {
         return formatToString("TourneyCongratsPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
