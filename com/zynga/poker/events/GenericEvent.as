package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class GenericEvent extends Event
   {
      
      public function GenericEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const RUN_HSM_HANDS_EVENT:String = "runHSMHandsEvent";
      
      public static const MOVE_INVITE_TO_SEAT:String = "moveInviteToSeat";
      
      public static const SHOW_MINI_MFS:String = "showMiniMFS";
      
      public static const MAXIMIZE_HILO:String = "maximizeHiLo";
      
      public static const MAXIMIZE_DAILYCHALLENGE:String = "maximizeDailyChallenge";
      
      public static const DAILYCHALLENGE_BUBBLE_UP:String = "dailyChallengeBubbleUp";
      
      public static const SEND_DAILYCHALLENGE_TO_BACK:String = "sendDailyChallengeToBack";
      
      public static const UPDATE_DAILYCHALLENGE:String = "updateDailyChallenge";
      
      public static const DAILYCHALLENGE_SHOW_NOTIF:String = "dailyChallengeShowNotif";
      
      public static const SHOW_DAILYCHALLENGE:String = "showDailyChallenge";
      
      public static const HIDE_DAILYCHALLENGE:String = "hideDailyChallenge";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new GenericEvent(type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("GenericEvent","type","params","bubbles","cancelable","eventPhase");
      }
   }
}
