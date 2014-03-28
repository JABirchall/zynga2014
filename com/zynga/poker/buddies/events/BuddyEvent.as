package com.zynga.poker.buddies.events
{
   import flash.events.Event;
   
   public class BuddyEvent extends Event
   {
      
      public function BuddyEvent(param1:String, param2:String, param3:String="", param4:Boolean=false, param5:Boolean=false) {
         super(param1,param4,param5);
         this._zid = param2;
         this._name = param3;
      }
      
      public static const ACCEPT_REQUEST:String = "BuddyEvent:AcceptRequest";
      
      public static const DENY_REQUEST:String = "BuddyEvent:DenyRequest";
      
      private var _zid:String;
      
      private var _name:String;
      
      override public function clone() : Event {
         return new BuddyEvent(type,this.zid,this.name,bubbles,cancelable);
      }
      
      public function get zid() : String {
         return this._zid;
      }
      
      public function get name() : String {
         return this._name;
      }
   }
}
