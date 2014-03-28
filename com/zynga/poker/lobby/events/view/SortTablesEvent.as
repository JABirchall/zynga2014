package com.zynga.poker.lobby.events.view
{
   import com.zynga.poker.lobby.events.LVEvent;
   import flash.events.Event;
   
   public class SortTablesEvent extends LVEvent
   {
      
      public function SortTablesEvent(param1:String, param2:String, param3:Boolean=false) {
         super(param1);
         this.dataField = param2;
         this.sortDescending = param3;
      }
      
      public static const SORT_TABLES:String = "sort_tables";
      
      public var dataField:String = "";
      
      public var sortDescending:Boolean = false;
      
      override public function clone() : Event {
         return new SortTablesEvent(type,this.dataField,this.sortDescending);
      }
      
      override public function toString() : String {
         return formatToString("SortTablesEvent","type","bubbles","cancelable","eventPhase","dataField","sortDescending");
      }
   }
}
