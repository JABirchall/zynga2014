package com.zynga.poker.mfs.miniMFS.events
{
   import flash.events.Event;
   
   public class MiniMFSPopUpEvent extends Event
   {
      
      public function MiniMFSPopUpEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const TYPE_MINI_MFS_SEND_ALL:String = "MiniMFSSendAllRequest";
      
      public static const TYPE_MINI_MFS_POST_SEND:String = "MiniMFSPostSend";
      
      public static const TYPE_MINI_MFS_SEND_BUTTON_CLICKED:String = "MiniMFSSendButtonClicked";
      
      public static const TYPE_MINI_MFS_CLOSE_BUTTON_CLICKED:String = "MiniMFSCloseButtonClicked";
      
      public static const TYPE_MINI_MFS_INPUT_OUT_OF_FOCUS:String = "MiniMFSInputOutOfFocus";
      
      public static const TYPE_MINI_MFS_INPUT_IN_FOCUS:String = "MiniMFSInputInFocus";
      
      public static const TYPE_MINI_MFS_INPUT_ENTERED:String = "MiniMFSInputEntered";
      
      public var params:Object = null;
      
      override public function clone() : Event {
         return new MiniMFSPopUpEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("MiniMFSPopUpEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
