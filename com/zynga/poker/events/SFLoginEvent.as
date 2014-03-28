package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class SFLoginEvent extends Event
   {
      
      public function SFLoginEvent(param1:String, param2:String) {
         super(param1);
         this.message = param2;
      }
      
      public static const SF_LOGIN_FAILED:String = "SF_LOGIN_FAILED";
      
      public var message:String;
      
      override public function clone() : Event {
         return new SFLoginEvent(this.type,this.message);
      }
      
      override public function toString() : String {
         return formatToString("SFLoginEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
