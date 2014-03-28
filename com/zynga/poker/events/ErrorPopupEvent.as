package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class ErrorPopupEvent extends PopupEvent
   {
      
      public function ErrorPopupEvent(param1:String, param2:String, param3:String) {
         super(param1);
         this.sTitle = param2;
         this.sMsg = param3;
      }
      
      public var sTitle:String;
      
      public var sMsg:String;
      
      override public function clone() : Event {
         return new ErrorPopupEvent(this.type,this.sTitle,this.sMsg);
      }
      
      override public function toString() : String {
         return formatToString("ErrorPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
