package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVESitPressed extends TVEvent
   {
      
      public function TVESitPressed(param1:String, param2:int) {
         super(param1);
         this.nSit = param2;
      }
      
      public var nSit:int;
      
      override public function clone() : Event {
         return new TVESitPressed(this.type,this.nSit);
      }
      
      override public function toString() : String {
         return formatToString("TVESitPressed","type","bubbles","cancelable","eventPhase");
      }
   }
}
