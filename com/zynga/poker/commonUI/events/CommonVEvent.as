package com.zynga.poker.commonUI.events
{
   import flash.events.Event;
   
   public class CommonVEvent extends Event
   {
      
      public function CommonVEvent(param1:String) {
         super(param1);
      }
      
      public static const VIEW_INIT:String = "VIEW_INIT";
      
      public static const JOIN_USER:String = "JOIN_USER";
      
      public static const INVITE_USER:String = "INVITE_USER";
      
      public static const ZLIVE_HIDE:String = "ZLIVE_HIDE";
      
      public static const CHAT_FRIENDS:String = "CHAT_FRIENDS";
      
      public static const CLOSE_NOTIF:String = "CLOSE_NOTIF";
      
      public static const CLOSE_INVITE:String = "CLOSE_INVITE";
      
      public static const GAMEBAR_MOUSEOVER:String = "GAMEBAR_MOUSEOVER";
      
      public static const GAMEBAR_MOUSEOUT:String = "GAMEBAR_MOUSEOUT";
      
      public static const GAMEBAR_MOUSECLICK:String = "GAMEBAR_MOUSECLICK";
      
      public static const SHOW_PROFILE:String = "SHOW_PROFILE";
      
      public static const INVITE_FRIENDS:String = "INVITE_FRIENDS";
      
      public static const REALTIMENOTIF_DISPLAYED:String = "REALTIMENOTIF_DISPLAYED";
      
      public static const REALTIMENOTIF_CLOSED:String = "REALTIMENOTIF_CLOSED";
      
      public static const INVITENOTIF_DISPLAYED:String = "INVITENOTIF_DISPLAYED";
      
      override public function clone() : Event {
         return new CommonVEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("CommonVEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
