package com.zynga.events
{
   import flash.events.Event;
   
   public class URLEvent extends Event
   {
      
      public function URLEvent(param1:String, param2:Boolean, param3:String="") {
         super(param1);
         this.bSuccess = param2;
         this.data = param3;
      }
      
      public static const onLoaded:String = "onLoaded";
      
      public static const onIOError:String = "onIOError";
      
      public var data:String;
      
      public var bSuccess:Boolean;
      
      override public function clone() : Event {
         return new URLEvent(this.type,this.bSuccess,this.data);
      }
      
      override public function toString() : String {
         return formatToString("URLEvent","type","bubbles","cancelable","eventPhase","data","bSuccess");
      }
   }
}
