package com.zynga.io
{
   import flash.events.Event;
   
   public class SmartfoxConnectionEvent extends Event
   {
      
      public function SmartfoxConnectionEvent(param1:String, param2:String) {
         super(param1);
         this.evtType = param1;
         this.port = param2;
      }
      
      public var port:String;
      
      private var evtType:String;
      
      override public function clone() : Event {
         return new SmartfoxConnectionEvent(this.evtType,this.port);
      }
      
      override public function toString() : String {
         return formatToString("SmartfoxConnectionEvent","type","port");
      }
   }
}
