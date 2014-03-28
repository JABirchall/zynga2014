package com.zynga.poker.table.events.view
{
   import flash.events.Event;
   
   public class TVEPollEvent extends Event
   {
      
      public function TVEPollEvent(param1:String) {
         super(param1);
      }
      
      public static const POLL_CLOSE:String = "pollClose";
      
      public static const POLL_NO:String = "pollNo";
      
      public static const POLL_YES:String = "pollYes";
      
      override public function clone() : Event {
         return new TVEPollEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("TVEPollEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
