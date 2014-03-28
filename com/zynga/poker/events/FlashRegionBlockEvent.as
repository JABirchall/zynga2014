package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class FlashRegionBlockEvent extends Event
   {
      
      public function FlashRegionBlockEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const PLAY_NOW:String = "PLAY_NOW";
      
      public static const JOIN_TABLE:String = "JOIN_TABLE";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new FlashRegionBlockEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("FlashRegionBlockEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
