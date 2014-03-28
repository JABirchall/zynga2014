package com.zynga.ui.scroll
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ScrollEvent extends Event
   {
      
      public function ScrollEvent(param1:String, param2:Object=null, param3:Boolean=true, param4:Boolean=false) {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public static const DROP:String = "DROP";
      
      public static const GRAB:String = "GRAB";
      
      public static const DEFOCUS:String = "DEFOCUS";
      
      public static const disp:EventDispatcher = new EventDispatcher();
      
      public static function quickThrow(param1:String, param2:Object) : void {
         disp.dispatchEvent(new ScrollEvent(param1,param2));
      }
      
      public function get data() : Object {
         return this._data;
      }
      
      private var _data:Object;
      
      override public function clone() : Event {
         return new ScrollEvent(type,this._data,bubbles,cancelable);
      }
   }
}
