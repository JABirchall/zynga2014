package com.zynga.poker.commonUI.events
{
   import flash.events.Event;
   
   public class JoinUserEvent extends CommonVEvent
   {
      
      public function JoinUserEvent(param1:String, param2:Object, param3:String="zlive") {
         super(param1);
         this.friend = param2;
         this.jointype = param3;
      }
      
      public static const JOIN_TYPE_ZLIVE:String = "zlive";
      
      public static const JOIN_TYPE_NOTIF:String = "notif";
      
      public var friend:Object;
      
      public var jointype:String;
      
      override public function clone() : Event {
         return new JoinUserEvent(this.type,this.friend,this.jointype);
      }
      
      override public function toString() : String {
         return formatToString("JoinUserEvent","type","bubbles","cancelable","eventPhase","friend");
      }
   }
}
