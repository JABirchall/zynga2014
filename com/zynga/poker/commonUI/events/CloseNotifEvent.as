package com.zynga.poker.commonUI.events
{
   import com.zynga.poker.commonUI.notifs.BaseNotif;
   import flash.events.Event;
   
   public class CloseNotifEvent extends CommonVEvent
   {
      
      public function CloseNotifEvent(param1:String, param2:BaseNotif) {
         super(param1);
         this.notif = param2;
      }
      
      public var notif:BaseNotif;
      
      override public function clone() : Event {
         return new CloseNotifEvent(this.type,this.notif);
      }
      
      override public function toString() : String {
         return formatToString("CloseNotifEvent","type","bubbles","cancelable","eventPhase","notif");
      }
   }
}
