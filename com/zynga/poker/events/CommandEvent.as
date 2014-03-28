package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class CommandEvent extends Event
   {
      
      public function CommandEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const TYPE_CALL_FOR_HELP_CHALLENGE:String = "CommandEvent.callForHelpChallenge";
      
      public static const TYPE_JOIN_CHALLENGE:String = "CommandEvent.joinChallenge";
      
      public static const TYPE_HIDE_SIDENAV:String = "CommandEvent.hideSidenav";
      
      public static const TYPE_SHOW_SIDENAV:String = "CommandEvent.showSidenav";
      
      public static const TYPE_HIDE_LEADERBOARD_SURFACING:String = "CommandEvent.hideLeaderboardSurfacing";
      
      public static const TYPE_SHOW_LEADERBOARD_SURFACING:String = "CommandEvent.showLeaderboardSurfacing";
      
      public static const TYPE_HIDE_LEADERBOARD_FLYOUT:String = "CommandEvent.hideLeaderboardFlyout";
      
      public static const TYPE_SHOW_POKER_SCORE_SIDENAV:String = "CommandEvent.showPokerScoreSideNav";
      
      public static const TYPE_HIDE_FULLSCREEN:String = "CommandEvent.hideFullScreen";
      
      public static const TYPE_OPEN_TOURNAMENTS_AT_SUBTAB:String = "CommandEvent.openTournament";
      
      public static const TYPE_OPEN_CHALLENGES:String = "CommandEvent.openChallenges";
      
      public static const TYPE_OPEN_BUY_PAGE:String = "CommandEvent.TYPE_OPEN_BUY_PAGE";
      
      public static const TYPE_SHOW_LUCKY_BONUS:String = "CommandEvent.luckyBonus";
      
      public static const TYPE_FIRE_STAT_HIT:String = "CommandEvent.fireStatHit";
      
      public static const TYPE_UPDATE_COLLECTIONS_INFO:String = "CommandEvent.updateCollectionsInfo";
      
      public static const TYPE_UPDATE_POKER_GLOBAL_DATA:String = "CommandEvent.updatePokerGlobalData";
      
      public static const TYPE_OPEN_JS_POPUP:String = "CommandEvent.openJSPopup";
      
      public static const TYPE_UPDATE_NAV_ITEM_COUNT:String = "CommandEvent.updateNavItemCount";
      
      public static const TYPE_UPDATE_NAV_TIMER:String = "CommandEvent.updateNavTimer";
      
      public static const TYPE_INIT_LUCKY_HAND_COUPON:String = "CommandEvent.initLuckyHandCoupon";
      
      public static const TYPE_INIT_UNLUCKY_HAND_COUPON:String = "CommandEvent.initUnluckyHandCoupon";
      
      public static const TYPE_UPDATE_CHIPS:String = "CommandEvent.updateChips";
      
      public static const TYPE_UPDATE_CURRENCY:String = "CommandEvent.updateCurrency";
      
      public static const TYPE_UPDATE_TALITEMCOUNT:String = "CommandEvent.updateTALItemCount";
      
      public static const TYPE_REMOVE_TALITEM:String = "CommandEvent.removeTALItem";
      
      public static const TYPE_DISPLAY_GIFT_SHOP:String = "CommandEvent.displayGiftShop";
      
      public static const TYPE_UPDATE_TABLE_CASHIER:String = "CommandEvent.updateTableCashier";
      
      public static const TYPE_RESET_PROFILE_COUNTER:String = "CommandEvent.resetProfileCounter";
      
      public static const TYPE_UPDATE_PROFILE_ACHIEVEMENT_COUNTER:String = "CommandEvent.updateProfileAchievementCounter";
      
      public static const TYPE_SHOW_INSUFFICIENT_FUNDS:String = "CommandEvent.showInsufficientFunds";
      
      public static const TYPE_UPDATE_CASINO_GOLD:String = "CommandEvent.updateCasinoGold";
      
      public static const TYPE_OPEN_PROFILE_AT_TAB:String = "CommandEvent.showProfile";
      
      public static const TYPE_ACHIEVEMENT_ACTION:String = "CommandEvent.AchievementAction";
      
      public static const TYPE_SHOW_HSM_PROMO:String = "CommandEvent.showHSM";
      
      public static const TYPE_UPDATE_CHALLENGE_STATE:String = "CommandEvent.updateChallengeState";
      
      public static const TYPE_UPDATE_WAITING_CHALLENGES_COUNT:String = "CommandEvent.updateWaitingChallengesCount";
      
      public static const TYPE_NOTIFY_JS:String = "CommandEvent.notifyJS";
      
      public static const TYPE_UPDATE_USER_PREFERENCES:String = "CommandEvent.updateUserPreferences";
      
      public static const TYPE_SHOW_TOASTER:String = "CommandEvent.toaster";
      
      public static const TYPE_ATTACH_MINIGAME:String = "CommandEvent.attachMinigame";
      
      public static const TYPE_FIRE_ZTRACK_MILESTONE_HIT:String = "CommandEvent.fireZTrackMilestoneHit";
      
      public static const TYPE_FIND_ROOM:String = "CommandEvent.findRoom";
      
      public static const TYPE_HYPER_FIND_ROOM:String = "CommandEvent.hyperFindRoom";
      
      public static const TYPE_SHOW_LOBBY_BANNER:String = "CommandEvent.showLobbyBanner";
      
      public static const TYPE_SHOW_SKIP_TABLES_OVERLAY:String = "CommandEvent.showSkipTablesOverlay";
      
      public static const TYPE_SHOW_TABLE_ACE_MOTD:String = "CommandEvent.showTableAceMOTD";
      
      public static const TYPE_SURFACE_LEADERBOARD:String = "CommandEvent.surfaceLeaderboard";
      
      public static const TYPE_TABLE_CHAT_ENABLE:String = "CommandEvent.TableChatEnable";
      
      public static const TYPE_TABLE_CHICKLET_ENABLE:String = "CommandEvent.TableChickletEnable";
      
      public static const TYPE_TABLE_CHICKLET_UPDATE_POKER_SCORE:String = "CommandEvent.TableChickletUpdatePokerScore";
      
      public static const TYPE_TABLE_LEAVE:String = "CommandEvent.TableLeave";
      
      public static const TYPE_SHOW_MTT:String = "CommandEvent.showMtt";
      
      public static const TYPE_MTT_STAND_UP:String = "CommandEvent.mttStandUp";
      
      public static const TYPE_MTT_VERIFY_SERVER:String = "CommandEvent.mttVerifyServer";
      
      public static const TYPE_MTT_JOIN_TOURNAMENT:String = "CommandEvent.mttJoinTournament";
      
      public static const TYPE_MTT_LEAVE_TOURNAMENT:String = "CommandEvent.mttLeaveTournament";
      
      public static const TYPE_TABLE_SPOTLIGHT:String = "CommandEvent.tableSpotlight";
      
      public static const TYPE_MTT_CLAIM_REGISTER:String = "CommandEvent.mttClaimRegister";
      
      public static const TYPE_MTT_BLIND_INCREASE:String = "CommandEvent.mttIncreaseBlind";
      
      public static const TYPE_MTT_PLAY_NOW:String = "CommandEvent.mttPlayNow";
      
      public static const TYPE_MTT_CLOSE_FLYOUT:String = "CommandEvent.mttCloseFlyout";
      
      public static const TYPE_MTT_REQUEST_BLINDS:String = "CommandEvent.mttRequestBlinds";
      
      public static const TYPE_MTT_TOURNAMENT_TYPE:String = "CommandEvent.mttTournamentType";
      
      public static const TYPE_ZPWC_REGISTER_TOURNAMENT:String = "CommandEvent.zpwcRegisterForTournament";
      
      public static const TYPE_HELPINGHANDS_HAND_WON:String = "CommandEvent.HelpingHandsHandWon";
      
      public static const TYPE_ENABLE_TODO_ICON:String = "CommandEvent.showActionListItem";
      
      public static const TYPE_REQUEST_ZPWC_DATA:String = "CommandEvent.requestZPWCData";
      
      public static const TYPE_ZPWC_DATA_RESPONSE:String = "CommandEvent.ZPWCDataResponse";
      
      public static const TYPE_ADD_LUCKY_HAND_COUPON:String = "CommandEvent.AddLuckyHandCoupon";
      
      public static const TYPE_CHICKLET_COMMAND:String = "CommandEvent.ChickletCommand";
      
      public static const TYPE_TOGGLE_HELPING_HANDS_RAKE:String = "CommandEvent.ToggleHelpingHandsRake";
      
      public static const TYPE_SHOW_HELPING_HANDS_CAMPAIGN_INFO:String = "CommandEvent.ShowHelpingHandsCampaignInfo";
      
      public static const TYPE_SHOW_XPBOOST_TOASTER:String = "CommandEvent.ShowXPToaster";
      
      public static const TYPE_UPDATE_XPBOOST_TOASTER:String = "CommandEvent.UpdateXPToaster";
      
      public static const TYPE_SHOW_HAPPY_HOUR_LUCKY_BONUS:String = "CommandEvent.ShowHappyHourLuckyBonus";
      
      public static const TYPE_SHOW_HAPPY_HOUR_FLYOUT:String = "CommandEvent.ShowHappyHourFlyout";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new CommandEvent(type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("CommandEvent","type","params","bubbles","cancelable","eventPhase");
      }
   }
}
