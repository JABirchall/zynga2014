package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class PreSelectPopUpChicletEvent extends Event
   {
      
      public function PreSelectPopUpChicletEvent(param1:String) {
         super(param1);
      }
      
      public static const TYPE_CLICKED:String = "PreSelectPopUpChicletEvent.clicked";
      
      override public function clone() : Event {
         return new PreSelectPopUpChicletEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("PreSelectPopUpChicletEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
