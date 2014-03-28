package com.zynga.display.Dialog
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DialogEvent extends Event
   {
      
      public function DialogEvent(param1:String, param2:DialogBox=null, param3:Boolean=true, param4:Boolean=false) {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public static const CLOSE:String = "CLOSE";
      
      public static const CLOSED:String = "CLOSED";
      
      public static const OPEN:String = "OPEN";
      
      public static const DISABLE:String = "DISABLE";
      
      public static const ACTIVE:String = "ACTIVE";
      
      public static const ISOLATE:String = "ISOLATE";
      
      public static const RELEASE:String = "RELEASE";
      
      public static const PRIORITIZE:String = "PRIORITIZE";
      
      public static const ALONE:String = "ALONE";
      
      public static const disp:EventDispatcher = new EventDispatcher();
      
      public static function quickThrow(param1:String, param2:DialogBox) : void {
         disp.dispatchEvent(new DialogEvent(param1,param2));
      }
      
      public function get data() : DialogBox {
         return this._data;
      }
      
      private var _data:DialogBox;
      
      override public function clone() : Event {
         return new DialogEvent(type,this._data,bubbles,cancelable);
      }
   }
}
