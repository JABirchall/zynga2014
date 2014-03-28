package com.zynga.poker.commonUI.events
{
   import flash.events.Event;
   
   public class InviteUserEvent extends CommonVEvent
   {
      
      public function InviteUserEvent(param1:String, param2:Object, param3:String="zlive") {
         super(param1);
         this.friend = param2;
         this.jointype = param3;
      }
      
      public var friend:Object;
      
      public var jointype:String;
      
      override public function clone() : Event {
         return new InviteUserEvent(this.type,this.friend,this.jointype);
      }
      
      override public function toString() : String {
         return formatToString("InviteUserEvent","type","bubbles","cancelable","eventPhase","friend");
      }
   }
}
