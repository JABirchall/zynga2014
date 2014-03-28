package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class PCEvent extends Event
   {
      
      public function PCEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const LOBBY_JOINED:String = "LOBBY_JOINED";
      
      public static const TABLE_JOINED:String = "TABLE_JOINED";
      
      public static const CHIPS_UPDATED:String = "CHIPS_UPDATED";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new PCEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("PCEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
