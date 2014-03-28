package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class BDEvent extends Event
   {
      
      public function BDEvent(param1:String, param2:Array=null, param3:Array=null) {
         super(param1);
         this.aApproved = param2;
         this.aDenied = param3;
      }
      
      public static const BUDDY_ACCEPTALL:String = "BUDDY_ACCEPTALL";
      
      public static const BUDDY_DENYALL:String = "BUDDY_DENYALL";
      
      public static const BUDDY_IGNOREALL:String = "BUDDY_IGNOREALL";
      
      public static const BUDDY_DONE:String = "BUDDY_DONE";
      
      public var aApproved:Array;
      
      public var aDenied:Array;
      
      override public function clone() : Event {
         return new BDEvent(this.type,this.aApproved,this.aDenied);
      }
      
      override public function toString() : String {
         return formatToString("BDEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
