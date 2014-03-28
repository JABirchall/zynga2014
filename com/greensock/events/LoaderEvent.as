package com.greensock.events
{
   import flash.events.Event;
   
   public class LoaderEvent extends Event
   {
      
      public function LoaderEvent(param1:String, param2:Object, param3:String="", param4:*=null) {
         super(param1,false,false);
         this._target = param2;
         this.text = param3;
         this.data = param4;
      }
      
      public static const CHILD_OPEN:String = "childOpen";
      
      public static const CHILD_PROGRESS:String = "childProgress";
      
      public static const CHILD_CANCEL:String = "childCancel";
      
      public static const CHILD_COMPLETE:String = "childComplete";
      
      public static const CHILD_FAIL:String = "childFail";
      
      public static const OPEN:String = "open";
      
      public static const PROGRESS:String = "progress";
      
      public static const CANCEL:String = "cancel";
      
      public static const FAIL:String = "fail";
      
      public static const INIT:String = "init";
      
      public static const COMPLETE:String = "complete";
      
      public static const HTTP_STATUS:String = "httpStatus";
      
      public static const SCRIPT_ACCESS_DENIED:String = "scriptAccessDenied";
      
      public static const ERROR:String = "error";
      
      public static const IO_ERROR:String = "ioError";
      
      public static const SECURITY_ERROR:String = "securityError";
      
      protected var _target:Object;
      
      protected var _ready:Boolean;
      
      public var text:String;
      
      public var data;
      
      override public function clone() : Event {
         return new LoaderEvent(this.type,this._target,this.text,this.data);
      }
      
      override public function get target() : Object {
         if(this._ready)
         {
            return this._target;
         }
         this._ready = true;
         return null;
      }
   }
}
