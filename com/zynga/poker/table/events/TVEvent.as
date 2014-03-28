package com.zynga.poker.table.events
{
   import flash.events.Event;
   
   public class TVEvent extends Event
   {
      
      public function TVEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const eType:String = "tableView";
      
      public static const LEAVE_TABLE:String = "LEAVE_TABLE";
      
      public static const STAND_UP:String = "STAND_UP";
      
      public static const SIT_PRESSED:String = "SIT_PRESSED";
      
      public static const MUTE_PRESSED:String = "MUTE_PRESSED";
      
      public static const LIKE_PRESSED:String = "LIKE_PRESSED";
      
      public static const SEND_CHAT:String = "SEND_CHAT";
      
      public static const MUTE_MOD:String = "MUTE_MOD";
      
      public static const INVITE_PRESSED:String = "INVITE_PRESSED";
      
      public static const PLAY_SOUND_ONCE:String = "PLAY_SOUND_ONCE";
      
      public static const ON_POST_TO_PLAY_CHANGE:String = "ON_POST_TO_PLAY_CHANGE";
      
      public static const TOGGLE_MUTE_SOUND:String = "TOGGLE_MUTE_SOUND";
      
      public static const REFRESH_JOIN_USER_PRESSED:String = "REFRESH_JOIN_USER_PRESSED";
      
      public static const HAND_STRENGTH_PRESSED:String = "HAND_STRENGTH_PRESSED";
      
      public static const JOIN_USER_PRESSED:String = "JOIN_USER_PRESSED";
      
      public static const GIFT_PRESSED:String = "GIFT_PRESSED";
      
      public static const POKER_SCORE_PRESSED:String = "POKER_SCORE_PRESSED";
      
      public static const BET_SLIDER_PRESSED:String = "BET_SLIDER_PRESSED";
      
      public static const BET_PLUS_PRESSED:String = "BET_PLUS_PRESSED";
      
      public static const BET_MINUS_PRESSED:String = "BET_MINUS_PRESSED";
      
      public static const BET_INPUT_PRESSED:String = "BET_INPUT_PRESSED";
      
      public static const CHAT_NAME_PRESSED:String = "CHAT_NAME_PRESSED";
      
      public static const CHAT_SHARE_PRESSED:String = "CHAT_SHARE_PRESSED";
      
      public static const FRIEND_NET_PRESSED:String = "FRIEND_NET_PRESSED";
      
      public static const EMPTY_GIFT_PRESSED:String = "EMPTY_GIFT_PRESSED";
      
      public static const POLL_CLOSE:String = "pollClose";
      
      public static const POLL_YES:String = "pollYes";
      
      public static const POLL_NO:String = "pollNo";
      
      public static const ON_BUY_CHIPS_CLICK:String = "onBuyChipsClick";
      
      public static const ON_HILO_REDIRECT_CLICK:String = "onHiloRedirectClick";
      
      public static const BOUNDARYUI_FADE_IN:String = "BOUNDARYUI_FADE_IN";
      
      public static const BOUNDARYUI_FADE_OUT:String = "BOUNDARYUI_FADE_OUT";
      
      public static const TV_INITIALIZED:String = "TV_INITIALIZED";
      
      public static const HSM_FREEUSE_PROMO_INVITE_PRESSED:String = "HSM_FREEUSE_PROMO_INVITE_PRESSED";
      
      public static const ON_START_JUMP_TABLE_SEARCH:String = "onStartJumpTableSearch";
      
      public static const ON_JUMP_TABLE_BUTTON_SHOWN:String = "onJumpTableButtonShown";
      
      public static const ON_CANCEL_JUMP_TABLE_SEARCH:String = "onCancelJumpTableSearch";
      
      public static const ON_TABLE_AD_BUTTON_CLICK:String = "onTableAdButtonClick";
      
      public static const ON_TIP_DEALER_CLICK:String = "onTipDealerClick";
      
      public static const ON_SHOW_MINIGAME_HIGHLOW:String = "onShowMinigameHighLow";
      
      public static const ON_HIDE_MINIGAME_HIGHLOW:String = "onHideMinigameHighLow";
      
      public static const ON_CHICKLET_ALPHA_CHANGED:String = "onChickletAlphaChanged";
      
      public static const ON_REPOSITION_CHICKLETS_START:String = "ON_REPOSITION_CHICKLETS_START";
      
      public static const ON_REPOSITION_CHICKLETS_COMPLETE:String = "ON_REPOSITION_CHICKLETS_COMPLETE";
      
      public static const ON_TABLE_CLEANUP:String = "onTableCleanup";
      
      public static const ON_HELPING_HANDS_CLICK:String = "ON_HELPING_HANDS_CLICK";
      
      public static const ON_HELPING_HANDS_HOVER:String = "ON_HELPING_HANDS_HOVER";
      
      public static const ON_HELPING_HANDS_MOUSE_OUT:String = "ON_HELPING_HANDS_MOUSE_OUT";
      
      public static const HELPING_HANDS_RAKE_BUTTON_CLICKED:String = "HELPING_HANDS_RAKE_BUTTON_CLICKED";
      
      public static const SKIP_TABLE_OVERLAY:String = "SKIP_TABLE_OVERLAY";
      
      public static const SKIP_TABLE_CLEAR_OVERLAY:String = "SKIP_TABLE_CLEAR_OVERLAY";
      
      public static const SHOW_LEADERBOARD:String = "SHOW_LEADERBOARD";
      
      public static const TABLE_PRESSED:String = "TABLE_PRESSED";
      
      public static const TABLE_ACE_PRESSED:String = "TABLE_ACE_PRESSED";
      
      public static const SHOW_DAILYCHALLENGE:String = "SHOW_DAILYCHALLENGE";
      
      public static const HIDE_DAILYCHALLENGE:String = "HIDE_DAILYCHALLENGE";
      
      public static const CHICKLET_LEFT:String = "CHICKLET_LEFT";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new TVEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("TVEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
