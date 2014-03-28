package com.zynga.poker.table.todo
{
   import flash.events.Event;
   
   public class TodoListViewEvent extends Event
   {
      
      public function TodoListViewEvent(param1:String, param2:String) {
         super(param1);
         this._iconName = param2;
      }
      
      public static const TODO_CLICKED:String = "todoClicked";
      
      private var _iconName:String;
      
      override public function clone() : Event {
         return new TodoListViewEvent(type,this._iconName);
      }
      
      public function get iconName() : String {
         return this._iconName;
      }
   }
}
