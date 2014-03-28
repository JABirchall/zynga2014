package com.zynga.poker.nav.sidenav.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SidenavEvents extends Event
   {
      
      public function SidenavEvents(param1:String, param2:Object=null, param3:Boolean=true, param4:Boolean=false) {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public static const REQUEST_PANEL:String = "REQUEST_PANEL";
      
      public static const CLOSE_PANEL:String = "CLOSE_PANEL";
      
      public static const PANEL_SELECTED:String = "PANEL_SELECTED";
      
      public static const disp:EventDispatcher = new EventDispatcher();
      
      public static function quickThrow(param1:String, param2:*) : * {
         disp.dispatchEvent(new SidenavEvents(param1,param2));
      }
      
      private var _data:Object;
      
      public function get data() : Object {
         return this._data;
      }
      
      override public function clone() : Event {
         return new SidenavEvents(type,this._data,bubbles,cancelable);
      }
   }
}
