package com.zynga.poker.lobby.events.controller
{
   import com.zynga.poker.lobby.events.LCEvent;
   import flash.events.Event;
   
   public class JoinTableEvent extends LCEvent
   {
      
      public function JoinTableEvent(param1:String, param2:int) {
         super(param1);
         this.nId = param2;
      }
      
      public var nId:int;
      
      override public function clone() : Event {
         return new JoinTableEvent(this.type,this.nId);
      }
      
      override public function toString() : String {
         return formatToString("JoinTableEvent","type","bubbles","cancelable","eventPhase","nId");
      }
   }
}
