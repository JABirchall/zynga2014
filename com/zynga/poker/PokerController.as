package com.zynga.poker
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import com.zynga.User;
   import com.gskinner.utils.SWFBridgeAS3;
   import com.zynga.poker.smartfox.controllers.SmartfoxController;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.lobby.LobbyController;
   import com.zynga.poker.nav.NavController;
   import com.zynga.poker.table.TableController;
   import com.zynga.poker.commonUI.CommonUIController;
   import com.zynga.poker.minigame.MinigameController;
   import com.zynga.poker.mfs.controller.MFSController;
   import com.zynga.poker.buddies.controllers.BuddiesController;
   import com.zynga.poker.friends.controllers.NotifController;
   import com.zynga.poker.happyhour.HappyHourController;
   import __AS3__.vec.Vector;
   import com.zynga.poker.events.MTTLoadEvent;
   import com.zynga.interfaces.IMTTController;
   import com.zynga.poker.table.shouts.ShoutController;
   import com.zynga.poker.achievements.actions.AchievementActionController;
   import com.zynga.poker.shootout.ShootoutConfig;
   import flash.utils.Dictionary;
   import com.zynga.poker.leaderboard.LeaderboardController;
   import com.zynga.poker.layers.LayerManager;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.protocol.RMoveGivenPlayer;
   import com.zynga.poker.pokerscore.controllers.PokerScoreController;
   import com.zynga.io.ExternalCall;
   import com.zynga.poker.zoom.*;
   import it.gotoandplay.smartfoxserver.*;
   import com.zynga.utils.ExternalAssetManager;
   import com.zynga.poker.constants.ExternalAsset;
   import com.zynga.poker.table.todo.TodoListModel;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.nav.INavController;
   import com.zynga.poker.console.ConsoleManager;
   import com.zynga.poker.shootout.ShootoutUser;
   import com.zynga.io.SmartfoxConnectionManager;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.poker.smartfox.controllers.ISmartfoxController;
   import com.zynga.poker.smartfox.events.SmartfoxEvent;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.events.JSEvent;
   import com.zynga.poker.events.PokerSoundEvent;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.commands.SmartfoxCommand;
   import com.zynga.poker.commands.LobbyControllerCommand;
   import com.zynga.poker.commands.AchievementActionControllerCommand;
   import com.zynga.poker.commands.MinigameControllerCommand;
   import com.zynga.poker.commands.TableControllerCommand;
   import com.zynga.poker.commands.PopupControllerCommand;
   import com.zynga.poker.protocol.SAcquireToken;
   import flash.events.TimerEvent;
   import com.zynga.locale.LocaleManager;
   import flash.events.Event;
   import com.zynga.utils.LocalCookieManager;
   import flash.utils.getTimer;
   import com.zynga.poker.module.interfaces.IModuleController;
   import com.adobe.serialization.json.JSON;
   import com.zynga.poker.lobby.events.LCEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.popups.Popup;
   import com.zynga.load.LoadManager;
   import com.greensock.events.LoaderEvent;
   import com.zynga.poker.events.MTTEvent;
   import com.zynga.ui.lobbyBanner.LobbyBanner;
   import com.zynga.poker.protocol.SGetUserShootoutState;
   import com.zynga.poker.protocol.RFinishPlayerMove;
   import com.zynga.poker.protocol.SPickSpecificRoomShootout;
   import com.zynga.poker.commands.MTTControllerCommand;
   import com.zynga.poker.commands.mtt.MTTSuggestTourneyCommand;
   import com.zynga.poker.commands.mtt.MTTClaimRegisterCommand;
   import com.zynga.poker.events.PopupEvent;
   import com.zynga.poker.commands.selfcontained.DeselectSideNavItemCommand;
   import com.zynga.poker.events.ProfilePopupEvent;
   import com.zynga.poker.popups.modules.profile.ProfilePanelTab;
   import flash.net.URLVariables;
   import com.zynga.utils.ObjectUtil;
   import com.zynga.poker.protocol.SFindRoomRequest;
   import com.zynga.poker.protocol.SCollectionResetNewCnt;
   import com.zynga.poker.commands.pokercontroller.ResetProfileCounterCommand;
   import com.zynga.poker.protocol.RCollectionItemEarned;
   import com.zynga.poker.commands.smartfox.GetCollectionsCommand;
   import com.zynga.poker.protocol.RCollectionsInfo;
   import com.zynga.poker.constants.LiveChromeAchievements;
   import com.zynga.poker.protocol.SJSMessageToSmartfox;
   import com.zynga.poker.protocol.RSmartfoxMessageToJS;
   import com.zynga.poker.protocol.RRequestHeartBeat;
   import com.zynga.poker.nav.events.NCEvent;
   import com.zynga.poker.protocol.SGetChipsSig;
   import com.zynga.poker.commonUI.events.CommonCEvent;
   import com.zynga.poker.table.shouts.ShoutControllerEvent;
   import com.zynga.poker.commands.mtt.ZPWCGenericCommand;
   import com.zynga.poker.table.shouts.views.ZPWCEligibleTournamentShout;
   import flash.utils.setTimeout;
   import com.zynga.poker.table.events.TCEvent;
   import com.zynga.poker.table.GiftLibrary;
   import com.zynga.poker.protocol.SGetGiftInfo3;
   import com.zynga.poker.protocol.SGetGiftPrices3;
   import com.zynga.poker.constants.TableType;
   import com.zynga.poker.protocol.SPickRoom;
   import com.zynga.poker.commands.smartfox.GetUserInfoCommand;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.events.ErrorPopupEvent;
   import com.zynga.poker.events.InterstitialPopupEvent;
   import com.zynga.poker.protocol.SGetRoomPass;
   import com.zynga.poker.statistic.ZTrack;
   import com.zynga.poker.protocol.SApplyToCreateRoom;
   import com.zynga.poker.protocol.SCancelCreateRoom;
   import com.zynga.poker.protocol.SCreateRoom;
   import com.zynga.poker.protocol.RAlert;
   import com.zynga.utils.FlashCookie;
   import com.zynga.poker.lobby.events.controller.JoinTableEvent;
   import com.zynga.poker.events.FlashRegionBlockEvent;
   import com.zynga.poker.protocol.SStandUp;
   import com.zynga.poker.protocol.SSit;
   import com.zynga.poker.protocol.SAddBuddy;
   import com.zynga.poker.protocol.SBuyGift2;
   import com.zynga.poker.buddies.commands.BuddyAcceptRequestCommand;
   import com.zynga.poker.buddies.commands.BuddyDenyRequestCommand;
   import com.zynga.poker.protocol.SIgnoreAllBuddy;
   import com.zynga.poker.protocol.SReportUser;
   import com.zynga.io.SmartfoxConnectionEvent;
   import com.zynga.poker.protocol.SSuperLogin;
   import com.zynga.poker.protocol.RLogKO;
   import com.zynga.poker.protocol.RHyperJoin;
   import com.zynga.poker.protocol.RBoughtGift2;
   import com.zynga.poker.protocol.RGiftShown2;
   import com.zynga.poker.protocol.RLogin;
   import com.zynga.poker.protocol.RDisplayRoom;
   import com.zynga.poker.protocol.RJoinRoom;
   import com.zynga.poker.events.PCEvent;
   import com.zynga.poker.protocol.SReplayState;
   import com.zynga.poker.commands.selfcontained.sound.LoadSoundGroupCommand;
   import com.zynga.poker.protocol.RJoinRoomError;
   import com.zynga.poker.protocol.RSetMod;
   import com.zynga.poker.protocol.SCreateBucketRoom;
   import com.zynga.poker.protocol.RRoomPicked;
   import com.zynga.poker.protocol.RRoomPass;
   import com.zynga.poker.protocol.RGiftInfo3;
   import com.zynga.poker.protocol.RAcquireToken;
   import com.zynga.poker.protocol.SSendTableBuddyCount;
   import com.zynga.poker.protocol.RGiftPrices3;
   import com.zynga.poker.minigame.events.MGEvent;
   import com.zynga.poker.minigame.minigameHelper.MinigameUtils;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.poker.protocol.ROutOfChips;
   import com.zynga.poker.protocol.RShowMessage;
   import com.zynga.poker.protocol.RAdminMessage;
   import com.zynga.poker.protocol.SAddPoints;
   import com.zynga.poker.protocol.SAlertPublished;
   import com.zynga.poker.friends.interfaces.INotifController;
   import com.zynga.poker.commands.navcontroller.UpdateXPBoostToasterCommand;
   import com.zynga.poker.zoom.messages.ZoomTableInvitationMessage;
   import com.zynga.poker.protocol.RShootoutConfig;
   import com.zynga.poker.protocol.RUserShootoutState;
   import com.zynga.poker.protocol.RPremiumShootoutConfig;
   import com.zynga.poker.protocol.RGetUserInfo;
   import com.zynga.poker.protocol.RRakeAmount;
   import com.zynga.poker.protocol.RRakeDisabled;
   import com.zynga.poker.protocol.RRakeEnabled;
   import com.zynga.poker.protocol.RRakeInsufficientFunds;
   import flash.system.Capabilities;
   import com.zynga.poker.commonUI.events.JoinUserEvent;
   import com.zynga.poker.protocol.RRatholingUserState;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   import com.zynga.poker.commands.navcontroller.DisplayGiftShopCommand;
   import com.zynga.poker.happyhour.HappyHourModel;
   import com.zynga.poker.nav.sidenav.Sidenav;
   import com.zynga.poker.commands.navcontroller.UpdateNavItemCountCommand;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.protocol.RLadderGameHighScore;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.protocol.RJumpTableSearchResult;
   import flash.display.DisplayObject;
   import flash.system.Security;
   
   public class PokerController extends MovieClip implements IPokerController
   {
      
      public function PokerController() {
         this._mttEvent = new Vector.<MTTLoadEvent>();
         this.heartBeatsCollection = new Dictionary();
         super();
         Security.allowDomain("zlsn.poker.zynga.com");
         Security.allowDomain("zlsn3.poker.zynga.com");
         Security.allowDomain("yhsn.poker.zynga.com");
         Security.allowDomain("gosn.poker.zynga.com");
         Security.allowDomain("gosn3.poker.zynga.com");
         Security.allowDomain("facebook.poker.zynga.com");
         Security.allowDomain("facebook2.poker.zynga.com");
         Security.allowDomain("facebook3.poker.zynga.com");
         Security.allowDomain("fb-vrsn.poker.zynga.com");
         Security.allowDomain("zyngalive.poker.zynga.com");
         Security.allowDomain("apps.facebook.com");
         Security.allowDomain("api.msappspace.com");
         Security.allowDomain("graph.facebook.com");
         Security.allowDomain("track.poker.zynga.com");
         Security.allowDomain("facebook-stg.poker.zynga.com");
         Security.allowDomain("zdc-shared-stg.poker.zynga.com");
         Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
         if(SSLMigration.isSSLEnabled)
         {
            Security.loadPolicyFile("https://zynga1-a.akamaihd.net/poker/crossdomain.php");
            Security.loadPolicyFile("https://nav3.poker.zynga.com/crossdomain.xml");
            Security.loadPolicyFile("https://nav4.poker.zynga.com/crossdomain.xml");
            Security.allowDomain("graph.facebook.com");
            Security.allowDomain("nav3.zynga.com");
            Security.allowDomain("nav3.poker.zynga.com");
            Security.allowDomain("nav4.poker.zynga.com");
            Security.allowDomain("track.poker.zynga.com");
            Security.allowInsecureDomain("apps.facebook.com","apps.*.facebook.com");
            Security.allowInsecureDomain("shared-stg.poker.zynga.com");
            Security.allowInsecureDomain("statics-shared-stg.poker.zynga.com");
            Security.allowInsecureDomain("statics.poker.static.zynga.com");
            Security.allowInsecureDomain("statics3.poker.zynga.com");
            Security.allowInsecureDomain("*.zgncdn.com");
         }
         else
         {
            Security.allowDomain("shared-stg.poker.zynga.com");
            Security.allowDomain("statics-shared-stg.poker.zynga.com");
            Security.allowDomain("statics.poker.static.zynga.com");
            Security.allowDomain("statics3.poker.zynga.com");
            Security.allowDomain("*.zgncdn.com");
         }
         if(aStatsHash == null)
         {
            aStatsHash = new Array();
         }
      }
      
      public static var aStatsHash:Array = null;
      
      public static var aZtrackHash:Array;
      
      private const DEFAULT_LIVE_JOIN_ACTIVE_PLAYER_THRESHOLD:int = 3;
      
      private const PG_PROGRESS_DONE:int = 4;
      
      private const USER_PRESENCE_TIMER_DELAY:int = 300;
      
      private const ZOOM_THROTTLE:Number = 100;
      
      private const ZOOM_FRIENDS_LIMIT:Number = 500;
      
      public var timerUserPresence:Timer;
      
      public var mainDisplay:MovieClip;
      
      public var main:Object;
      
      public var pgData:PokerGlobalData;
      
      public var viewer:User;
      
      public var ladderBridge:SWFBridgeAS3;
      
      private var pcmConnect:PokerConnectionManager;
      
      private var lcmConnect:Object;
      
      private var _loadBalancer:LoadBalancer;
      
      private var _sfxController:SmartfoxController;
      
      private var popupControl:PopupController;
      
      private var lobbyControl:LobbyController;
      
      public var navControl:NavController;
      
      public var tableControl:TableController;
      
      public var commonControl:CommonUIController;
      
      public var openGraphController:OpenGraphController;
      
      public var minigameControl:MinigameController;
      
      public var mfsControl:MFSController;
      
      public var buddiesControl:BuddiesController;
      
      public var notifControl:NotifController;
      
      public var happyHourControl:HappyHourController;
      
      private var _mttLoading:Boolean = false;
      
      private var _mttType:String = "NORMAL";
      
      private var _mttEvent:Vector.<MTTLoadEvent>;
      
      private var _MTTController:IMTTController;
      
      private var _mttServerSwapping:Boolean = false;
      
      private var _mttRoom:String = "";
      
      private var _mttHomeServer:String = "";
      
      private var _shoutController:ShoutController;
      
      private var _achievementActionController:AchievementActionController;
      
      private var bTableInitialized:Boolean = false;
      
      private var externalInterfaceReadyTimer:Timer;
      
      public var pokerSoundManager:PokerSoundManager;
      
      private var _zoomControl:ZshimController = null;
      
      private var _zoomModel:ZshimModel;
      
      private var nRetries:int;
      
      public var soConfig:ShootoutConfig = null;
      
      private var hasDoneTableBuyInMilestone:Boolean = false;
      
      private var flashBlockedRegion:String = null;
      
      private var flashInterruptedAction:Object = null;
      
      private var flashBlockedTimeOut:Timer;
      
      private var heartBeatsCollection:Dictionary;
      
      private var _leaderboard:LeaderboardController;
      
      private var _popupLeaderboard:LeaderboardController;
      
      public var layerManager:LayerManager;
      
      private var _commandDispatcher:ICommandDispatcher;
      
      private var _externalInterface:IExternalCall;
      
      private var _configModel:ConfigModel;
      
      private var _registry:IClassRegistry;
      
      private var _rollingRebootStoredInfoForLobbyJoin:RMoveGivenPlayer;
      
      private var _lobbyTransitionHyperJoin:JoinRoomTransition;
      
      private var _isPlayNow:Boolean = false;
      
      private var _checkedPlayersClubAppEntryReward:Boolean = false;
      
      public function init(param1:MovieClip, param2:Object, param3:Object, param4:Object, param5:Object, param6:Object, param7:Object, param8:Object, param9:Object, param10:Object, param11:IClassRegistry, param12:SWFBridgeAS3=null) : void {
         var _loc18_:PokerScoreController = null;
         this._externalInterface = ExternalCall.getInstance();
         this._registry = param11;
         this.main = Object(param1);
         this.lcmConnect = param8;
         this.pgData = param9 as PokerGlobalData;
         this._configModel = param11.getObject(ConfigModel);
         this.checkFlashVersionGood();
         this.nRetries = this.pgData.nRetries;
         this.loadBalancer = LoadBalancer(param10);
         this.pgData.lbPopup = param3;
         this.pgData.lbLobby = param4;
         this.pgData.lbNav = param5;
         this.pgData.lbTable = param6;
         this.pgData.lbConfig = param7;
         this.pgData.xmlPopups = this.main.popupXML;
         this.pgData.xmlAssets = this.main.assetsXML;
         ExternalAssetManager.initAssets(this.pgData.xmlAssets);
         if(this.pgData.promoTableBG)
         {
            ExternalAssetManager.addAsset(ExternalAsset.TABLE_PROMO,this.pgData.promoTableBG,false);
         }
         this.viewer = new User(this.pgData.zid);
         this.pgData.viewer = this.viewer;
         this.pgData.gender = param2.hasOwnProperty("gender")?param2["gender"]:"masc";
         this.parseUserPreferences();
         if(this.pgData.userPreferencesContainer != null)
         {
            this.pgData.arbAutoRebuySelected = Boolean(int(this.pgData.userPreferencesContainer.rebuyEnabled));
            this.pgData.arbTopUpStackSelected = Boolean(int(this.pgData.userPreferencesContainer.topUpEnabled));
         }
         var _loc13_:TodoListModel = param11.getObject(TodoListModel);
         _loc13_.init();
         this.layerManager = new LayerManager();
         this.layerManager.addLayer(PokerControllerLayers.TABLE_LOBBY_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.COMMON_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.MINIGAME_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.MTT_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.MODULE_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.NAV_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.POPUP_LAYER);
         this.layerManager.addLayer(PokerControllerLayers.MFS_LAYER);
         var _loc14_:MovieClip = this.main as MovieClip;
         _loc14_.mainView.addChild(this.layerManager);
         this.popupControl = param11.getObject(IPopupController);
         this.lobbyControl = param11.getObject(LobbyController);
         this.navControl = param11.getObject(INavController);
         this.tableControl = param11.getObject(TableController);
         this.commonControl = param11.getObject(CommonUIController);
         this.minigameControl = new MinigameController();
         this.minigameControl.configModel = this._configModel;
         this._achievementActionController = new AchievementActionController();
         this.mfsControl = new MFSController();
         this.buddiesControl = param11.getObject(BuddiesController);
         this.buddiesControl.init(null);
         ConsoleManager.instance = param11.getObject(ConsoleManager);
         this.pokerSoundManager = param11.getObject(PokerSoundManager);
         this.pokerSoundManager.debugMode = this._configModel.getBooleanForFeatureConfig("core","debugMode");
         this.pokerSoundManager.startPokerSoundManager(this._configModel.getStringForFeatureConfig("core","jsConfig"));
         this.soConfig = new ShootoutConfig();
         this.pgData.soUser = new ShootoutUser();
         this.pcmConnect = param11.getObject(IPokerConnectionManager) as PokerConnectionManager;
         if(this._configModel.getBooleanForFeatureConfig("core","sfxConnectionLogging"))
         {
            this.pcmConnect.setConnectionLogging(true);
         }
         this.pcmConnect.assignSFClient(param8.smartfox);
         this.pcmConnect.initProtocolListeners();
         this.pcmConnect.addEventListener(SmartfoxConnectionManager.CONNECTED,this.onConnectionHandler);
         this.pcmConnect.addEventListener(SmartfoxConnectionManager.CONNECT_FAILED,this.onConnectionFailed);
         this.pcmConnect.addEventListener(ProtocolEvent.onMessage,this.onProtocolMessage);
         var _loc15_:SmartfoxController = param11.getObject(ISmartfoxController) as SmartfoxController;
         _loc15_.assignSfxClient(param8.smartfox);
         _loc15_.init();
         _loc15_.addEventListener(SmartfoxEvent.SMARTFOX_DISCONNECTED,this.handleDisconnect,false,0,true);
         this._sfxController = _loc15_;
         addEventListener(CommandEvent.TYPE_HIDE_FULLSCREEN,this.onHideFullScreenMode);
         addEventListener(CommandEvent.TYPE_SHOW_LUCKY_BONUS,this.onShowLuckyBonus);
         addEventListener(CommandEvent.TYPE_FIRE_STAT_HIT,this.onFireStatHit);
         addEventListener(CommandEvent.TYPE_UPDATE_COLLECTIONS_INFO,this.handleCollectionsInfo);
         addEventListener(CommandEvent.TYPE_UPDATE_POKER_GLOBAL_DATA,this.onUpdatePokerGlobalData);
         addEventListener(CommandEvent.TYPE_RESET_PROFILE_COUNTER,this.onResetProfileCounter);
         addEventListener(CommandEvent.TYPE_UPDATE_CASINO_GOLD,this.onUpdateCasinoGold);
         addEventListener(CommandEvent.TYPE_OPEN_PROFILE_AT_TAB,this.onOpenProfileCommand);
         addEventListener(JSEvent.TYPE_NOTIFYJS,this.notifyJS);
         addEventListener(CommandEvent.TYPE_UPDATE_CHIPS,this.onUpdateChips);
         addEventListener(CommandEvent.TYPE_UPDATE_CURRENCY,this.onUpdateCurrency);
         addEventListener(CommandEvent.TYPE_UPDATE_USER_PREFERENCES,this.onUpdateUserPreferences);
         addEventListener(PokerSoundEvent.ON_SOUND_REQUEST,this.onPokerSoundEvent);
         addEventListener(CommandEvent.TYPE_FIND_ROOM,this.onFindRoom);
         addEventListener(CommandEvent.TYPE_HYPER_FIND_ROOM,this.onHyperFindRoom);
         addEventListener(CommandEvent.TYPE_MTT_STAND_UP,this.onMTTStandUp);
         addEventListener(CommandEvent.TYPE_UPDATE_TALITEMCOUNT,this.onUpdateTALItemCount);
         addEventListener(CommandEvent.TYPE_REMOVE_TALITEM,this.onRemoveTALItemCount);
         addEventListener(CommandEvent.TYPE_ENABLE_TODO_ICON,this.showTodoIcon);
         addEventListener(CommandEvent.TYPE_SHOW_HAPPY_HOUR_FLYOUT,this.showHappyHourFlyout);
         addEventListener(CommandEvent.TYPE_SHOW_HAPPY_HOUR_LUCKY_BONUS,this.showHappyHourLuckyBonus);
         var _loc16_:PokerCommandDispatcher = PokerCommandDispatcher.getInstance();
         this._commandDispatcher = _loc16_;
         _loc16_.addDispatcherForType(JSCommand,this);
         _loc16_.addDispatcherForType(NavControllerCommand,this.navControl);
         _loc16_.addDispatcherForType(PokerControllerCommand,this);
         _loc16_.addDispatcherForType(SmartfoxCommand,this.pcmConnect);
         _loc16_.addDispatcherForType(LobbyControllerCommand,this.lobbyControl);
         _loc16_.addDispatcherForType(AchievementActionControllerCommand,this._achievementActionController);
         _loc16_.addDispatcherForType(MinigameControllerCommand,this.minigameControl);
         _loc16_.addDispatcherForType(TableControllerCommand,this.tableControl);
         _loc16_.addDispatcherForType(PopupControllerCommand,this.popupControl);
         this.initXPLevelNames();
         this.initPopups();
         this.initCommonUI();
         this.initNav();
         this.initModule();
         this.initMinigame();
         this.initShoutController();
         this.initMFSController();
         if(this._configModel.isFeatureEnabled("leaderboard"))
         {
            this._leaderboard = new LeaderboardController(this.layerManager.getLayer(PokerControllerLayers.COMMON_LAYER),this.pgData.timeStamp,this,this.pgData);
            this._leaderboard.configModel = this._configModel;
            this._leaderboard.externalInterface = this._externalInterface;
            if(this.pgData.rejoinRoom == -1)
            {
               this.showLeaderboard(this._configModel.getFeatureConfig("leaderboard"));
            }
         }
         if(this._configModel.isFeatureEnabled("scoreCard"))
         {
            _loc18_ = param11.getObject(PokerScoreController);
            _loc18_.init(null);
            if(this._configModel.getBooleanForFeatureConfig("core","scoreCardFeedEntry") == true)
            {
               this.popupControl.showPokerScoreCard();
            }
         }
         else
         {
            if(this._configModel.getBooleanForFeatureConfig("core","scoreCardFeedEntry") == true)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Poker FB ScoreCard Other Unknown o:ComingSoonPopup:2013-05-20"));
               this._externalInterface.call("zc.feature.scoreCard.showComingSoonPopup");
            }
         }
         this.pcmConnect.onExtensionHandler(this.lcmConnect.sfeLogin);
         this.pcmConnect.onRoomListUpdate(this.lcmConnect.sfeRoomList);
         this.pcmConnect.onJoinRoomHandler(this.lcmConnect.sfeJoinRoom);
         if(this.lcmConnect.sfeSetMod != null)
         {
            this.pcmConnect.onExtensionHandler(this.lcmConnect.sfeSetMod);
         }
         this.initUserPresence();
         this.initOpenGraph();
         this._externalInterface.addCallback("showShootoutTab",this.showShootoutTab);
         this._externalInterface.addCallback("userDidProvideEMail",this.userDidProvideEMail);
         this._externalInterface.addCallback("forceChipUpdate",this.forceChipUpdate);
         this._externalInterface.addCallback("forceUpdateCurrency",this.forceUpdateCurrency);
         this._externalInterface.addCallback("forceCasinoGoldUpdate",this.forceCasinoGoldUpdate);
         this._externalInterface.addCallback("iFrameJSReady",this.iFrameJSReady);
         this._externalInterface.addCallback("onHideFullScreenMode",this.onHideFullScreenMode);
         this._externalInterface.addCallback("updateTodoCount",this.updateTodoCount);
         this._externalInterface.addCallback("notifyJSFromLadder",this.notifyJSFromLadder);
         this._externalInterface.addCallback("hideTodoIcon",this.hideTodoIcon);
         this._externalInterface.addCallback("onBuzzBoxClick_GetChipsSig",this.onBuzzBoxClick_GetChipsSig);
         this._externalInterface.addCallback("displayShout",this.displayShout);
         this._externalInterface.addCallback("closeShout",this.closeShout);
         this._externalInterface.addCallback("openMiniGame",this.openMiniGame);
         this._externalInterface.addCallback("showServeProgress",this.showServeProgress);
         this._externalInterface.addCallback("JSMessageToSmartfox",this.JSMessageToSmartfox);
         this._externalInterface.addCallback("showScratchersMiniGame",this.showScratchersMiniGame);
         this._externalInterface.addCallback("updateScratchersMiniGame",this.updateScratchersMiniGame);
         this._externalInterface.addCallback("showInsufficientFunds",this.showInsufficientFunds);
         this._externalInterface.addCallback("showGiftShop",this.showGiftShop);
         this._externalInterface.addCallback("showLuckyBonus",this.showLuckyBonus);
         this._externalInterface.addCallback("showPokerGenius",this.showPokerGenius);
         this._externalInterface.addCallback("showPokerGeniusMarketing",this.showPokerGeniusMarketing);
         this._externalInterface.addCallback("updateFourColorDeck",this.updateFourColorDeck);
         this._externalInterface.addCallback("onLuckyBonusPullSlot",this.onLuckyBonusPullSlot);
         this._externalInterface.addCallback("onJsStatHit",this.onJsStatHit);
         if(this._configModel.isFeatureEnabled("leaderboard"))
         {
            this._externalInterface.addCallback("showLeaderboard",this.updateLeaderboardData);
         }
         this._externalInterface.addCallback("mttClaimRegister",this.onMTTClaimRegister);
         this._externalInterface.addCallback("showTabBanner",this.onShowLobbyBanner);
         this._externalInterface.addCallback("showZPWCRegistration",this.showZPWCEligibleTournamentShout);
         this.pcmConnect.sendMessage(new SAcquireToken("SAcquireToken"));
         if(param12 != null)
         {
            this.ladderBridge = param12;
            this.ladderBridge.client = this;
         }
         if(!this.externalInterfaceReadyTimer)
         {
            this.externalInterfaceReadyTimer = new Timer(1 * 1000,1);
            this.externalInterfaceReadyTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onExtIntRdyTimerComplete);
            this.externalInterfaceReadyTimer.start();
         }
         var _loc17_:Boolean = this._configModel.getBooleanForFeatureConfig("scratchers","showScratchersCheckFreePlay");
         if(_loc17_)
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new JSCommand("zc.feature.miniGame.scratchers.check"));
         }
         if(this.pgData.enableMTT)
         {
            this.loadMTT();
         }
         this._externalInterface.call("zc.feature.looseningAchievements.tryFTUE");
         if(this._configModel.getBooleanForFeatureConfig("luckyBonusAppEntry","isAutoOpen") == true)
         {
            this.showLuckyBonus();
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:LuckyBonus:appentry:2013-11-14"));
         }
         if(this._configModel.isFeatureEnabled("happyHour"))
         {
            this.happyHourControl = param11.getObject(HappyHourController);
            this.happyHourControl.init(null);
         }
         LocaleManager.countryCode = this.pgData.countryCode;
      }
      
      private function onExtIntRdyTimerComplete(param1:TimerEvent) : void {
         if(!this.pgData.externalInterfaceReady)
         {
            this._externalInterface.call("ZY.App.IsIFrameJSReady");
            if(this.externalInterfaceReadyTimer)
            {
               this.externalInterfaceReadyTimer.reset();
               this.externalInterfaceReadyTimer.start();
            }
         }
         else
         {
            if(this.externalInterfaceReadyTimer)
            {
               this.externalInterfaceReadyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onExtIntRdyTimerComplete);
               this.externalInterfaceReadyTimer.stop();
               this.externalInterfaceReadyTimer = null;
            }
         }
      }
      
      private function iFrameJSReady() : void {
         this.pgData.externalInterfaceReady = true;
         if(this.externalInterfaceReadyTimer)
         {
            this.externalInterfaceReadyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onExtIntRdyTimerComplete);
            this.externalInterfaceReadyTimer.stop();
            this.externalInterfaceReadyTimer = null;
         }
      }
      
      public function get connected() : Boolean {
         return !(this.pcmConnect == null) && (this.pcmConnect.isConnected)?true:false;
      }
      
      public function onNotifyJS(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.notifyJS(_loc2_.event);
      }
      
      public function notifyJS(param1:Event) : void {
         var _loc2_:String = null;
         if(param1 is JSEvent)
         {
            _loc2_ = "ZY.App.Flash.Events.handleFlashEvent";
            this._externalInterface.call(_loc2_,(param1 as JSEvent).jsEventType,(param1 as JSEvent).params);
         }
      }
      
      private function notifyJSFromLadder(... rest) : void {
         var _loc2_:* = "ZY.App.Flash.Events.handleGenericFlashEvent";
         rest.splice(0,0,_loc2_);
         this._externalInterface.call.apply(this,rest);
      }
      
      public function notifyJSRevealComplete() : void {
         this.notifyJS(new JSEvent(JSEvent.REVEAL_COMPLETE));
      }
      
      public function gameLoadingComplete() : void {
         this.pgData.gameLoadingComplete = true;
         this.fireLoadTimeStat();
         LocalCookieManager.loadLocalCookie();
         LocalCookieManager.deleteLocalCookie();
         if(this.pgData.disableLiveJoin)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:LiveJoin:Disabled:2013-04-04"));
         }
         else
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:LiveJoin:Enabled:2013-04-04"));
         }
      }
      
      private function fireLoadTimeStat() : void {
         var _loc1_:int = getTimer();
         var _loc2_:int = (_loc1_ - this.pgData.loadInitiatedTime) / 1000;
         var _loc3_:* = "";
         if(_loc2_ >= 0 && _loc2_ <= 10)
         {
            _loc3_ = "0to10";
         }
         else
         {
            if(_loc2_ > 10 && _loc2_ <= 20)
            {
               _loc3_ = "11to20";
            }
            else
            {
               if(_loc2_ > 20 && _loc2_ <= 30)
               {
                  _loc3_ = "21to30";
               }
               else
               {
                  if(_loc2_ > 30 && _loc2_ <= 40)
                  {
                     _loc3_ = "31to40";
                  }
                  else
                  {
                     if(_loc2_ > 40 && _loc2_ <= 50)
                     {
                        _loc3_ = "41to50";
                     }
                     else
                     {
                        if(_loc2_ > 50 && _loc2_ <= 60)
                        {
                           _loc3_ = "51to60";
                        }
                        else
                        {
                           if(_loc2_ > 60)
                           {
                              _loc3_ = "61plus";
                           }
                           else
                           {
                              _loc3_ = "invalid";
                           }
                        }
                     }
                  }
               }
            }
         }
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:FlashLoadTime:PostLogin:" + _loc3_ + ":2013-01-02"));
      }
      
      public function onLadderBridgeConnect(param1:Event) : void {
         this.ladderBridge.removeEventListener(Event.CONNECT,this.onLadderBridgeConnect);
         this.ladderBridge.send("loadLadderCallback");
      }
      
      public function canLadderLoad() : void {
         if(!(this.ladderBridge == null) && (this.ladderBridge.connected))
         {
            this.ladderBridge.send("loadLadderCallback");
         }
      }
      
      public function onStatHit(param1:Object) : void {
         var _loc2_:PokerStatHit = PokerStatHit.fromString(param1);
         if(_loc2_ != null)
         {
            _loc2_.loc = PokerStatHit.HITLOC_AGNOSTIC;
            PokerStatsManager.DoHitForStat(_loc2_);
         }
      }
      
      private function initPopups() : void {
         this.popupControl.externalInterface = this._externalInterface;
         this.popupControl.startPopupController(this.main as MovieClip,this.pgData,this,this.lobbyControl,this.tableControl,this.navControl);
      }
      
      private function initModule() : void {
         this._registry.getObject(IModuleController).init(this.layerManager.getLayer(PokerControllerLayers.MODULE_LAYER));
      }
      
      private function initMinigame() : void {
         this.minigameControl.externalInterface = this._externalInterface;
         this.minigameControl.startMinigameController(this.pcmConnect,this.main as MovieClip,this.pgData,this,this.lobbyControl,this.tableControl,this.navControl);
      }
      
      private function parseUserPreferences() : void {
         var JSONObj:Object = null;
         var obj:* = undefined;
         var userPrefs:String = this._configModel.getStringForFeatureConfig("userPrefs","userPrefs");
         if((userPrefs) && (this.pgData.userPreferencesContainer))
         {
            try
            {
               JSONObj = com.adobe.serialization.json.JSON.decode(unescape(userPrefs));
               for (obj in JSONObj)
               {
                  this.pgData.userPreferencesContainer.commitValueWithKey(obj,JSONObj[obj]);
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function commitUserPreferences() : void {
         if(this.pgData.userPreferencesContainer)
         {
            if(this._externalInterface.available)
            {
               this._externalInterface.call("ZY.App.UserPreferences.update",escape(this.pgData.userPreferencesContainer.getJSONString()),this.pgData.userPreferencesContainer.getUserPreferenceSource());
               this.pgData.userPreferencesContainer.setUserPreferenceSource("null");
            }
         }
      }
      
      private function onUpdateUserPreferences(param1:CommandEvent) : void {
         if((param1.params.key) && (param1.params.value))
         {
            this.pgData.userPreferencesContainer.commitValueWithKey(param1.params.key,param1.params.value);
            this.commitUserPreferences();
         }
      }
      
      private function initLobby() : void {
         this.lobbyControl.addEventListener(LCEvent.VIEW_INIT,this.onLobbyInit);
         this.lobbyControl.addEventListener(LCEvent.JOIN_TABLE,this.onJoinTable);
         this.popupControl.addEventListener(CommonVEvent.JOIN_USER,this.onZLivePopupJoin);
         this.popupControl.addEventListener(PokerSoundEvent.ON_SOUND_REQUEST,this.onPokerSoundEvent);
         this.lobbyControl.addEventListener(LCEvent.CONNECT_TO_NEW_SERVER,this.onServerChosen);
         this.lobbyControl.addEventListener(LCEvent.FIND_SEAT,this.onFindSeat);
         this.lobbyControl.addEventListener(LCEvent.PRIVATE_TABLE_CLICK,this.onPrivateTableClick);
         this.lobbyControl.addEventListener(LCEvent.REFRESHED_USER_INFO,this.onRefreshedUserInfo);
         this.lobbyControl.addEventListener(LCEvent.ON_USER_CHIPS_UPDATED,this.onUserChipsUpdated);
         this.lobbyControl.addEventListener(MTTLoadEvent.MTT_SHOW_LISTINGS,this.onMTTShowListings,false,0,true);
         this.lobbyControl.addEventListener(LCEvent.PLAY_TOURNAMENT,this.onPlayMTT,false,0,true);
         this.lobbyControl.addEventListener(LCEvent.CLOSE_FLYOUT,this.onCloseMTTFlyout,false,0,true);
         addEventListener(MTTLoadEvent.MTT_LOAD,this.onMTTLoadRequest,false,0,true);
         this.lobbyControl.startLobbyController(this.main as MovieClip,this.pcmConnect,this,this.lcmConnect.sfeDisplayRoomList);
         this.refreshLobbyBackground();
      }
      
      private function loadMTT() : void {
         this.onMTTLoadRequest(null);
      }
      
      private function onMTTLoadRequest(param1:MTTLoadEvent) : void {
         var basePath:String = null;
         var popupConfig:Popup = null;
         var mttEvent:MTTLoadEvent = param1;
         if(this._configModel.isFeatureEnabled("mtt"))
         {
            this._mttEvent.push(mttEvent);
            basePath = this._configModel.getStringForFeatureConfig("core","basePath");
            if(!this._mttLoading && !this._MTTController && (basePath))
            {
               this._mttLoading = true;
               popupConfig = this.getPopupConfigByID(Popup.MTT);
               LoadManager.load(basePath + popupConfig.moduleSource,{"onComplete":function(param1:LoaderEvent):void
               {
                  var _loc2_:* = undefined;
                  _MTTController = param1.data.content.rawContent as IMTTController;
                  _MTTController.init(layerManager.getLayer(PokerControllerLayers.MTT_LAYER),pcmConnect,pgData,_externalInterface,pgData.enableMTTSurface);
                  addEventListener(MTTEvent.MTT_WITHDRAW,_MTTController.onHandleEvent,false,0,true);
                  addEventListener(MTTEvent.MTT_ENABLE_REQUESTS,_MTTController.onHandleEvent,false,0,true);
                  lobbyControl.addEventListener(MTTEvent.MTT_ENABLE_REQUESTS,_MTTController.onHandleEvent,false,0,true);
                  lobbyControl.addEventListener(MTTEvent.MTT_DISABLE_REQUESTS,_MTTController.onHandleEvent,false,0,true);
                  lobbyControl.addEventListener(MTTEvent.ZPWC_ENABLE_REQUESTS,_MTTController.onHandleEvent,false,0,true);
                  lobbyControl.addEventListener(MTTEvent.ZPWC_DISABLE_REQUESTS,_MTTController.onHandleEvent,false,0,true);
                  addEventListener(CommandEvent.TYPE_MTT_VERIFY_SERVER,onMTTVerifyServer);
                  addEventListener(CommandEvent.TYPE_MTT_JOIN_TOURNAMENT,onMTTJoinTournament);
                  addEventListener(CommandEvent.TYPE_MTT_LEAVE_TOURNAMENT,onMTTLeaveTournament);
                  addEventListener(CommandEvent.TYPE_MTT_TOURNAMENT_TYPE,onMTTTournamentType);
                  _externalInterface.addCallback("mttFriends",mttFriends);
                  _externalInterface.call("zc.feature.mtt.getFriends");
                  if(lobbyControl.canBannerAdEnable(LobbyBanner.MTT))
                  {
                     lobbyControl.initMTT(_MTTController.getViewByKey("MTTPlayNow"),_MTTController.getViewByKey("MTT_Banner"));
                  }
                  else
                  {
                     lobbyControl.initMTT(_MTTController.getViewByKey("MTTPlayNow"),null);
                  }
                  while(_mttEvent.length)
                  {
                     _loc2_ = _mttEvent.shift();
                     if(_loc2_)
                     {
                        _loc2_.params.replyTo(_loc2_);
                     }
                  }
                  if(pgData.enableZPWC)
                  {
                     lobbyControl.initZPWC(_MTTController.getViewByKey("ZPWC_Ticket"),_MTTController.getViewByKey("ZPWC_Sparkle"),_MTTController.getViewByKey("ZPWC_TabBanner"));
                  }
               }});
            }
         }
      }
      
      private function mttVerifyLoaded(param1:MTTLoadEvent=null) : void {
         if(!this._MTTController)
         {
            this.onMTTLoadRequest(new MTTLoadEvent(MTTLoadEvent.MTT_LOAD,{"replyTo":this.mttVerifyLoaded}));
         }
         else
         {
            this.onInitZoom();
            this.zoomControl.connect();
            this.notifyJS(new JSEvent(JSEvent.SF_CONNECTED));
         }
      }
      
      private function onMTTVerifyServer(param1:CommandEvent) : void {
         if(param1.params.ip == this.pgData.ip)
         {
            this._mttRoom = param1.params.room;
            dispatchEvent(new CommandEvent("MTTServerVerified",
               {
                  "room":this._mttRoom,
                  "serverJump":false
               }));
         }
         else
         {
            this._mttRoom = param1.params.room;
            this.mttConnectToServer(param1.params.ip);
         }
      }
      
      private function mttConnectToServer(param1:String, param2:String="", param3:String="", param4:String="") : void {
         var _loc5_:Object = this._configModel.getFeatureConfig("core");
         this._mttServerSwapping = true;
         this.pgData.bUserDisconnect = true;
         this.pcmConnect.disconnectWithoutReconnect();
         this.pgData.ip = param1;
         this.pgData.serverId = param4 == ""?this.loadBalancer.getServerIdByIp(this.pgData.ip):param4;
         this.pgData.serverName = param3 == ""?this.loadBalancer.getServerNameByIp(this.pgData.ip):param3;
         this.pgData.server_type = param2 == ""?this.loadBalancer.getServerType(this.pgData.serverId):param2;
         if(_loc5_)
         {
            _loc5_.sZone = this.loadBalancer.getZone(this.pgData.server_type);
         }
         this.connectToServer();
      }
      
      private function onMTTShowListings(param1:MTTLoadEvent) : void {
         if(!this._MTTController)
         {
            dispatchEvent(new MTTLoadEvent(MTTLoadEvent.MTT_LOAD,
               {
                  "replyTo":this.onMTTShowListings,
                  "callback":param1.params.callback,
                  "listingType":param1.params.listingType
               }));
         }
         else
         {
            param1.params.callback(this._MTTController.getViewByKey(param1.params.listingType));
         }
      }
      
      private function onMTTSitInfo(param1:Object) : void {
         this.pgData.assignedSeat = param1.seat;
         this.pgData.bAutoSitMe = true;
      }
      
      private function onMoveGivenPlayer(param1:Object) : void {
         var _loc3_:JoinRoomTransition = null;
         var _loc2_:RMoveGivenPlayer = RMoveGivenPlayer(param1);
         if(_loc2_.serverType.indexOf("shootout") == 0)
         {
            this.pgData.joinShootoutLobby = true;
            this.pgData.rollingRebootOverride = _loc2_;
            this.lobbyControl.setShootoutMode();
            this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
         }
         else
         {
            if(_loc2_.serverType == "premium_so")
            {
               this._rollingRebootStoredInfoForLobbyJoin = _loc2_;
               this.tableControl.leaveTable();
            }
            else
            {
               if(_loc2_.serverType == "sitngo")
               {
                  this._rollingRebootStoredInfoForLobbyJoin = _loc2_;
                  _loc3_ = new JoinRoomTransition(this.pgData.lobbyRoomId);
                  _loc3_.join(this.pcmConnect);
               }
               else
               {
                  this.mttConnectToServer(_loc2_.serverIp,_loc2_.serverType,_loc2_.serverName,String(_loc2_.serverId));
                  if(_loc2_.roomId > 1)
                  {
                     this.pcmConnect.rollingRebootStoredInfo = _loc2_;
                  }
               }
            }
         }
      }
      
      private function onFinishPlayerMove(param1:Object) : void {
         var _loc2_:RFinishPlayerMove = RFinishPlayerMove(param1);
         if(_loc2_.roomId > 1)
         {
            this.pgData.bIsFastRR = true;
            this.pgData.assignedChips = _loc2_.buyIn;
            this.pgData.joinShootoutLobby = false;
            this.pgData.moveTimestamp = _loc2_.timestamp;
            this.pgData.movePass = _loc2_.pass;
            this.pgData.moveServerId = _loc2_.serverId;
            this.pgData.moveRoom = _loc2_.roomId;
            if(_loc2_.serverType.indexOf("shootout") == 0 || _loc2_.serverType == "premium_so")
            {
               this.pgData.forcedSeat = _loc2_.seat;
               this.pgData.requiredSmallBlind = this.pgData.getRoomById(_loc2_.roomId).smallBlind;
               this.pcmConnect.sendMessage(new SPickSpecificRoomShootout(this.soConfig.nId,this.soConfig.nIdVersion,_loc2_.roomId));
            }
            else
            {
               this.pgData.assignedRoom = _loc2_.roomId;
               this.pgData.assignedSeat = _loc2_.seat;
               if(_loc2_.serverType == "sitngo")
               {
                  this.pgData.forcedSeat = _loc2_.seat;
                  this.pgData.requiredSmallBlind = this.pgData.getRoomById(_loc2_.roomId).smallBlind;
               }
               this.pgData.bAutoSitMe = true;
               this.joinTableCheck(_loc2_.roomId);
            }
         }
      }
      
      public function mttFriends(param1:Object) : void {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for (_loc3_ in param1)
         {
            _loc2_.push(param1[_loc3_]);
         }
         this._MTTController.friendZids = _loc2_;
      }
      
      private function onMTTStandUp(param1:CommandEvent) : void {
         this.tableControl.leaveMTTTable();
         dispatchEvent(new CommandEvent("MTTStandUp",param1.params));
      }
      
      private function onMTTJoinTournament(param1:CommandEvent) : void {
         this.pgData.mttZone = true;
         if(this.pgData.server_type == "PokerMtt")
         {
            this._mttHomeServer = this.loadBalancer.findMTTHomeServer();
         }
         else
         {
            this._mttHomeServer = this.pgData.ip;
         }
         dispatchEvent(new CommandEvent("mttJoinComplete"));
      }
      
      private function onMTTLeaveTournament(param1:CommandEvent) : void {
         if(this.tableControl)
         {
            this.tableControl.leaveMTTTable();
         }
         this.mttConnectToServer(this._mttHomeServer);
      }
      
      private function onMTTTournamentType(param1:CommandEvent) : void {
         if((param1.params) && (param1.params.type))
         {
            this._mttType = param1.params.type;
         }
      }
      
      private function leaveMTTZone() : void {
         this.pgData.mttZone = false;
         if((this.tableControl) && (this.tableControl.ptView))
         {
            this.tableControl.cleanupTable();
         }
         if(this._mttType == "NORMAL")
         {
            this.lobbyControl.showMTTLobby(this._MTTController.getViewByKey("listings"));
         }
         else
         {
            this.lobbyControl.showZPWCLobby(this._MTTController.getViewByKey("zpwcListings"));
         }
      }
      
      private function onCloseMTTFlyout(param1:LCEvent) : void {
         this._commandDispatcher.dispatchCommand(new MTTControllerCommand(new CommandEvent(CommandEvent.TYPE_MTT_CLOSE_FLYOUT)));
      }
      
      private function onPlayMTT(param1:LCEvent) : void {
         this._commandDispatcher.dispatchCommand(new MTTSuggestTourneyCommand());
      }
      
      private function onMTTClaimRegister(param1:Object) : void {
         var _loc2_:String = null;
         if(this._configModel.isFeatureEnabled("mtt"))
         {
            if(!this._MTTController)
            {
               if(!this.pgData.enableMTT)
               {
                  this.pgData.enableMTT = true;
               }
               this.lobbyControl.hideLobby();
               this.lobbyControl.initLobbyView();
               dispatchEvent(new MTTLoadEvent(MTTLoadEvent.MTT_LOAD,
                  {
                     "replyTo":this.onMTTClaimRegister,
                     "data":param1
                  }));
            }
            else
            {
               _loc2_ = "";
               if(param1 is MTTLoadEvent)
               {
                  _loc2_ = param1.params.data.id;
               }
               else
               {
                  _loc2_ = param1.id;
               }
               this._commandDispatcher.dispatchCommand(new MTTClaimRegisterCommand(_loc2_));
               this.lobbyControl.onMTTClicked(null);
            }
         }
         else
         {
            this._externalInterface.call("zc.feature.mtt.showRampDown");
         }
      }
      
      private function onShowLobbyBanner(param1:Object) : void {
         if(!this._MTTController)
         {
            if(!this.pgData.enableMTT)
            {
               this.pgData.enableMTT = true;
            }
            dispatchEvent(new MTTLoadEvent(MTTLoadEvent.MTT_LOAD,
               {
                  "replyTo":this.onShowLobbyBanner,
                  "data":param1
               }));
         }
         else
         {
            this.lobbyControl.showTabBanner();
         }
      }
      
      public function postNavLoad_loadLobby() : void {
         this.zoomUpdateUser();
         this.initLobby();
         this.main.revealMainView();
         var _loc1_:Boolean = this._configModel.getBooleanForFeatureConfig("miniGames","miniGamesActive");
         if((((this.pgData.luckyBonusEnabled && this.pgData.luckyBonusFTUEEligible) && (this.pgData.userPreferencesContainer)) && (!int(this.pgData.userPreferencesContainer.ftueLuckyBonus))) && (this.navControl.navView.sideNav.enabled) && !_loc1_)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyBonusFTUE:2012-03-26"));
            this.navControl.navView.initNavFTUE("LuckyBonus",[LocaleManager.localize("flash.popup.luckyBonus.ftue1"),LocaleManager.localize("flash.popup.luckyBonus.ftue2")]);
         }
         if(!this.pgData.disableNewUserPopup && this._configModel.getIntForFeatureConfig("user","newUserPopup") > 0 && !this._configModel.isFeatureEnabled("uXImprovements"))
         {
            dispatchEvent(new PopupEvent("showNewUser"));
         }
         else
         {
            this.lobbyControl.showPlayNowTutorialArrow();
         }
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:SWF:LoadComplete:2009-02-11","",1,"",PokerStatHit.HITTYPE_FG));
         PokerLoadMilestone.stopClientHeartbeat();
         this.notifyJS(new JSEvent(JSEvent.LOAD_COMPLETE));
         this._externalInterface.call("flashLoadCompleteCallback");
         this.popupControl.postloadPopupModules();
         if(!this._configModel.getBooleanForFeatureConfig("profilePanel","hideCollections"))
         {
            if(this.pgData.showCollectionsOnLoad)
            {
               this.showCollections();
            }
            else
            {
               this.getCollectionsInfo();
            }
         }
         if(this.ladderBridge != null)
         {
            if(this.ladderBridge.connected)
            {
               this.canLadderLoad();
            }
            else
            {
               this.ladderBridge.addEventListener(Event.CONNECT,this.onLadderBridgeConnect);
            }
         }
      }
      
      private function initMFSController() : void {
         this.mfsControl.externalInterface = this._externalInterface;
         this.mfsControl.configModel = this._configModel;
         this.mfsControl.startMFSController(this.layerManager,this.popupControl);
      }
      
      public function initOpenGraph() : void {
         if(!this._configModel.isFeatureEnabled("openGraph"))
         {
            return;
         }
         this.openGraphController = new OpenGraphController();
         this.openGraphController.externalInterface = this._externalInterface;
      }
      
      private function closePopupResponse(param1:Object) : void {
         var _loc2_:String = null;
         if(param1 !== false)
         {
            _loc2_ = param1 as String;
            this._commandDispatcher.dispatchCommand(new DeselectSideNavItemCommand(_loc2_));
         }
      }
      
      public function setSidebarItemsDeselected(param1:String) : void {
         this._commandDispatcher.dispatchCommand(new DeselectSideNavItemCommand(param1));
      }
      
      private function onOpenProfileCommand(param1:CommandEvent) : void {
         if(param1.params)
         {
            this.showProfile(param1.params.zid,param1.params.playerName,param1.params.source,param1.params.tab);
         }
      }
      
      public function showProfile(param1:String, param2:String="", param3:String="", param4:String="Overview") : void {
         var _loc5_:String = this.pgData.inLobbyRoom?"Lobby":"Table";
         if(param3 == "ZLive")
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,_loc5_ + " Other Click o:onZLiveProfileClick:2011-05-09"));
         }
         this.navControl.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,
            {
               "zid":param1,
               "playerName":param2
            },param4));
      }
      
      private function showAchievements(param1:Object=null) : void {
         this.navControl.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,param1,ProfilePanelTab.ACHIEVEMENTS));
      }
      
      private function showCollections(param1:Object=null) : void {
         var _loc2_:Boolean = !(param1 == null) && (param1.hasOwnProperty("closePHPPopups"))?Boolean(param1["closePHPPopups"]):true;
         this.navControl.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,param1,ProfilePanelTab.COLLECTIONS,null,_loc2_));
      }
      
      private function openMiniGame(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         if((this.navControl.navView.navFTUE) && (this.navControl.navView.navFTUE.active))
         {
            this.navControl.navView.navFTUE.hideFTUE();
         }
         var _loc2_:String = param1["game"] != null?param1["game"] as String:"";
         switch(_loc2_)
         {
            case "Blackjack":
               this.popupControl.showBlackjack();
               break;
            case "HiLo":
               this.popupControl.showHiLoGame(param1.data);
               break;
            case "SpinTheWheel":
               this.popupControl.showSpinTheWheel(param1.data);
               break;
         }
         
      }
      
      public function getPopupConfigByID(param1:String) : Popup {
         return this.popupControl.getPopupConfigByID(param1);
      }
      
      private function onJsStatHit(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.nav3Url;
         var _loc3_:Number = param1.inc;
         if(_loc2_ == null || (isNaN(_loc3_)))
         {
            return;
         }
         var _loc4_:String = _loc2_.substr(_loc2_.indexOf("?") + 1);
         var _loc5_:URLVariables = new URLVariables(_loc4_);
         var _loc6_:String = _loc5_.hasOwnProperty("item")?_loc5_.item:"";
      }
      
      private function onUpdatePokerGlobalData(param1:CommandEvent) : void {
         var _loc2_:Object = param1.params;
         if(!(_loc2_ == null) && (this.pgData.hasOwnProperty(_loc2_.name)))
         {
            this.pgData[_loc2_.name] = _loc2_.value;
         }
      }
      
      private function onFindRoom(param1:CommandEvent) : void {
         if(!this.pgData.inLobbyRoom)
         {
            return;
         }
         var _loc2_:Boolean = ObjectUtil.maybeGetBoolean(param1.params,"newUser",false);
         if(_loc2_)
         {
            this.findGame();
            return;
         }
         var _loc3_:int = int(param1.params);
         var _loc4_:String = this.pgData.userPreferencesContainer.tableTypeValue;
         if(!(this.pgData.dispMode == "tournament") && !(this.pgData.dispMode == "shootout") && !(this.pgData.dispMode == "weekly") && !(this.pgData.dispMode == "premium"))
         {
            this.pcmConnect.sendMessage(new SFindRoomRequest("SFindRoomRequest",9,_loc3_,_loc3_ * 2,0,"Challenge",0,_loc4_,[],1,0));
         }
         else
         {
            this.pgData.playAtStakes = _loc3_;
            this.lobbyControl.plModel.sLobbyMode = "challenge";
            this.pgData.dispMode = "challenge";
            this.pgData.bVipNav = true;
            this.pgData.joinPrevServ = true;
            this.pgData.newServerId = String(this.loadBalancer.getPrevServerOfType("normal"));
            this.pcmConnect.disconnect();
         }
         this._isPlayNow = true;
      }
      
      private function onHyperFindRoom(param1:CommandEvent) : void {
         var evt:CommandEvent = param1;
         var transition:JoinRoomTransition = new JoinRoomTransition(evt.params.roomId,evt.params.smallBlind,evt.params.maximumPlayers,evt.params.roomType);
         transition.fAfterJoin = function():void
         {
            pgData.roomNameDisplay = null;
            pgData.bAutoSitMe = true;
         };
         transition.join(this.pcmConnect);
      }
      
      private function onFireStatHit(param1:CommandEvent) : void {
         var _loc2_:PokerStatHit = param1.params as PokerStatHit;
         if(_loc2_ != null)
         {
            PokerStatsManager.DoHitForStat(_loc2_);
         }
      }
      
      private function onResetProfileCounter(param1:CommandEvent) : void {
         switch(param1.params)
         {
            case ResetProfileCounterCommand.ACHIEVEMENTS:
               this.pgData.newAchievementItemCount = 0;
               this.setNewCollectionItemCount(this.pgData.newCollectionItemCount);
               break;
            case ResetProfileCounterCommand.COLLECTIONS:
               this.setNewCollectionItemCount(0);
               this.pgData.buddyRequestedItemsCount = 0;
               this.pgData.buddyRequestedItemsOffsetCount = 0;
               this.pcmConnect.sendMessage(new SCollectionResetNewCnt("SCollectionResetNewCnt",this.pgData.inLobbyRoom));
               break;
         }
         
      }
      
      public function setNewCollectionItemCount(param1:int, param2:Boolean=true) : void {
         this.pgData.newCollectionItemCount = param1;
         if(param2)
         {
            this.navControl.updateNewProfileItemCount(this.pgData.newCollectionItemCount + this.pgData.newAchievementItemCount);
         }
         this.popupControl.setNewCollectionItemCount(param1);
      }
      
      private function handleCollectionItemEarned(param1:RCollectionItemEarned) : void {
         var _loc2_:* = NaN;
         if(!this._configModel.getBooleanForFeatureConfig("profilePanel","hideCollections"))
         {
            _loc2_ = param1.newItemCount + this.pgData.buddyRequestedItemsCount;
            if(param1.newItemCount > 0)
            {
               _loc2_ = _loc2_ - this.pgData.buddyRequestedItemsOffsetCount;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.setNewCollectionItemCount(_loc2_);
            if(param1.itemId > 0)
            {
               this.popupControl.incrementCollectionItemCount(param1.itemId);
            }
         }
      }
      
      public function getCollectionsInfo(param1:String="") : void {
         this._commandDispatcher.dispatchCommand(new GetCollectionsCommand(param1,this.pgData.inLobbyRoom));
      }
      
      private function handleCollectionsInfo(param1:CommandEvent) : void {
         var _loc2_:Object = param1.params as RCollectionsInfo;
         this.pgData.collections = _loc2_.collections;
         var _loc3_:Number = 0;
         if(_loc2_.userInfo.hasOwnProperty("newCnt"))
         {
            _loc3_ = Number(_loc2_.userInfo["newCnt"]);
         }
         _loc3_ = _loc3_ + this.pgData.buddyRequestedItemsCount;
         if((_loc2_.userInfo.hasOwnProperty("newCnt")) && Number(_loc2_.userInfo["newCnt"]) > 0)
         {
            _loc3_ = _loc3_ - this.pgData.buddyRequestedItemsOffsetCount;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this.setNewCollectionItemCount(_loc3_);
         if(_loc3_ > 0 && !this.pgData.hasSeenFirstItem && (this._externalInterface.available))
         {
            if(this.pgData.true_sn == this.pgData.SN_FACEBOOK || this.pgData.true_sn == this.pgData.SN_ZYNGALIVE)
            {
               this._externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.GET_THAT_BOOTY_ID);
            }
            this.pgData.hasSeenFirstItem = true;
         }
      }
      
      private function JSMessageToSmartfox(param1:Object) : void {
         if(this.pcmConnect != null)
         {
            this.pcmConnect.sendMessage(new SJSMessageToSmartfox("SJSMessageToSmartfox",param1,this.pgData.inLobbyRoom));
         }
      }
      
      private function onSmartfoxMessageToJS(param1:Object) : void {
         var _loc2_:String = null;
         switch(RSmartfoxMessageToJS(param1).jsDest)
         {
            case "canvas":
               this.notifyJS(new JSEvent(RSmartfoxMessageToJS(param1).messageName,RSmartfoxMessageToJS(param1).message));
               break;
            case "iframe":
               _loc2_ = "ZY.App.Flash.Events.handleFlashEvent";
               this._externalInterface.call(_loc2_,RSmartfoxMessageToJS(param1).messageName,RSmartfoxMessageToJS(param1).message);
               break;
         }
         
      }
      
      private function onRRequestHeartBeat(param1:Object) : void {
         var _loc2_:RRequestHeartBeat = RRequestHeartBeat(param1);
         var _loc3_:PokerHeartBeat = new PokerHeartBeat(_loc2_.id,_loc2_.delay,this,this.pcmConnect);
         this.heartBeatsCollection[_loc2_.id] = _loc3_;
      }
      
      public function killHeartBeat(param1:PokerHeartBeat) : void {
         this.heartBeatsCollection[param1.id] = null;
      }
      
      private function onStatsInfo(param1:Object) : void {
         var _loc2_:Array = com.adobe.serialization.json.JSON.decode(param1.params).stats;
         if(_loc2_)
         {
            this.popupControl.updateStats(_loc2_);
         }
      }
      
      private function onNavRequestCloseFlashPopups(param1:NCEvent) : void {
         this.popupControl.closeAllPopups(!param1.target.isPopupJS);
      }
      
      private function onNavRequestClosePHPPopups(param1:NCEvent) : void {
         this.popupControl.closePHPPopups();
      }
      
      private function onBuzzBoxClick_GetChipsSig() : void {
         this.pcmConnect.sendMessage(new SGetChipsSig("SGetChipsSig",this.pgData.inLobbyRoom));
      }
      
      private function initCommonUI() : void {
         this.commonControl.startCommonUIController(this);
         this.commonControl.addEventListener(CommonCEvent.ON_ZLIVE_HIDE,this.onCommonUIControllerZLiveHide,false,0,true);
         this.commonControl.init(this.layerManager.getLayer(PokerControllerLayers.COMMON_LAYER));
      }
      
      private function onCommonUIControllerZLiveHide(param1:CommonCEvent) : void {
         try
         {
            this.tableControl.updateJoinButtonSelected(false);
         }
         catch(e:Error)
         {
         }
      }
      
      private function initShoutController() : void {
         if(!this._shoutController)
         {
            this._shoutController = new ShoutController(this.minigameControl);
            this._shoutController.addEventListener(ShoutControllerEvent.EVENT_SHOW_ACHIEVEMENTS_PROFILE,this.showUnclaimedAchievements,false,0,true);
         }
      }
      
      public function displayShout(param1:String) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         this.initShoutController();
         this._shoutController.queueShout(_loc2_);
         this.navControl.onZoomShout(_loc2_);
      }
      
      private function showZPWCEligibleTournamentShout() : void {
         addEventListener(CommandEvent.TYPE_ZPWC_DATA_RESPONSE,this.onZPWCTournamentDataResponse,false,0,true);
         this._commandDispatcher.dispatchCommand(new ZPWCGenericCommand(CommandEvent.TYPE_REQUEST_ZPWC_DATA));
      }
      
      public function onZPWCTournamentDataResponse(param1:CommandEvent) : void {
         removeEventListener(CommandEvent.TYPE_ZPWC_DATA_RESPONSE,this.onZPWCTournamentDataResponse);
         var _loc2_:Object = param1.params.zpwcData;
         var _loc3_:Object = 
            {
               "type":ZPWCEligibleTournamentShout.SHOUT_TYPE,
               "ttdName":"ZPWCEligibleRegistration",
               "swfVars":
                  {
                     "tourneyID":param1.params.tourneyID,
                     "round":param1.params.round,
                     "roundStart":param1.params.startTime
                  }
            };
         this._shoutController.queueShout(_loc3_);
      }
      
      public function closeShout() : void {
         if(this._shoutController)
         {
            this._shoutController.onCloseShout();
         }
      }
      
      private function showUnclaimedAchievements(param1:ShoutControllerEvent) : void {
         this.navControl.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,null,ProfilePanelTab.ACHIEVEMENTS));
      }
      
      private function onLuckyBonusPullSlot(param1:Object) : void {
         this.popupControl.setLuckyBonusSpinResults(param1);
      }
      
      public function autoSpinLuckyBonus(param1:Boolean=false) : void {
         this.popupControl.autoSpinLuckyBonus(param1);
      }
      
      private function onShowLuckyBonus(param1:CommandEvent) : void {
         this.showLuckyBonus();
      }
      
      public function showLuckyBonus() : void {
         this.popupControl.showLuckyBonus();
      }
      
      private function showPokerGeniusMarketing() : void {
         if(this.getQuestionCount() > 0)
         {
            setTimeout(this.navControl.showStaticGameDropdown,3000);
         }
      }
      
      public function removeGameDropdown() : void {
         this.navControl.removeGameDropdown();
      }
      
      private function showPokerGenius(param1:Object) : void {
         this.popupControl.showPokerGenius(param1);
      }
      
      public function getQuestionCount() : int {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(this.pgData.pokerGeniusSettings)
         {
            _loc1_ = this.pgData.pokerGeniusSettings.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if((this.pgData.pokerGeniusSettings[_loc2_]) && this.pgData.pokerGeniusSettings[_loc2_].progress < this.PG_PROGRESS_DONE)
               {
                  break;
               }
               _loc2_++;
            }
            return _loc1_ - _loc2_;
         }
         return 0;
      }
      
      private function initXPLevelNames() : void {
         var _loc1_:Object = null;
         for each (_loc1_ in this.pgData.xpLevels)
         {
            _loc1_["name"] = LocaleManager.localize(_loc1_["name"]);
         }
      }
      
      private function initNav() : void {
         this.navControl.addEventListener(NCEvent.VIEW_INIT,this.onNavInit);
         this.navControl.addEventListener(NCEvent.CLOSE_FLASH_POPUPS,this.onNavRequestCloseFlashPopups);
         this.navControl.addEventListener(NCEvent.CLOSE_PHP_POPUPS,this.onNavRequestClosePHPPopups);
         this.navControl.pcmConnect = this.pcmConnect;
         this.navControl.pControl = this;
         this.navControl.init(this.layerManager.getLayer(PokerControllerLayers.NAV_LAYER));
         this._externalInterface.addCallback("closePopupResponse",this.closePopupResponse);
         this._externalInterface.addCallback("setSidebarItemsDeselected",this.setSidebarItemsDeselected);
         this._externalInterface.addCallback("showProfile",this.showProfile);
         this._externalInterface.addCallback("showAchievements",this.showAchievements);
         this._externalInterface.addCallback("showCollections",this.showCollections);
         this._externalInterface.addCallback("showChipsPanel",this.showChipsPanel);
         this._externalInterface.addCallback("closeAllPopups",this.closeAllPopups);
      }
      
      private function initTable() : void {
         if(this._isPlayNow)
         {
            this._isPlayNow = false;
            this.tableControl.isPlayNow = true;
         }
         if(!this.bTableInitialized)
         {
            this.tableControl.addEventListener(TCEvent.VIEW_INIT,this.onTableInit);
            this.tableControl.addEventListener(TCEvent.LEAVE_TABLE,this.onLeaveTable);
            this.tableControl.addEventListener(TCEvent.STAND_UP,this.onStandUp);
            this.tableControl.addEventListener(PokerSoundEvent.ON_SOUND_REQUEST,this.onPokerSoundEvent);
            this.tableControl.addEventListener(TCEvent.FRIEND_NET_PRESSED,this.onFriendNetworkPressed);
            this.tableControl.addEventListener(TCEvent.USER_CHIPS_UPDATED,this.onUserChipsUpdated);
            this.tableControl.pcmConnect = this.pcmConnect;
            this.tableControl.pControl = this;
            this.tableControl.init(this.layerManager.getLayer(PokerControllerLayers.TABLE_LOBBY_LAYER));
            this.bTableInitialized = true;
            this._externalInterface.call("flashJoinRoomCallback");
            PokerLoadMilestone.sendLoadMilestone("client_table_loaded");
         }
         else
         {
            this.tableControl.dispose();
            this.tableControl.init(this.layerManager.getLayer(PokerControllerLayers.TABLE_LOBBY_LAYER));
         }
      }
      
      private function initBuddyInvites() : void {
         this.pgData.aBuddyInvites = new Array();
      }
      
      private function getGiftInfo3(param1:Number) : void {
         if(GiftLibrary.GetInst().HasLoadedAllGiftInfo())
         {
            return;
         }
         this.pcmConnect.sendMessage(new SGetGiftInfo3("SGetGiftInfo3",param1));
      }
      
      public function getGiftPrices3(param1:Number, param2:String, param3:Boolean) : void {
         this.pcmConnect.sendMessage(new SGetGiftPrices3("SGetGiftPrices3",param1,param2,param3));
      }
      
      public function findGame() : void {
         var _loc1_:* = NaN;
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:JoinRoomTransition = null;
         var _loc5_:* = 0;
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         this.pgData.bAutoFindSeat = false;
         if(!this.pgData.inLobbyRoom)
         {
            return;
         }
         if(!(this.pgData.dispMode == "tournament") && !(this.pgData.dispMode == "shootout") && !(this.pgData.dispMode == "weekly") && !(this.pgData.dispMode == "premium"))
         {
            this.pgData.bAutoSitMe = true;
            _loc1_ = this.lobbyControl.plModel.newbieMaxLevel;
            _loc2_ = "";
            _loc2_ = _loc1_ > 0 && this.pgData.xpLevel < _loc1_?TableType.NORMAL:this.lobbyControl.plModel.filterTableType;
            _loc3_ = 0;
            if(!(this.lobbyControl == null) && !(this.lobbyControl.plModel == null))
            {
               _loc3_ = ObjectUtil.maybeGetInt(this.lobbyControl.plModel.lobbyConfig,"playNowFastTables",0);
            }
            if(this.pgData.enableHyperJoin)
            {
               _loc4_ = new JoinRoomTransition();
               _loc4_.join(this.pcmConnect);
            }
            else
            {
               if(_loc3_ == 0)
               {
                  this.pcmConnect.sendMessage(new SPickRoom("SPickRoom",_loc2_));
               }
               else
               {
                  _loc5_ = 10;
                  if(this.pgData.userPreferencesContainer.tableTypeValue == TableType.FAST)
                  {
                     _loc6_ = this.pgData.userPreferencesContainer.fastFilterValue.split(" / ");
                  }
                  else
                  {
                     _loc6_ = this.pgData.userPreferencesContainer.normalFilterValue.split(" / ");
                  }
                  if(_loc6_.length > 1)
                  {
                     _loc5_ = _loc6_[0];
                  }
                  else
                  {
                     _loc7_ = this.pgData.points / 5;
                     _loc8_ = this.lobbyControl.plModel.smallBlindLevels.length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_)
                     {
                        _loc10_ = this.lobbyControl.plModel.smallBlindLevels[_loc9_].smallBlind;
                        if(_loc10_ <= _loc7_ && _loc10_ > _loc5_)
                        {
                           _loc5_ = _loc10_;
                        }
                        _loc9_++;
                     }
                  }
                  switch(_loc3_)
                  {
                     case 3:
                        this.pcmConnect.sendMessage(new SFindRoomRequest("SFindRoomRequest",9,_loc5_,_loc5_ * 2,0,"Challenge",0,_loc2_,[],1,0));
                        break;
                     case 4:
                        this.pcmConnect.sendMessage(new SFindRoomRequest("SFindRoomRequest",5,_loc5_,_loc5_ * 2,0,"Challenge",0,_loc2_,[],1,0));
                        break;
                     case 5:
                        this.pcmConnect.sendMessage(new SFindRoomRequest("SFindRoomRequest",5,_loc5_,_loc5_ * 2,0,"Challenge",0,TableType.FAST,[],1,0));
                        break;
                     default:
                        this.pcmConnect.sendMessage(new SPickRoom("SPickRoom",_loc2_));
                  }
                  
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:PlayNow:" + _loc3_ + ":2013-05-13"));
               }
            }
         }
         else
         {
            this.pgData.bAutoFindSeat = true;
            this.lobbyControl.plModel.sLobbyMode = "challenge";
            this.pgData.dispMode = "challenge";
            this.pgData.bVipNav = true;
            this.pgData.joinPrevServ = true;
            this.pgData.newServerId = String(this.loadBalancer.getPrevServerOfType("normal"));
            this.pcmConnect.disconnect();
         }
      }
      
      public function updateCasinoGold() : void {
         this._commandDispatcher.dispatchCommand(new GetUserInfoCommand());
      }
      
      public function joinTableCheck(param1:int) : void {
         var joinRoomTransition:JoinRoomTransition = null;
         var inId:int = param1;
         var tRoom:RoomItem = this.pgData.getRoomById(inId);
         if(tRoom == null)
         {
            this.pgData.userDidSelectTableFromTableSelector = false;
            dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),LocaleManager.localize("flash.message.lobby.selectTable")));
            return;
         }
         this.pgData.gameRoomId = inId;
         if(this.pgData.dispMode == "shootout" && this.pgData.rejoinRoom > -1)
         {
            joinRoomTransition = new JoinRoomTransition(inId);
            joinRoomTransition.fBeforeJoin = function():void
            {
               lobbyControl.hideLobby();
               dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,LocaleManager.localize("flash.message.interstitial.joiningTable"),""));
            };
            joinRoomTransition.join(this.pcmConnect);
            return;
         }
         if(inId != -1)
         {
            if(this.pgData.dispMode == "shootout" && tRoom == null)
            {
               joinRoomTransition = new JoinRoomTransition(inId);
               joinRoomTransition.fBeforeJoin = function():void
               {
                  lobbyControl.hideLobby();
                  dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,LocaleManager.localize("flash.message.interstitial.joiningTable"),""));
               };
               joinRoomTransition.join(this.pcmConnect);
            }
            else
            {
               if(tRoom.tableType == "Private" && (this.pgData.iAmMod))
               {
                  this.pcmConnect.sendMessage(new SGetRoomPass("SGetRoomPass",inId));
               }
               else
               {
                  if(tRoom.tableType == "Private")
                  {
                     this.pgData.nPrivateRoomId = inId;
                     this.submitPassword(this.pgData.privateTableCommonPassword);
                  }
                  else
                  {
                     if(!this.pgData.joiningContact)
                     {
                        ZTrack.logCount(ZTrack.THROTTLE_ALWAYS,"o:LobbyUI:2010-04-08","table_selector","click","","","",1);
                     }
                     joinRoomTransition = new JoinRoomTransition(inId);
                     joinRoomTransition.fBeforeJoin = function():void
                     {
                        lobbyControl.hideLobby();
                        var _loc1_:String = pgData.hideTableNamesInLobby?LocaleManager.localize("flash.message.interstitial.joiningTable"):LocaleManager.localize("flash.message.interstitial.joiningTableX",{"name":pgData.roomNameDisplay});
                        dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,_loc1_,""));
                     };
                     joinRoomTransition.join(this.pcmConnect);
                  }
               }
            }
         }
      }
      
      public function tableJoin(param1:Object) : void {
         this.tableControl.tableJoin(param1);
      }
      
      public function hideInterstitial() : void {
         this.popupControl.hideInterstitial();
      }
      
      public function applyToCreatePrivateRoom() : void {
         var _loc1_:SApplyToCreateRoom = new SApplyToCreateRoom("SApplyToCreateRoom");
         this.pcmConnect.sendMessage(_loc1_);
      }
      
      public function cancelCreatePrivateRoom() : void {
         var _loc1_:SCancelCreateRoom = new SCancelCreateRoom("SCancelCreateRoom");
         this.pcmConnect.sendMessage(_loc1_);
      }
      
      public function createPrivateRoom(param1:String, param2:String, param3:Number, param4:Number, param5:Number) : void {
         var _loc6_:SCreateRoom = new SCreateRoom("SCreateRoom",param1,param2,param3,param4,param5);
         this.pcmConnect.sendMessage(_loc6_);
      }
      
      public function submitPassword(param1:String) : void {
         var _loc2_:JoinRoomTransition = new JoinRoomTransition(this.pgData.nPrivateRoomId);
         _loc2_.join(this.pcmConnect);
      }
      
      private function onAlert(param1:Object) : void {
         var _loc4_:* = NaN;
         var _loc2_:RAlert = RAlert(param1);
         var _loc3_:Object = _loc2_.oJSON;
         if(_loc3_["levelUppedXP"] != undefined)
         {
            _loc4_ = Number(_loc3_["levelUppedXP"]["level"]);
            if(!isNaN(_loc4_))
            {
               this.popupControl.setGiftPanelNewXPLevel(_loc4_);
            }
         }
         if(_loc3_["collections"] != undefined)
         {
            this.notifyJS(new JSEvent(JSEvent.COLLECTIONS_SHOUT,_loc3_.collections));
         }
         if(this.pgData.debugShout)
         {
            dispatchEvent(new ErrorPopupEvent("onErrorPopup","Shout Debug",com.adobe.serialization.json.JSON.encode(_loc2_.oJSON)));
         }
      }
      
      private function onUserChipsUpdated(param1:*) : void {
         try
         {
            this.navControl.updateChips();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onRefreshedUserInfo(param1:LCEvent) : void {
      }
      
      private function onLobbyInit(param1:LCEvent) : void {
         var tCookie:FlashCookie = null;
         var evt:LCEvent = param1;
         this.lobbyControl.displayLobby();
         this.commonControl.showView();
         this.loadBalancer.clearConnFail();
         if(this.pgData.trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LobbyRendered:AllLoaded_" + this.nRetries + ":2009-04-10","",1,"",PokerStatHit.HITTYPE_FG));
         }
         try
         {
            tCookie = new FlashCookie("PokerRetry");
         }
         catch(err:Error)
         {
            return;
         }
         tCookie.ClearAllValues();
         this.showTableRebalFTUE();
         this.playersClubInit();
      }
      
      private function onNavInit(param1:NCEvent) : void {
         this.navControl.displayNav();
      }
      
      private function onTableInit(param1:TCEvent) : void {
         this.layerManager.addLayerAfter(PokerControllerLayers.SHOUT_LAYER,PokerControllerLayers.MINIGAME_LAYER);
         this._shoutController.shoutParentView = this.layerManager.getLayer(PokerControllerLayers.SHOUT_LAYER);
         this._shoutController.allowedToShout = true;
      }
      
      public function onJoinTable(param1:JoinTableEvent) : void {
         if(this.pgData.dispMode == "challenge" && (this.checkForFlashBlockRequest(FlashRegionBlockEvent.JOIN_TABLE)))
         {
            this.flashInterruptedAction = param1;
            return;
         }
         this.joinTableCheck(param1.nId);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Lobby:TableListJoin:2009-03-20","",1,"",PokerStatHit.HITTYPE_FG));
      }
      
      private function onLeaveTable(param1:TCEvent) : void {
         var joinRoomTransition:JoinRoomTransition = null;
         var evt:TCEvent = param1;
         if(this.pgData.dispMode == "shootout")
         {
            this.pgData.joinShootoutLobby = true;
            this.lobbyControl.setShootoutMode();
            this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
         }
         else
         {
            if(this.pgData.dispMode == "premium")
            {
               joinRoomTransition = new JoinRoomTransition(this.pgData.lobbyRoomId);
               joinRoomTransition.fBeforeJoin = function():void
               {
                  pgData.joinPremiumLobby = true;
                  lobbyControl.setPremiumMode();
               };
               joinRoomTransition.join(this.pcmConnect);
            }
            else
            {
               if(this.pgData.dispMode == "weekly")
               {
                  this.lobbyControl.setWeeklyMode();
                  this.loadBalancer.addPrevServerId(Number(this.pgData.serverId));
                  this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
               }
               else
               {
                  if(this.pgData.mttZone)
                  {
                     dispatchEvent(new MTTEvent(MTTEvent.MTT_WITHDRAW));
                  }
                  else
                  {
                     this.processLeaveTable();
                  }
               }
            }
         }
      }
      
      private function processLeaveTable() : void {
         var joinRoomTransition:JoinRoomTransition = new JoinRoomTransition(this.pgData.lobbyRoomId);
         joinRoomTransition.fBeforeJoin = function():void
         {
            dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,LocaleManager.localize("flash.message.interstitial.joiningLobby"),""));
            lobbyControl.showLobbyGift(pgData.shownGiftID);
         };
         joinRoomTransition.join(this.pcmConnect);
      }
      
      private function onStandUp(param1:TCEvent) : void {
         var _loc2_:SStandUp = new SStandUp("SStandUp");
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      private function onFriendNetworkPressed(param1:TCEvent) : void {
         this.pgData.ZLiveToggle = -this.pgData.ZLiveToggle;
         if(this.pgData.ZLiveToggle > 0)
         {
            this.commonControl.showFriendSelector();
            this.tableControl.updateJoinButtonSelected(true);
         }
         else
         {
            this.commonControl.hideFriendSelector();
            this.tableControl.updateJoinButtonSelected(false);
         }
      }
      
      public function onBuyInAccept(param1:Number, param2:int, param3:int) : void {
         this.pgData.rakeEnabled = (this.tableControl.rakeNextHand) && (this._configModel.isFeatureEnabled("hsm"))?1:0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         _loc4_ = int(this.pgData.arbAutoRebuySelected);
         _loc5_ = int(this.pgData.arbTopUpStackSelected);
         var _loc6_:Object = this._configModel.getFeatureConfig("hsm");
         var _loc7_:Object = (_loc6_) && (_loc6_.fg_shsm)?_loc6_.fg_shsm:new Object();
         var _loc8_:Boolean = _loc7_.on == 1?true:false;
         var _loc9_:SSit = new SSit("SSit",param1,param2,param3,_loc8_?0:this.pgData.rakeEnabled,_loc4_,_loc5_,int(this.tableControl.HSMEnabled));
         this.tableControl.showHSMPromo();
         this.pcmConnect.sendMessage(_loc9_);
         this.tableControl.ptView.updateAfterBuyIn();
         if(!this.hasDoneTableBuyInMilestone)
         {
            PokerLoadMilestone.sendLoadMilestone("client_table_buyin");
            this.hasDoneTableBuyInMilestone = true;
         }
         if((_loc8_) && !this.tableControl.ptModel.isTournament)
         {
            if(this.pgData.rakeEnabled)
            {
               this.tableControl.onRakeEnabled();
            }
            else
            {
               this.tableControl.onRakeDisabled(false);
            }
         }
      }
      
      public function onReBuyInCancel(param1:int) : void {
         this.tableControl.onReBuyInCancel();
      }
      
      public function onAddBuddy(param1:String) : void {
         var _loc2_:SAddBuddy = new SAddBuddy("SAddBuddy",param1);
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      public function onBuyGift2(param1:Number, param2:Number, param3:String) : void {
         var _loc4_:SBuyGift2 = new SBuyGift2("SBuyGift2",param1,param2,param3,this.pgData.inLobbyRoom);
         this.pcmConnect.sendMessage(_loc4_);
      }
      
      public function onAcceptBuddy(param1:String, param2:String) : void {
         this._commandDispatcher.dispatchCommand(new BuddyAcceptRequestCommand(param1,param2));
      }
      
      public function onIgnoreBuddy(param1:String) : void {
         this._commandDispatcher.dispatchCommand(new BuddyDenyRequestCommand(param1));
      }
      
      public function onIgnoreAllBuddy() : void {
         var _loc1_:SIgnoreAllBuddy = new SIgnoreAllBuddy("SIgnoreAllBuddy");
         this.pcmConnect.sendMessage(_loc1_);
      }
      
      public function onClaimGift(param1:Number, param2:Number, param3:String) : void {
         this.pcmConnect.sendMessage(
            {
               "type":"SClaimGift",
               "messageName":"claimSponsoredGift",
               "giftId":param2,
               "categoryId":param1,
               "toZid":param3,
               "fromLobby":this.pgData.inLobbyRoom
            });
      }
      
      public function onAbuse(param1:String, param2:String, param3:String) : void {
         var _loc4_:SReportUser = new SReportUser("SReportUser",param1,param2,param3);
         this.pcmConnect.sendMessage(_loc4_);
      }
      
      public function onPrivateTableClick(param1:LCEvent) : void {
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),"Private rooms are temporarily not available while we work on adding additional security features."));
      }
      
      private function getLobbyRooms() : void {
         this.pcmConnect.getLobbyRooms();
      }
      
      public function reconnectToServer() : void {
         this.loadBalancer.addEventListener(LoadBalancer.onServerChosen,this.onServerChosen);
         this.loadBalancer.chooseBestServer();
      }
      
      public function connectToServer() : void {
         var _loc1_:Array = this.pgData.ip.split(":");
         var _loc2_:Array = this.loadBalancer.getPortOrder(this.pgData.serverId);
         var _loc3_:String = this.pgData.ip;
         if(_loc1_.length > 1)
         {
            _loc3_ = _loc1_[0];
            if(_loc2_.length == 0)
            {
               _loc2_ = [_loc1_[1]];
            }
         }
         this.pcmConnect.connect(_loc3_,_loc2_,this.pgData.lastKnownGoodPort,this.pgData.serverId,this.loadBalancer.getConnectionTimeout(this.pgData.serverId),this.loadBalancer.getPollRate(this.pgData.serverId));
         var _loc4_:* = "";
         if(this.pgData.lastHyperJoin == null || (this.pgData.lastHyperJoin.isComplete()))
         {
            _loc4_ = this.pgData.mttZone?LocaleManager.localize("flash.mtt.interstitial"):LocaleManager.localize("flash.message.interstitial.connecting");
         }
         dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,_loc4_,""));
         this.refreshLobbyBackground();
      }
      
      public function cleanupAndReconnect() : void {
         if(!this.pgData.inLobbyRoom)
         {
            this.tableControl.cleanupTable();
         }
         this.pgData.joinPrevServ = true;
         this.pgData.newServerId = this.pgData.serverId;
         this.reconnectToServer();
      }
      
      private function onServerChosen(param1:Event) : void {
         this.loadBalancer.removeEventListener(LoadBalancer.onServerChosen,this.onServerChosen);
         var _loc2_:Array = this.pgData.ip.split(":");
         var _loc3_:Array = this.loadBalancer.getPortOrder(this.pgData.serverId);
         var _loc4_:String = this.pgData.ip;
         if(_loc2_.length > 1)
         {
            _loc4_ = _loc2_[0];
            if(_loc3_.length == 0)
            {
               _loc3_ = [_loc2_[1]];
            }
         }
         this.pcmConnect.connect(_loc4_,_loc3_,this.pgData.lastKnownGoodPort,this.pgData.serverId,this.loadBalancer.getConnectionTimeout(this.pgData.serverId),this.loadBalancer.getPollRate(this.pgData.serverId));
         var _loc5_:String = LocaleManager.localize("flash.message.interstitial.connecting");
         dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,_loc5_,""));
         this.refreshLobbyBackground();
      }
      
      public function onFindSeat(param1:LCEvent) : void {
         if(this.pgData.dispMode == "challenge" && (this.checkForFlashBlockRequest(FlashRegionBlockEvent.PLAY_NOW)))
         {
            this.flashInterruptedAction = param1;
            return;
         }
         this.findGame();
         PokerStatsManager.DoHitForStat(new PokerStatHit("TableJoinFindMeASeat",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other TableJoinFindMeASeat o:LiveJoin:2009-05-14",null,1,""));
      }
      
      private function onConnectionHandler(param1:SmartfoxConnectionEvent) : void {
         var _loc2_:* = "";
         var _loc3_:* = "";
         var _loc4_:* = "";
         var _loc5_:* = "";
         var _loc6_:Number = 0;
         var _loc7_:Object = this._configModel.getFeatureConfig("user");
         if(_loc7_)
         {
            if(_loc7_.pw)
            {
               _loc2_ = _loc7_.pw;
            }
            if(_loc7_.pic_url)
            {
               _loc3_ = _loc7_.pic_url;
            }
            if(_loc7_.pic_lrg_url)
            {
               _loc4_ = _loc7_.pic_lrg_url;
            }
            if(_loc7_.userLocale)
            {
               _loc5_ = _loc7_.userLocale;
            }
            if(_loc7_.newUserPopup > 0)
            {
               _loc6_ = 1;
            }
         }
         this.pgData.lastKnownGoodPort = param1.port;
         var _loc8_:String = this.pgData.zid;
         var _loc9_:int = this._configModel.getIntForFeatureConfig("table","tourneyId",-1);
         if(_loc9_ > -1)
         {
            _loc8_ = _loc8_ + (":" + _loc9_);
         }
         var _loc10_:int = this._configModel.getIntForFeatureConfig("user","clientId",-1);
         var _loc11_:SSuperLogin = new SSuperLogin(_loc8_,_loc3_,_loc4_,this.pgData.sn_id,String(this.pgData.tourneyState),this.pgData.protoVersion,0,"flash",_loc10_,1,1,1,_loc2_,this._configModel.getStringForFeatureConfig("core","sZone","TexasHoldemUp"),_loc5_,this.pgData.nHideGifts,this._configModel.getIntForFeatureConfig("gift","pgBuyAndSend",1),this.pgData.pgViewAndDisplay,_loc6_,this.pgData.emailSubscribed?1:0,this.pgData.smartfoxVars,this.pgData.buildVersion,this.pgData.clientSupportsUnreachableProtection);
         this.pcmConnect.login(_loc11_);
         this.refreshLobbyBackground();
      }
      
      private function onConnectionFailed(param1:SmartfoxConnectionEvent) : void {
         this.pgData.lastKnownGoodPort = "";
         var _loc2_:RLogKO = new RLogKO("RLogKO",false,"There is a problem connecting to the server. Please refresh your page and try again!",false);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         switch(_loc2_.type)
         {
            case "RLogin":
               this.handleLogin(_loc2_);
               break;
            case "RRoomListUpdate":
               this.handleRoomListUpdate(_loc2_);
               break;
            case "RJoinRoom":
               this.handleJoinRoom(_loc2_);
               break;
            case "RJoinRoomError":
               this.handleJoinRoomError(_loc2_);
               break;
            case "RConnectionLost":
               this.handleConnectionLost(_loc2_);
               break;
            case "RAlert":
               this.onAlert(_loc2_);
               break;
            case "RGiftInfo3":
               this.updateGiftInfo3(_loc2_);
               break;
            case "RGiftTooExpensive":
               this.updateGiftTooExpensive(_loc2_);
               break;
            case "RPremiumGiftTooExpensive":
               this.onPremiumGiftTooExpensive(_loc2_);
               break;
            case "RGiftPrices3":
               this.updateGiftPrices3(_loc2_);
               break;
            case "RSetMod":
               this.updateSetMod(_loc2_);
               break;
            case "RRoomPass":
               this.handleRoomPass(_loc2_);
               break;
            case RHyperJoin.PROTOCOL_TYPE:
               this.handleHyperJoin(_loc2_);
               break;
            case "RRoomPicked":
               this.handleRoomPicked(_loc2_);
               break;
            case "RDisplayRoomList":
               this.handleDisplayRoomList(_loc2_);
               break;
            case "RBoughtGift2":
               this.onBoughtGift2(_loc2_);
               break;
            case "ROutOfChips":
               this.onOutOfChips(_loc2_);
               break;
            case "RShowMessage":
               this.onShowMessage(_loc2_);
               break;
            case "RAcquireToken":
               this.onAcquireToken(_loc2_);
               break;
            case "RAdminMessage":
               this.onAdminMessage(_loc2_);
               break;
            case "RLogKO":
               this.onLogKO(_loc2_);
               break;
            case "RShootoutConfig":
               this.onShootoutConfig(_loc2_);
               break;
            case "RPremiumShootoutConfig":
               this.onPremiumShootoutConfig(_loc2_);
               break;
            case "RDisplayRoom":
               this.onDisplayRoom(_loc2_);
               break;
            case "RUserShootoutState":
               this.onUserShootoutState(_loc2_);
               break;
            case "RGetUserInfo":
               this.onGetUserInfo(_loc2_);
               break;
            case "RGiftShown2":
               this.onGiftShown2(_loc2_);
               break;
            case "RBuyRoundSkippingTooExpensive":
               this.onBuyRoundSkippingTooExpensive(_loc2_);
               break;
            case "RCollectionItemEarned":
               if(_loc2_ is RCollectionItemEarned)
               {
                  this.handleCollectionItemEarned(_loc2_ as RCollectionItemEarned);
               }
               break;
            case "RStatsInfo":
               this.onStatsInfo(_loc2_);
               break;
            case "RLadderGameHighScore":
               this.onLadderGameHighScore(_loc2_);
               break;
            case "RRatholingUserState":
               this.onRatholingUserState(_loc2_);
               break;
            case "RRakeAmount":
               this.onRakeAmount(_loc2_);
               break;
            case "RRakeDisabled":
               this.onRakeDisabled(_loc2_);
               break;
            case "RRakeEnabled":
               this.onRakeEnabled(_loc2_);
               break;
            case "RRakeInsufficientFunds":
               this.onRakeInsufficientFunds(_loc2_);
               break;
            case "RSmartfoxMessageToJS":
               this.onSmartfoxMessageToJS(_loc2_);
               break;
            case "RRequestHeartBeat":
               this.onRRequestHeartBeat(_loc2_);
               break;
            case "RJumpTableSearchResult":
               this.onJumpTableSearchResult(_loc2_);
               break;
            case "RMTTSitInfo":
               this.onMTTSitInfo(_loc2_);
               break;
            case RMoveGivenPlayer.PROTOCOL_TYPE:
               this.onMoveGivenPlayer(_loc2_);
               break;
            case RFinishPlayerMove.PROTOCOL_TYPE:
               this.onFinishPlayerMove(_loc2_);
               break;
         }
         
      }
      
      private function onBoughtGift2(param1:Object) : void {
         var _loc5_:PokerUser = null;
         var _loc2_:RBoughtGift2 = RBoughtGift2(param1);
         var _loc3_:* = false;
         var _loc4_:* = false;
         if(_loc2_.senderSit == -1)
         {
            _loc3_ = true;
            _loc4_ = true;
         }
         if(!(_loc2_.senderSit == -1) && (this.tableControl))
         {
            if(this.tableControl.ptModel)
            {
               _loc5_ = this.tableControl.ptModel.getUserBySit(_loc2_.senderSit);
               if(!(_loc5_ == null) && (this.pgData.isMe(_loc5_.zid)))
               {
                  _loc3_ = true;
               }
            }
         }
         if(_loc3_)
         {
            this.popupControl.boughtGiftSuccessfully();
         }
      }
      
      public function giftTooExpensiveGeneral(param1:Number, param2:int, param3:String) : void {
         if(param3 == "chips")
         {
            if(((!this.pgData.inLobbyRoom) && (this.tableControl)) && (this.tableControl.ptModel) && this.tableControl.ptModel.nBigblind * 10 <= 40)
            {
               this.showInsufficientChips();
            }
            else
            {
               this._externalInterface.call("ZY.App.outOfChips.openPopup",param1,"chips",param2);
            }
         }
         else
         {
            this._externalInterface.call("ZY.App.outOfChips.openPopup",param1,"gold",param2);
         }
      }
      
      private function onPremiumGiftTooExpensive(param1:Object) : void {
         var _loc2_:Number = param1.uCostOfGift - param1.uMyCurrentChipTotal;
         var _loc3_:* = 6;
         this.giftTooExpensiveGeneral(_loc2_,_loc3_,"gold");
      }
      
      private function onGiftShown2(param1:Object) : void {
         var _loc3_:PokerUser = null;
         var _loc2_:RGiftShown2 = RGiftShown2(param1);
         if(!(_loc2_.sit == -1) && !this.pgData.inLobbyRoom)
         {
            _loc3_ = this.tableControl.ptModel.getUserBySit(_loc2_.sit);
            if(_loc3_.zid == this.viewer.zid)
            {
               this.setShownGift(_loc2_.giftId);
            }
         }
         else
         {
            this.setShownGift(_loc2_.giftId);
         }
      }
      
      public function setShownGift(param1:Number) : void {
         this.pgData.shownGiftID = param1;
         this.popupControl.shownGift(this.pgData.shownGiftID);
         this.lobbyControl.setShownGift(param1);
      }
      
      private function onBuyRoundSkippingTooExpensive(param1:Object) : void {
         this.pgData.bDidPurchaseShootoutSkip = false;
         if(param1.uCostOfGift == this.pgData.skipShootoutRound1Price)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Shootout Other Click o:FailedShootoutRoundSkipTo2:2010-01-06",null,1,""));
         }
         else
         {
            if(param1.uCostOfGift == this.pgData.skipShootoutRound2Price)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Shootout Other Click o:FailedShootoutRoundSkipTo3:2010-01-06",null,1,""));
            }
         }
         var _loc2_:Number = param1.uCostOfGift - this.pgData.casinoGold;
         this.giftTooExpensiveGeneral(_loc2_,8,"gold");
      }
      
      private function handleLogin(param1:Object) : void {
         var _loc2_:RLogin = RLogin(param1);
         if(_loc2_.bSuccess)
         {
            this.pgData.playLevel = _loc2_.playLevel;
            this.pgData.name = _loc2_.name;
            this.pgData.points = _loc2_.points;
            this.pgData.rejoinRoom = _loc2_.rejoinRoom;
            this.pgData.rejoinType = _loc2_.rejoinType;
            this.pgData.rejoinPass = _loc2_.rejoinPass;
            this.pgData.rejoinTime = _loc2_.rejoinTime;
            this.pgData.bonus = _loc2_.bonus;
            this.pgData.privateTableEnabled = _loc2_.privateTableEnabled;
            if(this.lobbyControl)
            {
               this.lobbyControl.updatePrivateTablesTab(this.pgData.privateTableEnabled);
            }
            this.onInitZoom();
            this.zoomControl.connect();
            this.notifyJS(new JSEvent(JSEvent.SF_CONNECTED));
         }
      }
      
      private function handleRoomListUpdate(param1:Object) : void {
         if(this.pgData.firstRoomList)
         {
            this.pgData.firstRoomList = false;
         }
      }
      
      private function onDisplayRoom(param1:Object) : void {
         var _loc2_:RDisplayRoom = RDisplayRoom(param1);
         if(this.pgData.getRoomById(_loc2_.rooms[0].id) == null)
         {
            this.pgData.aGameRooms.push(_loc2_.rooms[0]);
         }
      }
      
      private function handleJoinRoom(param1:Object) : void {
         var joinRoomTransition:JoinRoomTransition = null;
         var inMsg:Object = param1;
         var tMsg:RJoinRoom = RJoinRoom(inMsg);
         if(this.pgData.lastHyperJoin != null)
         {
            if(this.pgData.lastHyperJoin.nRoomId == tMsg.roomId)
            {
               this.pgData.lastHyperJoin.close();
            }
            else
            {
               if(tMsg.roomId == this.pgData.lobbyRoomId)
               {
                  this.pgData.lastHyperJoin.join(this.pcmConnect);
               }
            }
         }
         var sServType:String = this.loadBalancer.getServerType(this.pgData.serverId);
         this.updateLobbyTabs(sServType);
         if(tMsg.roomName == "Saloon")
         {
            this.pgData.lobbyRoomId = tMsg.roomId;
            this.pgData.inLobbyRoom = true;
            if(this._lobbyTransitionHyperJoin !== null)
            {
               this.pgData.lastHyperJoin = this._lobbyTransitionHyperJoin;
               this._lobbyTransitionHyperJoin = null;
               this.hyperJoinServerConnect(this.pgData.lastHyperJoin.targetServerId);
               return;
            }
            this.layerManager.removeLayer(PokerControllerLayers.SHOUT_LAYER);
            this.unhideLeaderboard();
            dispatchEvent(new PCEvent(PCEvent.LOBBY_JOINED));
            if(!(this.main.pfrm == null) && this.main.pfrm.setStatus is Function)
            {
               this.main.pfrm.setStatus(PokerFramerateManager.STATUS_LOBBY);
            }
            this.showTableRebalFTUE();
            this.lobbyControl.startLobbyIdleTimer();
            this.lobbyControl.showLobby();
         }
         else
         {
            if(this.pgData.joiningContact)
            {
               if(tMsg.numPlayers >= 0)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:LiveJoin:Attempted:2013-04-04"));
                  if(tMsg.numPlayers >= this.getLiveJoinActivePlayerThreshold(tMsg))
                  {
                     this.joinRoom(tMsg.roomId,tMsg.roomName);
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:LiveJoin:Succeeded:2013-04-09"));
                  }
                  else
                  {
                     dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.unableToJoinBuddyTitle"),LocaleManager.localize("flash.message.unableToJoinBuddyMessage2")));
                     this.pgData.joiningContact = false;
                     this.pgData.isJoinFriend = false;
                     this.pgData.joinFriendId = "";
                     this.pgData.joinFriendName = "";
                     joinRoomTransition = new JoinRoomTransition(this.pgData.lobbyRoomId);
                     joinRoomTransition.fAfterJoin = function():void
                     {
                        zoomUpdateUser();
                        closeShout();
                        PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Unknown Other Unknown o:LiveJoin:Denied:2013-04-04"));
                     };
                     joinRoomTransition.join(this.pcmConnect);
                  }
                  this.pgData.joiningContact = false;
               }
            }
            else
            {
               this.joinRoom(tMsg.roomId,tMsg.roomName);
            }
         }
         if((this.pgData.joiningContact) && !(this.pgData.nNewRoomId == -1))
         {
         }
         this.initBuddyInvites();
         this.onUpdateUserPresence(null);
         this.zoomUpdateUser();
         if((this.pgData.inLobbyRoom) && (this.pgData.jumpTablesEnabled) && (this.pgData.willJumpTable) && !(this.pgData.tableIdToJumpTo == -1))
         {
            joinRoomTransition = new JoinRoomTransition(this.pgData.tableIdToJumpTo);
            joinRoomTransition.fBeforeJoin = function():void
            {
               pgData.gameRoomId = pgData.tableIdToJumpTo;
            };
            joinRoomTransition.fAfterJoin = function():void
            {
               pgData.willJumpTable = false;
               pgData.tableIdToJumpTo = -1;
               pgData.tableNameToJumpTo = "";
            };
            joinRoomTransition.join(this.pcmConnect);
         }
         if(this._rollingRebootStoredInfoForLobbyJoin != null)
         {
            this.mttConnectToServer(this._rollingRebootStoredInfoForLobbyJoin.serverIp,this._rollingRebootStoredInfoForLobbyJoin.serverType,this._rollingRebootStoredInfoForLobbyJoin.serverName,String(this._rollingRebootStoredInfoForLobbyJoin.serverId));
            if(this._rollingRebootStoredInfoForLobbyJoin.roomId > 1)
            {
               this.pcmConnect.rollingRebootStoredInfo = this._rollingRebootStoredInfoForLobbyJoin;
            }
            this._rollingRebootStoredInfoForLobbyJoin = null;
         }
      }
      
      private function getLiveJoinActivePlayerThreshold(param1:RJoinRoom) : int {
         if(!this._configModel.getBooleanForFeatureConfig("core","limitLiveJoins"))
         {
            return 0;
         }
         var _loc2_:int = this.DEFAULT_LIVE_JOIN_ACTIVE_PLAYER_THRESHOLD;
         switch(param1.maxPlayers)
         {
            case 5:
               _loc2_ = 3;
               break;
            case 9:
               _loc2_ = 5;
               break;
         }
         
         return _loc2_;
      }
      
      private function joinRoom(param1:int, param2:String) : void {
         this.lobbyControl.hideLobby();
         this.getGiftPrices3(-1,this.viewer.zid,false);
         this.pgData.inLobbyRoom = false;
         this.pgData.gameRoomId = param1;
         if(this._configModel.getIntForFeatureConfig("table","tourneyId",-1) > -1)
         {
            this.pgData.gameRoomName = "Weekly Tourney";
         }
         else
         {
            this.pgData.gameRoomName = param2;
         }
         this.initTable();
         this.popupControl.hideInterstitial();
         var _loc3_:SReplayState = new SReplayState("SReplayState");
         this.pcmConnect.sendMessage(_loc3_);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:Table:OnJoinedATable:2012-07-13"));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:DisplayTable:2009-03-20","",1,"",PokerStatHit.HITTYPE_FG));
         if(!(this.main.pfrm == null) && this.main.pfrm.setStatus is Function)
         {
            this.main.pfrm.setStatus(PokerFramerateManager.STATUS_TABLE);
         }
         this._commandDispatcher.dispatchCommand(new LoadSoundGroupCommand(PokerSoundEvent.GROUP_TABLE));
         this.pokerSoundManager.loadSoundByGroup(PokerSoundEvent.GROUP_TABLE);
         this.navControl.showOneClickRebuy();
         this.navControl.hideNavFTUEs();
         this.lobbyControl.stopLobbyIdleTimer();
         this.hideLeaderboard();
         dispatchEvent(new PCEvent(PCEvent.TABLE_JOINED));
      }
      
      private function handleJoinRoomError(param1:Object) : void {
         var _loc2_:RJoinRoomError = RJoinRoomError(param1);
         this.joinRoomError(_loc2_.sMessage);
      }
      
      private function joinRoomError(param1:String=null) : void {
         if(this.pgData.lastHyperJoin != null)
         {
            this.pgData.lastHyperJoin.cancel();
         }
         var _loc2_:* = "";
         switch(param1)
         {
            case "Password is wrong":
               LocaleManager.localize("flash.message.joinRoomError.invalidPassword");
               break;
            case "Problems joining this room":
               LocaleManager.localize("flash.message.joinRoomError.problems");
               break;
            case "This room is currently full":
               LocaleManager.localize("flash.message.joinRoomError.roomIsFull");
               break;
            case "All player slots are occupied":
               LocaleManager.localize("flash.message.joinRoomError.playerSlotsFull");
               break;
            case "All spectator slots are occupied":
               LocaleManager.localize("flash.message.joinRoomError.spectatorSlotsFull");
               break;
            case "User is already in this room!":
               LocaleManager.localize("flash.message.joinRoomError.alreadyInRoom");
               break;
            default:
               _loc2_ = param1;
         }
         
         var _loc3_:String = _loc2_?LocaleManager.localize("flash.message.joinRoomError",{"message":_loc2_}):LocaleManager.localize("flash.message.joinRoomErrorNoInfo");
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),_loc3_));
         this.pgData.isJoinFriend = false;
         this.pgData.joinFriendId = "";
         this.pgData.joiningContact = false;
         if(!this.pgData.mttZone)
         {
            this.lobbyControl.showLobby();
            this.getLobbyRooms();
         }
      }
      
      private function handleHyperJoin(param1:Object) : void {
         var _loc3_:* = NaN;
         var _loc4_:String = null;
         var _loc2_:RHyperJoin = RHyperJoin(param1);
         if(this.pgData.lastHyperJoin != null)
         {
            if(_loc2_.serverId == 0)
            {
               this.joinRoomError();
            }
            else
            {
               if(this.pgData.gameRoomId == Number(_loc2_.roomId) && this.pgData.serverId == String(_loc2_.serverId))
               {
                  _loc3_ = this.pgData.gameRoomId;
                  this.pgData.lastHyperJoin.cancel();
                  this.pgData.gameRoomId = _loc3_;
               }
               else
               {
                  this.pgData.lastHyperJoin.setHyperJoinResponse(_loc2_);
                  _loc4_ = String(_loc2_.serverId);
                  if(this.pgData.serverId == _loc4_)
                  {
                     this.pgData.lastHyperJoin.join(this.pcmConnect);
                  }
                  else
                  {
                     if(this.pgData.inLobbyRoom === false)
                     {
                        this._lobbyTransitionHyperJoin = this.pgData.lastHyperJoin;
                        this._lobbyTransitionHyperJoin.targetServerId = _loc4_;
                        this.onLeaveTable(null);
                     }
                     else
                     {
                        this.hyperJoinServerConnect(_loc4_);
                     }
                  }
               }
            }
         }
      }
      
      private function hyperJoinServerConnect(param1:String) : void {
         this.pgData.bUserDisconnect = true;
         this.pcmConnect.disconnectWithoutReconnect();
         this.pgData.serverId = param1;
         this.pgData.ip = this.loadBalancer.getServerIp(this.pgData.serverId);
         this.pgData.serverName = this.loadBalancer.getServerName(this.pgData.serverId);
         this.pgData.server_type = this.loadBalancer.getServerType(this.pgData.serverId);
         var _loc2_:Object = this.pgData.configModel.getFeatureConfig("core");
         if(_loc2_)
         {
            _loc2_.sZone = this.loadBalancer.getZone(this.pgData.server_type);
         }
         this.connectToServer();
      }
      
      private function handleDisplayRoomList(param1:Object) : void {
         this.getGiftInfo3(-1);
         if((this._mttServerSwapping) && (this.pgData.mttZone))
         {
            if(this.pgData.ip == this._mttHomeServer)
            {
               this.leaveMTTZone();
            }
            else
            {
               this._mttServerSwapping = false;
               dispatchEvent(new CommandEvent("MTTServerVerified",
                  {
                     "room":this._mttRoom,
                     "serverJump":true
                  }));
               this._mttRoom = "";
            }
         }
      }
      
      private function updateSetMod(param1:Object) : void {
         var _loc2_:RSetMod = RSetMod(param1);
         this.pgData.iAmMod = param1.isMod;
      }
      
      private function handleRoomPicked(param1:Object) : void {
         var _loc3_:SCreateBucketRoom = null;
         var _loc4_:Object = null;
         var _loc2_:RRoomPicked = RRoomPicked(param1);
         if(_loc2_.roomId == -1)
         {
            _loc3_ = new SCreateBucketRoom("SCreateBucketRoom",_loc2_.bucket);
            this.pcmConnect.sendMessage(_loc3_);
         }
         else
         {
            if(_loc2_.bucket != 0)
            {
               this.pgData.assignedSeat = _loc2_.bucket;
               this.pgData.assignedRoom = _loc2_.roomId;
               this.pgData.bAutoSitMe = true;
            }
            else
            {
               this.pgData.assignedSeat = 0;
               this.pgData.assignedRoom = -1;
            }
            if(_loc2_.sIp != "")
            {
               _loc4_ = this._configModel.getFeatureConfig("core");
               this.pgData.bUserDisconnect = true;
               this.pcmConnect.disconnectWithoutReconnect();
               this.pgData.ip = _loc2_.sIp;
               this.pgData.serverId = this.loadBalancer.getServerIdByIp(this.pgData.ip);
               this.pgData.serverName = this.loadBalancer.getServerNameByIp(this.pgData.ip);
               this.pgData.server_type = this.loadBalancer.getServerType(this.pgData.serverId);
               if(_loc4_)
               {
                  _loc4_.sZone = this.loadBalancer.getZone(this.pgData.server_type);
               }
               this.loadBalancer.addPrevServerId(Number(this.loadBalancer.getServerIdByIp(this._mttHomeServer)));
               this.connectToServer();
            }
            else
            {
               this.joinTableCheck(_loc2_.roomId);
            }
         }
      }
      
      private function handleRoomPass(param1:Object) : void {
         var _loc2_:RRoomPass = RRoomPass(param1);
         var _loc3_:JoinRoomTransition = new JoinRoomTransition(int(_loc2_.roomId));
         _loc3_.join(this.pcmConnect);
      }
      
      private function updateGiftInfo3(param1:Object) : void {
         var _loc2_:RGiftInfo3 = RGiftInfo3(param1);
         var _loc3_:Object = _loc2_.oJSON;
         var _loc4_:GiftLibrary = GiftLibrary.GetInst();
         _loc4_.AddGiftInfoList(_loc3_);
         _loc4_.giftFilters = this.pgData.giftFilters;
         this.showPlayersClubAppEntryReward();
      }
      
      private function updateGiftTooExpensive(param1:Object) : void {
         var _loc2_:Number = param1.uCostOfGift - param1.uMyCurrentChipTotal;
         var _loc3_:* = 5;
         this.giftTooExpensiveGeneral(_loc2_,_loc3_,"chips");
      }
      
      private function onAcquireToken(param1:Object) : void {
         var _loc2_:RAcquireToken = RAcquireToken(param1);
         this.pgData.userToken = _loc2_.token;
         this.pgData.userTokenExpirationDate = _loc2_.expirationDate;
         this.pgData.userTokenCounter = _loc2_.tokenCounter;
      }
      
      public function getUserToken() : String {
         var _loc1_:Date = new Date();
         if(this.pgData.userToken == null)
         {
            this.pcmConnect.sendMessage(new SAcquireToken("SAcquireToken"));
         }
         else
         {
            if(this.pgData.userTokenExpirationDate.getTime() < _loc1_.getTime())
            {
               this.pcmConnect.sendMessage(new SAcquireToken("SAcquireToken"));
            }
         }
         return String(this.pgData.userTokenCounter) + ":" + this.pgData.userToken;
      }
      
      public function sendTableBuddyCount(param1:Number) : void {
         var _loc2_:SSendTableBuddyCount = new SSendTableBuddyCount("SSendTableBuddyCount",param1);
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      public function getSameIDs() : Array {
         return this.commonControl.getSameTableIds(this.pgData.gameRoomId);
      }
      
      private function updateGiftPrices3(param1:Object) : void {
         var _loc2_:RGiftPrices3 = RGiftPrices3(param1);
         GiftLibrary.GetInst().AddGiftPriceList(String(_loc2_.giftType),_loc2_.giftArray);
         GiftLibrary.GetInst().AddCategoryList(_loc2_.catArray);
         this.popupControl.refreshDrinksTab();
      }
      
      private function handleConnectionLost(param1:Object) : void {
         this.notifyJS(new JSEvent(JSEvent.SF_DISCONNECTED));
         if((this.pgData.bUserDisconnect) || (this.pgData.joiningContact) || (this.pgData.bVipNav) || (this.pgData.joiningAnyTable))
         {
            if(this.pgData.dispMode == "shootout" || this.pgData.dispMode == "premium")
            {
               this.pgData.bVipNav = false;
            }
            if((this.pgData.bUserDisconnect) && !this.pgData.joiningContact)
            {
               this.navControl.hideSideNav();
               this.lobbyControl.showServerSelection();
            }
            else
            {
               this.reconnectToServer();
            }
         }
         else
         {
            this.handleDisconnectPopup();
            dispatchEvent(new MGEvent(MGEvent.MG_DESTROY_GAME_BY_TYPE,{"type":MinigameUtils.HIGHLOW}));
         }
      }
      
      private function handleDisconnect(param1:SmartfoxEvent) : void {
         this.handleDisconnectPopup();
      }
      
      private function handleDisconnectPopup() : void {
         this.pgData.isJoinFriend = false;
         this.pgData.isJoinFriendSit = false;
         if(this._configModel.getIntForFeatureConfig("zoom","connectToZoom",1) == 1)
         {
            if(this.zoomControl)
            {
               this.zoomControl.disconnect();
            }
         }
         var _loc1_:String = this.loadBalancer.getServerType(this.pgData.serverId);
         var _loc2_:String = this.pgData.inLobbyRoom?"Lobby":"Table";
         ZTrack.logCount(ZTrack.THROTTLE_ALWAYS,"PokerDisconnectPopup",_loc1_,this.pgData.serverId,_loc2_,"","",1);
         this.pgData.disconnectionPopupShown = true;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onDisconnectionPopupImpression:2012-03-26","",1,""));
         dispatchEvent(new ErrorPopupEvent("onDisconnection",LocaleManager.localize("flash.message.onDisconnection.title"),LocaleManager.localize("flash.message.onDisconnection.message")));
      }
      
      private function initUserPresence() : void {
         var _loc1_:Object = new Object();
         _loc1_.uid = this.viewer.zid;
         var _loc2_:Array = this.pgData.name.split(" ");
         _loc1_.first = _loc2_[0];
         _loc1_.last = _loc2_[1];
         _loc1_.sig = this._configModel.getStringForFeatureConfig("user","pw","");
         var _loc3_:String = this._configModel.getStringForFeatureConfig("core","presence_url");
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:LoadUrlVars = new LoadUrlVars();
         _loc4_.loadURL(_loc3_ + "login_user.php",_loc1_,"POST");
         if(this.timerUserPresence == null)
         {
            this.timerUserPresence = new Timer(this.USER_PRESENCE_TIMER_DELAY * 1000);
            this.timerUserPresence.addEventListener(TimerEvent.TIMER,this.onUpdateUserPresence);
            this.timerUserPresence.start();
         }
      }
      
      private function onUpdateUserPresence(param1:TimerEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:LoadUrlVars = null;
         if(this.pcmConnect.isConnected)
         {
            _loc2_ = new Object();
            _loc2_.uid = this.viewer.zid;
            _loc2_.server = this.pgData.serverId;
            _loc2_.room = this.pgData.inLobbyRoom?-1:this.pgData.gameRoomId;
            _loc2_.client_id = 1;
            _loc3_ = this._configModel.getStringForFeatureConfig("core","presence_url");
            if(!_loc3_)
            {
               return;
            }
            _loc4_ = new LoadUrlVars();
            _loc4_.loadURL(_loc3_ + "update_user.php",_loc2_,"POST");
         }
      }
      
      private function onPokerSoundEvent(param1:PokerSoundEvent) : void {
         this.pokerSoundManager.handlePokerSoundEvent(param1);
      }
      
      private function onOutOfChips(param1:Object) : void {
         var _loc2_:ROutOfChips = ROutOfChips(param1);
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),LocaleManager.localize("flash.message.outOfChipsMessage")));
      }
      
      private function onShowMessage(param1:Object) : void {
         var _loc2_:RShowMessage = RShowMessage(param1);
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),_loc2_.message));
      }
      
      private function onAdminMessage(param1:Object) : void {
         var _loc2_:RAdminMessage = RAdminMessage(param1);
         var _loc3_:* = "";
         var _loc4_:Object = {"name":
            {
               "type":"tn",
               "name":"",
               "gender":this.pgData.gender
            }};
         switch(_loc2_.message)
         {
            case "You\'re sending too many chat messages and will be kicked out if you continue.":
               _loc3_ = LocaleManager.localize("flash.message.warning.tooManyMessages",_loc4_);
               break;
            case "You are being kicked from the room for sending too many chat messages.":
               _loc3_ = LocaleManager.localize("flash.message.kickMessage.tooManyMessages",_loc4_);
               break;
            case "Stop Flooding! You have been banned for one hour.":
               _loc3_ = LocaleManager.localize("flash.message.banMessage.tooManyMessages",_loc4_);
               break;
            case "No swearing!":
               _loc3_ = LocaleManager.localize("flash.message.warning.noSwearing");
               break;
            case "You\'ve been warned! No swearing! Now you\'re kicked!":
               _loc3_ = LocaleManager.localize("flash.message.kickMessage.noSwearing",_loc4_);
               break;
            case "Stop swearing! You\'re being banned!":
               _loc3_ = LocaleManager.localize("flash.message.banMessage.noSwearing",_loc4_);
               break;
            case "You have been banned!":
               _loc3_ = LocaleManager.localize("flash.message.banMessage.youHaveBeenBanned",_loc4_);
               break;
            case "This server will reboot in 30 minutes. Please finish your current game, then select another casino from the lobby.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.30");
               break;
            case "This server will reboot in 20 minutes. Please finish your current game, then select another casino from the lobby.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.20");
               break;
            case "This server will reboot in 10 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.10");
               break;
            case "Server will reboot in 5 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.5");
               break;
            case "Server will reboot in 3 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.3");
               break;
            case "Server will reboot in 2 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.2");
               break;
            case "Server will reboot in 1 minute. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.1");
               break;
            case "Server is rebooting now... Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.rebootWarnMsg.0");
               break;
            case "This server will shutdown in 60 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.60");
               break;
            case "This server will shutdown in 30 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.30");
               break;
            case "This server will shutdown in 10 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.10");
               break;
            case "Server will shutdown in 5 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.5");
               break;
            case "Server will shutdown in 3 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.3");
               break;
            case "Server will shutdown in 2 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.2");
               break;
            case "Server will shutdown in 1 minutes. Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.1");
               break;
            case "Server is shutting down now... Please go to the lobby and select another casino.":
               _loc3_ = LocaleManager.localize("flash.message.shutdownWarnMsg.0");
               break;
            default:
               _loc3_ = encodeURIComponent(_loc2_.message);
         }
         
         if(_loc3_ != "Admin Action Taken")
         {
            dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),_loc3_));
         }
         else
         {
            this.pgData.hasReceivedBanSignal = true;
         }
      }
      
      private function onLogKO(param1:Object) : void {
         var _loc2_:RLogKO = RLogKO(param1);
         if(!_loc2_.success)
         {
            if(_loc2_.cancelable)
            {
               dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.onLogKO.title"),_loc2_.message));
            }
            else
            {
               this.pgData.loginErrorPopupShown = true;
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onErrorPopupImpression:2012-03-26","",1,""));
               dispatchEvent(new ErrorPopupEvent("onLoginError",LocaleManager.localize("flash.message.onLogKO.title"),LocaleManager.localize("flash.message.onLogKO.defaultMessage")));
            }
         }
      }
      
      public function showFriendSelector() : void {
         if(this.pgData.inLobbyRoom)
         {
            this.commonControl.showFriendSelector();
         }
      }
      
      public function hideFriendSelector() : void {
         this.commonControl.hideFriendSelector();
      }
      
      public function unhideLeaderboard() : void {
         if(this._leaderboard == null)
         {
            return;
         }
         if(this.pgData.inLobbyRoom)
         {
            this._leaderboard.visible = true;
         }
      }
      
      public function hideLeaderboard() : void {
         if(this._leaderboard == null)
         {
            return;
         }
         this._leaderboard.visible = false;
      }
      
      public function getMoreChips() : void {
         var _loc1_:SAddPoints = new SAddPoints("SAddPoints");
         this.pcmConnect.sendMessage(_loc1_);
      }
      
      public function updateLobbyTabs(param1:String) : void {
         this.pgData.server_type = param1;
         switch(param1)
         {
            case "sitngo":
               this.pgData.dispMode = "tournament";
               this.lobbyControl.plModel.sLobbyMode = "tournament";
               break;
            case "shootout":
            case "shootout1":
            case "shootout2":
            case "shootout3":
               this.pgData.dispMode = "shootout";
               this.lobbyControl.plModel.sLobbyMode = "shootout";
               break;
            case "premium_so":
               this.pgData.dispMode = "premium";
               this.lobbyControl.plModel.sLobbyMode = "premium";
               break;
            case "normal":
               if(!(this.pgData.dispMode == "private") && !(this.pgData.dispMode == "mtt") && !(this.pgData.dispMode == "zpwc"))
               {
                  this.pgData.dispMode = "challenge";
                  this.lobbyControl.plModel.sLobbyMode = "challenge";
               }
               break;
         }
         
      }
      
      public function onShoutResponse(param1:String) : void {
         var _loc2_:SAlertPublished = new SAlertPublished(param1);
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      private function showShootoutTab() : void {
         if(this.pgData.inLobbyRoom)
         {
            this.lobbyControl.gotoShootout();
         }
         else
         {
            if(this.pgData.dispMode != "shootout")
            {
               this.pgData.dispMode = "shootout";
               this.tableControl.goToLobby();
            }
         }
      }
      
      public function gotoSitnGo() : void {
         if(this.pgData.inLobbyRoom)
         {
            this.lobbyControl.gotoSitnGo();
         }
      }
      
      public function onInitZoom() : void {
         if(this._configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         var _loc1_:Array = this.pgData.name.split(" ");
         var _loc2_:* = "";
         var _loc3_:* = "";
         var _loc4_:* = "Lobby";
         if(!(_loc1_[0] == null) && !(_loc1_[0] == undefined))
         {
            _loc2_ = _loc1_[0];
         }
         if(!(_loc1_[1] == null) && !(_loc1_[1] == undefined))
         {
            _loc3_ = _loc1_[1];
         }
         if(this.pgData.rejoinRoom != -1)
         {
            _loc4_ = "Playing";
         }
         var _loc5_:UserPresence = new UserPresence(this.viewer.zid,1,Number(this.pgData.serverId),this.pgData.rejoinRoom,_loc4_,_loc2_,_loc3_,"n/a",this._configModel.getStringForFeatureConfig("user","pic_url"),this.zoomGetFriendsList(),this.pgData.gameRoomStakes,this.pgData.points,this.pgData.xpLevel);
         var _loc6_:Object = this._configModel.getFeatureConfig("zoom");
         if(this.zoomControl == null)
         {
            this._zoomModel = new ZshimModel();
            if(_loc6_)
            {
               this._zoomControl = ZshimController.getInstance(_loc6_.zoomHost,_loc6_.zoomPort,_loc6_.zpw,_loc5_);
            }
            this.onInitZoomListeners();
         }
         else
         {
            if(!this._mttServerSwapping)
            {
               this.zoomControl.updateGameInfo(Number(this.pgData.serverId),this.pgData.rejoinRoom,_loc4_,this.pgData.gameRoomStakes,this.pgData.points,this.pgData.xpLevel);
            }
         }
         if(_loc6_)
         {
            PokerStatsManager.getInstance().initZoomStats(this.zoomControl,this.ZOOM_THROTTLE,this.pgData.zid);
         }
         else
         {
            PokerStatsManager.getInstance().initZoomStats(this.zoomControl,0,this.pgData.zid);
         }
      }
      
      public function zoomUpdateStakes(param1:String) : void {
         this.pgData.gameRoomStakes = param1;
         if(this.zoomControl != null)
         {
            this.zoomControl.updateGameInfo(Number(this.pgData.serverId),this.pgData.gameRoomId,"n/a",this.pgData.gameRoomStakes,this.pgData.points,this.pgData.xpLevel);
         }
         else
         {
            this.zoomControl.updateGameInfo(Number(this.pgData.serverId),this.pgData.rejoinRoom,"n/a",this.pgData.gameRoomStakes,this.pgData.points,this.pgData.xpLevel);
         }
      }
      
      private function onInitZoomListeners() : void {
         if(this._configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         this.notifControl = this._registry.getObject(INotifController);
         this.notifControl.init(null);
         if(!this._configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
         {
            this.notifControl.notifHandler = this._registry.getObject(CommonUIController);
         }
         this.zoomControl.addEventListener(ZshimController.ZOOM_UPDATE,this.onZoomUpdate);
         this.zoomControl.addEventListener(ZshimController.ZOOM_ADD_FRIEND,this.onZoomAddFriend);
         this.zoomControl.addEventListener(ZshimController.ZOOM_REMOVE_FRIEND,this.onZoomRemoveFriend);
         this.zoomControl.addEventListener(ZshimController.ZOOM_SOCKET_CLOSE,this.onZoomSocketClose);
         this.zoomControl.addEventListener(ZshimController.ZOOM_SHOUT,this.onZoomShout,false,0,true);
         this.zoomControl.addEventListener(ZshimController.ZOOM_LEADERBOARD_UPDATE,this.onLeaderboardGetUpdate);
         this.zoomControl.addEventListener(ZshimController.ZOOM_SCORECARD_UPDATE,this.onScoreCardGetUpdate);
         this.zoomControl.addEventListener(ZshimController.ZOOM_PLAYERSCLUB_VIPUPDATE,this.onPlayersClubToasterUpdate);
         this.zoomControl.addEventListener(ZshimController.ZOOM_PLAYERSCLUB_BIGHANDREWARD,this.onPlayersClubBigHandReward);
         this.zoomControl.addEventListener(ZshimController.ZOOM_PLAYERSCLUB_POSTPURCHASEREWARD,this.onPlayersClubPostPurchaseReward);
         this.zoomControl.addEventListener(ZshimController.ZOOM_INITIATE_MINIGAMES,this.onInitiateMinigames);
         this.zoomControl.addEventListener(ZshimController.ZOOM_XPBOOST_WITH_PURCHASE,this.dispatchXPBarUpdateEvent,false,0,true);
         this.zoomControl.addEventListener(ZshimController.ZOOM_FORCE_CHIP_UPDATE,this.onZoomForceChipUpdate);
      }
      
      private function onZoomForceChipUpdate(param1:ZshimEvent) : void {
         var _loc2_:Object = null;
         if(param1.msg != null)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode(String(param1.msg));
            this.forceChipUpdate(_loc2_.chips);
         }
      }
      
      private function dispatchXPBarUpdateEvent(param1:ZshimEvent) : void {
         var _loc2_:Object = null;
         if(param1.msg != null)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode(String(param1.msg));
            this._commandDispatcher.dispatchCommand(new UpdateXPBoostToasterCommand(_loc2_));
         }
      }
      
      private function onZoomShout(param1:ZshimEvent) : void {
         this.displayShout(String(param1.msg));
         var _loc2_:Object = param1.msg;
      }
      
      private function onZoomUpdate(param1:ZshimEvent) : void {
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if(_loc2_ != null)
         {
            _loc2_.sRoomDesc = this.getNetworkUserStatus(_loc2_.nServerId,this.loadBalancer.getServerType(String(_loc2_.nServerId)),_loc2_.nRoomId);
            this.zoomModel.updatePlayer(_loc2_,"friends");
            this.zoomModel.updatePlayer(_loc2_,"network");
         }
      }
      
      private function onZoomAddFriend(param1:ZshimEvent) : void {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if((_loc2_) && !(_loc2_.sZid == this.pgData.zid))
         {
            _loc3_ = this.loadBalancer.getServerType(String(_loc2_.nServerId));
            if(!(_loc3_ == "tourney") && _loc3_.length > 0)
            {
               _loc2_.sRoomDesc = this.getNetworkUserStatus(_loc2_.nServerId,_loc3_,_loc2_.nRoomId);
            }
            this.zoomModel.addPlayer(_loc2_,"friends");
            _loc4_ = this._configModel.getFeatureConfig("zoom");
            if(_loc4_)
            {
               _loc4_.nZoomFriends++;
            }
         }
      }
      
      private function onZoomRemoveFriend(param1:ZshimEvent) : void {
         var _loc3_:Object = null;
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if((_loc2_) && !(_loc2_.sZid == this.pgData.zid))
         {
            this.zoomModel.deletePlayer(_loc2_,"friends");
            _loc3_ = this._configModel.getFeatureConfig("zoom");
            if(_loc3_)
            {
               _loc3_.nZoomFriends--;
            }
         }
      }
      
      private function onLeaderboardGetUpdate(param1:ZshimEvent) : void {
         this._externalInterface.call("zc.feature.leaderboard.retrieveLeaderboardData");
      }
      
      private function onScoreCardGetUpdate(param1:ZshimEvent) : void {
         if(this._configModel.isFeatureEnabled("scoreCard"))
         {
            this._externalInterface.call("zc.feature.scoreCard.retrieveScoreCardData");
         }
      }
      
      private function onPlayersClubToasterUpdate(param1:ZshimEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(param1.msg != null)
         {
            _loc2_ = this._configModel.getFeatureConfig("playersClub");
            if(_loc2_)
            {
               _loc3_ = com.adobe.serialization.json.JSON.decode(String(param1.msg));
               if(_loc2_.club != _loc3_.club)
               {
                  _loc3_.tier = _loc3_.club;
                  _loc3_.name = PokerGlobalData.instance.name;
                  _loc3_.texttype = "level" + _loc3_.club;
                  dispatchEvent(new PopupEvent("showPlayersClubEnvelope",false,_loc3_));
               }
               else
               {
                  if(this.navControl.canShowPlayersClubToaster())
                  {
                     if((this.tableControl) && (this.tableControl.ptModel) && (this.tableControl.ptModel.room))
                     {
                        _loc3_.stake = this.tableControl.ptModel.room.bigBlind;
                        _loc3_.increment = _loc3_.progress - _loc2_.progress;
                        this.navControl.showPlayersClubToaster(_loc3_);
                        this.navControl.startPlayersClubCoolDown();
                     }
                  }
               }
               _loc2_.progress = _loc3_.progress;
               _loc2_.club = _loc3_.club;
            }
         }
      }
      
      private function onPlayersClubPostPurchaseReward(param1:ZshimEvent) : void {
         var _loc2_:Object = null;
         if(param1.msg != null)
         {
            this.navControl.onHidePlayersClubToaster();
            _loc2_ = com.adobe.serialization.json.JSON.decode(String(param1.msg));
            _loc2_.name = PokerGlobalData.instance.name;
            _loc2_.texttype = "postbuy";
            dispatchEvent(new PopupEvent("showPlayersClubEnvelope",false,_loc2_));
         }
      }
      
      private function onPlayersClubBigHandReward(param1:ZshimEvent) : void {
         var _loc2_:Object = null;
         if(param1.msg != null)
         {
            this.navControl.onHidePlayersClubToaster();
            _loc2_ = com.adobe.serialization.json.JSON.decode(String(param1.msg));
            _loc2_.name = PokerGlobalData.instance.name;
            _loc2_.texttype = "bighand";
            dispatchEvent(new PopupEvent("showPlayersClubEnvelope",false,_loc2_));
         }
      }
      
      private function onInitiateMinigames(param1:ZshimEvent) : void {
         this._externalInterface.call("ZY.App.miniGames.processPostPurchaseMinigames");
      }
      
      private function onHideFullScreenMode(param1:Event=null) : void {
         PokerStageManager.hideFullScreenMode();
      }
      
      private function onZoomTableInvitation(param1:ZshimEvent) : void {
         var _loc2_:ZoomTableInvitationMessage = param1.msg as ZoomTableInvitationMessage;
         if(_loc2_ != null)
         {
            this.commonControl.showInviteNotif(_loc2_.fromUserId);
         }
      }
      
      private function onZoomToolbarJoin(param1:ZshimEvent) : void {
         this.zoomControl.sendGameSwfLoadedResponse();
         var _loc2_:String = param1.msg.uid;
         this.joinUser(_loc2_);
      }
      
      public function joinUser(param1:String) : void {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         if(param1)
         {
            _loc2_ = this.commonControl.uiModel.getOnlineUser(param1);
            if((_loc2_) && _loc2_.room_id > -1)
            {
               if(!(_loc2_.server_id == null) && !(_loc2_.server_id == "null"))
               {
                  _loc3_ = this.loadBalancer.getServerType(_loc2_.server_id);
                  if(_loc3_.split("shootout")[0] == "")
                  {
                     this.commonControl.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
                     return;
                  }
                  if(!this.pgData.inLobbyRoom)
                  {
                     this.tableJoin(_loc2_);
                  }
                  else
                  {
                     this.pgData.newServerId = _loc2_.server_id;
                     this.pgData.nNewRoomId = _loc2_.room_id;
                     this.pgData.joiningContact = true;
                     this.pgData.joiningShootout = _loc3_.split("shootout")[0] == ""?true:false;
                     this.pcmConnect.disconnect();
                  }
               }
               else
               {
                  this.commonControl.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
               }
            }
            else
            {
               this.commonControl.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
            }
         }
      }
      
      public function glowZLiveButton() : void {
         this.tableControl.glowButton();
      }
      
      public function updatezLiveButtonText(param1:Number) : void {
         this.tableControl.updatezLiveButtonText(param1);
      }
      
      private function onZoomSocketClose(param1:ZshimEvent) : void {
         this.zoomModel.clearPlayer("friends");
         this.zoomModel.clearPlayer("network");
      }
      
      private function zoomGetFriendsList() : String {
         if(this.pgData.aFriendZids == null || (this.pgData.disableLiveJoin))
         {
            return "";
         }
         if(this.pgData.aFriendZids.length <= this.ZOOM_FRIENDS_LIMIT)
         {
            return this.pgData.aFriendZids.toString();
         }
         return this.pgData.aFriendZids.slice(0,this.ZOOM_FRIENDS_LIMIT).toString();
      }
      
      private function zoomUpdateUser() : void {
         if(this._configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         if(this.pgData.rejoinRoom != -1)
         {
            return;
         }
         var _loc1_:Number = -1;
         if(!this.pgData.inLobbyRoom)
         {
            _loc1_ = this.pgData.gameRoomId;
         }
         else
         {
            this.zoomControl.updateGameInfo(Number(this.pgData.serverId),_loc1_,"n/a",this.pgData.gameRoomStakes,this.pgData.points,this.pgData.xpLevel);
         }
      }
      
      public function getNetworkUserStatus(param1:Number, param2:String, param3:Number) : String {
         var _loc4_:* = "";
         if(param2 == "normal" || param2 == "sitngo" || param2 == "shootout")
         {
            _loc4_ = this.getUserStatus(param1,param3);
         }
         else
         {
            if(param2.indexOf("special") == 0)
            {
               if(param2 == "special43")
               {
                  _loc4_ = "Mafia Casino";
               }
               else
               {
                  _loc4_ = this.getUserStatus(param1,param3);
               }
            }
         }
         if(_loc4_ == "Playing")
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("onlinefriendsplaying",0,0,0,PokerStatHit.TRACKHIT_ONCE,"online friends playing","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Lobby%20Other%20FriendsOnline%20o%3ALiveJoin%3A2009-04-17&ltsig=c40bb98d613415b425e427cc4e09eb44",1));
         }
         return _loc4_;
      }
      
      public function getUserStatus(param1:Number, param2:Number) : String {
         var _loc3_:* = "";
         if(param2 == -1)
         {
            _loc3_ = "Lobby - Can\'t Join";
            if(String(param1) == this.pgData.serverId)
            {
            }
         }
         else
         {
            if(this.pgData.gameRoomId == param2 && this.pgData.serverId == String(param1))
            {
               if(this.pgData.inLobbyRoom)
               {
                  _loc3_ = "Playing";
               }
               else
               {
                  _loc3_ = "At This Table";
               }
            }
            else
            {
               _loc3_ = "Playing";
            }
         }
         return _loc3_;
      }
      
      private function onShootoutConfig(param1:Object) : void {
         var _loc2_:RShootoutConfig = RShootoutConfig(param1);
         if(_loc2_.shootoutObj != null)
         {
            this.soConfig.updateConfig(Number(_loc2_.shootoutObj["id"]),Number(_loc2_.shootoutObj["idVersion"]),String(_loc2_.shootoutObj["last_modified"]),Number(_loc2_.shootoutObj["buyin"]),Number(_loc2_.shootoutObj["rounds"]),Number(_loc2_.shootoutObj["players"]),_loc2_.shootoutObj["winner_count"],_loc2_.shootoutObj["payouts"],this.pgData.skipShootoutRound1Price,this.pgData.skipShootoutRound2Price);
         }
         if(_loc2_.userObj != null)
         {
            this.pgData.soUser.updateUser(Boolean(Number(_loc2_.userObj["playing"]) == 0),String(_loc2_.userObj["last_played"]),Number(_loc2_.userObj["round"]),Number(_loc2_.userObj["won_count"]),Number(_loc2_.userObj["shootout_id"]),Number(_loc2_.userObj["buyin"]),String(_loc2_.userObj["skipped_rounds"]));
         }
         else
         {
            this.pgData.soUser.updateUser(false,"",1,0,0,0,"");
         }
         this.lobbyControl.updateShootoutConfig(this.soConfig,this.pgData.soUser);
      }
      
      private function onUserShootoutState(param1:Object) : void {
         var _loc4_:JoinRoomTransition = null;
         var _loc2_:RUserShootoutState = RUserShootoutState(param1);
         if(_loc2_.userObj != null)
         {
            this.pgData.soUser.updateUser(Boolean(Number(_loc2_.userObj["playing"]) == 0),String(_loc2_.userObj["last_played"]),Number(_loc2_.userObj["round"]),Number(_loc2_.userObj["won_count"]),Number(_loc2_.userObj["shootout_id"]),Number(_loc2_.userObj["buyin"]),String(_loc2_.userObj["skipped_rounds"]));
         }
         else
         {
            this.pgData.soUser.updateUser(false,"",1,0,0,0,"");
         }
         if(this.pgData.bDidPurchaseShootoutSkip)
         {
            if(this.pgData.soUser.sSkippedRounds == "1")
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Shootout Other Click o:PurchasedShootoutRoundSkipTo2:2010-01-06",null,1,""));
            }
            else
            {
               if(this.pgData.soUser.sSkippedRounds == "1,2" || this.pgData.soUser.sSkippedRounds == "2")
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Shootout Other Click o:PurchasedShootoutRoundSkipTo3:2010-01-06",null,1,""));
               }
            }
         }
         var _loc3_:String = this.loadBalancer.getServerType(this.pgData.serverId);
         if(!this.pgData.isShootoutWasWeekly && _loc3_ == "shootout1" && this.pgData.soUser.nRound == 1 || !(this.pgData.rollingRebootOverride == null))
         {
            if(this.pgData.joinShootoutLobby)
            {
               this.pgData.joinShootoutLobby = false;
               dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL,LocaleManager.localize("flash.message.interstitial.joiningLobby"),""));
               _loc4_ = new JoinRoomTransition(this.pgData.lobbyRoomId);
               _loc4_.join(this.pcmConnect);
            }
         }
         else
         {
            this.pgData.isShootoutWasWeekly = false;
            this.pgData.bVipNav = true;
            if(this.pgData.joinShootoutLobby)
            {
               this.pgData.joinShootoutLobby = false;
               _loc4_ = new JoinRoomTransition(this.pgData.lobbyRoomId);
               _loc4_.join(this.pcmConnect);
            }
            this.pcmConnect.disconnect();
         }
         if(this.pgData.rollingRebootOverride != null)
         {
            this.mttConnectToServer(this.pgData.rollingRebootOverride.serverIp,this.pgData.rollingRebootOverride.serverType,this.pgData.rollingRebootOverride.serverName,String(this.pgData.rollingRebootOverride.serverId));
            if(this.pgData.rollingRebootOverride.roomId > 1)
            {
               this.pcmConnect.rollingRebootStoredInfo = this.pgData.rollingRebootOverride;
            }
            this.pgData.rollingRebootOverride = null;
         }
      }
      
      private function onPremiumShootoutConfig(param1:Object) : void {
         var _loc2_:RPremiumShootoutConfig = RPremiumShootoutConfig(param1);
         this.lobbyControl.dispPremShootoutLob(_loc2_);
      }
      
      public function getPremiumShootoutConfig() : void {
         var _loc1_:Object = this.lobbyControl.getPremiumShootoutConfig(this.tableControl.ptModel.room.entryFee);
         if(_loc1_)
         {
            this.soConfig.updateConfig(Number(_loc1_["id"]),Number(_loc1_["idVersion"]),String(_loc1_["last_modified"]),Number(_loc1_["buyin"]),Number(_loc1_["rounds"]),Number(_loc1_["players"]),_loc1_["winner_count"],_loc1_["payouts"],this.pgData.skipShootoutRound1Price,this.pgData.skipShootoutRound2Price);
            this.pgData.soPremiumId = Number(_loc1_["id"]);
         }
         this.pgData.soUser.nRound = 1;
      }
      
      private function onGetUserInfo(param1:Object) : void {
         var _loc4_:* = 0;
         var _loc2_:RGetUserInfo = RGetUserInfo(param1);
         if(!isNaN(_loc2_.casinoGold))
         {
            this.pgData.casinoGold = _loc2_.casinoGold;
         }
         if(!isNaN(_loc2_.rakeEnabled))
         {
            this.pgData.rakeEnabled = _loc2_.rakeEnabled;
         }
         if(!isNaN(_loc2_.rakeBlindMultiplier))
         {
            this.pgData.rakeBlindMultiplier = _loc2_.rakeBlindMultiplier;
         }
         if(!isNaN(_loc2_.rakePercentage))
         {
            this.pgData.rakePercentage = 100 * _loc2_.rakePercentage;
         }
         var _loc3_:Array = this.lobbyControl.plModel.smallBlindLevels;
         if(((this._leaderboard) || (this._popupLeaderboard)) && _loc3_.length > 1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].maxBuyIn <= this.pgData.maxBuyinPercentOfChipstack * this.pgData.points)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc4_ >= _loc3_.length)
            {
               _loc4_ = _loc3_.length-1;
            }
            if(this._leaderboard)
            {
               this._leaderboard.setPlayNowPrefs(_loc3_[_loc4_].smallBlind,this.pgData.userPreferencesContainer.tableTypeValue,_loc3_[_loc4_].desc);
            }
            if(this._popupLeaderboard)
            {
               this._popupLeaderboard.setPlayNowPrefs(_loc3_[_loc4_].smallBlind,this.pgData.userPreferencesContainer.tableTypeValue,_loc3_[_loc4_].desc);
            }
         }
      }
      
      private function onRakeAmount(param1:Object) : void {
         var _loc2_:RRakeAmount = RRakeAmount(param1);
         this.tableControl.onRakeAmount(_loc2_.params);
      }
      
      private function onRakeDisabled(param1:Object) : void {
         var _loc2_:Object = this._configModel.getFeatureConfig("hsm");
         if((_loc2_) && (_loc2_.fg_shsm) && (_loc2_.fg_shsm.on))
         {
            return;
         }
         var _loc3_:RRakeDisabled = RRakeDisabled(param1);
         this.tableControl.onRakeDisabled(_loc3_.params.nextHand?true:false);
      }
      
      private function onRakeEnabled(param1:Object) : void {
         var _loc2_:RRakeEnabled = RRakeEnabled(param1);
         this.tableControl.onRakeEnabled(_loc2_.params.nextHand?true:false);
      }
      
      private function onRakeInsufficientFunds(param1:Object) : void {
         var _loc2_:RRakeInsufficientFunds = RRakeInsufficientFunds(param1);
         this.tableControl.onRakeInsufficientFunds(_loc2_);
      }
      
      private function checkFlashVersionGood() : void {
         var _loc7_:* = false;
         var _loc8_:* = undefined;
         var _loc9_:* = false;
         var _loc10_:* = undefined;
         var _loc1_:String = Capabilities.version.toString();
         _loc1_ = _loc1_.substr(4,_loc1_.length - 4);
         var _loc2_:Array = _loc1_.split(",");
         var _loc3_:String = this._configModel.getStringForFeatureConfig("user","browserName","").toLowerCase();
         var _loc4_:int = int(_loc2_[0]);
         var _loc5_:Array = [10,0,22,87];
         var _loc6_:Array = [9,0,159,0];
         if(_loc3_ == "msie")
         {
            if(_loc4_ == 9)
            {
               _loc7_ = true;
               for (_loc8_ in _loc2_)
               {
                  if(int(_loc2_[_loc8_]) < _loc6_[_loc8_])
                  {
                     _loc7_ = false;
                     break;
                  }
               }
               if(_loc7_)
               {
                  this.pgData.flashVersionGood = true;
               }
            }
            if(_loc4_ == 10)
            {
               _loc9_ = true;
               for (_loc10_ in _loc2_)
               {
                  if(int(_loc2_[_loc10_]) < _loc5_[_loc10_])
                  {
                     _loc9_ = false;
                     break;
                  }
               }
               if(_loc9_)
               {
                  this.pgData.flashVersionGood = true;
               }
            }
         }
      }
      
      private function onZLivePopupJoin(param1:JoinUserEvent) : void {
         this.commonControl.forceExternalZLiveJoin(param1);
      }
      
      private function onRatholingUserState(param1:Object) : void {
         var _loc2_:RRatholingUserState = RRatholingUserState(param1);
         var _loc3_:Date = new Date();
         if(!this.pgData.ratholingInfoObj)
         {
            this.pgData.ratholingInfoObj = new Object();
         }
         this.pgData.ratholingInfoObj["expireSecs"] = _loc2_.expireSecs;
         this.pgData.ratholingInfoObj["timestamp"] = _loc3_.time;
         this.pgData.ratholingInfoObj["minBuyin"] = _loc2_.minBuyin;
         this.pgData.ratholingInfoObj["roomId"] = _loc2_.roomId;
         this.pgData.ratholingInfoObj["serverId"] = this.pgData.serverId;
      }
      
      public function enableHandStrengthMeter(param1:String="popup", param2:String="phpcallback") : void {
         this.tableControl.onRakeEnabled();
         this.tableControl.hideAds();
      }
      
      public function showChipsPanel(param1:String="phpcallback") : void {
         this._commandDispatcher.dispatchCommand(new ShowBuyPageCommand("popup",param1,"chips"));
      }
      
      public function showGetGoldPanel(param1:String="popup", param2:String="phpcallback") : void {
         this._commandDispatcher.dispatchCommand(new ShowBuyPageCommand(param1,param2));
      }
      
      public function showGiftShop() : void {
         this._commandDispatcher.dispatchCommand(new DisplayGiftShopCommand());
      }
      
      public function closeAllPopups() : void {
         this.popupControl.unlockProfile();
         this.popupControl.closeAllPopups();
      }
      
      public function refreshLobbyBackground() : void {
         var _loc1_:* = "";
         if(this._configModel.getStringForFeatureConfig("core","seasonalTheme"))
         {
            _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_SEASONAL);
         }
         else
         {
            if(!this._configModel.getBooleanForFeatureConfig("core","adjustCasinoList"))
            {
               switch(this.loadBalancer.getServerLanguage(this.pgData.serverId))
               {
                  case "cl":
                     _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_CALIFORNIA_NORTH);
                     break;
                  case "tr":
                     _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_TURKEY);
                     break;
                  case "zh":
                     _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_CHINA);
                     break;
                  case "en":
                  case "eg":
                  default:
                     _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_DEFAULT);
               }
               
            }
         }
         if(!_loc1_)
         {
            _loc1_ = ExternalAssetManager.getUrl(ExternalAsset.LOBBY_DEFAULT);
         }
         this.lobbyControl.setBackgroundUrl(_loc1_);
      }
      
      private function onUpdateTALItemCount(param1:CommandEvent) : void {
         if(param1.params)
         {
            this.updateTodoCount(param1.params);
         }
      }
      
      private function onRemoveTALItemCount(param1:CommandEvent) : void {
         if((param1.params.toRemove) && (this.tableControl.ptView))
         {
            this.tableControl.removeTodoIcon(param1.params.toRemove);
         }
      }
      
      private function updateTodoCount(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.name;
         var _loc3_:int = param1.count;
         if(_loc2_ == null || (isNaN(_loc3_)))
         {
            return;
         }
         if(_loc2_ == "getChips")
         {
            this.navControl.navView.topNav.updateGetChipsCounter(_loc3_);
            return;
         }
         var _loc4_:TodoListModel = this._registry.getObject(TodoListModel);
         _loc4_.updateIconCount(_loc2_,_loc3_);
      }
      
      private function hideTodoIcon(param1:String) : void {
         var _loc2_:TodoListModel = null;
         if(this.pgData.inLobbyRoom)
         {
            _loc2_ = this._registry.getObject(TodoListModel);
            _loc2_.deleteItem(param1);
         }
         else
         {
            this.tableControl.removeTodoIcon(param1);
         }
      }
      
      private function showTodoIcon(param1:CommandEvent) : void {
         var _loc2_:TodoListModel = null;
         if(param1.params.show)
         {
            _loc2_ = this._registry.getObject(TodoListModel);
            _loc2_.addItem(param1.params.item);
         }
         else
         {
            this.hideTodoIcon(param1.params.item);
         }
      }
      
      private function showHappyHourFlyout(param1:CommandEvent) : void {
         var _loc2_:Object = null;
         if(param1.params.type === null || param1.params.isMarketing === null)
         {
            return;
         }
         if(param1.params.type === HappyHourModel.TYPE_LUCKY_BONUS)
         {
            this.navControl.showHappyHourLuckyBonusFlyout(param1.params.isMarketing);
         }
         else
         {
            if(param1.params.type === HappyHourModel.TYPE_DOUBLE_XP)
            {
               _loc2_ = this._configModel.getFeatureConfig("happyHour");
               if(_loc2_ !== null)
               {
                  _loc2_.isHappyHourDoubleXpFlyout = true;
                  _loc2_.isHappyHourDoubleXpMarketing = param1.params.isMarketing;
               }
               this.navControl.dispatchEvent(new PopupEvent("showXPIncreaseToaster"));
               if(param1.params.isMarketing === true)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:XPHappyHourOFFToaster:2014-02-06"));
               }
               else
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:XPHappyHourONToaster:2014-02-06"));
               }
            }
         }
      }
      
      private function showHappyHourLuckyBonus(param1:CommandEvent) : void {
         var _loc2_:Object = this._configModel.getFeatureConfig("sideNav");
         var _loc3_:Object = this._configModel.getFeatureConfig("happyHour");
         if(_loc3_ !== null)
         {
            _loc3_.isHappyHourLuckyBonusSpin = param1.params.shouldShow;
         }
         if(param1.params.shouldShow === true)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:LBHappyHourSidenav:2014-02-06"));
            _loc2_.sideNavAnimationsURL[Sidenav.LUCKY_BONUS] = this.pgData.luckyBonusHappyHourAnimationURL;
            this._commandDispatcher.dispatchCommand(new UpdateNavItemCountCommand("LuckyBonus",1));
            this.pgData.luckyBonusTimeUntil = 0;
         }
         else
         {
            _loc2_.sideNavAnimationsURL[Sidenav.LUCKY_BONUS] = this.pgData.luckyBonusAnimationURL;
            if(param1.params.showRegularLB === true)
            {
               this.popupControl.closeLuckyBonus(null);
               this.popupControl.showLuckyBonus();
            }
         }
         var _loc4_:Object = {};
         _loc4_[Sidenav.LUCKY_BONUS] = _loc2_.sideNavAnimationsURL[Sidenav.LUCKY_BONUS];
         this.navControl.setNavAnimations(_loc4_);
      }
      
      public function showTutorialArrow(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number, param5:Number=5) : void {
         this.popupControl.showTutorialArrow(param1,param2,param3,param4,param5);
      }
      
      public function showTutorialArrows(param1:DisplayObjectContainer, param2:Array, param3:Number=5) : void {
         this.popupControl.showTutorialArrows(param1,param2,param3);
      }
      
      public function hideTutorialArrows() : void {
         this.popupControl.hideTutorialArrows();
      }
      
      public function setTutorialArrowsVisible(param1:Boolean) : void {
         this.popupControl.setTutorialArrowsVisible(param1);
      }
      
      public function showPlayWithYourPokerBuddies(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         this.popupControl.showPlayWithYourPokerBuddies(param1,param2,param3,param4);
      }
      
      public function hidePlayWithYourPokerBuddies() : void {
         this.popupControl.hidePlayWithYourPokerBuddies();
      }
      
      public function showInviteFriendsToPlay(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         this.popupControl.showInviteFriendsToPlay(param1,param2,param3,param4);
      }
      
      public function hideInviteFriendsToPlay() : void {
         this.popupControl.hideInviteFriendsToPlay();
      }
      
      public function updateOffTableChipDisplays(param1:Boolean=false) : void {
         this.navControl.updateChips(param1);
         this.lobbyControl.updateUserInfoChipDisplay();
         try
         {
            this.ladderBridge.send("onLadderUpdate",this.pgData.viewer.zid,this.pgData.points,this.pgData.nAchievementRank,false);
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateCasinoGoldDisplays() : void {
         this.navControl.updateCasinoGold();
         try
         {
            this.ladderBridge.send("onLadderUpdate",this.pgData.viewer.zid,this.pgData.points,this.pgData.nAchievementRank,false);
         }
         catch(e:Error)
         {
         }
      }
      
      public function onUpdateCasinoGoldDisplays(param1:CommandEvent) : void {
         this.updateCasinoGoldDisplays();
      }
      
      private function userDidProvideEMail(param1:Boolean) : void {
         this.pgData.emailSubscribed = param1;
      }
      
      private function forceChipUpdate(param1:Number) : void {
         this.updateChips(param1,true,true);
      }
      
      public function updateChips(param1:Number=0, param2:Boolean=true, param3:Boolean=false, param4:Boolean=false) : void {
         var _loc5_:* = NaN;
         if(param2)
         {
            this.pgData.points = this.pgData.points + param1;
            _loc5_ = param1;
         }
         else
         {
            _loc5_ = param1 - this.pgData.points;
            this.pgData.points = param1;
         }
         dispatchEvent(new PCEvent(PCEvent.CHIPS_UPDATED,{"delta":_loc5_}));
         if(param3)
         {
            this.updateOffTableChipDisplays(param4);
         }
         else
         {
            this.navControl.updateChips(param4);
         }
      }
      
      private function onUpdateChips(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.updateChips(_loc2_.points,_loc2_.isDelta,_loc2_.updateOffTableDisplays);
      }
      
      private function onUpdateCurrency(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.updateCurrency(_loc2_.points,_loc2_.type,_loc2_.isDelta);
      }
      
      private function forceUpdateCurrency(param1:Object) : void {
         this.updateCurrency(param1.value,param1.type,true);
      }
      
      public function updateCurrency(param1:Number, param2:String, param3:Boolean=true) : void {
         switch(param2)
         {
            case "ZPWCTicket":
               if(param3)
               {
                  this.pgData.zpwcTickets = this.pgData.zpwcTickets + param1;
               }
               else
               {
                  this.pgData.zpwcTickets = param1;
               }
               this.navControl.updateTickets();
               break;
            case "chips":
               this.updateChips(param1,param3);
               break;
         }
         
      }
      
      private function onUpdateCasinoGold(param1:CommandEvent) : void {
         var _loc2_:int = param1.params.value;
         if(param1.params.isDelta)
         {
            this.forceCasinoGoldUpdate(_loc2_);
         }
         else
         {
            this.pgData.casinoGold = _loc2_;
         }
         if(!param1.params.isDelta || (param1.params.updateDisplays))
         {
            this.updateCasinoGoldDisplays();
         }
      }
      
      private function forceCasinoGoldUpdate(param1:Number) : void {
         this.pgData.casinoGold = this.pgData.casinoGold + param1;
         this.updateCasinoGoldDisplays();
      }
      
      private function onLadderGameHighScore(param1:Object) : void {
         var msg:Object = param1;
         var tMsg:RLadderGameHighScore = RLadderGameHighScore(msg);
         try
         {
            this.ladderBridge.send("onASyncLadderUpdate",this.pgData.viewer.zid,tMsg.currentWeek,tMsg.currentScore);
         }
         catch(e:Error)
         {
         }
      }
      
      public function onLadderASyncBuddyPassed(param1:Object) : void {
         this._externalInterface.call("ZY.App.AsyncLadderGames.buddyPassed",param1.rank,param1.buddyName,param1.myProfileUrl,param1.buddyProfileUrl,param1.buddyZid,param1.potSize);
      }
      
      public function onLadderASyncHighScore(param1:Object) : void {
         this._externalInterface.call("ZY.App.AsyncLadderGames.newHighScore",param1);
      }
      
      public function handleToolbarFriendInviteFromLobby(param1:String="") : void {
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.friendSelector.popups.inviteToolbarUserFromLobbyTitle"),LocaleManager.localize("flash.friendSelector.popups.inviteToolbarUserFromLobbyBody",{"name":
            {
               "type":"tn",
               "name":"",
               "gender":param1
            }})));
      }
      
      public function setSidebarItemIsEnabled(param1:String, param2:Boolean) : void {
         this.navControl.setSidebarItemIsEnabled(param1,param2);
      }
      
      public function showLeaderboard(param1:Object=null, param2:Boolean=false, param3:Boolean=false, param4:DisplayObjectContainer=null) : void {
         var _loc5_:PopupEvent = null;
         if(param1)
         {
            this.pgData.leaderboardData = param1;
            _loc5_ = new PopupEvent("showLeaderboard",false,
               {
                  "showInPopup":param2,
                  "isUpdate":param3
               });
            _loc5_.closePHPPopups = false;
            dispatchEvent(_loc5_);
         }
         else
         {
            if(param2)
            {
               if(this._popupLeaderboard === null)
               {
                  if(param4 !== null)
                  {
                     this._popupLeaderboard = new LeaderboardController(param4,this.pgData.timeStamp,this,this.pgData);
                  }
                  else
                  {
                     this._popupLeaderboard = new LeaderboardController(this.layerManager.getLayer(PokerControllerLayers.POPUP_LAYER),this.pgData.timeStamp,this,this.pgData);
                  }
               }
               else
               {
                  if(!(param4 === null) && !(param4 == this._popupLeaderboard.displayContainer))
                  {
                     this._popupLeaderboard = new LeaderboardController(param4,this.pgData.timeStamp,this,this.pgData);
                  }
               }
               if(!param3)
               {
                  this._popupLeaderboard.visible = true;
               }
               this._popupLeaderboard.configModel = this._configModel;
               this._popupLeaderboard.externalInterface = this._externalInterface;
               this._popupLeaderboard.setPlayNowPrefs(this._leaderboard.smallBlind,this._leaderboard.tableType,this._leaderboard.stakesDesc);
               this._popupLeaderboard.showLeaderboard(this.pgData.leaderboardData,param2);
            }
            else
            {
               this._leaderboard.showLeaderboard(this.pgData.leaderboardData);
               if(!this.pgData.inLobbyRoom)
               {
                  this._leaderboard.visible = false;
               }
            }
         }
      }
      
      public function updateLeaderboardData(param1:Object=null) : void {
         this.showLeaderboard(param1);
         if(this._popupLeaderboard)
         {
            this.showLeaderboard(param1,true,true);
         }
      }
      
      public function showGameCardPopup() : void {
         PokerStageManager.hideFullScreenMode();
         if(this.pgData.sn_id == this.pgData.SN_FACEBOOK)
         {
            this._externalInterface.call("ZY.App.GameCards.open");
         }
         else
         {
            this._externalInterface.call("openPopup",-2,"popup_gamecards",null,null);
         }
      }
      
      public function showInsufficientChips() : void {
         dispatchEvent(new PopupEvent("showInsufficientChips"));
      }
      
      public function showInsufficientFunds() : void {
         dispatchEvent(new PopupEvent("showInsufficientFunds"));
      }
      
      public function checkForFlashBlockRequest(param1:String) : Boolean {
         var _loc2_:Object = null;
         if(this.flashInterruptedAction)
         {
            return false;
         }
         if(this._externalInterface.available)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode(unescape(this._externalInterface.call("ZY.App.Flash.Events.checkForFlashRegionBlock",param1)));
            if(!_loc2_)
            {
               this.flashInterruptedAction = null;
               return false;
            }
            if(_loc2_["action"] == "block")
            {
               this.flashBlockedRegion = _loc2_["region"];
               if(!this.flashBlockedTimeOut)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function updateFourColorDeck(param1:int) : void {
         this.pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.FOUR_COLOR_DECK,param1);
         this.commitUserPreferences();
         if(this.tableControl != null)
         {
            this.tableControl.setFourColorDeck(param1);
         }
      }
      
      public function leaveTableAndGoToPremiumLobby() : void {
         this.pgData.disableRTLPopup = true;
         this.tableControl.cleanupTable();
         this.tableControl.ptView.dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
         this.lobbyControl.gotoPremiumTab();
      }
      
      public function onJumpTableSearchResult(param1:Object) : void {
         var joinRoomTransition:JoinRoomTransition = null;
         var msg:Object = param1;
         var tMsg:RJumpTableSearchResult = RJumpTableSearchResult(msg);
         if(tMsg.roomItem)
         {
            this.pgData.tableIdToJumpTo = tMsg.roomItem.id;
            this.pgData.tableNameToJumpTo = tMsg.roomItem.roomName;
            if((this.tableControl) && (this.pgData.willJumpTable))
            {
               this.tableControl.performTableJump();
            }
            else
            {
               joinRoomTransition = new JoinRoomTransition(this.pgData.tableIdToJumpTo);
               joinRoomTransition.fAfterJoin = function():void
               {
                  pgData.bAutoSitMe = true;
               };
               joinRoomTransition.join(this.pcmConnect);
            }
         }
         else
         {
            if(this.tableControl)
            {
               this.tableControl.handleTableJumpError();
            }
         }
      }
      
      public function attachViewToLayer(param1:DisplayObject, param2:String, param3:Boolean=false) : void {
         this.layerManager.addChildToLayer(param2,param1,param3);
      }
      
      public function removeViewFromLayer(param1:DisplayObject, param2:String) : void {
         this.layerManager.removeChildFromLayer(param2,param1);
      }
      
      private function getLayer(param1:String) : DisplayObjectContainer {
         return this.layerManager.getLayer(param1);
      }
      
      private function showScratchersMiniGame(param1:Object) : void {
         if(param1)
         {
            this.updateScratchersMiniGame(param1);
            dispatchEvent(new PopupEvent("showScratchers"));
         }
      }
      
      private function showServeProgress(param1:Object) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1.hasOwnProperty("amt"))
         {
            _loc2_ = param1["amt"];
         }
         if(param1.hasOwnProperty("appEntry"))
         {
            _loc3_ = param1["appEntry"];
         }
         if(_loc2_)
         {
            PokerGlobalData.instance.serveProgressData.drip = _loc2_;
         }
         PokerGlobalData.instance.serveProgressData.isFirstVisit = _loc3_;
         this.navControl.navView.hideAmexServeAd();
         this.navControl.navView.showAmexServeIcon();
         dispatchEvent(new PopupEvent("showServeProgress"));
      }
      
      private function updateScratchersMiniGame(param1:Object) : void {
         if(param1)
         {
            this.popupControl.updateScratchers(param1);
         }
      }
      
      public function showTableRebalFTUE() : void {
         if(this._configModel.getBooleanForFeatureConfig("tableRebal","showFTUE"))
         {
            this.lobbyControl.showTableRebalFTUE();
         }
      }
      
      private function playersClubInit() : void {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(this._configModel.isFeatureEnabled("playersClub"))
         {
            _loc1_ = this._configModel.getFeatureConfig("playersClub");
            _loc2_ = new Object();
            _loc2_.tier = _loc1_.club;
            _loc2_.name = PokerGlobalData.instance.name;
            if(_loc1_.isFTUE)
            {
               _loc2_.texttype = "intro" + _loc2_.tier;
            }
            else
            {
               if(_loc1_.isEnteringRedTier)
               {
                  _loc2_.texttype = "level" + _loc2_.tier;
               }
               else
               {
                  if(_loc1_.sweepsWinnerInfo["show"])
                  {
                     _loc2_.winAmount = _loc1_.sweepsWinnerInfo["amt"];
                     if(_loc1_.sweepsWinnerInfo["userIsWinner"])
                     {
                        _loc2_.texttype = "weeklyWinner";
                     }
                     else
                     {
                        _loc2_.texttype = "weeklyLoser";
                        _loc2_.winnerName = _loc1_.sweepsWinnerInfo["winnerName"];
                        _loc2_.numEntries = _loc1_.sweepsWinnerInfo["numEntries"];
                     }
                  }
                  else
                  {
                     return;
                  }
               }
            }
            dispatchEvent(new PopupEvent("showPlayersClubEnvelope",false,_loc2_));
         }
      }
      
      private function showPlayersClubAppEntryReward() : void {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(!this._checkedPlayersClubAppEntryReward)
         {
            this._checkedPlayersClubAppEntryReward = true;
            if(this._configModel.isFeatureEnabled("playersClub"))
            {
               _loc1_ = this._configModel.getFeatureConfig("playersClub");
               if(_loc1_.appEntryResult != null)
               {
                  _loc2_ = com.adobe.serialization.json.JSON.decode(_loc1_.appEntryResult);
                  _loc3_ = 
                     {
                        "tier":_loc1_.club,
                        "name":PokerGlobalData.instance.name,
                        "texttype":"appentry",
                        "granted":_loc2_.granted,
                        "rewards":_loc2_.rewards
                     };
                  dispatchEvent(new PopupEvent("showPlayersClubEnvelope",false,_loc3_));
               }
            }
         }
      }
      
      public function displayMiniMFSPopUp(param1:Object) : void {
         this.mfsControl.displayMiniMFSPopUp(param1);
      }
      
      public function displayBigMFSPopUp(param1:Object) : void {
         this.mfsControl.displayBigMFSPopUp(param1);
      }
      
      public function displayPostSendPopUp(param1:Object) : void {
         this.mfsControl.displayPostSendPopUp(param1);
      }
      
      public function get zoomControl() : ZshimController {
         return this._zoomControl;
      }
      
      public function get zoomModel() : ZshimModel {
         return this._zoomModel;
      }
      
      public function get loadBalancer() : LoadBalancer {
         return this._loadBalancer;
      }
      
      public function set loadBalancer(param1:LoadBalancer) : void {
         this._loadBalancer = param1;
      }
   }
}
