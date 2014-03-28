package com.zynga.poker.protocol
{
   import flash.events.Event;
   
   public class ProtocolEvent extends Event
   {
      
      public function ProtocolEvent(param1:String, param2:Object) {
         super(param1);
         this.msg = param2;
      }
      
      public static const onMessage:String = "onMessage";
      
      public var msg:Object;
      
      override public function clone() : Event {
         return new ProtocolEvent(this.type,this.msg);
      }
      
      override public function toString() : String {
         return formatToString("ProtocolEvent","type","bubbles","cancelable","eventPhase","msg");
      }
   }
}
