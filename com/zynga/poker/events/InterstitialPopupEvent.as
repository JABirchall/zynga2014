package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class InterstitialPopupEvent extends PopupEvent
   {
      
      public function InterstitialPopupEvent(param1:String, param2:String, param3:String) {
         super(param1);
         this.sTitle = param2;
         this.sBody = param3;
      }
      
      public static const INTERSITIAL:String = "showInterstitial";
      
      public var sTitle:String;
      
      public var sBody:String;
      
      override public function clone() : Event {
         return new InterstitialPopupEvent(this.type,this.sTitle,this.sBody);
      }
      
      override public function toString() : String {
         return formatToString("InterstitialPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
