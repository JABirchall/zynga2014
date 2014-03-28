package com.zynga.poker.popups
{
   public class Popup extends Object
   {
      
      public function Popup(param1:XML) {
         super();
         this.definition = param1;
         this.id = String(param1.@id);
         this.type = String(param1.@type);
         this.eventType = param1.child("event").toString();
         this.controllers = param1.child("event").attribute("controller").toString().split(",");
         if(this.type == "flash" && param1.child("content").child("module").length() > 0)
         {
            this.hasModule = true;
            this.moduleType = String(param1.content.module.@type);
            this.moduleClassName = String(param1.content.module.@className);
            this.moduleSource = String(param1.content.module.@src);
            this.moduleLoadType = String(param1.content.module.@loadType);
            if(String(param1.content.module.@dependencies) != "")
            {
               this._moduleDependencies = String(param1.content.module.@dependencies).split(",");
            }
         }
      }
      
      public static const BIG_MFS:String = "BigMFSPopUp";
      
      public static const BUDDY_DIALOG:String = "BuddyDialog";
      
      public static const CHALLENGES:String = "Challenges";
      
      public static const CHIP_EXPLOSION_ANIMATION:String = "ChipExplosionAnimation";
      
      public static const CLAIM_COLLECTION:String = "ClaimCollection";
      
      public static const CONFIRM_LEAVE_TABLE:String = "ConfirmLeaveTable";
      
      public static const CREATE_TABLE:String = "CreateTable";
      
      public static const DISCONNECT:String = "Disconnect";
      
      public static const ENTER_PASSWORD:String = "EnterPassword";
      
      public static const ERROR:String = "Error";
      
      public static const ERROR_REFRESH:String = "ErrorRefresh";
      
      public static const ERROR_NOT_CANCELABLE:String = "ErrorNotCancelable";
      
      public static const GIFT_SHOP:String = "GiftShop";
      
      public static const INTERSTITIAL:String = "Interstitial";
      
      public static const INSUFFICIENT_CHIPS:String = "InsufficientChips";
      
      public static const INSUFFICIENT_FUNDS:String = "InsufficientFunds";
      
      public static const LEADERBOARD:String = "Leaderboard";
      
      public static const LOGIN_ERROR:String = "LoginError";
      
      public static const LUCKY_BONUS:String = "LuckyBonus";
      
      public static const LUCKY_BONUS_FEED:String = "LuckyBonusFeed";
      
      public static const MINI_MFS:String = "MiniMFSPopUp";
      
      public static const NEW_USER:String = "NewUser";
      
      public static const OUT_OF_CHIPS_DIALOG:String = "OutOfChipsDialog";
      
      public static const POKER_GENIUS:String = "PokerGenius";
      
      public static const POKER_GENIUS_FEED:String = "PokerGeniusFeed";
      
      public static const POKER_SCORECARD:String = "PokerScoreCard";
      
      public static const POWER_TOURNEY_HOW_TO_PLAY:String = "PowerTournamentHowToPlay";
      
      public static const PRESELECT_MFS:String = "PreSelectPopUp";
      
      public static const PROFILE:String = "Profile";
      
      public static const REPORT_USER:String = "ReportUser";
      
      public static const SHOOTOUT_CONGRATS:String = "ShootoutCongrats";
      
      public static const SHOOTOUT_ERROR:String = "ShootoutError";
      
      public static const SHOOTOUT_HOW_TO_PLAY:String = "ShootoutHowToPlay";
      
      public static const SHOOTOUT_LEARN_MORE:String = "ShootoutLearnMore";
      
      public static const SHOWDOWN_CONGRATS:String = "ShowdownCongrats";
      
      public static const SHOWDOWN_TERMS_OF_SERVICE:String = "ShowdownTermsOfService";
      
      public static const SPIN_THE_WHEEL:String = "SpinTheWheel";
      
      public static const TABLE_CASHIER:String = "TableCashier";
      
      public static const TABLE_CASHIER_MONETIZED:String = "TableCashierMonetized";
      
      public static const TERMS_OF_SERVICE_REMINDER:String = "TermsOfServiceReminder";
      
      public static const TOURNAMENT_BUY_IN:String = "TournamentBuyIn";
      
      public static const TOURNAMENT_CONGRATS:String = "TournamentCongrats";
      
      public static const WEEKLY_HOW_TO_PLAY:String = "WeeklyHowToPlay";
      
      public static const HILO_GAME:String = "HiLoGame";
      
      public static const MINIGAME_HILO:String = "HighLow";
      
      public static const SCRATCHERS:String = "Scratchers";
      
      public static const BLACKJACK:String = "Blackjack";
      
      public static const ONECLICKREBUY:String = "OneClickRebuy";
      
      public static const AMEX_SERVE:String = "ServeProgress";
      
      public static const MTT:String = "MTT";
      
      public static const PLAYER_ROLLOVER:String = "PlayerRolloverRedesign";
      
      public static const BETTING_UI:String = "BettingUI";
      
      public static const MEGA_BILLIONS_LUCKY_BONUS:String = "MegaBillionsLuckyBonus";
      
      public static const BUDDIES_PANEL:String = "BuddiesPanel";
      
      public static const BUST_OUT:String = "BustOut";
      
      public static const BUDDIES_REQUESTS:String = "BuddiesRequestsPopup";
      
      public static const BUDDIES_LIST:String = "BuddiesList";
      
      public static const BUDDIES_TOASTER:String = "BuddiesToaster";
      
      public static const CARD_CONTROLLER:String = "TableCard";
      
      public static const DEALER_PUCK:String = "DealerPuck";
      
      public static const CHICKLET_MENU:String = "ChickletMenu";
      
      public static const TABLE_CHICKLET:String = "TableChicklet";
      
      public static const TABLE_SEAT:String = "TableSeat";
      
      public static const TABLE_INVITE:String = "TableInvite";
      
      public static const ATTABLEERASELOSS:String = "AtTableEraseLoss";
      
      public static const PLAYERSCLUBTOASTER:String = "PlayersClubToaster";
      
      public static const PLAYERSCLUBENVELOPE:String = "PlayersClubEnvelope";
      
      public static const PLAYERSCLUBREWARDCENTER:String = "PlayersClubRewardCenter";
      
      public static const XPCAPINCREASETOASTER:String = "XPCapIncreaseToaster";
      
      public static const HELPINGHANDSTOASTER:String = "HelpingHandsToaster";
      
      public static const HELPINGHANDSCAMPAIGNINFO:String = "HelpingHandsCampaignInfo";
      
      public var definition:XML;
      
      public var id:String;
      
      public var type:String;
      
      public var eventType:String;
      
      public var controllers:Array;
      
      public var hasModule:Boolean;
      
      public var moduleClassName:String;
      
      public var moduleType:String;
      
      public var moduleSource:String;
      
      public var moduleLoadType:String;
      
      private var _moduleDependencies:Array;
      
      public var module:Object;
      
      public var container:Object;
      
      public function get moduleDependencies() : Array {
         return (this._moduleDependencies) || ([]);
      }
      
      public function get isLoaded() : Boolean {
         return !(this.module == null);
      }
   }
}
