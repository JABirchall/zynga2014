package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class GiftPopupEvent extends PopupEvent
   {
      
      public function GiftPopupEvent(param1:String, param2:int, param3:Array, param4:String="") {
         super(param1);
         this.sit = param2;
         this.gifts = param3;
         this.sZid = param4;
      }
      
      public var sit:int;
      
      public var gifts:Array;
      
      public var sZid:String;
      
      override public function clone() : Event {
         return new GiftPopupEvent(this.type,this.sit,this.gifts,this.sZid);
      }
      
      override public function toString() : String {
         return formatToString("GiftPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
