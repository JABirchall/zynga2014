package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class MFSPopUpEvent extends Event
   {
      
      public function MFSPopUpEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const TYPE_SHOW_POST_SEND_POPUP:String = "MFSPopUpEvent.showPostSendPopup";
      
      public var params:Object = null;
      
      override public function clone() : Event {
         return new MFSPopUpEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("MFSPopUpEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
