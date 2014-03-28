package com.zynga.poker.table.todo
{
   import flash.events.Event;
   
   public class TAListEvent extends Event
   {
      
      public function TAListEvent(param1:String, param2:Object=null) {
         super(param1);
         this.item = param2;
      }
      
      public static const TABLE_ACTION_LIST_ITEM_CLICK:String = "tableActionListItemClick";
      
      public static const TABLE_ACTION_LIST_AUTO_ROTATE:String = "taliAutoRotate";
      
      public var item:Object;
      
      override public function clone() : Event {
         return new TAListEvent(type,this.item);
      }
      
      override public function toString() : String {
         return formatToString("TAListEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
