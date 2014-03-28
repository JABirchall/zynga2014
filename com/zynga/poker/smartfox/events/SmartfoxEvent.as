package com.zynga.poker.smartfox.events
{
   import flash.events.Event;
   
   public class SmartfoxEvent extends Event
   {
      
      public function SmartfoxEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const SMARTFOX_ROLLING_REBOOT:String = "Smartfox.RollingReboot";
      
      public static const SMARTFOX_ROLLING_REBOOT_READY_STATE:String = "Smartfox.RollingRebootReadyState";
      
      public static const SMARTFOX_DISCONNECTED:String = "Smartfox.Disconnected";
      
      override public function clone() : Event {
         return new SmartfoxEvent(type,bubbles,cancelable);
      }
   }
}
