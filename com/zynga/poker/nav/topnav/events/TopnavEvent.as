package com.zynga.poker.nav.topnav.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TopnavEvent extends Event
   {
      
      public function TopnavEvent(param1:String, param2:Object=null, param3:Boolean=true, param4:Boolean=false) {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public static const NEW_ACHIEVEMENTS_NOTIFICATION_RESET:String = "NEW_ACHIEVEMENTS_NOTIFICATION_RESET";
      
      public static const disp:EventDispatcher = new EventDispatcher();
      
      public static function quickThrow(param1:String, param2:*) : * {
         disp.dispatchEvent(new TopnavEvent(param1,param2));
      }
      
      private var _data:Object;
      
      public function get data() : Object {
         return this._data;
      }
      
      override public function clone() : Event {
         return new TopnavEvent(type,this._data,bubbles,cancelable);
      }
   }
}
