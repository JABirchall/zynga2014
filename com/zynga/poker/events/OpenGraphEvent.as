package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class OpenGraphEvent extends Event
   {
      
      public function OpenGraphEvent(param1:String, param2:Number=0) {
         super(param1);
         this.params = "{\"uid\":\"" + param2 + "\"}";
      }
      
      public static const liveJoin:String = "liveJoin";
      
      public static const achievementTypesPendingNameChange:String = "achievementTypesPendingNameChange";
      
      public var params:String;
      
      override public function clone() : Event {
         return new OpenGraphEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("TVEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
