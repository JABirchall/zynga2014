package com.zynga.poker.lobby.events
{
   import flash.events.Event;
   
   public class LCEvent extends Event
   {
      
      public function LCEvent(param1:String) {
         super(param1);
      }
      
      public static const eType:String = "lobbyControl";
      
      public static const VIEW_INIT:String = "VIEW_INIT";
      
      public static const JOIN_TABLE:String = "JOIN_TABLE";
      
      public static const FIND_SEAT:String = "FIND_SEAT";
      
      public static const PLAY_TOURNAMENT:String = "PLAY_TOURNAMENT";
      
      public static const CLOSE_FLYOUT:String = "CLOSE_FLYOUT";
      
      public static const CONNECT_TO_NEW_SERVER:String = "RECONNECT_TO_SERVER";
      
      public static const RECORD_STAT:String = "RECORD_STAT";
      
      public static const PRIVATE_TABLE_CLICK:String = "PRIVATE_TABLE_CLICK";
      
      public static const REFRESHED_USER_INFO:String = "REFRESHED_USER_INFO";
      
      public static const ON_USER_CHIPS_UPDATED:String = "ON_USER_CHIPS_UPDATED";
      
      override public function clone() : Event {
         return new LCEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("LCEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
