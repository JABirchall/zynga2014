package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class GiftLibraryEvent extends Event
   {
      
      public function GiftLibraryEvent(param1:String) {
         super(param1);
      }
      
      public static const GIFTS_LOADED:String = "GIFTS_LOADED";
      
      override public function clone() : Event {
         return new GiftLibraryEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("GiftLibraryEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
