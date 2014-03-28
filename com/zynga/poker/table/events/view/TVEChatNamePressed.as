package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEChatNamePressed extends TVEvent
   {
      
      public function TVEChatNamePressed(param1:String, param2:String) {
         super(param1);
         this.zid = param2;
      }
      
      public var zid:String;
      
      override public function clone() : Event {
         return new TVEChatNamePressed(this.type,this.zid);
      }
      
      override public function toString() : String {
         return formatToString("TVEChatNamePressed","type","bubbles","cancelable","eventPhase");
      }
   }
}
