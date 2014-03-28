package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEGiftPressed extends TVEvent
   {
      
      public function TVEGiftPressed(param1:String, param2:int) {
         super(param1);
         this.sit = param2;
      }
      
      public var sit:int;
      
      override public function clone() : Event {
         return new TVEGiftPressed(this.type,this.sit);
      }
      
      override public function toString() : String {
         return formatToString("TVEGiftPressed","type","bubbles","cancelable","eventPhase");
      }
   }
}
