package com.zynga.poker.lobby
{
   import com.zynga.poker.feature.FeatureController;
   import flash.utils.Timer;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerConnectionManager;
   import com.zynga.poker.LoadBalancer;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.protocol.RPremiumShootoutConfig;
   import com.zynga.ui.lobbyBanner.LobbyBannerController;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import com.zynga.poker.events.PCEvent;
   import com.zynga.poker.lobby.events.*;
   import com.zynga.poker.table.GiftLibrary;
   import com.zynga.poker.events.GiftLibraryEvent;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.table.TableModel;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.ui.lobbyBanner.LobbyBannerEvent;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.events.JSEvent;
   import flash.display.DisplayObject;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.minigame.events.MGEvent;
   import com.zynga.poker.minigame.minigameHelper.MinigameUtils;
   import com.zynga.poker.commands.selfcontained.PositionSideNavCommand;
   import com.zynga.poker.lobby.events.view.SortTablesEvent;
   import com.zynga.poker.events.MTTEvent;
   import com.zynga.poker.protocol.SSkipShootRound;
   import com.zynga.poker.table.constants.TableDisplayMode;
   import flash.events.Event;
   import fl.data.DataProvider;
   import com.zynga.poker.constants.TableType;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.UnlockComponentsLevel;
   import com.zynga.poker.lobby.events.view.TableSelectedEvent;
   import flash.events.TimerEvent;
   import com.zynga.poker.protocol.SGetRoomInfo2;
   import com.zynga.poker.UserPreferencesContainer;
   import com.zynga.load.LoadManager;
   import com.greensock.events.LoaderEvent;
   import com.zynga.utils.ObjectUtil;
   import com.zynga.poker.protocol.SPickRoomShootout;
   import com.zynga.poker.protocol.SGetUserShootoutState;
   import com.zynga.poker.statistic.ZTrack;
   import com.zynga.poker.lobby.events.controller.JoinTableEvent;
   import com.zynga.poker.protocol.RDisplayRoomList;
   import com.zynga.poker.protocol.SGetShootoutConfig;
   import com.zynga.poker.protocol.SGetPremiumShootoutConfig;
   import com.zynga.poker.protocol.SPickRoom;
   import com.zynga.poker.protocol.SFindRoomRequest;
   import com.zynga.poker.protocol.RRoomInfo2;
   import com.zynga.poker.LBEvent;
   import com.zynga.poker.events.MTTLoadEvent;
   import com.zynga.ui.lobbyBanner.LobbyBanner;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.events.URLEvent;
   import com.adobe.serialization.json.JSON;
   import flash.system.Security;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   import com.zynga.poker.events.ErrorPopupEvent;
   import com.zynga.poker.events.PopupEvent;
   import com.zynga.poker.commands.js.CloseAllPHPPopupsCommand;
   import com.zynga.poker.commands.navcontroller.ShowSideNavCommand;
   import com.zynga.poker.lobby.events.view.CasinoSelectedEvent;
   import com.zynga.poker.protocol.RTM;
   import com.zynga.poker.lobby.events.view.BuzzAdEvent;
   import com.zynga.poker.protocol.RPointsUpdate;
   import com.zynga.poker.commands.pokercontroller.UpdateChipsCommand;
   import com.zynga.poker.protocol.RGameAlreadyStarted;
   import com.zynga.poker.protocol.RWrongRound;
   import com.zynga.poker.protocol.RWrongBuyin;
   import com.zynga.poker.protocol.RSitNotReserved;
   import com.zynga.poker.protocol.RShootoutConfigChanged;
   import com.zynga.poker.protocol.RTourneyOver;
   import com.zynga.poker.protocol.RServerStatus;
   import com.zynga.poker.shootout.ShootoutConfig;
   import com.zynga.poker.shootout.ShootoutUser;
   import com.zynga.poker.commands.leaderboard.SurfaceLeaderboardCommand;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.poker.PokerStatsManager;
   import flash.display.Sprite;
   import com.zynga.poker.commands.navcontroller.HideSideNavCommand;
   import com.zynga.poker.commands.selfcontained.module.ShowModuleCommand;
   import com.zynga.poker.module.ModuleEvent;
   
   public class LobbyController extends FeatureController
   {
      
      public function LobbyController() {
         super();
         this.plModel = new LobbyModel();
      }
      
      public var timerLobbyIdle:Timer;
      
      public var plModel:LobbyModel;
      
      public var plView:LobbyView;
      
      private var mainDisp:MovieClip;
      
      private var pcmConnect:PokerConnectionManager;
      
      private var loadBalancer:LoadBalancer;
      
      private var pControl:PokerController;
      
      private var bViewInit:Boolean = false;
      
      private var atThisTableTimer:Timer;
      
      private var hasClickedSortDropDown:Boolean = false;
      
      private var premiumSoConfig:RPremiumShootoutConfig;
      
      private var lastTableSeen:Number;
      
      private var _userIsScrollingLobbyGrid:Boolean = false;
      
      private var _serverStatusDidUpdateWhileUserScrolledLobbyGrid:Boolean = false;
      
      private var _lobbyBannerController:LobbyBannerController;
      
      public function startLobbyController(param1:MovieClip, param2:PokerConnectionManager, param3:PokerController, param4:SFSEvent=null) : void {
         this.mainDisp = param1;
         this.pControl = param3;
         this.plModel.configModel = configModel;
         this.plModel.init();
         this.plModel.setSponsoredShootoutVars();
         this.pcmConnect = param2;
         this.pcmConnect.addEventListener("onMessage",this.onProtocolMessage);
         if(!pgData.inLobbyRoom)
         {
            this.pControl.addEventListener(PCEvent.LOBBY_JOINED,this.onLobbyJoined);
         }
         if(param4 != null)
         {
            this.pcmConnect.onExtensionHandler(param4);
         }
         if(this.plModel.shootoutConfig)
         {
            if((this.plModel.shootoutConfig.isShootoutPromo) && !(this.plModel.shootoutConfig.shootoutLobbyBadgeUrl == this.plView.shootoutBadgeUrl))
            {
               this.plView.shootoutBadgeUrl = this.plModel.shootoutConfig.shootoutLobbyBadgeUrl;
            }
            if((this.plModel.shootoutConfig.showShootoutRegisterWinnerBadge) && !(this.plModel.shootoutConfig.shootoutRegisterWinnerBadgeUrl == this.plView.shootoutBadgeUrl))
            {
               this.plView.shootoutBadgeUrl = this.plModel.shootoutConfig.shootoutRegisterWinnerBadgeUrl;
            }
         }
         if((this.plModel.lobbyConfig) && (this.plModel.lobbyConfig.goToShootouts))
         {
            this.onShootoutClicked(null);
         }
         this.plView.displayGiftChicklet(this.pgData.shownGiftID);
         GiftLibrary.GetInst().addEventListener(GiftLibraryEvent.GIFTS_LOADED,this._giftLibraryGiftLoadedHandler);
         externalInterface.addCallback("autositShootout",this.autositShootout);
         externalInterface.addCallback("buzzBoxCallback",this.buzzBoxCallback);
         externalInterface.addCallback("claimSponsoredShootoutsCallback",this.claimSponsoredShootoutsCallback);
         externalInterface.addCallback("gotoPremiumTab",this.gotoPremiumTab);
         externalInterface.addCallback("gotoShootout",this.gotoShootout);
         externalInterface.addCallback("gotoWeeklyTourney",this.gotoWeeklyTourney);
         externalInterface.addCallback("startZSCMiniGameChallenge",this.startZSCMiniGameChallenge);
         externalInterface.addCallback("onPowerTournamentEnter",this.onPowerTournamentEnter);
         externalInterface.addCallback("showPlayNowTutorialArrow",this.showPlayNowTutorialArrow);
         addEventListener(CommandEvent.TYPE_SHOW_INSUFFICIENT_FUNDS,this.onShowInsufficientFunds);
         addEventListener(CommandEvent.TYPE_OPEN_TOURNAMENTS_AT_SUBTAB,this.onShowTournamentsTab);
         addEventListener(CommandEvent.TYPE_SHOW_LOBBY_BANNER,this.onShowLobbyBanner);
      }
      
      private function onPowerTournamentEnter(param1:Object) : void {
         var _loc2_:TableModel = null;
         if(!pgData.inLobbyRoom)
         {
            _loc2_ = this.pControl.tableControl.ptModel;
            if("Challenge" == _loc2_.room.gameType)
            {
               this.pControl.tableControl.ptView.dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
            }
            else
            {
               return;
            }
         }
         this.pcmConnect.addEventListener(ProtocolEvent.onMessage,this.onPremiumShootoutConfLoad);
         this.gotoPremiumTab();
      }
      
      private function onPremiumShootoutConfLoad(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         if("RPremiumShootoutConfig" != _loc2_.type)
         {
            return;
         }
         this.pcmConnect.removeEventListener(ProtocolEvent.onMessage,this.onPremiumShootoutConfLoad);
         var _loc3_:Object = this.getPremiumShootoutConfig(25);
         if(!_loc3_)
         {
            return;
         }
         _loc3_["trackingSuf"] = "Other Click EnterTournamentButton o:MOTDHighRollerSufficientFunds:2013-02-03";
         _loc3_["trackingInsuf"] = "Other Click EnterTournamentButton o:MOTDHighRollerInsufficientFunds:2013-02-03";
         _loc3_["ref"] = "MTT_MOTD";
         var _loc4_:LVEvent = new LVEvent(LVEvent.PREMIUM_CLICK,_loc3_);
         this.onPlayPremiumShootout(_loc4_);
      }
      
      private function onShowTournamentsTab(param1:CommandEvent) : void {
         if(param1.params)
         {
            switch(param1.params.tab)
            {
               case TournamentSubTabs.SHOOTOUT:
                  this.onShootoutClicked(null);
                  break;
               case TournamentSubTabs.SITNGO:
                  this.gotoSitnGo();
                  break;
               case TournamentSubTabs.WEEKLY:
                  this.gotoWeeklyTourney();
                  break;
               case TournamentSubTabs.POWER:
               default:
                  this.gotoPremiumTab();
            }
            
         }
      }
      
      private function _giftLibraryGiftLoadedHandler(param1:GiftLibraryEvent) : void {
         this.plView.displayGiftChicklet(this.pgData.shownGiftID);
      }
      
      private function onLobbyJoined(param1:PCEvent) : void {
      }
      
      private function initLobbyModel() : void {
         this.plModel.playerName = pgData.name;
         this.plModel.playerGender = pgData.gender;
         this.plModel.playerRank = pgData.aRankNames[pgData.nAchievementRank];
         this.plModel.playersOnline = pgData.usersOnline;
         this.plModel.totalChips = pgData.points;
         this.plModel.xpLevel = pgData.xpLevel;
         this.plModel.sortByStakesLevel = pgData.sortByStakesLevel;
         if(pgData.userPreferencesContainer)
         {
            this.plModel.userPreferencesContainer = pgData.userPreferencesContainer;
         }
         if(this.plModel.sLobbyMode == null)
         {
            this.plModel.sLobbyMode = pgData.dispMode;
         }
         this.plModel.serverName = pgData.serverName;
         if(pgData.points < 40)
         {
            this.plModel.bShowGetPoints = true;
         }
         this.plModel.sn_id = pgData.sn_id;
         this.plModel.fb_sig_user = Number(pgData.uid);
         this.plModel.pic_url = configModel.getStringForFeatureConfig("user","pic_url");
         this.plModel.sZid = pgData.zid;
         this.plModel.disableShareWithFriendsCheckboxes = pgData.disableShareWithFriendsCheckboxes;
         if(this.plModel.lobbyConfig)
         {
            this.plModel.tabsGlowingTags = this.plModel.lobbyConfig.tabsGlowingTags;
         }
         this.plModel.playerSpeedTestVariant = configModel.getIntForFeatureConfig("playerSpeedTest","playerSpeedTestVariant");
         if(pgData.bUserDisconnect)
         {
            pgData.bUserDisconnect = false;
            this.plView.setLobbyButtons(true);
            this.plView.loadNewServerLobby();
            this.showPlayNowTutorialArrow();
         }
      }
      
      private function setLobbyFilters() : void {
         if((pgData.enableRoomTypeOnly) || (pgData.lobbyUncheckBoxes))
         {
            this.plView.hideEmptyTables.selected = false;
            this.plView.hideFullTables.selected = false;
         }
         else
         {
            this.plView.hideEmptyTables.selected = pgData.flashCookie?pgData.flashCookie.GetValue("bHideEmptyTables",true):true;
            this.plView.hideRunningTables.selected = pgData.flashCookie?pgData.flashCookie.GetValue("bHideRunningTables",true):true;
            this.plView.hideFullTables.selected = pgData.flashCookie?pgData.flashCookie.GetValue("bHideFullTables",true):true;
         }
      }
      
      public function initLobbyView() : void {
         var powerTourneyConfig:Object = null;
         var powerTourneyHappyHourConfig:Object = null;
         var lobbyAdsUrl:Array = null;
         var buzzBoxUrl:String = null;
         var strace:String = null;
         try
         {
            this.plView = new LobbyView();
            if(pgData.userPreferencesContainer)
            {
               this.plView.userPreferencesContainer = pgData.userPreferencesContainer;
            }
            this.plView.showZPWCLobbyArrow = pgData.showZPWCLobbyArrow;
            this.plView.disableTutorial = !configModel.isFeatureEnabled("tutorial");
            powerTourneyConfig = configModel.getFeatureConfig("powerTourney");
            this.plView.enablePremiumShootout = powerTourneyConfig.enablePremiumShootout;
            this.plView.enablePowerTourneyLobbyTab = powerTourneyConfig.enablePowerTourneyLobbyTab;
            powerTourneyHappyHourConfig = configModel.getFeatureConfig("powerTourneyHappyHour");
            if(powerTourneyHappyHourConfig != null)
            {
               this.plView.shouldShowPowerTourneyTabToaster = powerTourneyHappyHourConfig.showPowerTourneyToaster;
               this.plView.isCurrentlyHappyHour = powerTourneyHappyHourConfig.displayPowerTourneyRightNowText;
               this.plView.showHappyHourMarketting = powerTourneyHappyHourConfig.showHappyHourMarketing;
            }
            this.plView.highLowArrowEnabled = configModel.isFeatureEnabled("highLow");
            this.plView.enableMTTSurfacing = pgData.enableMTTSurface;
            lobbyAdsUrl = configModel.getArrayForFeatureConfig("lobbyAds","lobbyAdUrlsObject");
            this.plView.isLobbyRedesign = this.plModel.lobbyConfig.isNewLobby;
            this.plView.preflight();
            this.plView.initView(this.plModel,this.plModel.lobbyConfig?this.plModel.lobbyConfig.hideLobbyTabs:null,lobbyAdsUrl);
            this.plView.lobbyStats = pgData.lobbyStats;
            buzzBoxUrl = configModel.getStringForFeatureConfig("buzzBox","buzz_url");
            if((buzzBoxUrl) && !pgData.pokerGeniusSettings)
            {
               this.plView.initBuzzAd(buzzBoxUrl);
            }
            if(configModel.isFeatureEnabled("userPrefs"))
            {
               this.plView.initRoomSortDropDown();
            }
            if(configModel.isFeatureEnabled("lobbyBanner"))
            {
               this._lobbyBannerController = registry.getObject(LobbyBannerController);
               this._lobbyBannerController.init(this.plView);
               this._lobbyBannerController.addEventListener(LobbyBannerEvent.TYPE_MTT_BANNER,this.onMTTLobbyBannerAction,false,0,true);
               externalInterface.addCallback("showLobbyBanner",this.showLobbyBanner);
            }
            this.initViewListeners();
            if(pgData.flashCookie != null)
            {
               this.setLobbyFilters();
            }
            this.updatePrivateTablesTab((pgData.privateTableEnabled) || (pgData.enableZPWC) || (configModel.isFeatureEnabled("tournamentImprovements")));
            if((pgData.userPreferencesContainer) && (pgData.userPreferencesContainer.normalFilterValue == "default") && pgData.userPreferencesContainer.fastFilterValue == "default")
            {
               this.onDisplayRoomSortDropDownArrow(null,0);
            }
            this.applyUserPreferences();
            this.pControl.commonControl.expandFriendSelectorFriendsSectionToFullSize();
            dispatchEvent(new LCEvent(LCEvent.VIEW_INIT));
         }
         catch(e:Error)
         {
            externalInterface.call("ZY.App.f.phone_home","initLobbyView error: " + e.message);
            strace = e.getStackTrace();
            if(strace != null)
            {
               externalInterface.call("ZY.App.f.phone_home","initLobbyView stacktrace: " + strace);
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:Loader:InitLobbyViewError:2011-05-22",null,1));
            throw e;
         }
      }
      
      public function displayLobby() : void {
         if(pgData.inLobbyRoom)
         {
            this.showLobby();
         }
         else
         {
            this.hideLobby();
         }
      }
      
      public function applyUserPreferences() : void {
         if(pgData.userPreferencesContainer)
         {
            this.plView.applyUserPreferences();
            if(!(pgData.userPreferencesContainer.sortFilterValue == "") && !(pgData.userPreferencesContainer.sortByValue == ""))
            {
               this.plModel.sortTables(pgData.userPreferencesContainer.sortFilterValue,Boolean(int(pgData.userPreferencesContainer.sortByValue)));
            }
            pgData.userPreferencesContainer.setHasAppliedPreferences();
         }
      }
      
      public function hideLobby() : void {
         this.pControl.notifyJS(new JSEvent(JSEvent.LOBBY_HIDDEN));
         this.hideTableRebalFTUE();
         this.hideZPWCFTUE();
         this.pControl.removeViewFromLayer(this.plView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
         this.pControl.hidePlayWithYourPokerBuddies();
      }
      
      public function showLobby() : void {
         var _loc1_:* = 0;
         if(this.plView)
         {
            this.pControl.attachViewToLayer(this.plView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
            this.plView.y = 40;
            this.pControl.notifyJS(new JSEvent(JSEvent.LOBBY_VISIBLE));
            this.plView.refreshRoomFilterDropDown();
            if(pgData.userPreferencesContainer)
            {
               this.plView.applyUserPreferences();
            }
            if((this.plModel.lobbyConfig) && (this.plModel.lobbyConfig.showNewLadderArrow))
            {
               this.pControl.showTutorialArrows(this.plView as DisplayObjectContainer,[
                  {
                     "x":255,
                     "y":525,
                     "rotation":90
                  },
                  {
                     "x":465,
                     "y":525,
                     "rotation":90
                  }],5);
               this.plModel.lobbyConfig.showNewLadderArrow = false;
            }
            if(pgData.showGameCardButtonArrows)
            {
               this.pControl.showTutorialArrow(this.plView as DisplayObjectContainer,410,8,270,10);
            }
            _loc1_ = configModel.getIntForFeatureConfig("tutorial","tutorialLevel");
            if(_loc1_ > 0 && pgData.xpLevel <= _loc1_)
            {
               this.pControl.hideTutorialArrows();
            }
            this.plView.showHighLowArrow(false);
            this.setLobbyFilters();
         }
         if((pgData.freeFullScreenMode) || (pgData.rakeFullScreenMode))
         {
            PokerStageManager.hideFullScreenMode();
         }
         dispatchEvent(new MGEvent(MGEvent.MG_DESTROY_GAME_BY_TYPE,{"type":MinigameUtils.HIGHLOW}));
         dispatchCommand(new PositionSideNavCommand(PositionSideNavCommand.POSITION_LOBBY));
      }
      
      public function showPlayNowTutorialArrow() : void {
         var _loc1_:int = configModel.getIntForFeatureConfig("tutorial","tutorialLevel");
         if(_loc1_ > 0 && pgData.xpLevel <= _loc1_)
         {
            this.pControl.showTutorialArrow(this.plView as DisplayObjectContainer,290,45,180,0);
         }
      }
      
      private function getLobbyRooms() : void {
         this.pcmConnect.getLobbyRooms();
      }
      
      private function initViewListeners() : void {
         this.plView.addEventListener(LVEvent.onPointsTabClick,this.onPointsTabClick);
         this.plView.addEventListener(LVEvent.onPrivateTabClick,this.onPrivateTabClick);
         this.plView.addEventListener(LVEvent.onTourneyTabClick,this.onTourneyTabClick);
         this.plView.addEventListener(LVEvent.onPremiumTabClick,this.onPremiumTabClick);
         this.plView.addEventListener(LVEvent.PREMIUM_CLICK,this.onPlayPremiumShootout);
         if(!pgData.hideLobbyTableHover)
         {
            this.plView.addEventListener(LVEvent.TABLE_MOUSE_OVER,this.onTableMouseOver);
         }
         this.plView.addEventListener(LVEvent.TABLE_MOUSE_OUT,this.onTableMouseOut);
         this.plView.addEventListener(LVEvent.TABLE_SELECTED,this.onTableSelected);
         this.plView.addEventListener(SortTablesEvent.SORT_TABLES,this.onSortTables);
         this.plView.addEventListener(LVEvent.JOIN_ROOM,this.onJoinRoom);
         this.plView.addEventListener(LVEvent.LOCKED_ROOM_CLICK,this.onLockedRoomClick);
         this.plView.addEventListener(LVEvent.CREATE_TABLE,this.onCreateTableClicked);
         this.plView.addEventListener(LVEvent.CHANGE_CASINO,this.onChangeCasinoClicked);
         this.plView.addEventListener(LVEvent.FIND_SEAT,this.onFindSeatClicked);
         this.plView.addEventListener(LVEvent.SHOW_TUTORIAL,this.onShowTutorial);
         this.plView.addEventListener(LVEvent.PLAY_TOURNAMENT,this.onPlayTournament);
         this.plView.addEventListener(LVEvent.REFRESH_LIST,this.onRefreshListClicked);
         this.plView.addEventListener(LVEvent.CONNECT_TO_NEW_CASINO,this.onCasinoSelectorConnectClicked);
         this.plView.addEventListener(LVEvent.CANCEL_NEW_CASINO_CONNECT,this.onCasinoSelectorCancelClicked);
         this.plView.addEventListener(LVEvent.SHOOTOUT_CLICK,this.onShootoutClicked);
         this.plView.addEventListener(LVEvent.SITNGO_CLICK,this.onSitNGoClicked);
         if(pgData.enableMTT)
         {
            this.plView.addEventListener(LVEvent.MTT_CLICK,this.onMTTClicked);
            this.plView.addEventListener(MTTEvent.MTT_ENABLE_REQUESTS,this.onMTTEnableRequests);
            this.plView.addEventListener(MTTEvent.MTT_DISABLE_REQUESTS,this.onMTTDisableRequests);
            this.plView.addEventListener(MTTEvent.ZPWC_ENABLE_REQUESTS,this.onMTTEnableRequests);
            this.plView.addEventListener(MTTEvent.ZPWC_DISABLE_REQUESTS,this.onMTTEnableRequests);
         }
         if(pgData.enableZPWC)
         {
            this.plView.addEventListener(LVEvent.ZPWC_CLICK,this.onZPWCClick);
         }
         this.plView.addEventListener(LVEvent.WEEKLY_CLICK,this.onWeeklyClicked);
         this.plView.addEventListener(LVEvent.BUYIN_CLICK,this.onBuyInClicked);
         this.plView.addEventListener(LVEvent.REGISTER_WEEKLY_CLICK,this.onRegisterWeeklyClicked);
         this.plView.addEventListener(LVEvent.HOWTOPLAY_CLICK,this.onHowToPlayClicked);
         this.plView.addEventListener(LVEvent.SHOOTOUT_LEARNMORE_CLICK,this.onLearnMoreClicked);
         this.plView.addEventListener(LVEvent.ON_TELL_FRIENDS_CHECK_BOX_CLICK,this.onWeeklyTellFriendsCheckBoxClicked);
         this.plView.addEventListener(LVEvent.FULL_TABLES,this.filterLobbyGrid);
         this.plView.addEventListener(LVEvent.RUNNING_TABLES,this.filterLobbyGrid);
         this.plView.addEventListener(LVEvent.EMPTY_TABLES,this.filterLobbyGrid);
         this.plView.addEventListener(LVEvent.NORMAL_TABLES_SELECTED,this.filterLobbyGrid);
         this.plView.addEventListener(LVEvent.FAST_TABLES_SELECTED,this.filterLobbyGrid);
         this.plView.addEventListener(LVEvent.CASINO_SELECTED,this.pickNewCasino);
         this.plView.addEventListener(LVEvent.REFRESH_LOBBY_ROOMS,this.refreshLobbyRooms);
         this.plView.addEventListener(LVEvent.RECORD_STAT,this.onRecordLobbyViewStat);
         this.plView.addEventListener(LVEvent.GET_MORE_CHIPS,this.onGetMoreChipsClicked);
         this.plView.addEventListener(LVEvent.REFRESHED_USER_INFO,this.onRefreshedUserInfo);
         this.plView.addEventListener(LVEvent.GIFT_SHOP_CLICK,this.onGiftShopClicked);
         this.plView.addEventListener(LVEvent.SKIP_SHOOTOUT_ROUND_CLICK,this.onSkipShootoutRoundClickHandler);
         this.plView.addEventListener(LVEvent.CLAIM_SPONSORED_SHOOTOUTS,this.onClaimSponsoredShootouts);
         this.plView.addEventListener(LVEvent.REQUEST_SPONSORED_SHOOTOUTS,this.onRequestSponsoredShootouts);
         this.plView.addEventListener(LVEvent.MINMAX_FILTER_BUTTON_CLICK,this.onMinMaxFilterButtonClick);
         this.plView.addEventListener(LVEvent.MINMAX_FILTER_SCROLLBAR_CLICK,this.onMinMaxFilterScrollBarClick);
         this.plView.addEventListener(LVEvent.MINMAX_FILTER_KEY_SELECTED,this.onMinMaxFilterKeySelected);
         this.plView.addEventListener(LVEvent.DISPLAY_ROOM_SORT_DROPDOWN_ARROW,this.onDisplayRoomSortDropDownArrow);
         this.plView.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_DOWN,this.onLobbyGridScrollBarMouseDown);
         this.plView.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_CLICK,this.onLobbyGridScrollGridScrollBarClick);
         this.plView.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_UP,this.onLobbyGridScrollBarMouseUp);
         this.plView.addEventListener(LVEvent.LOBBYGRID_ROLLOVER,this.onLobbyGridRollover);
         this.plView.addEventListener(LVEvent.LOBBYGRID_ROLLOUT,this.onLobbyGridRollout);
         this.plView.addEventListener(LVEvent.LOBBYGRIDLOCK_PURCHASEFASTTABLES,this.onLobbyGridLockPurchaseFastTables);
         var _loc1_:String = configModel.getStringForFeatureConfig("buzzBox","buzz_url");
         if(_loc1_)
         {
            if(this.plView.buzzAd)
            {
               this.plView.buzzAd.addEventListener(LVEvent.BUZZ_AD_CLICK,this.onBuzzAdClicked);
               this.plView.buzzAd.addEventListener(LVEvent.BUZZ_AD_IMPRESSION,this.onBuzzAdImpression);
            }
         }
         this.plView.addEventListener(LVEvent.SCRATCHERS_AD_CLICK,this.onScratchersAdClick,false,0,true);
         this.plView.addEventListener(LVEvent.BLACKJACK_AD_CLICK,this.onBlackjackAdClick,false,0,true);
         this.plView.addEventListener(LVEvent.POKER_GENIUS_AD_CLICK,this.onPokerGeniusAdClick,false,0,true);
         this.plView.addEventListener(LVEvent.HIDE_TABLE_REBAL_FTUE,this.onHideTableRebalFTUE,false,0,true);
         this.plView.addEventListener(LVEvent.ADD_VIEW_TO_LAYER,this.onAddViewTolayer,false,0,true);
         if(configModel.isFeatureEnabled("videoPoker"))
         {
            this.plView.addEventListener(LVEvent.SHOW_VIDEO_POKER,this.onShowVideoPoker,false,0,true);
            this.plView.addEventListener(LVEvent.VIDEO_POKER_IMPRESSION,this.onVideoPokerImpression,false,0,true);
         }
      }
      
      private function onBuzzAdImpression(param1:LVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:BuzzAd:" + param1.oParams.slideId + ":2011-06-03"));
      }
      
      private function onClaimSponsoredShootouts(param1:LVEvent) : void {
         this.pControl.notifyJS(new JSEvent(JSEvent.CLAIM_SPONSORED_SHOOTOUTS,param1.oParams));
      }
      
      private function onRequestSponsoredShootouts(param1:LVEvent) : void {
         if(pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE || pgData.true_sn == pgData.SN_STANDALONEZDC)
         {
            externalInterface.call("ZY.App.SponsoredShootouts.requestSponsoredShootouts",param1.oParams);
         }
      }
      
      private function onSkipShootoutRoundClickHandler(param1:LVEvent) : void {
         var _loc2_:* = NaN;
         var _loc3_:SSkipShootRound = null;
         if(configModel.getBooleanForFeatureConfig("lobby","disableSkipShootout"))
         {
            this.pControl.showInsufficientFunds();
         }
         else
         {
            _loc2_ = Number(param1.oParams.targetRound);
            if(_loc2_ > 0)
            {
               this.plModel.nSelectedTable = -1;
               this.plModel.sLobbyMode = TableDisplayMode.SHOOTOUT_MODE;
               pgData.dispMode = TableDisplayMode.SHOOTOUT_MODE;
               this.plView.setDefaultSubtab(TableDisplayMode.SHOOTOUT_MODE);
               pgData.bVipNav = true;
               this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
               _loc3_ = new SSkipShootRound("SSkipShootRound",_loc2_);
               pgData.bDidPurchaseShootoutSkip = true;
               this.pcmConnect.sendMessage(_loc3_);
               fireStat(new PokerStatHit("SkipShootoutRound",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click SkipShoutoutRoundButton o:SkipShootoutRound:2010-01-06",null,1,"round" + _loc2_));
               if(pgData.lobbyStats)
               {
                  fireStat(new PokerStatHit("SkipShootoutRoundOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click SkipShoutoutRoundButton o:SkipShootoutRound:2010-04-08"));
               }
            }
            this.checkLobbyTimerAndDoHitForStat();
         }
      }
      
      private function onGiftShopClicked(param1:LVEvent) : void {
         this.pControl.showGiftShop();
         fireStat(new PokerStatHit("GiftIconClick_Lobby",9,23,2010,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:Player:GiftIcon:GiftShop:2009-09-23",null,1));
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("giftIconClick_LobbyOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:Player:GiftIcon:GiftShopOnce:2010-04-08"));
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      public function refreshLobbyRooms(param1:LVEvent) : void {
         var _loc2_:* = undefined;
         this.plModel.nSelectedTable = -1;
         this.filterLobbyGrid(_loc2_);
      }
      
      private function filterLobbyGrid(param1:Event) : void {
         var _loc3_:* = false;
         var _loc4_:Object = null;
         var _loc9_:String = null;
         this.plView.resetSelection();
         var _loc2_:DataProvider = new DataProvider();
         var _loc5_:* = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:* = "";
         this.plView.hideLockOverlayOnLobbyGrid();
         this.plView.unlockLobbyGrid();
         this.plView.refreshRoomFilterDropDown();
         if(this.plModel.sLobbyMode == "challenge" || this.plModel.sLobbyMode == "private")
         {
            _loc5_ = 0;
            while(_loc5_ < this.plModel.lobbyGridData.length)
            {
               _loc4_ = this.plModel.lobbyGridData.getItemAt(_loc5_);
               _loc6_ = _loc4_["sitPlayers"];
               _loc7_ = _loc4_["maxPlayers"];
               _loc8_ = _loc4_["type"] != ""?_loc4_["type"]:TableType.NORMAL;
               _loc3_ = true;
               if(this.plModel.sLobbyMode == "challenge" && this.plModel.filterTableType == TableType.NORMAL && _loc8_ == TableType.NEWBIE)
               {
                  if(_loc4_["unlockLevel"] < 0 && !(this.plModel.newbieMaxLevel == Math.abs(_loc4_["unlockLevel"])))
                  {
                     this.plModel.newbieMaxLevel = Math.abs(_loc4_["unlockLevel"]);
                  }
                  if(_loc4_["unlockLevel"] < 0 && pgData.xpLevel >= Math.abs(_loc4_["unlockLevel"]))
                  {
                     _loc3_ = false;
                  }
               }
               else
               {
                  if(this.plModel.sLobbyMode == "challenge" && !(this.plModel.filterTableType == _loc8_))
                  {
                     _loc3_ = false;
                  }
                  else
                  {
                     if(this.plModel.sLobbyMode == "private")
                     {
                        if(!pgData.isMe(_loc4_["creatorId"]) && !pgData.isFriend(_loc4_["creatorId"]))
                        {
                           _loc3_ = false;
                        }
                     }
                  }
               }
               if((this.plView.hideFullTables.selected) && _loc6_ == _loc7_ && _loc4_["creatorId"] == "")
               {
                  _loc3_ = false;
               }
               if((this.plView.hideEmptyTables.selected) && _loc6_ == 0 && _loc4_["creatorId"] == "")
               {
                  _loc3_ = false;
               }
               if(pgData.userPreferencesContainer)
               {
                  _loc9_ = this.plModel.filterTableType == TableType.NORMAL?this.plModel.normalFilterKey:this.plModel.fastFilterKey;
                  if(_loc9_ != "All")
                  {
                     if(this.plView.stakesCellFormatter(_loc4_) != _loc9_)
                     {
                        _loc3_ = false;
                     }
                  }
               }
               if(_loc3_)
               {
                  _loc2_.addItem(_loc4_);
               }
               _loc5_++;
            }
            this.plView.lobbyGrid.dataProvider = _loc2_;
         }
         else
         {
            if(this.plModel.sLobbyMode == "tournament")
            {
               _loc5_ = 0;
               while(_loc5_ < this.plModel.lobbyGridData.length)
               {
                  _loc4_ = this.plModel.lobbyGridData.getItemAt(_loc5_);
                  _loc6_ = _loc4_["sitPlayers"];
                  _loc7_ = _loc4_["maxPlayers"];
                  _loc8_ = _loc4_["type"] != ""?_loc4_["type"]:TableType.NORMAL;
                  _loc3_ = true;
                  if(this.plModel.filterTableType != _loc8_)
                  {
                     _loc3_ = false;
                  }
                  if((this.plView.hideRunningTables.selected) && _loc4_["status"] == LocaleManager.localize("flash.lobby.gameSelector.hideRunningTablesLabel"))
                  {
                     _loc3_ = false;
                  }
                  if((this.plView.hideEmptyTables.selected) && _loc6_ == 0)
                  {
                     _loc3_ = false;
                  }
                  if(_loc3_)
                  {
                     _loc2_.addItem(_loc4_);
                  }
                  _loc5_++;
               }
               this.plView.lobbyGrid.dataProvider = _loc2_;
            }
         }
         if(pgData.flashCookie != null)
         {
            if(!((param1) && (param1["oParams"]) && (param1["oParams"].skipEmptyUpdate)))
            {
               if(this.plModel.sLobbyMode == "tournament")
               {
                  if(pgData.flashCookie)
                  {
                     pgData.flashCookie.SetValue("bHideEmptyTables",this.plView.hideEmptyTables.selected);
                  }
                  if(pgData.flashCookie)
                  {
                     pgData.flashCookie.SetValue("bHideRunningTables",this.plView.hideRunningTables.selected);
                  }
               }
               else
               {
                  if(this.plModel.sLobbyMode != "shootout")
                  {
                     if(this.plModel.sLobbyMode == "challenge" && !pgData.lobbyUncheckBoxes)
                     {
                        if(pgData.flashCookie)
                        {
                           pgData.flashCookie.SetValue("bHideEmptyTables",this.plView.hideEmptyTables.selected);
                        }
                        if(pgData.flashCookie)
                        {
                           pgData.flashCookie.SetValue("bHideFullTables",this.plView.hideFullTables.selected);
                        }
                     }
                  }
               }
            }
         }
         if((pgData.userPreferencesContainer) && this.plModel.sLobbyMode == "challenge")
         {
            if(this.plView.lobbyGrid.length == 0)
            {
               this.plView.displayRoomListEmptyLobbyLock();
            }
            else
            {
               this.plView.unlockLobbyGrid();
            }
         }
         if((pgData.userPreferencesContainer) && (pgData.userPreferencesContainer.getHasAppliedPreferences()) && this.plModel.sLobbyMode == "challenge")
         {
            this.pControl.commitUserPreferences();
         }
         if(this.plModel.sLobbyMode == "challenge")
         {
            if(this.plModel.filterTableType == TableType.FAST)
            {
               if(pgData.xpLevel < UnlockComponentsLevel.fastTables)
               {
                  this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.fastTables);
               }
            }
         }
         else
         {
            if(this.plModel.sLobbyMode == "shootout" && pgData.xpLevel < UnlockComponentsLevel.shootout)
            {
               this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.shootout);
            }
            else
            {
               if(this.plModel.sLobbyMode == "tournament")
               {
                  if(pgData.dispMode == "weekly")
                  {
                     if(pgData.xpLevel < UnlockComponentsLevel.weeklyTourney)
                     {
                        this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.weeklyTourney);
                     }
                  }
                  else
                  {
                     if(this.plModel.filterTableType == TableType.FAST)
                     {
                        if(pgData.xpLevel < UnlockComponentsLevel.sitngoFast)
                        {
                           this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.sitngoFast);
                        }
                     }
                     else
                     {
                        if(pgData.xpLevel < UnlockComponentsLevel.sitngo)
                        {
                           this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.sitngo);
                        }
                     }
                  }
               }
            }
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onSortTables(param1:SortTablesEvent) : void {
         switch(param1.dataField)
         {
            case "name":
               if((pgData.lobbyStats) || (this.plModel.playerSpeedTestVariant))
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click RoomTableSort o:LobbyUI:2010-04-08"));
                  fireStat(new PokerStatHit("lobbyClickRoomTableSortOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click RoomTableSortOnce o:LobbyUI:2010-04-08"));
               }
               break;
            case "players":
               if((pgData.lobbyStats) || (this.plModel.playerSpeedTestVariant))
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click PlayersTableSort o:LobbyUI:2010-04-08"));
                  fireStat(new PokerStatHit("lobbyClickPlayersTableSortOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click PlayersTableSortOnce o:LobbyUI:2010-04-08"));
               }
               break;
            case "stakes":
               if((pgData.lobbyStats) || (this.plModel.playerSpeedTestVariant))
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click StakesTableSort o:LobbyUI:2010-04-08"));
                  fireStat(new PokerStatHit("lobbyClickStakesTableSortOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click StakesTableSortOnce o:LobbyUI:2010-04-08"));
               }
               break;
            case "minMaxBuyIn":
               if((pgData.lobbyStats) || (this.plModel.playerSpeedTestVariant))
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click MinMaxBuyInTableSort o:LobbyUI:2010-04-08"));
                  fireStat(new PokerStatHit("lobbyClickMinMaxBuyInTableSortOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click MinMaxBuyInTableSortOnce o:LobbyUI:2010-04-08"));
               }
               break;
            case "playerSpeed":
               fireStat(new PokerStatHit("LobbyClickPlayerSpeedTableSort",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click PlayerSpeedTableSort o:LobbyUI:2012-01-17"));
               fireStat(new PokerStatHit("LobbyClickPlayerSpeedTableSortOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click PlayerSpeedTableSortOnce o:LobbyUI:2012-01-17"));
               break;
         }
         
         this.plModel.sortTables(param1.dataField,param1.sortDescending);
         this.filterLobbyGrid(null);
      }
      
      private function onTableSelected(param1:TableSelectedEvent) : void {
         this.plModel.nSelectedTable = param1.nId;
         if(param1.roomItem)
         {
            this.plModel.selectedRoomItem = param1.roomItem;
         }
         else
         {
            this.plModel.selectedRoomItem = null;
         }
         this.plView.highlightJoinRoomButton();
      }
      
      private function onTableMouseOver(param1:TableSelectedEvent) : void {
         if(!this.atThisTableTimer)
         {
            this.atThisTableTimer = new Timer(500,1);
            this.atThisTableTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onAtThisTableTimerComplete);
         }
         this.atThisTableTimer.reset();
         this.atThisTableTimer.start();
      }
      
      private function onTableMouseOut(param1:TableSelectedEvent) : void {
         if(this.atThisTableTimer)
         {
            this.atThisTableTimer.stop();
         }
         this.plView.hideAtThisTable();
      }
      
      private function onAtThisTableTimerComplete(param1:TimerEvent) : void {
         this.pcmConnect.sendMessage(new SGetRoomInfo2("SGetRoomInfo2",this.plModel.mouseOverRoomId));
      }
      
      private function onMinMaxFilterButtonClick(param1:LVEvent) : void {
         this.hasClickedSortDropDown = true;
         this.pControl.hideTutorialArrows();
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onMinMaxFilterScrollBarClick(param1:LVEvent) : void {
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onMinMaxFilterKeySelected(param1:LVEvent) : void {
         var _loc2_:* = "";
         var _loc3_:* = "";
         if(this.plModel.filterTableType == TableType.NORMAL)
         {
            this.plModel.normalFilterKey = String(param1.oParams.key);
            _loc2_ = UserPreferencesContainer.NORMAL_FILTER;
            _loc3_ = this.plModel.normalFilterKey;
         }
         else
         {
            if(this.plModel.filterTableType == TableType.FAST)
            {
               this.plModel.fastFilterKey = String(param1.oParams.key);
               _loc2_ = UserPreferencesContainer.FAST_FILTER;
               _loc3_ = this.plModel.fastFilterKey;
            }
         }
         if((pgData.userPreferencesContainer.getHasAppliedPreferences()) && !(_loc2_ == "") && !(_loc3_ == ""))
         {
            if(this.hasClickedSortDropDown)
            {
               pgData.userPreferencesContainer.everFiltered = "1";
               this.hasClickedSortDropDown = false;
            }
            pgData.userPreferencesContainer.commitValueWithKey(_loc2_,_loc3_);
         }
         this.filterLobbyGrid(param1);
      }
      
      private function onPrivateTabClick(param1:LVEvent) : void {
         var _loc2_:* = undefined;
         this.plModel.nSelectedTable = -1;
         if(pgData.dispMode == "tournament" || pgData.dispMode == "shootout")
         {
            pgData.bDidGetShootoutState = false;
            this.plModel.sLobbyMode = "private";
            pgData.dispMode = "private";
            pgData.bVipNav = true;
            pgData.joinPrevServ = true;
            this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            pgData.newServerId = String(this.pControl.loadBalancer.getPrevServerOfType("normal"));
            this.pcmConnect.disconnect();
            this.pControl.hideTutorialArrows();
         }
         else
         {
            this.plModel.sLobbyMode = "private";
            pgData.dispMode = "private";
            this.plModel.updateRoomList(pgData.aGameRooms);
            this.recordRoomList();
            this.plView.lobbyGrid.dataProvider = new DataProvider(this.plModel.lobbyGridData);
            this.plView.setPrivateGames();
            this.filterLobbyGrid(_loc2_);
         }
         this.getLobbyRooms();
         fireStat(new PokerStatHit("LobbyClickPrivateTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:PrivateTab:2010-06-09",null,1));
         fireStat(new PokerStatHit("LobbyClickPrivateTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:PrivateTabOnce:2010-06-09"));
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      private function onPointsTabClick(param1:LVEvent) : void {
         var _loc2_:* = undefined;
         this.plModel.nSelectedTable = -1;
         pgData.bDidGetShootoutState = false;
         if(!(this.plModel.sLobbyMode == "challenge") && !(this.plModel.sLobbyMode == "mtt") && !(this.plModel.sLobbyMode == "zpwc"))
         {
            this.plModel.sLobbyMode = "challenge";
            pgData.dispMode = "challenge";
            pgData.bVipNav = true;
            this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            this.pcmConnect.disconnect();
         }
         else
         {
            this.plModel.sLobbyMode = "challenge";
            pgData.dispMode = "challenge";
            this.plModel.updateRoomList(pgData.aGameRooms);
            this.recordRoomList();
            this.plView.lobbyGrid.dataProvider = new DataProvider(this.plModel.lobbyGridData);
            this.plView.setPointsGames();
            this.filterLobbyGrid(_loc2_);
         }
         this.plModel.seatedPlayersGridData = new DataProvider();
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      public function gotoPremiumTab() : void {
         this.onPremiumTabClick(null);
      }
      
      private function onPremiumTabClick(param1:LVEvent) : void {
         if((pgData.lobbyStats) && (param1))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click PowerTournamentTab o:LobbyUI:2011-06-05"));
         }
         pgData.isShootoutWasWeekly = true;
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "premium";
         pgData.dispMode = "premium";
         pgData.bVipNav = true;
         pgData.bDidGetShootoutState = false;
         this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
         this.pcmConnect.disconnect();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      public function dispPremShootoutLob(param1:RPremiumShootoutConfig) : void {
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Impression PowerTournamentTab o:LobbyUI:2011-06-05"));
         }
         this.pControl.hideTutorialArrows();
         this.premiumSoConfig = param1;
         var _loc2_:String = configModel.getStringForFeatureConfig("core","basePath");
         if(_loc2_)
         {
            LoadManager.load(_loc2_ + "./modules/PowerTourneyAssets0004.swf",{"onComplete":this.onPowerTourneyAssetsLoaded});
         }
      }
      
      public function getPremiumShootoutConfig(param1:Number) : Object {
         var _loc2_:* = 0;
         while(_loc2_ < this.premiumSoConfig.shootoutObj.length)
         {
            if(Number(this.premiumSoConfig.shootoutObj[_loc2_].buyin) == param1)
            {
               return this.premiumSoConfig.shootoutObj[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function onPowerTourneyAssetsLoaded(param1:LoaderEvent) : void {
         this.plView.showPremiumLobby(this.premiumSoConfig.shootoutObj);
         this.plView.setLobbyDisplay();
      }
      
      private function onPlayPremiumShootout(param1:LVEvent) : void {
         var _loc2_:String = null;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         if(pgData.casinoGold < Number(param1.oParams["buyin"]))
         {
            _loc3_ = Number(param1.oParams["buyin"]) - pgData.casinoGold;
            _loc4_ = 4;
            if(param1.oParams["trackingInsuf"])
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,param1.oParams["trackingInsuf"]));
            }
            this.showInsufficientChips(_loc3_,_loc4_,"gold",ObjectUtil.maybeGetString(param1.oParams,"ref",""));
            return;
         }
         if(param1.oParams["trackingSuf"])
         {
            _loc2_ = param1.oParams["trackingSuf"];
         }
         else
         {
            _loc2_ = "Lobby Click PowerTournamentPlayButton o:LobbyUI:2011-06-05";
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,_loc2_));
         this.pControl.soConfig.updateConfig(Number(param1.oParams["id"]),Number(param1.oParams["idVersion"]),String(param1.oParams["last_modified"]),Number(param1.oParams["buyin"]),Number(param1.oParams["rounds"]),Number(param1.oParams["players"]),param1.oParams["winner_count"],param1.oParams["payouts"],pgData.skipShootoutRound1Price,pgData.skipShootoutRound2Price);
         pgData.soPremiumId = Number(param1.oParams["id"]);
         pgData.soUser.nRound = 1;
         pgData.joinPremiumLobby = false;
         this.pcmConnect.sendMessage(new SPickRoomShootout("SPickRoomShootout",this.pControl.soConfig.nId,this.pControl.soConfig.nIdVersion));
      }
      
      private function onTourneyTabClick(param1:LVEvent=null) : void {
         if(pgData.enableMTT)
         {
            this.onMTTClicked(new LVEvent(LVEvent.MTT_CLICK));
            return;
         }
         externalInterface.call("zc.feature.mtt.showRampDown");
         var _loc2_:Object = configModel.getFeatureConfig("powerTourney");
         if((_loc2_) && (_loc2_.enablePremiumShootout) && !_loc2_.enablePowerTourneyLobbyTab)
         {
            this.onPremiumTabClick(new LVEvent(LVEvent.PREMIUM_CLICK));
            return;
         }
         if(pgData.dispMode == "shootout")
         {
            return;
         }
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickTourneyTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsTab o:LobbyUI:2010-04-19"));
            fireStat(new PokerStatHit("lobbyClickTourneyTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click TournamentsTabOnce o:LobbyUI:2010-04-08"));
         }
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "shootout";
         pgData.dispMode = "shootout";
         this.plView.setDefaultSubtab("shootout");
         pgData.bVipNav = true;
         this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
         pgData.bDidGetShootoutState = true;
         this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
         this.pControl.hideTutorialArrows();
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      public function setShootoutMode() : void {
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "shootout";
         pgData.dispMode = "shootout";
         this.plView.setDefaultSubtab("shootout");
         pgData.bVipNav = true;
         this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
      }
      
      public function setWeeklyMode() : void {
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "shootout";
         pgData.dispMode = "shootout";
         pgData.bVipNav = true;
         this.plView.setDefaultSubtab("weekly");
         if(this.plModel)
         {
            this.plModel.tableConfig.tourneyId = -1;
         }
         pgData.joinWeeklyLobby = true;
      }
      
      public function setPremiumMode() : void {
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "premium";
         pgData.dispMode = "premium";
      }
      
      private function onJoinRoom(param1:LVEvent) : void {
         var _loc2_:RoomItem = null;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         if(this.plModel.nSelectedTable != 0)
         {
            _loc2_ = null;
            if(this.plModel.nSelectedTable > 0)
            {
               _loc2_ = pgData.getRoomById(this.plModel.nSelectedTable);
            }
            if(_loc2_)
            {
               if(this.lastTableSeen == _loc2_.id)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Other o:JoinLastTableSeen:2011-11-07"));
               }
               if(this.plModel.checkRoomChipsLocked(_loc2_))
               {
                  _loc3_ = 0;
                  if(this.plModel.sLobbyMode == "challenge")
                  {
                     _loc3_ = _loc2_.minBuyin - pgData.points;
                     _loc4_ = 1;
                  }
                  else
                  {
                     if(this.plModel.sLobbyMode == "tournament")
                     {
                        _loc3_ = _loc2_.entryFee + _loc2_.hostFee - pgData.points;
                        _loc4_ = 2;
                     }
                  }
                  pgData.joinRoomInsufficientChips = true;
                  this.showInsufficientChips(_loc3_,_loc4_,"chips");
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:JoinRoomLock:JoinRoom:2010-04-05"));
               }
               else
               {
                  if(configModel.getIntForFeatureConfig("user","newUserPopup"))
                  {
                     ZTrack.logMilestone("join_room","data_grid");
                  }
                  pgData.isJoinFriend = false;
                  pgData.joinFriendId = "";
                  if((this.plModel.lobbyConfig) && (this.plModel.lobbyConfig.allowRealTimeTableStatusStats))
                  {
                     pgData.userDidSelectTableFromTableSelector = true;
                  }
                  dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE,this.plModel.nSelectedTable));
                  this.plModel.nSelectedTable = -1;
               }
               if(this.plModel.sLobbyMode == "private")
               {
                  fireStat(new PokerStatHit("lobbyClickJoinPrivateTable",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click JoinPrivateTable o:LobbyUI:2010-06-09",null,1));
                  fireStat(new PokerStatHit("lobbyClickJoinPrivateTableOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click JoinPrivateTableOnce o:LobbyUI:2010-06-09"));
               }
               else
               {
                  if(pgData.lobbyStats == true)
                  {
                     fireStat(new PokerStatHit("lobbyClickJoinTable",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"TableSelector Click JoinTable o:LobbyUI:2010-08-23"));
                  }
               }
            }
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onLockedRoomClick(param1:LVEvent) : void {
         pgData.joinRoomInsufficientChips = true;
         var _loc2_:Number = param1.oParams.minBuyIn - pgData.points;
         var _loc3_:* = 1;
         this.showInsufficientChips(_loc2_,_loc3_,"chips");
         var _loc4_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:JoinRoomLock:GridRow:2010-04-05");
         var _loc5_:int = configModel.getIntForFeatureConfig("user","fg");
         if(!(_loc5_ == 0) && !(_loc5_ == -1))
         {
            _loc4_.type = PokerStatHit.HITTYPE_FG;
            fireStat(_loc4_);
         }
         else
         {
            fireStat(_loc4_);
         }
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         switch(_loc2_.type)
         {
            case "RLogin":
               break;
            case "RRoomListUpdate":
               break;
            case "RDisplayRoomList":
               this.handleDisplayRoomList(_loc2_);
               break;
            case "RRoomInfo":
               this.handleRoomInfo(_loc2_);
               break;
            case "RRoomInfo2":
               this.handleRoomInfo2(_loc2_);
               break;
            case "RRoomPicked":
               break;
            case "RTM":
               this.handleRTM(_loc2_);
               break;
            case "RPointsUpdate":
               this.onPointsUpdate(_loc2_);
               break;
            case "RGameAlreadyStarted":
               this.onGameAlreadyStarted(_loc2_);
               break;
            case "RWrongRound":
               this.onWrongRound(_loc2_);
               break;
            case "RWrongBuyIn":
               this.onWrongBuyin(_loc2_);
               break;
            case "RSitNotReserved":
               this.onSitNotReserved(_loc2_);
               break;
            case "RShootoutConfigChanged":
               this.onShootoutConfigChanged(_loc2_);
               break;
            case "RTourneyOver":
               this.onTourneyOver(_loc2_);
               break;
            case "RServerStatus":
               this.onServerStatus(_loc2_);
               break;
         }
         
      }
      
      public function setShownGift(param1:Number) : void {
         this.plView.displayGiftChicklet(param1);
      }
      
      private function handleDisplayRoomList(param1:Object) : void {
         var e:* = undefined;
         var smallBlind:int = 0;
         var tableType:String = null;
         var tRoom:RoomItem = null;
         var inMsg:Object = param1;
         var tMsg:RDisplayRoomList = RDisplayRoomList(inMsg);
         if(!pgData.bRoomListInit)
         {
            pgData.bRoomListInit = true;
         }
         pgData.aGameRooms = tMsg.rooms.concat();
         this.plModel.xpLevel = pgData.xpLevel;
         if((pgData.bUserDisconnect) || (pgData.bVipNav) || (pgData.joiningContact) || (pgData.joiningAnyTable))
         {
            this.plModel.updateRoomList(pgData.aGameRooms);
            this.initLobbyModel();
            if(pgData.bVipNav)
            {
               this.plModel.updateRoomList(pgData.aGameRooms);
               this.plView.setLobbyDisplay();
               pgData.bVipNav = false;
            }
            if(pgData.joiningContact)
            {
               if(pgData.nNewRoomId != -1)
               {
                  dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE,pgData.nNewRoomId));
               }
               else
               {
                  this.plModel.updateRoomList(pgData.aGameRooms);
                  this.plView.loadNewServerLobby();
               }
            }
            else
            {
               if((pgData.joiningAnyTable) && !(pgData.newRoomName == null))
               {
                  pgData.joiningAnyTable = false;
                  pgData.nNewRoomId = pgData.getRoomByName(pgData.newRoomName).id;
                  if(pgData.nNewRoomId != -1)
                  {
                     dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE,pgData.nNewRoomId));
                  }
                  else
                  {
                     this.plModel.updateRoomList(pgData.aGameRooms);
                     this.plView.loadNewServerLobby();
                  }
               }
               else
               {
                  pgData.isJoinFriend = false;
                  pgData.isJoinFriendSit = false;
               }
            }
         }
         if(!pgData.bUserDisconnect && !pgData.bVipNav && !pgData.joiningContact)
         {
            if(!this.bViewInit)
            {
               this.initLobbyModel();
               this.plModel.updateRoomList(pgData.aGameRooms);
               this.initLobbyView();
               this.bViewInit = true;
            }
            else
            {
               this.plView.lobbyGrid.dataProvider = new DataProvider();
               this.plModel.updateRoomList(pgData.aGameRooms);
               this.plView.lobbyGrid.dataProvider = new DataProvider(this.plModel.lobbyGridData);
               this.plView.loadNewServerLobby();
            }
         }
         if(pgData.joiningContact)
         {
            pgData.joiningShootout = false;
            if(this.pControl.loadBalancer.getServerType(pgData.serverId) == "shootout")
            {
               pgData.joiningShootout = true;
            }
         }
         this.recordRoomList();
         pgData.bUserDisconnect = false;
         pgData.joinShootoutLobby = false;
         this.filterLobbyGrid(e);
         this.plModel.serverName = pgData.serverName;
         this.plModel.playersOnline = pgData.usersOnline;
         this.plModel.totalChips = pgData.points;
         this.plView.refreshUserInfo();
         dispatchEvent(new LCEvent(LCEvent.ON_USER_CHIPS_UPDATED));
         if((pgData.joinWeeklyLobby) || (this.plModel.lobbyConfig) && (this.plModel.lobbyConfig.forceTourneySubtab))
         {
            pgData.joinWeeklyLobby = false;
            this.plModel.lobbyConfig.forceTourneySubtab = false;
            this.showWeeklyLobby();
         }
         try
         {
            this.pControl.hideInterstitial();
         }
         catch(err:TypeError)
         {
         }
         if(pgData.dispMode == "shootout" || ((this.plModel.shootoutConfig) && (!(this.plModel.shootoutConfig.shootoutId == null))) && (this.plModel.shootoutConfig.shootoutId > -1))
         {
            this.pcmConnect.sendMessage(new SGetShootoutConfig("SGetShootoutConfig"));
         }
         if(pgData.dispMode == "premium")
         {
            this.pcmConnect.sendMessage(new SGetPremiumShootoutConfig("SGetPremiumShootoutConfig"));
         }
         if(!pgData.joiningContact)
         {
            if(pgData.rejoinRoom != -1)
            {
               dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE,pgData.rejoinRoom));
            }
            else
            {
               if((this.plModel.lobbyConfig) && (this.plModel.lobbyConfig.firstTimePlayer))
               {
                  this.plModel.lobbyConfig.firstTimePlayer = false;
                  dispatchEvent(new LCEvent(LCEvent.FIND_SEAT));
               }
               else
               {
                  if((this.plModel.tableConfig) && (this.plModel.tableConfig.tourneyId > -1) && this.pcmConnect.rollingRebootStoredInfo == null)
                  {
                     this.pcmConnect.sendMessage(new SPickRoom("SPickRoom"));
                  }
                  else
                  {
                     if(pgData.bAutoFindSeat)
                     {
                        pgData.bAutoFindSeat = false;
                        this.pControl.findGame();
                     }
                     else
                     {
                        if(pgData.playAtStakes > 0)
                        {
                           smallBlind = pgData.playAtStakes;
                           tableType = pgData.userPreferencesContainer.tableTypeValue;
                           this.pcmConnect.sendMessage(new SFindRoomRequest("SFindRoomRequest",9,smallBlind,smallBlind * 2,0,"Challenge",1,tableType,[],1,0));
                           pgData.playAtStakes = 0;
                        }
                        else
                        {
                           if((this.plModel.tableConfig) && (this.plModel.tableConfig.showdownRoomId))
                           {
                              tRoom = pgData.getRoomById(this.plModel.tableConfig.showdownRoomId);
                              if(tRoom != null)
                              {
                                 dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE,tRoom.id));
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         this.plModel.selectedRoomItem = null;
         this.plView.adjustControlsLocation();
         if(this.plView.lobbyGrid.length > 0)
         {
            this.pControl.hideTutorialArrows();
         }
      }
      
      private function handleRoomInfo(param1:Object) : void {
      }
      
      private function handleRoomInfo2(param1:Object) : void {
         var _loc4_:String = null;
         var _loc2_:RRoomInfo2 = RRoomInfo2(param1);
         var _loc3_:RoomItem = RoomItem(this.plModel.aRoomsById[this.plModel.mouseOverRoomId]);
         if(_loc3_)
         {
            _loc4_ = this.plModel.sLobbyMode == "tournament"?this.plView.feeCellFormatter(_loc3_):this.plView.stakesCellFormatter(_loc3_);
            this.plView.showAtThisTable(_loc3_["roomName"],_loc4_,_loc2_.aPlayerList);
            this.lastTableSeen = _loc3_.id;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:ShowAtThisTable:2011-11-07"));
         }
      }
      
      private function onCreateTableClicked(param1:LVEvent) : void {
         this.pControl.applyToCreatePrivateRoom();
         fireStat(new PokerStatHit("LobbyClickCreateTable",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click CreateTable o:LobbyUI:2010-06-09",null,1));
         fireStat(new PokerStatHit("LobbyClickCreateTableOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click CreateTableOnce o:LobbyUI:2010-06-09"));
      }
      
      public function showServerSelection() : void {
         this.pControl.loadBalancer.addEventListener(LBEvent.onParseServerList,this.serverListParsed);
         this.pControl.loadBalancer.getServerList();
      }
      
      private function serverListParsed(param1:LBEvent) : void {
         if(!pgData.joiningContact)
         {
            this.plModel.updateCasinoList(this.pControl.loadBalancer.aServerList);
            this.plView.updateCasinoList();
         }
         this.plModel.playersOnline = pgData.usersOnline;
         this.plView.refreshUserInfo();
         this.pControl.commonControl.updateFriendSelectorPlayersOnlineNowText(pgData.usersOnline);
      }
      
      public function joinAnyTable(param1:String, param2:String) : void {
         pgData.newServerId = param1;
         pgData.newRoomName = param2.split("_").join(" ");
         pgData.joiningShootout = false;
         pgData.joiningAnyTable = true;
         this.pcmConnect.disconnect();
      }
      
      private function onFindSeatClicked(param1:LVEvent) : void {
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickPlayNow",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click PlayNow o:LobbyUI:2010-04-19"));
            fireStat(new PokerStatHit("lobbyClickPlayNowOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click PlayNowOnce o:LobbyUI:2010-04-08"));
         }
         if(configModel.getIntForFeatureConfig("user","newUserPopup"))
         {
            ZTrack.logMilestone("join_room","play_now");
         }
         this.pControl.hideTutorialArrows();
         this.checkLobbyTimerAndDoHitForStat();
         this.pControl.removeGameDropdown();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
         var _loc2_:Object = configModel.getFeatureConfig("nineteenOrLessChips");
         if(!(_loc2_ == null) && pgData.points < _loc2_.minWalletSize)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click PlayNow o:NineteenOrLesschips:Play:2013-10-24"));
            if(_loc2_.shouldPopBuyPage)
            {
               this.showInsufficientChips(_loc2_.minWalletSize - pgData.points,1,"chips","NineteenOrLessChipsPlayNow");
               return;
            }
         }
         dispatchEvent(new LCEvent(LCEvent.FIND_SEAT));
      }
      
      private function onShowTutorial(param1:LVEvent) : void {
         externalInterface.call("showTutorial");
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickLearnToPlay",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click LearnToPlay o:LobbyUI:2010-04-19"));
            fireStat(new PokerStatHit("lobbyClickLearnToPlayOnce",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click LearnToPlayOnce o:LobbyUI:2010-04-08"));
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onPlayTournament(param1:LVEvent) : void {
         dispatchEvent(new LCEvent(LCEvent.PLAY_TOURNAMENT));
         this.onTourneyTabClick();
      }
      
      private function onRefreshListClicked(param1:LVEvent) : void {
         this.pcmConnect.getLobbyRooms();
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickRefreshList",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click RefreshList o:LobbyUI:2010-04-19"));
            fireStat(new PokerStatHit("lobbyClickRefreshListOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click RefreshListOnce o:LobbyUI:2010-04-08"));
         }
      }
      
      private function onShootoutClicked(param1:LVEvent) : void {
         var _loc2_:String = pgData.dispMode;
         if(pgData.dispMode == "shootout")
         {
            return;
         }
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "shootout";
         pgData.dispMode = "shootout";
         if(!pgData.bDidGetShootoutState || _loc2_ == "weekly")
         {
            pgData.bVipNav = true;
            this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            if(_loc2_ == "weekly")
            {
               pgData.isShootoutWasWeekly = true;
            }
            pgData.bDidGetShootoutState = true;
            this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
         }
         else
         {
            this.plView.setDefaultSubtab("shootout");
            this.plView.updateShootoutConfig(this.plModel.oShootoutConfig,this.plModel.oShootoutUser);
         }
         if(configModel.isFeatureEnabled("tournamentImprovements"))
         {
            fireStat(new PokerStatHit("LobbyClickShootoutTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsShootoutTabImproved o:LobbyUI:2014-03-04"));
         }
         else
         {
            fireStat(new PokerStatHit("LobbyClickShootoutTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsShootoutTab o:LobbyUI:2010-04-19"));
         }
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickShootoutTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click TournamentsShootoutTabOnce o:LobbyUI:2010-04-08"));
         }
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      private function onSitNGoClicked(param1:LVEvent) : void {
         if(pgData.dispMode == "tournament")
         {
            return;
         }
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "tournament";
         pgData.dispMode = "tournament";
         pgData.bVipNav = true;
         this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
         pgData.bDidGetShootoutState = false;
         this.pcmConnect.disconnect();
         if(configModel.isFeatureEnabled("tournamentImprovements"))
         {
            fireStat(new PokerStatHit("LobbyClickSitNGoTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsSitNGoTabImproved o:LobbyUI:2014-03-04"));
         }
         else
         {
            fireStat(new PokerStatHit("LobbyClickSitNGoTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsSitNGoTab o:LobbyUI:2010-04-19"));
         }
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickSitNGoTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click TournamentsSitNGoTabOnce o:LobbyUI:2010-04-08"));
         }
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      public function onMTTClicked(param1:LVEvent) : void {
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click MTTTab o:LobbyUI:2012-11-15"));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click MTTTabOnce o:LobbyUI:2012-11-15"));
         }
         if(pgData.dispMode == "mtt")
         {
            return;
         }
         pgData.bDidGetShootoutState = false;
         this.plModel.nSelectedTable = -1;
         this.plView.hideLockOverlayOnLobbyGrid();
         this.plView.unlockLobbyGrid();
         if(!(this.plModel.sLobbyMode == "challenge") && !(this.plModel.sLobbyMode == "mtt") && !(this.plModel.sLobbyMode == "zpwc"))
         {
            this.plModel.sLobbyMode = "mtt";
            pgData.dispMode = "mtt";
            pgData.bVipNav = true;
            this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            this.pcmConnect.disconnect();
         }
         else
         {
            this.plModel.sLobbyMode = "mtt";
            pgData.dispMode = "mtt";
            pgData.bVipNav = true;
         }
         dispatchEvent(new MTTLoadEvent(MTTLoadEvent.MTT_SHOW_LISTINGS,
            {
               "callback":this.showMTTLobby,
               "listingType":"listings"
            }));
      }
      
      public function onZPWCClick(param1:LVEvent) : void {
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click ZPWCTab o:LobbyUI:2013-1-28"));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click ZPWCTabOnce o:LobbyUI:2013-1-28"));
         }
         if(pgData.dispMode == "zpwc")
         {
            return;
         }
         pgData.bDidGetShootoutState = false;
         this.plModel.nSelectedTable = -1;
         this.plView.hideLockOverlayOnLobbyGrid();
         this.plView.unlockLobbyGrid();
         if(!(this.plModel.sLobbyMode == "challenge") && !(this.plModel.sLobbyMode == "mtt") && !(this.plModel.sLobbyMode == "zpwc"))
         {
            this.plModel.sLobbyMode = "zpwc";
            pgData.dispMode = "zpwc";
            pgData.bVipNav = true;
            this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            this.pcmConnect.disconnect();
         }
         else
         {
            this.plModel.sLobbyMode = "zpwc";
            pgData.dispMode = "zpwc";
            pgData.bVipNav = true;
         }
         this.plView.tabBannerController.hideView();
         this.plView.removeZPWCArrow();
         dispatchEvent(new MTTLoadEvent(MTTLoadEvent.MTT_SHOW_LISTINGS,
            {
               "callback":this.showZPWCLobby,
               "listingType":"zpwcListings"
            }));
      }
      
      public function onMTTEnableRequests(param1:MTTEvent) : void {
         dispatchEvent(param1);
      }
      
      public function onMTTDisableRequests(param1:MTTEvent) : void {
         dispatchEvent(param1);
      }
      
      public function showMTTLobby(param1:DisplayObject) : void {
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Impression MTTTab o:LobbyUI:2012-11-30"));
         }
         this.plView.setLobbyDisplay();
         this.plView.showMTT(param1);
         this.hideLobbyBanner(LobbyBanner.MTT);
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      public function showZPWCLobby(param1:DisplayObject) : void {
         this.plView.setLobbyDisplay();
         this.plView.showZPWC(param1);
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onWeeklyClicked(param1:LVEvent) : void {
         if(pgData.dispMode == "weekly")
         {
            return;
         }
         this.showWeeklyLobby();
         fireStat(new PokerStatHit("LobbyClickWeeklyTab",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsWeeklyTab o:LobbyUI:2010-04-19"));
         if(pgData.lobbyStats)
         {
            fireStat(new PokerStatHit("lobbyClickWeeklyTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click TournamentsWeeklyTabOnce o:LobbyUI:2010-04-08"));
         }
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      private function showWeeklyLobby() : void {
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "weekly";
         pgData.dispMode = "weekly";
         this.plView.setDefaultSubtab("weekly");
         var _loc1_:LoadUrlVars = new LoadUrlVars();
         var _loc2_:* = "";
         var _loc3_:uint = 0;
         while(_loc3_ < pgData.aFriendZids.length)
         {
            _loc2_ = _loc2_ + pgData.aFriendZids[_loc3_];
            _loc2_ = _loc2_ + (_loc3_ == pgData.aFriendZids.length-1?"":",");
            _loc3_++;
         }
         var _loc4_:Date = new Date();
         var _loc5_:Object = new Object();
         _loc5_.sn = pgData.sn_id;
         _loc5_.uid = pgData.uid;
         _loc5_.noise = _loc4_.getTime().toString() + String(Math.floor(Math.random() * 1000));
         this.plView.showWeeklyLoading();
         _loc1_.addEventListener(URLEvent.onLoaded,this.onUpdateWeeklyConfig,false,0,true);
         _loc1_.loadURL(pgData.sRootURL + "adapter/tourney_info.php?p=" + pgData.getSig(),_loc5_,"POST");
         if(pgData.xpLevel < UnlockComponentsLevel.weeklyTourney)
         {
            this.plView.showLockOverlayOnLobbyGrid(UnlockComponentsLevel.weeklyTourney);
         }
         else
         {
            this.plView.hideLockOverlayOnLobbyGrid();
         }
      }
      
      private function onUpdateWeeklyConfig(param1:URLEvent) : void {
         var evt:URLEvent = param1;
         try
         {
            this.plModel.oWeeklyData = com.adobe.serialization.json.JSON.decode(String(evt.data));
            pgData.tourneyState = parseInt(this.plModel.oWeeklyData.tourneyState);
            this.plModel.nWeeklyTourneyState = pgData.tourneyState;
            pgData.tourneyStartDate = this.plModel.oWeeklyData.startDate;
            pgData.tourneyEndDate = this.plModel.oWeeklyData.endDate;
            this.plView.updateWeeklyConfig(this.plModel.oWeeklyData);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onBuyInClicked(param1:LVEvent, param2:Boolean=true) : void {
         var _loc3_:String = null;
         if(this.plModel.sLobbyMode == "shootout")
         {
            if(pgData.dispMode != "shootout")
            {
               return;
            }
            if((externalInterface.available) && Security.sandboxType == Security.REMOTE)
            {
               externalInterface.call("ZY.App.shootoutEntry.setRound",pgData.soUser.nRound);
               externalInterface.call("ZY.App.shootoutEntry.open");
            }
            else
            {
               this.autositShootout();
            }
            fireStat(new PokerStatHit("LobbyClickShootoutBuyinTab",6,1,2010,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click TournamentsShootoutPlayButton o:LobbyUI:2009-06-01",null,1));
         }
         else
         {
            if(this.plModel.sLobbyMode == "weekly")
            {
               if(!parseInt(this.plModel.oWeeklyData.tourneyPoints) && !(this.plModel.oWeeklyData.tourneyState == 0))
               {
                  if(externalInterface.available)
                  {
                     externalInterface.call("ZY.App.buyBack.popup");
                     dispatchCommand(new ShowBuyPageCommand("weekly","lobby_weekly_buyback","chips"));
                  }
               }
               else
               {
                  if(this.plModel.bPostWeeklyTourneyStatusToFeed == true)
                  {
                     this.postWeeklyTellFriendsForFBFeed(param2);
                  }
                  if(this.plModel.tableConfig)
                  {
                     this.plModel.tableConfig.tourneyId = parseInt(this.plModel.oWeeklyData.tourneyId);
                     _loc3_ = pgData.zid;
                     _loc3_ = _loc3_ + (":" + this.plModel.tableConfig.tourneyId);
                  }
                  pgData.bVipNav = true;
                  this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
                  this.pcmConnect.disconnect();
               }
               fireStat(new PokerStatHit("weeklyTourneyPlayNow",7,29,2010,PokerStatHit.TRACKHIT_ALWAYS,"Tourney Other Click o:PlayNow:2009-07-29",null,1));
               if(pgData.lobbyStats == true)
               {
                  fireStat(new PokerStatHit("weeklyTourneyPlayNowOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Tourney Other Click o:PlayNowOnce:2010-04-08"));
               }
            }
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onRegisterWeeklyClicked(param1:LVEvent) : void {
         var _loc2_:LoadUrlVars = new LoadUrlVars();
         var _loc3_:String = !this.plModel.lobbyConfig || this.plModel.lobbyConfig.tourneyInviteUid == null || this.plModel.lobbyConfig.tourneyInviteUid == -1?pgData.sn_id + "&uid=" + pgData.uid:pgData.sn_id + "&uid=" + pgData.uid + "&tourney_invite_uid=" + this.plModel.lobbyConfig.tourneyInviteUid;
         _loc2_.addEventListener(URLEvent.onLoaded,this.onRegisterForWeeklyResponse);
         _loc2_.loadURL(pgData.sRootURL + "adapter/tourney_register.php?sn=" + _loc3_ + pgData.getSig(),null,"POST");
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onRegisterForWeeklyResponse(param1:URLEvent) : void {
         if(param1.data == "success")
         {
            this.onBuyInClicked(null,false);
         }
         else
         {
            dispatchEvent(new ErrorPopupEvent("onErrorPopup","Registration Error","Unable to enter you into the tournament.  Please refresh your browser and try again."));
         }
      }
      
      private function autositShootout() : void {
         var _loc1_:* = NaN;
         pgData.joiningShootout = false;
         if(pgData.points < this.pControl.soConfig.nBuyin)
         {
            _loc1_ = this.pControl.soConfig.nBuyin - pgData.points;
            this.showInsufficientChips(_loc1_,9,"chips");
         }
         else
         {
            this.pcmConnect.sendMessage(new SPickRoomShootout("SPickRoomShootout",this.pControl.soConfig.nId,this.pControl.soConfig.nIdVersion));
         }
      }
      
      private function onHowToPlayClicked(param1:LVEvent) : void {
         if(this.plModel.sLobbyMode == "shootout")
         {
            dispatchEvent(new PopupEvent("showShootoutHowToPlay"));
         }
         if(this.plModel.sLobbyMode == "weekly")
         {
            dispatchEvent(new PopupEvent("showWeeklyHowToPlay"));
         }
         if(this.plModel.sLobbyMode == "premium")
         {
            dispatchEvent(new PopupEvent("showPowerTourneyHowToPlay"));
         }
         this.checkLobbyTimerAndDoHitForStat();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      private function onLearnMoreClicked(param1:LVEvent) : void {
         var _loc2_:LoadUrlVars = null;
         if((this.plModel.shootoutConfig) && (this.plModel.shootoutConfig.showShootoutRegisterWinnerBadge))
         {
            _loc2_ = new LoadUrlVars();
            _loc2_.navigateURL(this.plModel.shootoutConfig.shootoutRegisterWinnerPageUrl,"_top");
         }
         else
         {
            dispatchEvent(new PopupEvent("showShootoutLearnMore"));
         }
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function postWeeklyTellFriendsForFBFeed(param1:Boolean) : void {
         if(param1)
         {
            externalInterface.call("postTourneyPlay");
         }
         else
         {
            externalInterface.call("postTourneyJoin");
         }
      }
      
      private function onWeeklyTellFriendsCheckBoxClicked(param1:LVEvent) : void {
         this.plModel.bPostWeeklyTourneyStatusToFeed = Boolean(param1.oParams);
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onChangeCasinoClicked(param1:LVEvent) : void {
         this.hideTableRebalFTUE();
         this.plView.hideAll();
         this.plView.showCasinoList();
         this.pControl.navControl.hideSideNav();
         this.pControl.hideFriendSelector();
         this.pControl.hideLeaderboard();
         this.pControl.setTutorialArrowsVisible(false);
         pgData.bUserDisconnect = true;
         this.showServerSelection();
         this.pControl.removeGameDropdown();
         dispatchEvent(new LCEvent(LCEvent.CLOSE_FLYOUT));
      }
      
      private function beforeConnectToCasino() : void {
         this.plView.clearDisplayRestoreContainer();
         this.pControl.hideTutorialArrows();
         dispatchCommand(new CloseAllPHPPopupsCommand());
         pgData.bUserDisconnect = true;
         this.pcmConnect.disconnectWithoutReconnect();
         fireStat(new PokerStatHit("lobbyClickChangeCasino",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click ChangeCasino o:LobbyUI:2010-05-18"));
         fireStat(new PokerStatHit("lobbyClickChangeCasinoOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click ChangeCasinoOnce o:LobbyUI:2010-05-18"));
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onCasinoSelectorCancelClicked(param1:LVEvent) : void {
         this.plView.restoreHiddenAll();
         dispatchCommand(new ShowSideNavCommand());
         this.plView.hideCasinoList();
         this.pControl.showFriendSelector();
         this.pControl.unhideLeaderboard();
         this.pControl.setTutorialArrowsVisible(true);
         pgData.bUserDisconnect = false;
      }
      
      private function onCasinoSelectorConnectClicked(param1:LVEvent) : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(this.plView.casinoSelector.casinoList.selectedItem != null)
         {
            this.beforeConnectToCasino();
            pgData.serverName = this.plModel.sSelServerName;
            pgData.ip = this.plModel.sSelServerIp;
            _loc2_ = this.pControl.loadBalancer.getServerType(pgData.serverId);
            if(_loc2_ == "normal")
            {
               this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
            }
            pgData.serverId = this.plModel.sSelServerId;
            pgData.server_type = this.plModel.sSelServerType;
            _loc3_ = configModel.getFeatureConfig("core");
            if(_loc3_)
            {
               _loc3_.sZone = this.pControl.loadBalancer.getZone(pgData.server_type);
            }
            if(pgData.server_type == "sitngo")
            {
               pgData.dispMode = "tournament";
               this.plModel.sLobbyMode = "tournament";
            }
            else
            {
               if(pgData.server_type == "shootout")
               {
                  pgData.dispMode = "shootout";
                  this.plModel.sLobbyMode = "shootout";
               }
               else
               {
                  pgData.dispMode = "challenge";
                  this.plModel.sLobbyMode = "challenge";
               }
            }
            this.pControl.connectToServer();
            _loc4_ = configModel.getStringForFeatureConfig("smartfox","region");
            _loc5_ = this.pControl.loadBalancer.getServerLanguage(pgData.serverId);
            _loc6_ = this.pControl.loadBalancer.getServerType(pgData.serverId);
            if((_loc4_) && (_loc5_) && _loc6_ == "normal")
            {
               _loc8_ = _loc4_ + ":" + (_loc5_ == "cl"?"cl":"noncl");
               fireStat(new PokerStatHit("CasinoChangeRegion",11,2,2010,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Unknown o:CasinoChangeRegion:2009-11-02",null,1,_loc8_));
            }
            _loc7_ = this.plModel.sSelServerName;
            if(_loc7_.search(" ") != -1)
            {
               _loc7_ = _loc7_.replace(" ","_");
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Unknown o:ConnectToCasino:" + _loc7_ + ":2010-05-18"));
            fireStat(new PokerStatHit("lobbyOtherConnectToCasinoOnce:" + _loc7_,0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Unknown o:ConnectToCasinoOnce:" + _loc7_ + ":2010-05-18"));
         }
         else
         {
            dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),LocaleManager.localize("flash.message.lobby.casinoSelector.selectCasinoMessage")));
         }
      }
      
      public function onReconnection(param1:Event) : void {
      }
      
      private function pickNewCasino(param1:CasinoSelectedEvent) : void {
         this.plModel.sSelServerIp = param1.nIp;
         this.plModel.sSelServerName = param1.nName;
         this.plModel.sSelServerId = String(param1.nServerId);
         this.plModel.sSelServerType = this.pControl.loadBalancer.getServerType(this.plModel.sSelServerId);
      }
      
      private function handleRTM(param1:Object) : void {
         var _loc2_:RTM = RTM(param1);
         var _loc3_:String = LocaleManager.localize("flash.message.defaultTitle");
         var _loc4_:String = LocaleManager.localize("flash.message.lobby.rtmMessage",{"chips":_loc2_.chips});
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc3_,_loc4_));
      }
      
      private function onRecordLobbyViewStat(param1:LVEvent) : void {
      }
      
      private function onGetMoreChipsClicked(param1:LVEvent) : void {
         this.pControl.getMoreChips();
      }
      
      private function onRefreshedUserInfo(param1:LVEvent) : void {
         dispatchEvent(new LCEvent(LCEvent.REFRESHED_USER_INFO));
      }
      
      private function onBuzzAdClicked(param1:BuzzAdEvent) : void {
         var _loc2_:String = null;
         var _loc3_:LoadUrlVars = null;
         switch(param1.sTarget)
         {
            case "flash":
               if(this.pControl.hasOwnProperty(param1.sLink))
               {
                  this.pControl[param1.sLink].call(this.pControl);
               }
               break;
            case "bridge_javascript":
            case "javascript":
               externalInterface.call(param1.sLink);
               break;
            default:
               _loc2_ = "_blank";
               if(param1.sTarget == "same")
               {
                  _loc2_ = "_top";
               }
               _loc3_ = new LoadUrlVars();
               _loc3_.navigateURL(param1.sLink,_loc2_);
         }
         
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onPointsUpdate(param1:Object) : void {
         var _loc2_:RPointsUpdate = RPointsUpdate(param1);
         dispatchCommand(new UpdateChipsCommand(_loc2_.points,false));
         this.plModel.totalChips = pgData.points;
         this.plView.refreshUserInfo();
      }
      
      public function updateUserInfoChipDisplay() : void {
         this.plModel.totalChips = pgData.points;
         this.plView.refreshUserInfo();
      }
      
      private function onGameAlreadyStarted(param1:Object) : void {
         var _loc2_:RGameAlreadyStarted = RGameAlreadyStarted(param1);
         dispatchEvent(new ErrorPopupEvent("onErrorPopup","Seating Error","We were unable to sit you at an appropriate Shootout table. Please try again."));
      }
      
      private function onWrongRound(param1:Object) : void {
         var _loc2_:RWrongRound = RWrongRound(param1);
         var _loc3_:* = "You cannot sit at this table because it is a Shootout Round " + _loc2_.nRoomRound + " table. You are currently qualified for Round " + _loc2_.nUserRound + ".";
         dispatchEvent(new ErrorPopupEvent("onErrorPopup","Incorrect Round",_loc3_));
      }
      
      private function onWrongBuyin(param1:Object) : void {
         var _loc2_:RWrongBuyin = RWrongBuyin(param1);
         dispatchEvent(new ErrorPopupEvent("onErrorPopup","Buy-in Amount Changed","This Buy-in amount is no longer valid. Please reload the Shootouts lobby and try again."));
      }
      
      private function onSitNotReserved(param1:Object) : void {
         var _loc2_:RSitNotReserved = RSitNotReserved(param1);
         dispatchEvent(new ErrorPopupEvent("onErrorPopup","Can\'t Join","Our apologies, someone rudely sat in the seat we were reserving for you. Please try again."));
      }
      
      private function onShootoutConfigChanged(param1:Object) : void {
         var _loc2_:RShootoutConfigChanged = RShootoutConfigChanged(param1);
         this.pcmConnect.sendMessage(new SGetShootoutConfig("SGetShootoutConfig"));
      }
      
      private function onTourneyOver(param1:Object) : void {
         var _loc2_:RTourneyOver = RTourneyOver(param1);
         if(this.plModel.sLobbyMode == "shootout")
         {
            if((this.plModel.shootoutConfig) && (_loc2_.place == 1) && this.plModel.oShootoutUser.nRound == this.plModel.oShootoutConfig.nRounds)
            {
               this.plModel.shootoutConfig.showShootoutRegisterWinnerBadge = 1;
               if(this.plModel.shootoutConfig.shootoutRegisterWinnerBadgeUrl != this.plView.shootoutBadgeUrl)
               {
                  this.plView.shootoutBadgeUrl = this.plModel.shootoutConfig.shootoutRegisterWinnerBadgeUrl;
               }
            }
         }
      }
      
      private function onServerStatus(param1:Object) : void {
         var _loc5_:String = null;
         var _loc6_:DataGridRoomItem = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         if((this.plModel.lobbyConfig) && !this.plModel.lobbyConfig.useRealTimeTableStatus)
         {
            return;
         }
         var _loc2_:RServerStatus = RServerStatus(param1);
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         for (_loc5_ in _loc2_.serverStatusDictionary)
         {
            _loc6_ = this.plModel.getDataGridRoomItemWithRoomId(_loc5_);
            if(_loc6_)
            {
               _loc7_ = _loc2_.serverStatusDictionary.getNumberOfPlayersForRoomId(_loc5_);
               _loc8_ = _loc6_["sitPlayers"];
               _loc9_ = _loc6_["maxPlayers"];
               if(_loc8_ < _loc9_ && _loc7_ == _loc9_)
               {
                  _loc3_++;
               }
               if(_loc8_ == _loc9_ && _loc7_ < _loc9_)
               {
                  _loc4_++;
               }
            }
         }
         if(_loc3_)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Impression TableSelector o:TableStatusChanged:TableFull:" + String(_loc3_) + ":2012-06-05"));
         }
         if(_loc4_)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Impression TableSelector o:TableStatusChanged:SeatAvailable:" + String(_loc4_) + ":2012-06-05"));
         }
         this.plModel.realTimeTableData = _loc2_.serverStatusDictionary;
         if(!this._userIsScrollingLobbyGrid)
         {
            this.performServerStatusUpdate();
         }
         else
         {
            this._serverStatusDidUpdateWhileUserScrolledLobbyGrid = true;
         }
      }
      
      private function performServerStatusUpdate() : void {
         if(!this.plModel || !this.plModel.realTimeTableData)
         {
            return;
         }
         var _loc1_:Number = this.plView.lobbyGrid.verticalScrollPosition;
         this.plView.createAndDisplayLobbyGridBitmapCache();
         this.plModel.updateRoomList(pgData.aGameRooms);
         this.recordRoomList();
         this.filterLobbyGrid(null);
         this.plModel.realTimeTableData = null;
         this.plView.lobbyGrid.verticalScrollPosition = _loc1_;
         this.plView.destroyLobbyGridBitmapCache();
      }
      
      private function recordRoomList() : void {
         pgData.aRoomsById = this.plModel.aRoomsById;
      }
      
      public function updateShootoutConfig(param1:ShootoutConfig, param2:ShootoutUser) : void {
         if((param1) && (param2))
         {
            this.plModel.oShootoutConfig = param1;
            this.plModel.oShootoutUser = param2;
            this.plView.updateShootoutConfig(param1,param2);
            if(!(this.plModel.shootoutConfig.shootoutId == null) && this.plModel.shootoutConfig.shootoutId > -1)
            {
               this.plModel.sLobbyMode = "shootout";
               pgData.dispMode = "shootout";
               this.plModel.shootoutConfig.shootoutId = -1;
               pgData.bDidGetShootoutState = true;
               this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
            }
         }
      }
      
      public function buzzBoxCallback() : void {
         if(pgData.inLobbyRoom)
         {
            this.plView.dispatchEvent(new LVEvent(LVEvent.onTourneyTabClick));
         }
      }
      
      public function gotoShootout() : void {
         if(pgData.inLobbyRoom)
         {
            this.plView.dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_CLICK));
         }
      }
      
      private function gotoWeeklyTourney() : void {
         if(pgData.inLobbyRoom)
         {
            this.plView.dispatchEvent(new LVEvent(LVEvent.WEEKLY_CLICK));
         }
      }
      
      public function gotoSitnGo() : void {
         this.plView.dispatchEvent(new LVEvent(LVEvent.SITNGO_CLICK));
      }
      
      public function updateShootoutUser(param1:ShootoutUser) : void {
         if(pgData.dispMode == "shootout")
         {
            return;
         }
         this.plModel.nSelectedTable = -1;
         this.plModel.sLobbyMode = "shootout";
         pgData.dispMode = "shootout";
         pgData.bVipNav = true;
         pgData.joinPrevServ = false;
         this.pControl.loadBalancer.addPrevServerId(Number(pgData.serverId));
         this.pcmConnect.disconnect();
      }
      
      public function showLobbyGift(param1:int) : void {
         this.plView.displayGiftChicklet(param1);
      }
      
      public function updatePrivateTablesTab(param1:Boolean) : void {
         if(this.plView)
         {
            if(this.plView.mcLobby)
            {
               this.plView.mcLobby.mcPrivateTabOff.visible = param1;
               this.plView.mcLobby.mcPrivateTabOn.visible = false;
            }
         }
      }
      
      private function onDisplayRoomSortDropDownArrow(param1:LVEvent, param2:int=5) : void {
         var _loc3_:Number = 160;
         this.pControl.showTutorialArrow(this.plView as DisplayObjectContainer,220,_loc3_,270,param2);
      }
      
      private function onLobbyGridScrollBarMouseDown(param1:LVEvent) : void {
         this._userIsScrollingLobbyGrid = true;
      }
      
      private function onLobbyGridScrollGridScrollBarClick(param1:LVEvent) : void {
         this.checkLobbyTimerAndDoHitForStat();
      }
      
      private function onLobbyGridScrollBarMouseUp(param1:LVEvent) : void {
         this._userIsScrollingLobbyGrid = false;
         if(this._serverStatusDidUpdateWhileUserScrolledLobbyGrid)
         {
            this.performServerStatusUpdate();
            this._serverStatusDidUpdateWhileUserScrolledLobbyGrid = false;
         }
      }
      
      private function onLobbyGridLockPurchaseFastTables(param1:LVEvent) : void {
      }
      
      private function onLobbyGridRollover(param1:LVEvent) : void {
         commandDispatcher.dispatchCommand(new SurfaceLeaderboardCommand(true));
      }
      
      private function onLobbyGridRollout(param1:LVEvent) : void {
         commandDispatcher.dispatchCommand(new SurfaceLeaderboardCommand(false));
      }
      
      private function claimSponsoredShootoutsCallback(param1:String) : void {
         if(param1 == "1")
         {
            this.plModel.sponsoredShootoutsConfig.sponsorShootoutsAccepted = 0;
            this.plModel.sponsoredShootoutsConfig.sponsorShootoutsState = true;
            this.plModel.sponsorShootoutsAccepted = 0;
            this.plModel.sponsorShootoutsState = true;
            this.pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
         }
      }
      
      public function showTableRebalFTUE() : void {
         var _loc2_:MovieClip = null;
         var _loc1_:Boolean = configModel.getBooleanForFeatureConfig("tableRebal","showFTUE");
         if(!_loc1_)
         {
            return;
         }
         if(this.plView != null)
         {
            _loc2_ = this.plView.getTableRebalFTUE();
            if(_loc2_ != null)
            {
               this.pControl.attachViewToLayer(_loc2_,PokerControllerLayers.TABLE_LOBBY_LAYER);
            }
         }
      }
      
      private function onHideTableRebalFTUE(param1:LVEvent) : void {
         this.plView.removeEventListener(LVEvent.HIDE_TABLE_REBAL_FTUE,this.onHideTableRebalFTUE);
         var _loc2_:DisplayObject = param1.oParams as DisplayObject;
         if(_loc2_ != null)
         {
            this.pControl.removeViewFromLayer(_loc2_,PokerControllerLayers.TABLE_LOBBY_LAYER);
            dispatchCommand(new JSCommand("ZY.App.increaseTableStakes.closeFTUE"));
         }
      }
      
      public function hideTableRebalFTUE() : void {
         var _loc1_:Boolean = configModel.getBooleanForFeatureConfig("tableRebal","showFTUE");
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:MovieClip = this.plView.getTableRebalFTUE();
         if(_loc2_ != null)
         {
            this.pControl.removeViewFromLayer(_loc2_,PokerControllerLayers.TABLE_LOBBY_LAYER);
         }
      }
      
      private function hideZPWCFTUE() : void {
         if(this.plView.zpwcFTUE)
         {
            this.pControl.removeViewFromLayer(this.plView.zpwcFTUE,PokerControllerLayers.MTT_LAYER);
         }
         else
         {
            this.plView.showZPWCLobbyArrow = false;
         }
      }
      
      private function onShowInsufficientFunds(param1:CommandEvent) : void {
         this.showInsufficientChips(param1.params.shortAmount,param1.params.eventType,param1.params.chipsType,param1.params.ref);
      }
      
      private function showInsufficientChips(param1:Number, param2:int, param3:String, param4:String="") : void {
         externalInterface.call("ZY.App.outOfChips.openPopup",param1,param3,param2,param4);
      }
      
      private function onScratchersAdClick(param1:LVEvent) : void {
         dispatchCommand(new JSCommand("zc.feature.miniGame.scratchers.showFromLobby"));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:Scratchers:LobbyUnit:2012-07-16"));
      }
      
      private function onBlackjackAdClick(param1:LVEvent) : void {
         dispatchEvent(new PopupEvent("showBlackjack"));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:Blackjack:LobbyUnit:2012-08-16"));
      }
      
      private function onPokerGeniusAdClick(param1:LVEvent) : void {
         dispatchEvent(new PopupEvent("showPokerGenius"));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:PokerGenius:LobbyAd:2012-08-16"));
      }
      
      public function removePokerGeniusLobbyAd() : void {
         this.plView.removePokerGeniusLobbyAd();
      }
      
      private function startZSCMiniGameChallenge(param1:Object) : void {
         if(param1.gameType == MinigameUtils.HIGHLOW && (pgData.inLobbyRoom))
         {
            this.plView.showHighLowArrow(true);
         }
      }
      
      public function startLobbyIdleTimer() : void {
         if(PokerStatsManager.getInstance().makeThrottledHits)
         {
            if(!this.timerLobbyIdle)
            {
               this.timerLobbyIdle = new Timer(1000);
               this.timerLobbyIdle.addEventListener(TimerEvent.TIMER,this.onLobbyIdleTimerInterval);
            }
            this.timerLobbyIdle.start();
         }
      }
      
      public function stopLobbyIdleTimer() : void {
         if(this.timerLobbyIdle)
         {
            this.timerLobbyIdle.reset();
         }
      }
      
      private function onLobbyIdleTimerInterval(param1:TimerEvent) : void {
         if(this.timerLobbyIdle)
         {
            if(pgData.inLobbyRoom)
            {
               if(this.timerLobbyIdle.currentCount == 30)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:LobbyIdle:ByTimeAt30:2010-08-31"));
               }
               else
               {
                  if(this.timerLobbyIdle.currentCount == 60)
                  {
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:LobbyIdle:ByTimeAt60:2010-08-31"));
                  }
               }
            }
         }
      }
      
      public function checkLobbyTimerAndDoHitForStat() : void {
         if(this.timerLobbyIdle)
         {
            if(pgData.inLobbyRoom)
            {
               if(this.timerLobbyIdle.currentCount >= 30 && this.timerLobbyIdle.currentCount < 60)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:LobbyIdle:ByClickWith30:2010-08-31"));
               }
               else
               {
                  if(this.timerLobbyIdle.currentCount >= 60)
                  {
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:LobbyIdle:ByClickWith60:2010-08-31"));
                  }
               }
               this.stopLobbyIdleTimer();
               this.startLobbyIdleTimer();
            }
         }
      }
      
      private function onShowLobbyBanner(param1:CommandEvent) : void {
         this.showTabBanner();
      }
      
      public function showTabBanner() : void {
         if(this.plView)
         {
            this.plView.showLobbyBanner();
         }
      }
      
      private function showLobbyBanner(param1:Object) : void {
         if(this._lobbyBannerController == null)
         {
            return;
         }
         var _loc2_:String = param1.type;
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Lobby Other Impression o:LobbyBanner" + _loc2_ + ":2013-01-28"));
         this._lobbyBannerController.showView(_loc2_);
      }
      
      private function hideLobbyBanner(param1:String) : void {
         if(this._lobbyBannerController)
         {
            this._lobbyBannerController.hideView(param1);
         }
      }
      
      public function canBannerAdEnable(param1:String) : Boolean {
         var _loc2_:* = false;
         if(this._lobbyBannerController)
         {
            _loc2_ = this._lobbyBannerController.canAdEnable(param1);
         }
         return _loc2_;
      }
      
      public function initMTT(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void {
         if((this.plView) && (param1))
         {
            this.plView.initMTT(param1 as Sprite);
         }
         if((this._lobbyBannerController) && !(param2 == null))
         {
            this._lobbyBannerController.addView(param2 as LobbyBanner,LobbyBanner.MTT);
            this.showLobbyBanner({"type":LobbyBanner.MTT});
            if(!pgData.enableZPWC)
            {
               this._lobbyBannerController.enableAd(LobbyBanner.MTT);
            }
         }
      }
      
      private function onMTTLobbyBannerAction(param1:LobbyBannerEvent) : void {
         this.onMTTClicked(null);
      }
      
      public function initZPWC(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:DisplayObjectContainer) : void {
         if((this.plView) && (param1) && (param2))
         {
            this.plView.initZPWC(param1 as MovieClip,param2 as MovieClip,param3 as MovieClip);
         }
      }
      
      public function setBackgroundUrl(param1:String) : void {
         this.plView.lobbyBackgroundUrl = param1;
      }
      
      private function onAddViewTolayer(param1:LVEvent) : void {
         this.pControl.attachViewToLayer(param1.oParams.view,param1.oParams.layer,true);
      }
      
      private function onVideoPokerImpression(param1:LVEvent) : void {
         fireStat(new PokerStatHit("VideoPoker",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:VideoPoker:Surfacing:2013-08-19"));
      }
      
      private function onShowVideoPoker(param1:LVEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         if(configModel.isFeatureEnabled("videoPoker"))
         {
            _loc2_ = configModel.getFeatureConfig("videoPoker");
            _loc3_ = pgData.ip.split(":");
            _loc2_.assignedIpAddress = _loc3_[0];
            _loc2_.assignedPort = _loc3_[1];
            _loc2_.isActive = true;
            dispatchCommand(new HideSideNavCommand());
            dispatchCommand(new ShowModuleCommand("VideoPoker",null,null,this.onVideoPokerClose));
            fireStat(new PokerStatHit("VideoPoker",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:VideoPoker:Surfacing:2013-08-19"));
         }
         dispatchCommand(new ShowModuleCommand("VideoPoker",null,null,this.onVideoPokerClose));
      }
      
      private function onVideoPokerClose(param1:ModuleEvent) : void {
         var _loc2_:Object = configModel.getFeatureConfig("videoPoker");
         _loc2_.isActive = false;
         this.pcmConnect.disconnectWithoutReconnect();
         this.pControl.connectToServer();
      }
   }
}
