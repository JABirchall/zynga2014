package com.zynga.poker.zoom
{
   import flash.events.Event;
   
   public class ZshimEvent extends Event
   {
      
      public function ZshimEvent(param1:String, param2:Object=null) {
         super(param1);
         this.msg = param2;
      }
      
      public static const ZOOM_PROFILE_REQUEST:String = "ZOOM_PROFILE_REQUEST";
      
      public static const ZOOM_PROFILE_MESSAGE:String = "ZOOM_PROFILE_MESSAGE";
      
      public var msg:Object;
      
      override public function clone() : Event {
         return new ZshimEvent(this.type,this.msg);
      }
      
      override public function toString() : String {
         return formatToString("ZshimEvent","type","bubbles","cancelable","eventPhase","msg");
      }
   }
}
