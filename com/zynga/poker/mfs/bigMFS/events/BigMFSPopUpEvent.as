package com.zynga.poker.mfs.bigMFS.events
{
   import flash.events.Event;
   
   public class BigMFSPopUpEvent extends Event
   {
      
      public function BigMFSPopUpEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const TYPE_BIG_MFS_SEND_BUTTON_CLICKED:String = "BigMFSSendButtonClicked";
      
      public static const TYPE_BIG_MFS_CLOSE_BUTTON_CLICKED:String = "BigMFSCloseButtonClicked";
      
      public static const TYPE_BIG_MFS_INPUT_OUT_OF_FOCUS:String = "BigMFSInputOutOfFocus";
      
      public static const TYPE_BIG_MFS_INPUT_IN_FOCUS:String = "BigMFSInputInFocus";
      
      public static const TYPE_BIG_MFS_INPUT_ENTERED:String = "BigMFSInputEntered";
      
      public static const TYPE_BIG_MFS_SELECT_ALL_CLICKED:String = "BigMFSSelectAllClicked";
      
      public static const TYPE_BIG_MFS_SEND_ALL_CLICKED:String = "BigMFSSendAllClicked";
      
      public static const TYPE_BIG_MFS_SEND_CLICKED:String = "BigMFSSendClicked";
      
      public static const TYPE_BIG_MFS_AUTO_SEND_TRIGGERED:String = "BigMFSAutoSendTriggered";
      
      public static const TYPE_BIG_MFS_POST_WALL_CLICKED:String = "BigMFSPostWallClicked";
      
      public static const TYPE_BIG_MFS_LIMIT_CLOSE_CLICKED:String = "BigMFSLimitCloseClicked";
      
      public static const TYPE_BIG_MFS_LIMIT_SEND_CLICKED:String = "BigMFSLimitSendClicked";
      
      public static const TYPE_BIG_MFS_CLOSE_STATS_CLICKED:String = "BigMFSCloseStatsClicked";
      
      public var params:Object = null;
      
      override public function clone() : Event {
         return new BigMFSPopUpEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("BigMFSPopUpEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
