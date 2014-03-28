package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class PopupEvent extends Event
   {
      
      public function PopupEvent(param1:String, param2:Boolean=true, param3:Object=null) {
         super(param1);
         this.closePHPPopups = param2;
         this.data = param3;
      }
      
      public static const POPUP:String = "POPUP";
      
      public static const UNKNOWN_ID:String = "POPUP_UNKNOWN";
      
      public var closePHPPopups:Boolean = true;
      
      public var data:Object;
      
      override public function clone() : Event {
         return new PopupEvent(this.type,this.closePHPPopups,this.data);
      }
      
      override public function toString() : String {
         return formatToString("PopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
