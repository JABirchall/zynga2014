package com.zynga.poker.nav.events
{
   import flash.events.Event;
   
   public class NVEvent extends Event
   {
      
      public function NVEvent(param1:String, param2:Object=null, param3:Boolean=false) {
         super(param1,param3);
         this._params = param2;
      }
      
      public static const eType:String = "navView";
      
      public static const USER_PIC_CLICKED:String = "USER_PIC_CLICKED";
      
      public static const SHOW_GIFT_SHOP:String = "SHOW_GIFT_SHOP";
      
      public static const HIDE_GIFT_SHOP:String = "HIDE_GIFT_SHOP";
      
      public static const SHOW_USER_PROFILE:String = "SHOW_USER_PROFILE";
      
      public static const HIDE_USER_PROFILE:String = "HIDE_USER_PROFILE";
      
      public static const GET_CHIPS_CLICKED:String = "GET_CHIPS_CLICKED";
      
      public static const GOLD_ROLLOVER:String = "GOLD_ROLLOVER";
      
      public static const GOLD_ROLLOUT:String = "GOLD_ROLLOUT";
      
      public static const CHIPS_ROLLOVER:String = "CHIPS_ROLLOVER";
      
      public static const CHIPS_ROLLOUT:String = "CHIPS_ROLLOUT";
      
      public static const ACHIEVEMENTS_CLICKED:String = "ACHIEVEMENTS_CLICKED";
      
      public static const GAME_SETTINGS_CLICKED:String = "GAME_SETTINGS_CLICKED";
      
      public static const GAME_CARD_BUTTON_CLICK:String = "GAME_CARD_BUTTON_CLICK";
      
      public static const NEWS_BUTTON_CLICK:String = "NEWS_BUTTON_CLICK";
      
      public static const SHOW_BUDDIES_DROPDOWN:String = "SHOW_BUDDIES_DROPDOWN";
      
      public static const SHOW_BUDDIES:String = "SHOW_BUDDIES";
      
      public static const TOGGLE_BUDDIES_DROPDOWN:String = "TOGGLE_BUDDIES_DROPDOWN";
      
      public static const HIDE_BUDDIES_DROPDOWN:String = "HIDE_BUDDIES_DROPDOWN";
      
      public static const HIDE_BUDDIES:String = "HIDE_BUDDIES";
      
      public static const SHOW_GET_CHIPS:String = "SHOW_GET_CHIPS";
      
      public static const HIDE_GET_CHIPS:String = "HIDE_GET_CHIPS";
      
      public static const SHOW_CHALLENGES:String = "SHOW_CHALLENGES";
      
      public static const HIDE_CHALLENGES:String = "HIDE_CHALLENGES";
      
      public static const SHOW_BETTING:String = "SHOW_BETTING";
      
      public static const HIDE_BETTING:String = "HIDE_BETTING";
      
      public static const PLAYING_LEVELUP_ANIMATION:String = "PLAYING_LEVELUP_ANIMATION";
      
      public static const PLAYING_LEVELUP_ANIMATION_WITH_BUTTON:String = "PLAYING_LEVELUP_ANIMATION_WITH_BUTTON";
      
      public static const STOP_LEVELUP_ANIMATION:String = "STOP_LEVELUP_ANIMATION";
      
      public static const SHOW_POKER_GENIUS:String = "SHOW_POKER_GENIUS";
      
      public static const HIDE_POKER_GENIUS:String = "HIDE_POKER_GENIUS";
      
      public static const SHOW_LUCKY_BONUS:String = "SHOW_LUCKY_BONUS";
      
      public static const SHOW_LUCKY_BONUS_GOLD:String = "SHOW_LUCKY_BONUS_GOLD";
      
      public static const HIDE_LUCKY_BONUS:String = "HIDE_LUCKY_BONUS";
      
      public static const SHOW_SCRATCHERS:String = "SHOW_SCRATCHERS";
      
      public static const HIDE_SCRATCHERS:String = "HIDE_SCRATCHERS";
      
      public static const FTUE_CLICKED:String = "FTUE_CLICKED";
      
      public static const SHOW_BLACKJACK:String = "SHOW_BLACKJACK";
      
      public static const HIDE_BLACKJACK:String = "HIDE_BLACKJACK";
      
      public static const SHOW_ONECLICKREBUY:String = "SHOW_ONECLICKREBUY";
      
      public static const HIDE_ONECLICKREBUY:String = "HIDE_ONECLICKREBUY";
      
      public static const PREP_HIDE_ONECLICKREBUY:String = "PREP_HIDE_ONECLICKREBUY";
      
      public static const SHOW_GAME_DROPDOWN:String = "SHOW_GAME_DROPDOWN";
      
      public static const HIDE_GAME_DROPDOWN:String = "HIDE_GAME_DROPDOWN";
      
      public static const PG_CLOSE_ANIM:String = "PG_CLOSE_ANIM";
      
      public static const PG_CLOSE_ANIM_FIN:String = "PG_CLOSE_ANIM_FIN";
      
      public static const SHOW_SERVEPROGRESS:String = "SHOW_AMEX";
      
      public static const HIDE_SERVEPROGRESS:String = "HIDE_AMEX";
      
      public static const SHOW_POKER_SCORE_CARD:String = "SHOW_POKER_SCORE_CARD";
      
      public static const SHOW_LEADERBOARD:String = "SHOW_LEADERBOARD";
      
      public static const BOUNDARYUI_FADE_IN:String = "BOUNDARYUI_FADE_IN";
      
      public static const BOUNDARYUI_FADE_OUT:String = "BOUNDARYUI_FADE_OUT";
      
      public static const GOLDHIT_CLICKED:String = "GOLDHIT_CLICKED";
      
      public static const CHIPSHIT_CLICKED:String = "CHIPSHIT_CLICKED";
      
      public static const HIDE_ARCADE_LUCKYBONUS_AD:String = "HIDE_ARCADE_LUCKYBONUS_AD";
      
      public static const ARCADE_PLAYNOW_CLICKED:String = "ARCADE_PLAYNOW_CLICKED";
      
      public static const SHOW_LUCKY_HAND_COUPON:String = "SHOW_LUCKY_HAND_COUPON";
      
      public static const SHOW_UNLUCKY_HAND_COUPON:String = "SHOW_UNLUCKY_HAND_COUPON";
      
      public static const HIDE_ATTABLEERASELOSS_SIDENAV:String = "HIDE_ATTABLEERASELOSS_SIDENAV";
      
      public static const SHOW_ATTABLEERASELOSS_COUPON:String = "SHOW_ATTABLEERASELOSS_COUPON";
      
      public static const SLIDE_ATTABLEERASELOSS_COUPON:String = "SLIDE_ATTABLEERASELOSS_COUPON";
      
      public static const SHOW_NEW_BUYER_SALE_UNLOCK:String = "SHOW_NEW_BUYER_SALE_UNLOCK_COUPON";
      
      public static const SHOW_PLAYERS_CLUB_TOASTER:String = "SHOW_PLAYERS_CLUB_TOASTER";
      
      public static const SHOW_PLAYERS_CLUB_REWARD_CENTER:String = "SHOW_PLAYERS_CLUB_REWARD_CENTER";
      
      public static const SHOW_BUY_PAGE:String = "SHOW_BUY_PAGE";
      
      public static const SHOW_XP_BOOST_TOASTER:String = "SHOW_XP_BOOST_TOASTER";
      
      public static const REMOVE_XP_BOOST_TOASTER:String = "REMOVE_XP_BOOST_TOASTER";
      
      private var _params:Object;
      
      override public function clone() : Event {
         return new NVEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("NVEvent","type","bubbles","cancelable","eventPhase");
      }
      
      public function get params() : Object {
         return this._params;
      }
   }
}
