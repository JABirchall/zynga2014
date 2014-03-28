package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class ChickletMenuEvent extends Event
   {
      
      public function ChickletMenuEvent(param1:String, param2:String, param3:Boolean=false, param4:String="", param5:String="masc", param6:Boolean=false) {
         super(param1);
         this.sZid = param2;
         this.bMuteUser = param3;
         this.playerName = param4;
         this.gender = param5;
         this.bFakeBuddyAdd = param6;
      }
      
      public static const PROFILE:String = "PROFILE";
      
      public static const ABUSE:String = "ABUSE";
      
      public static const MODERATE:String = "MODERATE";
      
      public static const GIFT_MENU:String = "GIFT_MENU";
      
      public static const GIFT_CHIPS:String = "GIFT_CHIPS";
      
      public static const SEND_CHIPS:String = "SEND_CHIPS";
      
      public static const SHOW_GIFT:String = "SHOW_GIFT";
      
      public static const SHOW_ITEMS:String = "SHOW_ITEMS";
      
      public static const POKER_SCORE:String = "POKER_SCORE";
      
      public static const ADD_BUDDY:String = "ADD_BUDDY";
      
      public static const MUTE_USER:String = "MUTE_USER";
      
      public static const DONE:String = "DONE";
      
      public static const FEED_CHECK:String = "FEED_CHECK";
      
      public static const HIDE:String = "HIDE";
      
      public var sZid:String;
      
      public var bMuteUser:Boolean;
      
      public var playerName:String;
      
      public var gender:String;
      
      public var bFakeBuddyAdd:Boolean;
      
      override public function clone() : Event {
         return new ChickletMenuEvent(this.type,this.sZid,this.bMuteUser,this.playerName,this.gender,this.bFakeBuddyAdd);
      }
      
      override public function toString() : String {
         return formatToString("ChickletMenuEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
