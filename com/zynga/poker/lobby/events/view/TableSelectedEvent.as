package com.zynga.poker.lobby.events.view
{
   import com.zynga.poker.lobby.events.LVEvent;
   import flash.events.Event;
   
   public class TableSelectedEvent extends LVEvent
   {
      
      public function TableSelectedEvent(param1:String, param2:int, param3:Object=null) {
         super(param1);
         this.nId = param2;
         this.roomItem = param3;
      }
      
      public var nId:int;
      
      public var roomItem:Object;
      
      override public function clone() : Event {
         return new TableSelectedEvent(type,this.nId,this.roomItem);
      }
      
      override public function toString() : String {
         return formatToString("TableSelectedEvent","type","bubbles","cancelable","eventPhase","nId","roomItem");
      }
   }
}
