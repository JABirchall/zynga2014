package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class RUEvent extends Event
   {
      
      public function RUEvent(param1:String, param2:String="", param3:String="", param4:int=0) {
         super(param1);
         this.sZid = param2;
         this.reason = param3;
         this.categoryId = param4;
      }
      
      public static const REPORTUSER:String = "REPORTUSER";
      
      public var sZid:String;
      
      public var reason:String;
      
      public var categoryId:int;
      
      override public function clone() : Event {
         return new RUEvent(this.type,this.sZid,this.reason);
      }
      
      override public function toString() : String {
         return formatToString("RUEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
