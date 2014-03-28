package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEMuteMod extends TVEvent
   {
      
      public function TVEMuteMod(param1:String, param2:String, param3:String) {
         super(param1);
         this.zid = param2;
         this.action = param3;
      }
      
      public var zid:String;
      
      public var action:String;
      
      override public function clone() : Event {
         return new TVEMuteMod(this.type,this.zid,this.action);
      }
      
      override public function toString() : String {
         return formatToString("TVEMuteMod","type","bubbles","cancelable","eventPhase");
      }
   }
}
