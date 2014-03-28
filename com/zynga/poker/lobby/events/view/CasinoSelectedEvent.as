package com.zynga.poker.lobby.events.view
{
   import com.zynga.poker.lobby.events.LVEvent;
   import flash.events.Event;
   
   public class CasinoSelectedEvent extends LVEvent
   {
      
      public function CasinoSelectedEvent(param1:String, param2:String, param3:String, param4:int) {
         super(param1);
         this.nIp = param2;
         this.nName = param3;
         this.nServerId = param4;
      }
      
      public var nIp:String;
      
      public var nName:String;
      
      public var nServerId:int;
      
      override public function clone() : Event {
         return new CasinoSelectedEvent(type,this.nIp,this.nName,this.nServerId);
      }
      
      override public function toString() : String {
         return formatToString("CasinoSelectedEvent","type","bubbles","cancelable","eventPhase","nIp","nName","nServerId");
      }
   }
}
