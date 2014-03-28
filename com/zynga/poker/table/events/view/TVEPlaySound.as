package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEPlaySound extends TVEvent
   {
      
      public function TVEPlaySound(param1:String, param2:String, param3:int) {
         super(param1);
         this.sEvent = param2;
         this.nSit = param3;
      }
      
      public var sEvent:String;
      
      public var nSit:int;
      
      override public function clone() : Event {
         return new TVEPlaySound(this.type,this.sEvent,this.nSit);
      }
      
      override public function toString() : String {
         return formatToString("TVEPlaySound","type","bubbles","cancelable","eventPhase");
      }
   }
}
