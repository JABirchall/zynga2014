package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVESendChat extends TVEvent
   {
      
      public function TVESendChat(param1:String, param2:String, param3:int) {
         super(param1);
         this.sMessage = param2;
         this.sendMode = param3;
      }
      
      public static const ENTER_PRESS:int = 1;
      
      public static const SEND_CLICK:int = 0;
      
      public var sMessage:String;
      
      public var sendMode:int;
      
      override public function clone() : Event {
         return new TVESendChat(this.type,this.sMessage,this.sendMode);
      }
      
      override public function toString() : String {
         return formatToString("TVESendChat","type","bubbles","cancelable","eventPhase");
      }
   }
}
