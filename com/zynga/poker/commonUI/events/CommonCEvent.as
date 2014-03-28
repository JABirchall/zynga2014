package com.zynga.poker.commonUI.events
{
   import flash.events.Event;
   
   public class CommonCEvent extends Event
   {
      
      public function CommonCEvent(param1:String) {
         super(param1);
      }
      
      public static const eType:String = "commonControl";
      
      public static const VIEW_INIT:String = "VIEW_INIT";
      
      public static const C_JOIN_USER:String = "C_JOIN_USER";
      
      public static const ON_ZLIVE_HIDE:String = "onZLiveHide";
      
      override public function clone() : Event {
         return new CommonCEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("CommonCEvents","type","bubbles","cancelable","eventPhase");
      }
   }
}
