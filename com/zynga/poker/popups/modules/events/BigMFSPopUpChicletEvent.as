package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class BigMFSPopUpChicletEvent extends Event
   {
      
      public function BigMFSPopUpChicletEvent(param1:String) {
         super(param1);
      }
      
      public static const TYPE_CLICKED:String = "BigMFSPopUpChicletEvent.clicked";
      
      override public function clone() : Event {
         return new BigMFSPopUpChicletEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("BigMFSPopUpChicletEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
