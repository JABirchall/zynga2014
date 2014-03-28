package com.zynga.poker
{
   import com.zynga.poker.shootout.ShootoutUser;
   import com.zynga.utils.FlashCookie;
   import com.zynga.User;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.protocol.RMoveGivenPlayer;
   import com.zynga.poker.table.GiftLibrary;
   import com.zynga.io.IExternalCall;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.poker.constants.LiveChromeAchievements;
   import com.adobe.serialization.json.JSON;
   import com.zynga.poker.table.BuddyInvite;
   import com.zynga.io.ExternalCall;
   
   public class PokerGlobalData extends Object implements IUserModel, IRevPromoModel
   {
      
      public function PokerGlobalData(param1:Inner) {
         this.aSnNames = new Array("none","Facebook","Orkut","Meebo","HI5","Friendster","Bebo","MySpace","Zynga","Yahoo","Tagged");
         this.xpLevels = new Array(
            {
               "level":1,
               "name":"flash.global.xp.level.1"
            },
            {
               "level":5,
               "name":"flash.global.xp.level.5"
            },
            {
               "level":10,
               "name":"flash.global.xp.level.10"
            },
            {
               "level":15,
               "name":"flash.global.xp.level.15"
            },
            {
               "level":20,
               "name":"flash.global.xp.level.20"
            },
            {
               "level":25,
               "name":"flash.global.xp.level.25"
            },
            {
               "level":30,
               "name":"flash.global.xp.level.30"
            },
            {
               "level":35,
               "name":"flash.global.xp.level.35"
            },
            {
               "level":40,
               "name":"flash.global.xp.level.40"
            },
            {
               "level":45,
               "name":"flash.global.xp.level.45"
            },
            {
               "level":50,
               "name":"flash.global.xp.level.50"
            },
            {
               "level":55,
               "name":"flash.global.xp.level.55"
            },
            {
               "level":75,
               "name":"flash.global.xp.level.75"
            },
            {
               "level":102,
               "name":"flash.global.xp.level.102"
            });
         this.aRankNames = new Array("","1K+","5K+","10K+","20K+","50K+","100K+","250K+","500K+","1M+","5M+","10M+","20M+","50M+");
         this.sigParams = new Object();
         this.playingBonusSentIDs = new Array();
         this.timeStamp = new Date().time;
         this.leaderboardData = {};
         super();
         if(!param1)
         {
            throw new Error("PokerGlobalData cannot be instantiated.");
         }
         else
         {
            this.aBuddyInvites = new Array();
            this.oGiftLib = GiftLibrary.GetInst();
            _loc2_ = new Date();
            this.uAppStartTime = _loc2_.time;
            this._externalInterface = ExternalCall.getInstance();
            return;
         }
      }
      
      public static const LOBBY_MODE_CHALLENGE:String = "challenge";
      
      public static const LOBBY_MODE_TOURNAMENT:String = "tournament";
      
      public static const LOBBY_MODE_PRIVATE:String = "private";
      
      private static var _instance:PokerGlobalData;
      
      public static function get instance() : PokerGlobalData {
         if(!_instance)
         {
            _instance = new PokerGlobalData(new Inner());
         }
         return _instance;
      }
      
      public var main:Object;
      
      public var configModel:ConfigModel;
      
      public var disableLiveJoin:Boolean = false;
      
      public var hideLobbyTableHover:Boolean = false;
      
      public var hideChangeCasinoButton:Boolean = false;
      
      public var hideTableNamesInLobby:Boolean = false;
      
      public var hideTableInfoAtTable:Boolean = false;
      
      private var _enableHyperJoin:Boolean = false;
      
      private var _lobbyUncheckBoxes:Boolean = false;
      
      private var _enableRoomTypeOnly:Boolean = false;
      
      public var _zid:String;
      
      private var _sn_id:int;
      
      public var true_sn:int = 0;
      
      private var _uid:String;
      
      public var obfuscatedUid:String;
      
      public var aFriendZids:Array;
      
      public var aAppIds:Array;
      
      public var sRootURL:String;
      
      public var nAchievementRank:int;
      
      private var unixApploadTimestamp:Number;
      
      public var loadInitiatedTime:int;
      
      public var nAchievementNumber:int;
      
      private var _pic_url:String;
      
      public var pic_lrg_url:String;
      
      public var tourneyState:int;
      
      public var tourneyStartDate:String;
      
      public var tourneyEndDate:String;
      
      public var bDidPurchaseShootoutSkip:Boolean = false;
      
      public var soUser:ShootoutUser = null;
      
      public var eraseLossRTLUpperLimit:uint = 90000000;
      
      public var eraseLossRTLLowerLimit:uint = 500000;
      
      public var eraseLossRTLNetMovement:uint = 0;
      
      public var improvedEraseLossRTLLowerLimit:uint = 10000;
      
      public var improvedEraseLossRTLpercent:uint = 15;
      
      public var disableNewUserPopup:Boolean;
      
      public var curr_tourney:String;
      
      public var tourney_invite:String;
      
      public var tourney_seats_available:String;
      
      public var debugShout:Boolean = false;
      
      public var trace_stats:int = 0;
      
      public var bAutoFindSeat:Boolean = false;
      
      public var promoTableBG:String;
      
      public var lobbySWF:String;
      
      public var server_type:String = null;
      
      public var joinShootoutLobby:Boolean = false;
      
      public var joinWeeklyLobby:Boolean = false;
      
      public var joinPremiumLobby:Boolean = false;
      
      public var joiningShootout:Boolean = false;
      
      public var bDidGetShootoutState:Boolean = false;
      
      public var isShootoutWasWeekly:Boolean = false;
      
      public var joiningContact:Boolean = false;
      
      public var joiningAnyTable:Boolean = false;
      
      public var joinPrevServ:Boolean = false;
      
      public var bUserDisconnect:Boolean = false;
      
      public var bVipNav:Boolean = false;
      
      public var iAmMod:Boolean = false;
      
      private var _serverName:String;
      
      public var ip:String = "";
      
      public var lastKnownGoodPort:String = "";
      
      public var serverId:String;
      
      public var newServerId:String;
      
      public var retryCookie:FlashCookie = null;
      
      public var nRetries:int = -2;
      
      public var flashCookie:FlashCookie = null;
      
      public var opt_Sound:Boolean;
      
      public var opt_Lobby_HideFullTables:Boolean;
      
      public var opt_Lobby_HideEmptyTables:Boolean;
      
      public var opt_LobbyTourney_HideRunningTables:Boolean;
      
      public var opt_LobbyTourney_HideEmptyTables:Boolean;
      
      public var protoVersion:int = 10;
      
      public var playLevel:int;
      
      private var _name:String;
      
      private var _gender:String;
      
      private var _points:Number;
      
      public var usersOnline:Number;
      
      public var rejoinRoom:int;
      
      public var rejoinType:uint;
      
      public var rejoinPass:String;
      
      public var rejoinTime:Number;
      
      public var bonus:Number = 0;
      
      public var nHideGifts:int;
      
      public var giftFilters:int = 0;
      
      private var _inLobbyRoom:Boolean = false;
      
      private var _xpLevel:Number;
      
      public var currentXP:Number;
      
      public var xpToNextLevel:Number;
      
      public var sortByStakesLevel:int = 0;
      
      public var showingLevelUpAnimation:Boolean = false;
      
      public var GIVE_CHIPS_TIME:int = 120000.0;
      
      public const SN_DEFAULT:int = 0;
      
      public const SN_FACEBOOK:int = 1;
      
      public const SN_ORKUT:int = 2;
      
      public const SN_MEEBO:int = 3;
      
      public const SN_HI5:int = 4;
      
      public const SN_FRIENDSTER:int = 5;
      
      public const SN_BEBO:int = 6;
      
      public const SN_MYSPACE:int = 7;
      
      public const SN_ZYNGA:int = 8;
      
      public const SN_YAHOO:int = 9;
      
      public const SN_TAGGED:int = 10;
      
      public const SN_ZYNGALIVE:int = 18;
      
      public const SN_SNAPI:int = 18;
      
      public const SN_STANDALONEZDC:int = 104;
      
      public var aSnNames:Array;
      
      public var xpLevels:Array;
      
      public var aRankNames:Array;
      
      private var _previousDisplayMode:String = null;
      
      private var _dispMode:String = "challenge";
      
      public var firstRoomList:Boolean = true;
      
      public var lobbyRoomId:int;
      
      private var _gameRoomId:int;
      
      public var gameRoomName:String;
      
      public var gameRoomStakes:String = "";
      
      public var bRoomListInit:Boolean = false;
      
      public var bLobbyAssetsLoaded:Boolean = false;
      
      public var viewer:User;
      
      public var aGameRooms:Array;
      
      public var aRoomsById:Array;
      
      public var lbPopup:Object;
      
      public var lbLobby:Object;
      
      public var lbNav:Object;
      
      public var lbTable:Object;
      
      public var lbConfig:Object;
      
      public var nNewRoomId:int = -1;
      
      public var newRoomName:String;
      
      public var nPrivateRoomId:int = -1;
      
      public var activeRoom:RoomItem;
      
      public var bAutoSitMe:Boolean = false;
      
      public var assignedSeat:int = 0;
      
      public var assignedRoom:int = -1;
      
      public var forcedSeat:int = -1;
      
      public var requiredSmallBlind:int = 0;
      
      public var movePass:String;
      
      public var moveTimestamp:Number;
      
      public var moveServerId:int;
      
      public var moveRoom:int;
      
      public var rollingRebootOverride:RMoveGivenPlayer = null;
      
      public var assignedChips:int = 0;
      
      public var bIsFastRR:Boolean = false;
      
      public var oGiftLib:GiftLibrary = null;
      
      public var aBuddyInvites:Array;
      
      public var oCurrTourney:Object;
      
      public var oTourneyInvite:Object;
      
      public var oTourneySeatsAvailable:Object;
      
      public var nWeeklyTourneyId:int;
      
      public var soPremiumId:Number = 1;
      
      public var bTableSoundMute:Boolean = false;
      
      private var _casinoGold:Number;
      
      public var gameLoadingComplete:Boolean = false;
      
      public var bFbFeedAllow:Boolean = true;
      
      public var bFbFeedOptin:Boolean = false;
      
      public var tourneyResultsPlace:Number;
      
      public var tourneyResultsWinnings:Number;
      
      public var sigParams:Object;
      
      public var xmlPopups:XML;
      
      public var xmlAssets:XML;
      
      private var uAppStartTime:Number;
      
      public var ZLiveToggle:Number = -1;
      
      public var showJoinNotifs:Boolean = false;
      
      public var countryCode:String = "";
      
      public var isJoinFriendSit:Boolean = false;
      
      public var isJoinFriend:Boolean = false;
      
      public var joinFriendId:String = "";
      
      public var joinFriendName:String = "";
      
      public var shootoutRegisterUrl:String = "";
      
      public var skipShootoutRound1Price:Number = 5;
      
      public var skipShootoutRound2Price:Number = 50;
      
      public var playingBonusSentIDs:Array;
      
      public var nBudPlayBonus:Number = 0;
      
      public var bForceDisplayOfMyChallenges:Boolean = false;
      
      public var iWaitingChallengesCount:int = -1;
      
      public var iUserChallengeStarted:int = -1;
      
      public var flashVersionGood:Boolean = false;
      
      private var _userLocale:String = "";
      
      public var userToken:String;
      
      public var userTokenExpirationDate:Date;
      
      public var userTokenCounter:int;
      
      public var pgViewAndDisplay:int = 1;
      
      public var shownGiftID:int = -1;
      
      public var enableTableSendChips:Boolean = false;
      
      public var tableChipsSent:Boolean = false;
      
      public var bDidGetInitialChallengeState:Boolean = false;
      
      public var doubleNewUserInitialChips:int = 4000;
      
      public var hasHadSecondSession:Boolean = false;
      
      public var hasSeenFirstItem:Boolean = false;
      
      public var hasUsedHsm:Boolean = false;
      
      public var hasChatted:Boolean = false;
      
      public var hasPlayedFastTable:Boolean = false;
      
      public var hasRaised:Boolean = false;
      
      public var hasFolded:Boolean = false;
      
      public var firstTimeCollections:Boolean = false;
      
      public var showCollectionsOnLoad:Boolean = false;
      
      public var collections:Array;
      
      public var newCollectionItemCount:Number = 0;
      
      public var buddyRequestedItemsCount:Number = 0;
      
      public var buddyRequestedItemsOffsetCount:Number = 0;
      
      public var emailSubscribed:Boolean = false;
      
      public var smartfoxVars:Object;
      
      public var buildVersion:int = 1;
      
      public var clientSupportsUnreachableProtection:int = 1;
      
      public var externalInterfaceReady:Boolean = false;
      
      public var joinRoomInsufficientChips:Boolean = false;
      
      public var lobbyStats:Boolean = false;
      
      public var privateTableEnabled:Boolean = false;
      
      public var privateTableCommonPassword:String = "dinbog";
      
      private var _userPreferencesContainer:UserPreferencesContainer;
      
      public var ratholingInfoObj:Object;
      
      public var _revPromoID:int = 0;
      
      public function get revPromoID() : int {
         return this._revPromoID;
      }
      
      public var _revPromoAnimationApplied:Boolean = false;
      
      public function set revPromoAnimationApplied(param1:Boolean) : void {
         this._revPromoAnimationApplied = param1;
      }
      
      public function get revPromoAnimationApplied() : Boolean {
         return this._revPromoAnimationApplied;
      }
      
      public function get xpLevel() : Number {
         return this._xpLevel;
      }
      
      public function set xpLevel(param1:Number) : void {
         this._xpLevel = param1;
      }
      
      public var tableOverlayAnimating:Boolean = false;
      
      public var showGameCardButtonArrows:int = 0;
      
      public var disableShareWithFriendsCheckboxes:Boolean = false;
      
      public var rakeEnabled:int = 0;
      
      public var rakePercentage:Number = 0.0;
      
      public var rakeBlindMultiplier:Number = 1.0;
      
      public var hasSeenHSMPromo:Boolean = false;
      
      public var hasSeenHSMPromo2:Boolean = false;
      
      public var hasSeenHSMInlineUpsell:Boolean = false;
      
      public var hasReceivedBanSignal:Boolean = false;
      
      public var disableRTLPopup:Boolean = false;
      
      public var showShoutoutSponsorRequest:Boolean = false;
      
      public var arbAutoRebuySelected:Boolean = false;
      
      public var arbTopUpStackSelected:Boolean = false;
      
      public var disableChipsAndGold:Boolean = false;
      
      public var jumpTablesEnabled:Boolean = false;
      
      public var willJumpTable:Boolean = false;
      
      public var tableIdToJumpTo:Number = -1;
      
      public var tableNameToJumpTo:String = "";
      
      public var showHiLoSideNavPromo:Boolean = false;
      
      private var _staticUrlPrefix:String = null;
      
      public var luckyBonusEnabled:Boolean = false;
      
      public var luckyBonusFeedPostEnabled:Boolean = true;
      
      public var luckyBonusFTUEEligible:Boolean = false;
      
      public var luckyBonusTimeUntil:Number = 0;
      
      public var luckyBonusAnimationURL:String;
      
      public var luckyBonusHappyHourAnimationURL:String;
      
      public var luckyBonusFriendCount:int;
      
      public var luckyBonusPayoutMultiplier:Number = 1.0;
      
      public var luckyBonusGoldMultipliers:Object = 1;
      
      public var luckyBonusGoldMultiplierCount:uint = 0;
      
      public var luckyBonusGoldEnabled:Boolean = false;
      
      public var luckyBonusAutoPopupComplete:Boolean = false;
      
      public var timeStamp:Number;
      
      public var freeFullScreenMode:Boolean = false;
      
      public var rakeFullScreenMode:Boolean = false;
      
      public var disconnectionPopupShown:Boolean = false;
      
      public var loginErrorPopupShown:Boolean = false;
      
      public var HighLowGameShowOnFirstFold:Boolean = false;
      
      public var HighLowGameDealerChat:Boolean = false;
      
      public var HighLowGameSWFURL:String = "";
      
      public var HighLowGameFG:String = "";
      
      public var maxAchievementMasteryLevel:int;
      
      public var achievementImageSubDir:String = "";
      
      public var newAchievementItemCount:Number = 0;
      
      public var achievementOldShoutTextEnabled:Boolean = false;
      
      public var userDidSelectTableFromTableSelector:Boolean = false;
      
      public var scratchersConfigObject:Object;
      
      public var pokerGeniusSettings:Object;
      
      public var serveProgressData:Object;
      
      public var serveProgressSidenavAdState:int = 2;
      
      private var _externalInterface:IExternalCall;
      
      private var _lastHyperJoin:JoinRoomTransition = null;
      
      private var _roomIdDisplay:int = 0;
      
      private var _roomNameDisplay:String = null;
      
      public var enableMTT:Boolean = false;
      
      public var enableMTTSurface:Boolean = false;
      
      public var mttZone:Boolean = false;
      
      public var enableZPWC:Boolean = false;
      
      public var enableZPWCSurfacing:Boolean = false;
      
      private var _zpwcTickets:int = 0;
      
      public var showZPWCLobbyArrow:Boolean = false;
      
      public var showArcadePostLuckyBonusAd:Boolean = true;
      
      public var lbPayoutMultEnabled:Boolean = false;
      
      public var lbPayoutMultAmt:int = 1;
      
      public var lbPayoutHardCap:int = 0;
      
      public var lbCOGEnabled:Boolean = false;
      
      public var leaderboardData:Object;
      
      public var maxBuyinPercentOfChipstack:Number = 0.2;
      
      public var leaderboardEnabled:Boolean = false;
      
      public var playAtStakes:Number = 0;
      
      public var luckyHandStartTime:Number = 0;
      
      public var luckyHandTimeLeft:Number = 0;
      
      public var luckyHandCouponEnabled:Boolean = false;
      
      public var megaBillionsEnabled:Boolean = false;
      
      public var _dailyAppEntryCount:int = 0;
      
      public function loadConfigData() : void {
         var _loc13_:String = null;
         var _loc14_:Array = null;
         var _loc15_:* = undefined;
         var _loc1_:Object = this.configModel.getFeatureConfig("user");
         if(_loc1_ != null)
         {
            this.emailSubscribed = _loc1_.emailSubscribed;
            this.true_sn = _loc1_.true_sn;
            this._sn_id = _loc1_.sn_id;
            this.countryCode = _loc1_.countryCode;
            if(_loc1_.uid)
            {
               this.zid = _loc1_.uid;
               this.uid = this.zid.split(":")[1];
            }
            else
            {
               this.zid = this.uid = "";
            }
            if(_loc1_.userLocale != null)
            {
               this._userLocale = _loc1_.userLocale;
            }
            this._pic_url = (_loc1_.pic_url) && (SafeAssetLoader.checkValidUrl(_loc1_.pic_url))?_loc1_.pic_url:"";
            _loc1_.pic_lrg_url = (_loc1_.pic_lrg_url) && (SafeAssetLoader.checkValidUrl(_loc1_.pic_lrg_url))?_loc1_.pic_lrg_url:"";
         }
         var _loc2_:Object = this.configModel.getFeatureConfig("core");
         if(_loc2_)
         {
            this._dailyAppEntryCount = _loc2_.dailyAppEntryCount;
            this._staticUrlPrefix = _loc2_.static_url_prefix;
            this.sRootURL = _loc2_.root_url;
            this.disableLiveJoin = _loc2_.disableLiveJoin;
            this.hideLobbyTableHover = _loc2_.hideLobbyTableHover;
            this.hideChangeCasinoButton = _loc2_.hideChangeCasinoButton;
            this.hideTableNamesInLobby = _loc2_.hideTableNamesInLobby;
            this.hideTableInfoAtTable = _loc2_.hideTableInfoAtTable;
            this._enableHyperJoin = _loc2_.enableHyperJoin;
            this._lobbyUncheckBoxes = _loc2_.lobbyUncheckBoxes;
            this._enableRoomTypeOnly = _loc2_.enableRoomTypeOnly;
            if(_loc2_.sslEnabled)
            {
               SSLMigration.isSSLEnabled = true;
               SSLMigration.collectionUrlPrefix = this._staticUrlPrefix;
            }
            if(_loc2_.statHitFileURL)
            {
               PokerStatsManager.statHitFileURL = _loc2_.statHitFileURL;
               PokerStatsManager.getInstance().makeThrottledHits = true;
            }
            if((this._sn_id == this.SN_SNAPI || this._sn_id == this.SN_FACEBOOK) && (_loc2_.snapi_auth))
            {
               this.sigParams.snapi_auth = _loc2_.snapi_auth;
            }
            PokerStatsManager.doNav3Stats = _loc2_.doNav3Stats?_loc2_.doNav3Stats:false;
            this.disableShareWithFriendsCheckboxes = _loc2_.disableShareWithFriendsCheckboxes;
            this.freeFullScreenMode = _loc2_.freeFullScreenMode;
            this.rakeFullScreenMode = _loc2_.rakeFullScreenMode;
            this.unixApploadTimestamp = _loc2_.unixApploadTimestamp;
         }
         var _loc3_:Object = this.configModel.getFeatureConfig("smartfox");
         if(_loc3_ != null)
         {
            this.smartfoxVars = _loc3_;
         }
         var _loc4_:Object = this.configModel.getFeatureConfig("userPrefs");
         if(_loc4_ != null)
         {
            this._userPreferencesContainer = new UserPreferencesContainer();
         }
         var _loc5_:Object = this.configModel.getFeatureConfig("lobby");
         if(_loc5_)
         {
            if(_loc5_.unlockFastTablesLevel)
            {
               UnlockComponentsLevel.fastTables = _loc5_.unlockFastTablesLevel;
            }
            if(_loc5_.lobbyStats)
            {
               this.lobbyStats = _loc5_.lobbyStats;
            }
         }
         var _loc6_:Object = this.configModel.getFeatureConfig("friendList");
         if(!(_loc6_ == null) && !(_loc6_.friendlist == null))
         {
            this.aFriendZids = _loc6_.friendlist.split(",");
         }
         var _loc7_:Object = this.configModel.getFeatureConfig("achievements");
         if(_loc7_)
         {
            this.nAchievementNumber = _loc7_.ach_num;
         }
         var _loc8_:Object = this.configModel.getFeatureConfig("pokerGenius");
         if(_loc8_)
         {
            this.pokerGeniusSettings = _loc8_.pokerGeniusSettings;
         }
         var _loc9_:Object = this.configModel.getFeatureConfig("serveProgress");
         if(_loc9_)
         {
            this.serveProgressData = _loc9_.serveProgressData;
         }
         var _loc10_:Object = this.configModel.getFeatureConfig("tableRebal");
         if(this.configModel.getBooleanForFeatureConfig("powerTourneyHappyHour","showPowerTourneyToaster"))
         {
            _loc10_.showFTUE = false;
         }
         var _loc11_:Object = this.configModel.getFeatureConfig("mtt");
         if(_loc11_)
         {
            this.enableMTT = this.configModel.isFeatureEnabled("mtt");
            this.enableMTTSurface = _loc11_.enableMTTSurface;
         }
         this.nHideGifts = 0;
         var _loc12_:Object = this.configModel.getFeatureConfig("giftShop");
         if(_loc12_)
         {
            _loc13_ = _loc12_.hideGifts;
            if(!(_loc13_ == null) && !(_loc13_ == ""))
            {
               _loc14_ = _loc13_.split(",");
               for (_loc15_ in _loc14_)
               {
                  if(_loc14_[_loc15_] != 0)
                  {
                     this.nHideGifts = 1;
                     this.giftFilters = _loc14_[_loc15_];
                     break;
                  }
               }
            }
         }
         this.processLuckyBonusData();
         this.processLiveChromeData();
      }
      
      private function processLuckyBonusData() : void {
         var _loc2_:String = null;
         var _loc1_:Object = this.configModel.getFeatureConfig("luckyBonus");
         if(_loc1_ == null)
         {
            return;
         }
         this.luckyBonusEnabled = !(_loc1_ == null) && (_loc1_.enabled);
         this.luckyBonusFeedPostEnabled = _loc1_.feedPostEnabled;
         this.luckyBonusFTUEEligible = _loc1_.LB_FTUE;
         this.luckyBonusTimeUntil = Math.max(0,_loc1_.LB_time_left_for_next_claim);
         this.luckyBonusAnimationURL = _loc1_.LB_sidenav;
         this.luckyBonusHappyHourAnimationURL = _loc1_.LB_sidenav_HH;
         this.luckyBonusFriendCount = _loc1_.LB_multiplier;
         this.luckyBonusGoldMultipliers = _loc1_.LB_gold_bonusmultipliers;
         this.luckyBonusPayoutMultiplier = _loc1_.LB_payoutMultiplier;
         for (_loc2_ in this.luckyBonusGoldMultipliers)
         {
            this.luckyBonusGoldMultiplierCount++;
         }
         this.luckyBonusGoldEnabled = this.luckyBonusGoldMultiplierCount > 0;
         if(_loc1_.lbPayoutMultEnabled != null)
         {
            this.lbPayoutMultEnabled = _loc1_.lbPayoutMultEnabled;
            this.lbPayoutMultAmt = _loc1_.lbPayoutMultAmt;
         }
         this.lbPayoutHardCap = _loc1_.LB_payoutHardCap;
         if(_loc1_.lbCOGEnabled != null)
         {
            this.lbCOGEnabled = _loc1_.lbCOGEnabled;
         }
      }
      
      private function processLiveChromeData() : void {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc1_:Object = this.configModel.getFeatureConfig("liveChrome");
         if(!(_loc1_ == null) && !(_loc1_.liveChromeFlags == null))
         {
            _loc2_ = _loc1_.liveChromeFlags;
            if(_loc2_.indexOf(LiveChromeAchievements.SHAKE_THAT_HEALTHY_STACK_ID) > -1)
            {
               this.doubleNewUserInitialChips = 1;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.LAST_LONGER_THAN_MOST_MEN_ID) > -1)
            {
               this.hasHadSecondSession = true;
            }
            else
            {
               _loc3_ = this.configModel.getFeatureConfig("user");
               if(_loc3_.dailyLoadCount < 2)
               {
                  this.hasHadSecondSession = true;
               }
            }
            if(_loc2_.indexOf(LiveChromeAchievements.GET_THAT_BOOTY_ID) > -1)
            {
               this.hasSeenFirstItem = true;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.KNOWING_IS_HALF_THE_BATTLE_ID) > -1)
            {
               this.hasUsedHsm = true;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.GREET_THOSE_YOU_BEAT_ID) > -1)
            {
               this.hasChatted = true;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.FAST_AND_THE_CURIOUS_ID) > -1)
            {
               this.hasPlayedFastTable = true;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.TAKE_CONTROL_ID) > -1)
            {
               this.hasRaised = true;
            }
            if(_loc2_.indexOf(LiveChromeAchievements.WHEN_TO_FOLD_ID) > -1)
            {
               this.hasFolded = true;
            }
         }
      }
      
      public function assignFlashVars(param1:Object) : void {
         var sKey:String = null;
         var sValue:String = null;
         var key:String = null;
         var inFlashVars:Object = param1;
         var oFlashVars:Object = inFlashVars;
         for (sKey in oFlashVars)
         {
            sValue = String(oFlashVars[sKey]);
         }
         this.nAchievementRank = int(inFlashVars.achievement_rank);
         this.disableNewUserPopup = Boolean(inFlashVars.disableNewUserPopup);
         this.debugShout = int(inFlashVars.debugShout) == 1?true:false;
         if(!(inFlashVars.promoTableBG == null) && !(inFlashVars.promoTableBG == ""))
         {
            this.promoTableBG = inFlashVars.promoTableBG;
         }
         if(inFlashVars.ip != null)
         {
            this.ip = inFlashVars.ip;
         }
         this.showJoinNotifs = inFlashVars.showJoinNotifs;
         if(!(inFlashVars.trace_stats == null) && !(inFlashVars.trace_stats == ""))
         {
            this.trace_stats = int(inFlashVars.trace_stats);
         }
         if(this._sn_id == this.SN_FACEBOOK)
         {
            for (key in inFlashVars)
            {
               if(key.indexOf("fb_sig") == 0 || key == "signed_request")
               {
                  this.sigParams[key] = String(inFlashVars[key]);
               }
            }
         }
         if(inFlashVars.nBudPlayBonus != null)
         {
            this.nBudPlayBonus = inFlashVars.nBudPlayBonus;
         }
         if(this._sn_id == this.SN_MYSPACE)
         {
            this.curr_tourney = inFlashVars.curr_tourney;
            this.tourney_invite = inFlashVars.tourney_invite;
            this.tourney_seats_available = inFlashVars.tourney_seats_available;
            if(this.curr_tourney != null)
            {
               try
               {
                  this.oCurrTourney = com.adobe.serialization.json.JSON.decode(unescape(this.curr_tourney));
               }
               catch(ex:*)
               {
               }
            }
            if(this.tourney_invite != null)
            {
               try
               {
                  this.oTourneyInvite = com.adobe.serialization.json.JSON.decode(unescape(this.tourney_invite));
               }
               catch(ex:*)
               {
               }
            }
            if(this.tourney_seats_available != null)
            {
               try
               {
                  this.oTourneySeatsAvailable = com.adobe.serialization.json.JSON.decode(unescape(this.tourney_seats_available));
               }
               catch(ex:*)
               {
               }
            }
         }
         try
         {
            this.flashCookie = new FlashCookie("zynga_poker");
            this.retryCookie = new FlashCookie("PokerRetry");
            this.nRetries = int(this.retryCookie.GetValue("nRetry",-1));
         }
         catch(err:Error)
         {
            if(trace_stats == 1)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:FlashCookie:" + escape(err.name) + ":2009-04-10","",1,"",PokerStatHit.HITTYPE_FG));
            }
         }
         if(inFlashVars["enableTableSendChips"] != null)
         {
            if(inFlashVars["enableTableSendChips"] == "1")
            {
               this.enableTableSendChips = true;
            }
         }
         if(int(inFlashVars["sortByStakesLevel"]) > 0)
         {
            this.sortByStakesLevel = int(inFlashVars["sortByStakesLevel"]);
         }
         if(inFlashVars["showCollections"] == "1")
         {
            this.showCollectionsOnLoad = true;
         }
         if(inFlashVars["firstTimeCollections"] == "1")
         {
            this.firstTimeCollections = true;
         }
         if(inFlashVars["achievementOldShoutTextEnabled"])
         {
            this.achievementOldShoutTextEnabled = Boolean(inFlashVars["achievementOldShoutTextEnabled"]);
         }
         if(inFlashVars["revPromoID"])
         {
            this._revPromoID = int(inFlashVars["revPromoID"]);
         }
         if(inFlashVars["show_hilo_sidenav_promo"])
         {
            this.showHiLoSideNavPromo = Boolean(int(inFlashVars["show_hilo_sidenav_promo"]));
         }
         if(inFlashVars["HighLowGameMaxShow"])
         {
            this.HighLowGameShowOnFirstFold = Boolean(int(inFlashVars["HighLowGameMaxShow"]));
         }
         if(inFlashVars["HighLowGameDealerChat"])
         {
            this.HighLowGameDealerChat = Boolean(int(inFlashVars["HighLowGameDealerChat"]));
         }
         if(inFlashVars["HighLowGameSWFURL"])
         {
            this.HighLowGameSWFURL = inFlashVars["HighLowGameSWFURL"];
         }
         if(inFlashVars["HighLowGameFG"])
         {
            this.HighLowGameFG = inFlashVars["HighLowGameFG"];
         }
         if(inFlashVars["maxAchievementMasteryLevel"])
         {
            this.maxAchievementMasteryLevel = int(inFlashVars["maxAchievementMasteryLevel"]);
         }
         if(inFlashVars["achievementImageSubDir"])
         {
            this.achievementImageSubDir = inFlashVars["achievementImageSubDir"];
         }
         if(inFlashVars["newAchievementItemCount"])
         {
            this.newAchievementItemCount = int(inFlashVars["newAchievementItemCount"]);
         }
         if(inFlashVars["enableZPWC"])
         {
            this.enableZPWC = Boolean(int(inFlashVars["enableZPWC"]));
         }
         if(inFlashVars["enableZPWCSurfacing"])
         {
            this.enableZPWCSurfacing = Boolean(int(inFlashVars["enableZPWCSurfacing"]));
         }
         if(inFlashVars["showZPWCLobbyArrow"])
         {
            this.showZPWCLobbyArrow = Boolean(int(inFlashVars["showZPWCLobbyArrow"]));
         }
         if(inFlashVars["userZPWCTickets"])
         {
            this.zpwcTickets = Number(inFlashVars["userZPWCTickets"]);
         }
         if(inFlashVars["maxBuyinPercentOfChipstack"])
         {
            this.maxBuyinPercentOfChipstack = Number(inFlashVars["maxBuyinPercentOfChipstack"]);
         }
      }
      
      public function isMe(param1:String) : Boolean {
         return param1 == this.zid?true:false;
      }
      
      public function isFriend(param1:String) : Boolean {
         var _loc2_:String = null;
         if(this.aFriendZids != null)
         {
            for each (_loc2_ in this.aFriendZids)
            {
               if(_loc2_ == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getRoomById(param1:int) : RoomItem {
         var _loc2_:RoomItem = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aGameRooms.length)
         {
            _loc2_ = RoomItem(this.aGameRooms[_loc3_]);
            if(int(_loc2_.id) == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getRoomByName(param1:String) : RoomItem {
         var _loc2_:RoomItem = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aGameRooms.length)
         {
            _loc2_ = RoomItem(this.aGameRooms[_loc3_]);
            if(_loc2_.roomName == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getGiftById(param1:int) : Object {
         return GiftLibrary.GetInst().GetGift(param1.toString()) as Object;
      }
      
      public function getGiftByTypeAndNumber(param1:int, param2:int) : Object {
         return null;
      }
      
      public function addBuddyInvite(param1:BuddyInvite) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.aBuddyInvites.length)
         {
            if(this.aBuddyInvites[_loc2_].sZid == param1.sZid)
            {
               return;
            }
            _loc2_++;
         }
         this.aBuddyInvites.push(param1);
      }
      
      public function isBuddyInvited(param1:String) : Boolean {
         var _loc2_:* = 0;
         while(_loc2_ < this.aBuddyInvites.length)
         {
            if(this.aBuddyInvites[_loc2_].sZid == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function removeBuddyInvite(param1:String) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.aBuddyInvites.length)
         {
            if(this.aBuddyInvites[_loc2_].sZid == param1)
            {
               this.aBuddyInvites.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function removeAllBuddyInvites() : void {
         this.aBuddyInvites.splice(0);
      }
      
      public function getSnName(param1:Number) : String {
         if(param1 >= 0 && param1 < this.aSnNames.length)
         {
            return this.aSnNames[param1];
         }
         return "";
      }
      
      public function getFriendZidsBySN(param1:int) : Array {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = new Array();
         for each (_loc3_ in this.aFriendZids)
         {
            _loc4_ = _loc3_.split(":");
            if((_loc4_) && _loc4_.length > 0)
            {
               if(int(_loc4_[0]) == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getXPLevelName(param1:Number) : String {
         var _loc4_:Object = null;
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         for each (_loc4_ in this.xpLevels)
         {
            if(param1 >= _loc4_["level"] && _loc4_["level"] > _loc3_)
            {
               _loc2_ = _loc4_["name"];
               _loc3_ = _loc4_["level"];
            }
         }
         return _loc2_;
      }
      
      public function getSig() : String {
         var _loc2_:String = null;
         var _loc1_:* = "";
         if(this.sigParams)
         {
            for (_loc2_ in this.sigParams)
            {
               _loc1_ = _loc1_ + ("&" + _loc2_ + "=" + this.sigParams[_loc2_]);
            }
         }
         if(this.true_sn)
         {
            _loc1_ = _loc1_ + ("&platform=" + this.true_sn);
         }
         return _loc1_;
      }
      
      public const kJS_BASEBALLCARDFEED_GAVECHIPS:String = "gavechips";
      
      public const kJS_BASEBALLCARDFEED_BUYTABLEDRINKS:String = "buytabledrinks";
      
      public const kJS_BASEBALLCARDFEED_BUYTABLEGIFTS:String = "buytablegifts";
      
      public const kJS_BASEBALLCARDFEED_BUYINDVDRINK:String = "buygiftdrink";
      
      public const kJS_BASEBALLCARDFEED_BUYINDVGIFT:String = "buygift";
      
      public function JSCall_BaseballCardFeed(param1:String, param2:Number, param3:String, param4:String) : void {
         var _loc5_:String = param1;
         var _loc6_:Number = param2;
         var _loc7_:String = param3;
         var _loc8_:String = param4;
         this._externalInterface.call("flash_alert",_loc5_,_loc6_,_loc7_,_loc8_);
      }
      
      public function JSCall_SignUpShootoutPromo(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         var feedCheck:Boolean = param1;
         var thisRound:Number = param2;
         var thisTotalRounds:Number = param3;
         var thisChips:Number = param4;
         var thisPlace:Number = param5;
         var sParam01:Number = 0;
         if(feedCheck)
         {
            sParam01 = 1;
         }
         try
         {
            if(sParam01 == 0)
            {
               this._externalInterface.call("ZY.App.shootoutEntry.register",sParam01);
            }
            if(sParam01 == 1)
            {
               this._externalInterface.call("ZY.App.shootoutEntry.register",sParam01,thisRound,thisTotalRounds,thisChips,thisPlace);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function getSNTrackingString(param1:int) : String {
         var _loc2_:* = "";
         switch(param1)
         {
            case this.SN_BEBO:
               _loc2_ = "BE";
               break;
            case this.SN_FACEBOOK:
               _loc2_ = "FB";
               break;
            case this.SN_FRIENDSTER:
               _loc2_ = "FR";
               break;
            case this.SN_HI5:
               _loc2_ = "H5";
               break;
            case this.SN_MEEBO:
               _loc2_ = "ME";
               break;
            case this.SN_MYSPACE:
               _loc2_ = "MS";
               break;
            case this.SN_ORKUT:
               _loc2_ = "OT";
               break;
            case this.SN_TAGGED:
               _loc2_ = "TG";
               break;
            case this.SN_YAHOO:
               _loc2_ = "YA";
               break;
            case this.SN_ZYNGA:
               _loc2_ = "ZY";
               break;
            case this.SN_SNAPI:
               _loc2_ = "SN";
               break;
         }
         
         return _loc2_;
      }
      
      public function EnablePHPPopups() : void {
         this._externalInterface.call("enable_popups");
      }
      
      public function DisablePHPPopups() : void {
         this._externalInterface.call("disable_popups");
      }
      
      public function addStaticUrlPart(param1:String) : String {
         return this._staticUrlPrefix + param1;
      }
      
      public function get points() : Number {
         return this._points;
      }
      
      public function set points(param1:Number) : void {
         this._points = param1;
      }
      
      public function get casinoGold() : Number {
         return this._casinoGold;
      }
      
      public function set casinoGold(param1:Number) : void {
         this._casinoGold = param1;
      }
      
      public function get userLocale() : String {
         return this._userLocale;
      }
      
      public function set userLocale(param1:String) : void {
         this._userLocale = param1;
      }
      
      public function get gender() : String {
         return this._gender;
      }
      
      public function set gender(param1:String) : void {
         this._gender = param1;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function set name(param1:String) : void {
         this._name = param1;
      }
      
      public function get userPreferencesContainer() : UserPreferencesContainer {
         return this._userPreferencesContainer;
      }
      
      public function get inLobbyRoom() : Boolean {
         return this._inLobbyRoom;
      }
      
      public function get staticUrlPrefix() : String {
         return this._staticUrlPrefix;
      }
      
      public function get serverTimeOffset() : Number {
         return this.unixApploadTimestamp - Math.round(this.uAppStartTime / 1000);
      }
      
      public function set inLobbyRoom(param1:Boolean) : void {
         this._inLobbyRoom = param1;
      }
      
      public function set uid(param1:String) : void {
         this._uid = param1;
      }
      
      public function get uid() : String {
         return this._uid;
      }
      
      public function set zid(param1:String) : void {
         this._zid = param1;
      }
      
      public function get zid() : String {
         return this._zid;
      }
      
      public function set pic_url(param1:String) : void {
         this._pic_url = param1;
      }
      
      public function get pic_url() : String {
         return this._pic_url;
      }
      
      public function get sn_id() : int {
         return this._sn_id;
      }
      
      public function get zpwcTickets() : Number {
         return this._zpwcTickets;
      }
      
      public function set zpwcTickets(param1:Number) : void {
         this._zpwcTickets = param1;
      }
      
      public function get serverName() : String {
         return this._serverName;
      }
      
      public function set serverName(param1:String) : void {
         this._serverName = param1;
      }
      
      public function get dispMode() : String {
         return this._dispMode;
      }
      
      public function set dispMode(param1:String) : void {
         this._previousDisplayMode = this._dispMode;
         this._dispMode = param1;
      }
      
      public function get gameRoomId() : int {
         return this._gameRoomId;
      }
      
      public function set gameRoomId(param1:int) : void {
         this._gameRoomId = param1;
      }
      
      public function get lastHyperJoin() : JoinRoomTransition {
         return this._lastHyperJoin;
      }
      
      public function set lastHyperJoin(param1:JoinRoomTransition) : void {
         this._lastHyperJoin = param1;
      }
      
      public function get roomNameDisplay() : String {
         return this._roomIdDisplay > 1?this.aRoomsById[this._roomIdDisplay].roomName:this._roomNameDisplay;
      }
      
      public function set roomNameDisplay(param1:String) : void {
         this._roomIdDisplay = 0;
         this._roomNameDisplay = param1;
      }
      
      public function set roomIdDisplay(param1:int) : void {
         this._roomIdDisplay = param1;
         this._roomNameDisplay = null;
      }
      
      public function get enableHyperJoin() : Boolean {
         return (this._enableHyperJoin) && this.server_type == "normal";
      }
      
      public function get lobbyUncheckBoxes() : Boolean {
         return (this._lobbyUncheckBoxes) && this.server_type == "normal";
      }
      
      public function get enableRoomTypeOnly() : Boolean {
         return (this._enableRoomTypeOnly) && this.server_type == "normal";
      }
      
      public function get dailyAppEntryCount() : int {
         return this._dailyAppEntryCount;
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
