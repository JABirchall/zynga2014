package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class InsufficientFundsEvent extends Event
   {
      
      public function InsufficientFundsEvent(param1:String) {
         super(param1);
      }
      
      public static const GET_CHIPS:String = "INSUFFICIENT_GET_CHIPS";
      
      public static const CANCEL:String = "INSUFFICIENT_CLOSE";
   }
}
