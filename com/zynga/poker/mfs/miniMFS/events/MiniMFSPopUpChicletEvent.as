package com.zynga.poker.mfs.miniMFS.events
{
   import flash.events.Event;
   
   public class MiniMFSPopUpChicletEvent extends Event
   {
      
      public function MiniMFSPopUpChicletEvent(param1:String) {
         super(param1);
      }
      
      public static const TYPE_CLICKED:String = "miniMFSPopUpChicletEvent.clicked";
      
      override public function clone() : Event {
         return new MiniMFSPopUpChicletEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("miniMFSPopUpChicletEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
