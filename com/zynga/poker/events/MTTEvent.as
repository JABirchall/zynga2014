package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class MTTEvent extends Event
   {
      
      public function MTTEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const MTT_WITHDRAW:String = "mttWithdraw";
      
      public static const MTT_ENABLE_REQUESTS:String = "mttEnableRequests";
      
      public static const MTT_DISABLE_REQUESTS:String = "mttDisableRequests";
      
      public static const ZPWC_ENABLE_REQUESTS:String = "zpwcEnableRequests";
      
      public static const ZPWC_DISABLE_REQUESTS:String = "zpwcDisableRequests";
      
      override public function clone() : Event {
         return new MTTEvent(type,bubbles,cancelable);
      }
   }
}
