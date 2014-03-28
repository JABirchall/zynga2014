package com.zynga.poker.table.events
{
   import flash.events.Event;
   
   public class TCEvent extends Event
   {
      
      public function TCEvent(param1:String) {
         super(param1);
      }
      
      public static const eType:String = "tableControl";
      
      public static const VIEW_INIT:String = "VIEW_INIT";
      
      public static const LEAVE_TABLE:String = "LEAVE_TABLE";
      
      public static const STAND_UP:String = "STAND_UP";
      
      public static const PLAY_SOUND_ONCE:String = "PLAY_SOUND_ONCE";
      
      public static const STOP_SOUND:String = "STOP_SOUND";
      
      public static const PLAY_SOUND_SEQUENCE:String = "PLAY_SOUND_SEQUENCE";
      
      public static const TOGGLE_MUTE_SOUND:String = "TOGGLE_MUTE_SOUND";
      
      public static const FRIEND_NET_PRESSED:String = "FRIEND_NET_PRESSED";
      
      public static const USERSINROOM_UPDATED:String = "USERSINROOM_UPDATED";
      
      public static const USER_CHIPS_UPDATED:String = "USER_CHIPS_UPDATED";
      
      public static const SEAT_JOINED:String = "SEAT_JOINED";
      
      public static const SEAT_TAKEN:String = "TCEvent.SEAT_TAKEN";
      
      override public function clone() : Event {
         return new TCEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("TCEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
