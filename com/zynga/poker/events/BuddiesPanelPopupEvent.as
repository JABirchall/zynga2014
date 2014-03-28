package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class BuddiesPanelPopupEvent extends PopupEvent
   {
      
      public function BuddiesPanelPopupEvent() {
         super(BuddiesPanelPopupEvent.TYPE_SHOW_BUDDIES);
      }
      
      public static const TYPE_SHOW_BUDDIES:String = "BuddiesEvent.showBuddies";
      
      override public function clone() : Event {
         return new BuddiesPanelPopupEvent();
      }
      
      override public function toString() : String {
         return formatToString("BuddiesPanelPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
