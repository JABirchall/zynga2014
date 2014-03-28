package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.interfaces.ICardController;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.PokerController;
   import flash.display.MovieClip;
   import com.zynga.User;
   import com.zynga.poker.table.todo.TodoListController;
   import com.zynga.poker.table.chicklet.ChickletController;
   import com.zynga.poker.table.positioning.PlayerPositionController;
   import flash.utils.Timer;
   import com.zynga.poker.popups.modules.tipTheDealer.DealerComment;
   import com.zynga.poker.table.chicklet.rollover.controllers.ProvController;
   import com.zynga.poker.table.betting.BettingControls;
   import flash.utils.Dictionary;
   import com.zynga.poker.table.interfaces.IDealerPuckController;
   import __AS3__.vec.Vector;
   import com.zynga.poker.table.events.TCEvent;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.protocol.*;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.commands.selfcontained.PositionSideNavCommand;
   import com.zynga.poker.commands.navcontroller.ShowLeaderboardSurfacingCommand;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.commands.selfcontained.module.ShowModuleCommand;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.poker.events.GiftPopupEvent;
   import com.zynga.poker.events.PopupEvent;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.commands.navcontroller.ShowXPBoostToasterCommand;
   import com.zynga.poker.constants.TableType;
   import com.zynga.format.BlindFormatter;
   import com.zynga.poker.constants.LiveChromeAchievements;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.table.layouts.ITableLayout;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.table.betting.ExtBettingControls;
   import com.zynga.poker.feature.FeatureModule;
   import com.zynga.poker.feature.FeatureModuleController;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.events.GenericEvent;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.table.chicklet.rollover.controllers.PlayerRolloverController;
   import com.zynga.poker.commands.mtt.MTTGenericCommand;
   import com.zynga.utils.ObjectUtil;
   import com.zynga.poker.events.OutOfChipsDialogPopupEvent;
   import com.zynga.poker.events.TBPopupEvent;
   import com.zynga.poker.events.PokerSoundEvent;
   import com.zynga.poker.commands.selfcontained.sound.SoundEventCommand;
   import com.zynga.poker.UserPreferencesContainer;
   import flash.events.FullScreenEvent;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.table.events.controller.BettingPanelControllerEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import com.zynga.poker.AtTableEraseLossManager;
   import com.zynga.poker.commands.selfcontained.module.HideModuleCommand;
   import com.zynga.poker.commands.js.CloseAllPHPPopupsCommand;
   import com.zynga.poker.events.JSEvent;
   import com.zynga.poker.statistic.ZTrack;
   import com.zynga.poker.minigame.events.MGEvent;
   import com.zynga.poker.minigame.minigameHelper.MinigameUtils;
   import com.zynga.poker.commands.navcontroller.HideLeaderboardSurfacingCommand;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.table.events.view.TVESitPressed;
   import com.zynga.poker.table.constants.TableDisplayMode;
   import com.zynga.poker.events.TourneyBuyInPopupEvent;
   import com.zynga.poker.commands.selfcontained.sound.PlaySoundCommand;
   import com.zynga.poker.table.events.view.TVESendChat;
   import com.zynga.poker.table.events.view.TVEChatNamePressed;
   import com.zynga.poker.UserProfile;
   import com.zynga.poker.events.ErrorPopupEvent;
   import com.zynga.poker.table.shouts.views.ShoutPowerTourneyHappyHourView;
   import com.adobe.serialization.json.JSON;
   import com.zynga.poker.commands.pokercontroller.FireZTrackMilestoneHitCommand;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.UpdateChipsCommand;
   import com.zynga.poker.pokerscore.interfaces.IPokerScoreService;
   import com.zynga.poker.PokerLoadMilestone;
   import com.zynga.poker.events.AtTableEraseLossPopupEvent;
   import com.zynga.poker.events.ShowdownCongratsPopupEvent;
   import com.zynga.poker.events.ShootoutCongratsPopupEvent;
   import com.zynga.poker.events.TourneyCongratsPopupEvent;
   import com.zynga.format.StringUtility;
   import com.zynga.poker.commonUI.asset.BuddyJoinBonus;
   import flash.geom.Point;
   import com.zynga.poker.table.events.view.TVEMuteMod;
   import com.zynga.poker.table.events.view.TVEGiftPressed;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   import flash.events.TimerEvent;
   import com.zynga.poker.table.events.view.TVEPlaySound;
   import com.zynga.poker.table.events.view.TVEJoinUserPressed;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.events.URLEvent;
   import com.zynga.poker.UserPresence;
   import com.zynga.poker.module.ModuleEvent;
   import com.zynga.poker.commands.tablecontroller.UpdateTableCashierCommand;
   import com.zynga.poker.zoom.ZshimModel;
   import com.zynga.poker.zoom.ZshimModelEvent;
   import com.zynga.poker.PokerToolbar;
   import com.zynga.poker.commands.navcontroller.HideLeaderboardFlyoutCommand;
   import com.zynga.poker.table.events.view.TVEChickletMouseEvent;
   import com.zynga.poker.popups.modules.events.ChickletMenuEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.display.Sprite;
   import flash.display.Graphics;
   import com.zynga.poker.protocol.mgfw.SGetSupportedMiniGameTypes;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.commands.navcontroller.InitLuckyHandCommand;
   import com.zynga.poker.commands.navcontroller.InitUnluckyHandCommand;
   import com.zynga.poker.pokerscore.models.PokerScoreModel;
   import com.zynga.poker.commands.navcontroller.ShowPokerScoreSideNavCommand;
   import com.zynga.utils.timers.PokerTimer;
   import com.greensock.TweenLite;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.poker.commands.skiptablescontroller.ShowSkipTablesOverlayCommand;
   
   public class TableController extends FeatureController implements ITableController
   {
      
      public function TableController() {
         super();
      }
      
      public static const HELPING_HANDS_STATE_CELEBRATION:Number = 2;
      
      public var ptModel:TableModel;
      
      public var ptView:TableView;
      
      private var _tableLayoutModel:TableLayoutModel;
      
      private var _cardController:ICardController;
      
      public var pcmConnect:IPokerConnectionManager;
      
      public var pControl:PokerController;
      
      private var mainDisp:MovieClip;
      
      private var viewer:User;
      
      private var _postTableTypeInitFunction:Function;
      
      private var _chatCtrl:ChatController;
      
      private var _invCtrl:InviteController;
      
      private var _todoListController:TodoListController;
      
      private var _dealerChatCtrl:DealerChatController;
      
      private var _chickletCtrl:ChickletController;
      
      private var _seatCtrl:TableSeatController;
      
      private var _chipCtrl:ChipController;
      
      private var _playerPosCtrl:PlayerPositionController;
      
      private var giveChipsTimer:Timer;
      
      public var bGiveChips:Boolean;
      
      public var bStandUp:Boolean;
      
      private var nChatCount:int = 0;
      
      private var isCheckSpectator:Boolean = false;
      
      private var isMutePressed:Boolean = false;
      
      private var startHandSittingIDs:Array;
      
      public var bGiftIconRequestedGiftShop:Boolean = false;
      
      public var sGiftIconRequestZid:String;
      
      private var hasOneHandBeenPlayedAtThisTable:Boolean = false;
      
      private var handsAtThisTable:Number = 0;
      
      private var normalTableHandsCounter:Number = 0;
      
      private var haveBettingControlsArrowsShown:Boolean = false;
      
      private var hasHandStrengthArrowShown:Boolean = false;
      
      private var hasDoneFirstHandMilestone:Boolean = false;
      
      private var showHiLoTestOnFirstFold:Boolean = true;
      
      private var potsCleared:int;
      
      private var potsWinnersSit:Array;
      
      private var dealTimer:Timer;
      
      private var bPass2:Boolean;
      
      public var showInviteFriendsNotificationOnPrivateTableCreation:Boolean = false;
      
      private var isPreFlop:Boolean = true;
      
      private var hasAppliedUserPreferences:Boolean = false;
      
      public var rakeNextHand:Boolean = false;
      
      private var hsmUsedStat:Boolean = false;
      
      private var hsmRakeIncreaseShoutState:int = 0;
      
      private var hsmRakeShoutHandsPlayed:int = 0;
      
      private var chickletClicked:Boolean = false;
      
      private var chickletMenuShowPosX:Number = 0;
      
      private var _showTableAceFTUE:Boolean = true;
      
      private var chickletMenuShowPosY:Number = 0;
      
      public var aAddBuddyAttemptsZids:Array;
      
      public var pointsLostInCurrentHand:Number = 0;
      
      public var blindsLostInCurrentHand:Number = 0;
      
      private var clientHandOverFlag:Boolean = false;
      
      private var commentTimer:Timer;
      
      private var _pokerScoreComment:DealerComment;
      
      public var openGraphData:Object;
      
      private var pyhViewerFolded:Boolean = false;
      
      private var pyhBlindsInCurrentHand:Number = 0;
      
      private var pyhViewerChipsOnTable:Number = 0;
      
      public var tipController:TipDealerController;
      
      public var provCtrl:ProvController;
      
      private var _mttChangeTable:Boolean = false;
      
      private var _bettingControls:BettingControls;
      
      private var _sfxHandlers:Dictionary;
      
      private var _sfxSecondaryHandlers:Dictionary;
      
      private var _completeInitUponSitStructure:Boolean;
      
      private var _inOutOfChipsTableFlow:Boolean;
      
      private var _userHadLuckyHand:Boolean;
      
      private var _luckyHandInMsg:Object;
      
      private var _puckControl:IDealerPuckController;
      
      private var _isBustOut:Boolean = false;
      
      private var _bustOutSit:int;
      
      private var _sfxHandlerQueue:Vector.<Object>;
      
      private var _tableInitialized:Boolean;
      
      private var _isPlayNow:Boolean = false;
      
      private var _joinTableTime:uint;
      
      public function set isPlayNow(param1:Boolean) : void {
         this._isPlayNow = param1;
      }
      
      private var clientHandsEnded:int = 0;
      
      override public function addListeners() : void {
         this.initRegularSfxHandlers();
         addEventListener(TCEvent.USERSINROOM_UPDATED,this.onCheckMuteList);
         addEventListener(TCEvent.USERSINROOM_UPDATED,this.onCheckJoinFriend);
         addEventListener(CommandEvent.TYPE_SHOW_HSM_PROMO,this.onHSMPromoRequest);
         addEventListener(CommandEvent.TYPE_MTT_BLIND_INCREASE,this.onMTTBlindIncrease);
         addEventListener(CommandEvent.TYPE_TABLE_SPOTLIGHT,this.onSpotlightRequest);
         addEventListener(CommandEvent.TYPE_TABLE_CHAT_ENABLE,this.enableChat);
         addEventListener(CommandEvent.TYPE_TABLE_CHICKLET_ENABLE,this.enableChicklet);
         addEventListener(CommandEvent.TYPE_TABLE_CHICKLET_UPDATE_POKER_SCORE,this.updatePokerScoreChicklet);
         addEventListener(CommandEvent.TYPE_TABLE_LEAVE,this.onTableLeaveCommand);
         addEventListener(CommandEvent.TYPE_ADD_LUCKY_HAND_COUPON,this.onAddLuckyHandCoupon);
         addEventListener(CommandEvent.TYPE_TOGGLE_HELPING_HANDS_RAKE,this.onToggleHelpingHandsRake);
         addEventListener(CommandEvent.TYPE_SHOW_HELPING_HANDS_CAMPAIGN_INFO,this.onShowCampaignInfoPopup);
         this.initViewListeners();
      }
      
      override protected function preInit() : void {
         this._tableInitialized = false;
         this.pcmConnect.addEventListener("onMessage",this.onProtocolMessage);
         this.bGiveChips = true;
         this.bStandUp = false;
         this._inOutOfChipsTableFlow = false;
         this.initStageListener();
         this.initPrioritySfxHandlers();
         this._sfxHandlerQueue = new Vector.<Object>();
         this.addDependencies();
      }
      
      override protected function onDependenciesLoaded() : void {
         if(!this.ptModel)
         {
            this._completeInitUponSitStructure = true;
            return;
         }
         this._completeInitUponSitStructure = false;
         super.onDependenciesLoaded();
      }
      
      private function addDependencies() : void {
         var _loc1_:Object = configModel.getFeatureConfig("redesign");
         if(_loc1_)
         {
            if(_loc1_.bettingUI)
            {
               addDependency(Popup.BETTING_UI);
            }
            if(_loc1_.rollover)
            {
               addDependency(Popup.PLAYER_ROLLOVER);
            }
         }
         if(configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            addDependency(Popup.CHICKLET_MENU);
            addDependency(Popup.TABLE_CHICKLET);
            addDependency(Popup.TABLE_SEAT);
         }
         addDependency(Popup.CARD_CONTROLLER);
         addDependency(Popup.DEALER_PUCK);
         addDependency(Popup.TABLE_INVITE);
      }
      
      override protected function postInit() : void {
         var _loc2_:Object = null;
         this.tableViewInitialized();
         dispatchCommand(new PositionSideNavCommand(PositionSideNavCommand.POSITION_TABLE));
         var _loc1_:Boolean = (this.ptModel.tableConfig) && this.ptModel.tableConfig.tourneyId > -1;
         if(!(this.ptModel.room.gameType === "Tournament") && _loc1_ === false)
         {
            dispatchCommand(new ShowLeaderboardSurfacingCommand());
            if(configModel.getBooleanForFeatureConfig("leaderboardAtTable","showTopRight") === true && pgData.xpLevel >= configModel.getIntForFeatureConfig("leaderboard","levelRequirement"))
            {
               this.ptView.initTopRightLeaderboardButton();
            }
         }
         if((pgData.bAutoSitMe) || (pgData.dispMode == "shootout" || pgData.dispMode == "premium") && pgData.rejoinRoom == -1)
         {
            pgData.bAutoSitMe = false;
            this.autoSit();
         }
         else
         {
            if(pgData.bAutoSitMe)
            {
               pgData.bAutoSitMe = false;
               this.autoSit();
            }
         }
         if(this.isFriendPlaying())
         {
            fireStat(new PokerStatHit("joinedafriendtable",0,0,0,PokerStatHit.TRACKHIT_ONCE,"join a friend\'s table","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Table%20Other%20FriendsTable%20o%3ALiveJoin%3A2009-04-17&ltsig=966e292ead49fab7f21044d04a6653f3",1));
         }
         if(pgData.isJoinFriend)
         {
            this.checkFriendStatus();
         }
         this.initializeMinigameAtTable();
         if((this.ptModel.isHHFeatureEnabled()) && !(this.ptModel.room.gameType == "Tournament") && !_loc1_)
         {
            _loc2_ = configModel.getFeatureConfig("helpingHands");
            if(_loc2_.rakeData.campaignState !== HELPING_HANDS_STATE_CELEBRATION)
            {
               this.ptView.initHelpingHandsButton();
               if(userModel.xpLevel >= _loc2_.rakeData.animationMinUserLevel)
               {
                  this.ptView.animateHHButton();
               }
               else
               {
                  this.ptView.stopHHButtonAnimation();
               }
            }
         }
         this.initTodoList();
         this._postTableTypeInitFunction.apply(this);
         this.openGraphData = new Object();
         this._tableInitialized = true;
         if((configModel.isFeatureEnabled("skipTables")) && pgData.dispMode == "challenge")
         {
            dispatchCommand(new ShowModuleCommand("SkipTables",null,null,null));
         }
         if((configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament)
         {
            dispatchCommand(new ShowModuleCommand("DailyChallenge",null,null,null,null,this.pControl.layerManager.getLayer(PokerControllerLayers.MINIGAME_LAYER)));
         }
      }
      
      override protected function alignToParentContainer() : void {
         if(!this.ptView || !_parentContainer)
         {
            return;
         }
         this.ptView.x = 0;
         this.ptView.y = 40;
      }
      
      private function initPrioritySfxHandlers() : void {
         this._sfxHandlers = new Dictionary();
         this._sfxHandlers["RInitGameRoom"] = this.preInitGameRoom;
         this._sfxHandlers["RInitTourney"] = this.preInitTourney;
      }
      
      private function onAddLuckyHandCoupon(param1:CommandEvent) : void {
         var _loc2_:SafeAssetLoader = param1.params as SafeAssetLoader;
         if(_loc2_ != null)
         {
            view.addChild(_loc2_);
         }
      }
      
      private function preInitGameRoom(param1:Object) : void {
         this._postTableTypeInitFunction = this.postGameRoomInit;
         this.createTableModel(param1);
         if(this._completeInitUponSitStructure)
         {
            this.onDependenciesLoaded();
         }
      }
      
      private function preInitTourney(param1:Object) : void {
         this._postTableTypeInitFunction = this.postTourneyInit;
         this.createTableModel(param1);
         this.ptModel.sTourneyMode = (param1 as RInitTourney).tourneyMode;
         this.ptModel.sfxHappyHour = (param1 as RInitTourney).bIsHappyHour;
         if(this._completeInitUponSitStructure)
         {
            this.onDependenciesLoaded();
         }
      }
      
      private function initRegularSfxHandlers() : void {
         this._sfxSecondaryHandlers = new Dictionary();
         this._sfxSecondaryHandlers["RTableAceUpdate"] = this.onTableAceUpdate;
         this._sfxSecondaryHandlers["RDealHoles"] = this.onDealHoles;
         this._sfxSecondaryHandlers["RSitJoined"] = this.onSitJoined;
         this._sfxSecondaryHandlers["RJoinRoom"] = this.onJoinRoom;
         this._sfxSecondaryHandlers["RSitTaken"] = this.onSitTaken;
         this._sfxSecondaryHandlers["RSpecStructure"] = this.onSpecStructure;
         this._sfxSecondaryHandlers["RSpecJoined"] = this.onSpecJoined;
         this._sfxSecondaryHandlers["RUserLost"] = this.onUserLost;
         this._sfxSecondaryHandlers["RUserSitOut"] = this.onUserSitOut;
         this._sfxSecondaryHandlers["RBustOutMonetization"] = this.onBustOutMonetization;
         this._sfxSecondaryHandlers["RTurnChanged"] = this.onTurnChanged;
         this._sfxSecondaryHandlers["RPostBlind"] = this.onPostBlind;
         this._sfxSecondaryHandlers["RMarkTurn"] = this.onMarkTurn;
         this._sfxSecondaryHandlers["RReplayHoles"] = this.onReplayHoles;
         this._sfxSecondaryHandlers["RFold"] = this.onFold;
         this._sfxSecondaryHandlers["RTourneyOver"] = this.onTourneyOver;
         this._sfxSecondaryHandlers["RCall"] = this.onCall;
         this._sfxSecondaryHandlers["RAllin"] = this.onAllin;
         this._sfxSecondaryHandlers["RRaise"] = this.onRaise;
         this._sfxSecondaryHandlers["RRaiseOption"] = this.onRaiseOption;
         this._sfxSecondaryHandlers["RCallOption"] = this.onCallOption;
         this._sfxSecondaryHandlers["RReplayCards"] = this.onReplayCards;
         this._sfxSecondaryHandlers["RFlop"] = this.onFlop;
         this._sfxSecondaryHandlers["RStreet"] = this.onStreet;
         this._sfxSecondaryHandlers["RRiver"] = this.onRiver;
         this._sfxSecondaryHandlers["RClear"] = this.onClear;
         this._sfxSecondaryHandlers["RWinners"] = this.onWinners;
         this._sfxSecondaryHandlers["RDefaultWinners"] = this.onDefaultWinners;
         this._sfxSecondaryHandlers["RAllinWar"] = this.onAllinWar;
         this._sfxSecondaryHandlers["RReplayPots"] = this.onReplayPots;
         this._sfxSecondaryHandlers["RReplayPlayers"] = this.onReplayPlayers;
         this._sfxSecondaryHandlers["RMakePot"] = this.onMakePot;
         this._sfxSecondaryHandlers["RReceiveChat"] = this.onReceiveChat;
         this._sfxSecondaryHandlers["RGetUsersInRoom"] = this.onGetUsersInRoom;
         this._sfxSecondaryHandlers["RUpdateChips"] = this.onUpdateChips;
         this._sfxSecondaryHandlers["RBoughtGift2"] = this.onBoughtGift2;
         this._sfxSecondaryHandlers["RDealerTipped"] = this.onDealerTipped;
         this._sfxSecondaryHandlers["RDealerTipTooExpensive"] = this.onDealerTipTooExpensive;
         this._sfxSecondaryHandlers["RUserGifts"] = this.onUserGifts;
         this._sfxSecondaryHandlers["RUserGifts2"] = this.onUserGifts2;
         this._sfxSecondaryHandlers["RGiftShown2"] = this.onGiftShown2;
         this._sfxSecondaryHandlers["RBuddyRequest"] = this.onBuddyRequest;
         this._sfxSecondaryHandlers["RNewBuddy"] = this.onNewBuddy;
         this._sfxSecondaryHandlers["RCardOptions"] = this.onCardOptions;
         this._sfxSecondaryHandlers["RSendGiftChips"] = this.onSendGiftChips;
         this._sfxSecondaryHandlers["RRefillPoints"] = this.onRefillPoints;
         this._sfxSecondaryHandlers["RGoToLobby"] = this.onGoToLobby;
         this._sfxSecondaryHandlers["RBuyIn"] = this.onBuyIn;
         this._sfxSecondaryHandlers["RBlindChange"] = this.onBlindChange;
         this._sfxSecondaryHandlers["RPointsUpdate"] = this.onPointsUpdate;
         this._sfxSecondaryHandlers["RUpdatePendingChips"] = this.onPointsPending;
         this._sfxSecondaryHandlers["RAchieved"] = this.onAchieved;
         this._sfxSecondaryHandlers["RShootoutBuyinChanged"] = this.onShootoutBuyinChanged;
         this._sfxSecondaryHandlers["RShootoutConfigChanged"] = this.onShootoutConfigChanged;
         this._sfxSecondaryHandlers["RPlayerBounced"] = this.onPlayerBounced;
         this._sfxSecondaryHandlers["RRoundChanged"] = this.onRoundChanged;
         this._sfxSecondaryHandlers["RSitPermissionRefused"] = this.onSitPermissionRefused;
         this._sfxSecondaryHandlers["RShowAllHoles"] = this.onShowAllHoles;
         this._sfxSecondaryHandlers["RAlreadyPlayingShootout"] = this.onAlreadyPlayingShootout;
         this._sfxSecondaryHandlers["RGiftPrices3"] = this.onGiftPrices;
         this._sfxSecondaryHandlers["RXPEarned"] = this.onXPEarned;
         this._sfxSecondaryHandlers["RUserLevelledUp"] = this.onUserLevelledUp;
         this._sfxSecondaryHandlers["RUserUnderUP"] = this.onUserUnderUP;
         this._sfxSecondaryHandlers["RAutoChips"] = this.onAutoChips;
         this._sfxSecondaryHandlers["REnterLuckyHandCouponTimestamp"] = this.onEnterLuckyHandCouponTimestamp;
         this._sfxSecondaryHandlers["REnterUnluckyHandCouponTimestamp"] = this.onEnterUnluckyHandCouponTimestamp;
         this._sfxSecondaryHandlers["RUpdatePendingChips"] = this.onUpdatePendingChips;
         this._sfxSecondaryHandlers["RPlayersClubUpdate"] = this.onPlayersClubUpdate;
         this._sfxSecondaryHandlers["RHelpingHandsUserContributionUpdate"] = this.onHelpingHandsUserContributionUpdate;
      }
      
      private function onGiftPrices(param1:Object) : void {
         if(this.bGiftIconRequestedGiftShop)
         {
            dispatchEvent(new GiftPopupEvent("showDrinkMenu",-1,[],this.sGiftIconRequestZid) as PopupEvent);
         }
         this.bGiftIconRequestedGiftShop = false;
      }
      
      private function repeatStatBasedOnServer(param1:PokerStatHit) : void {
         var _loc3_:* = 0;
         var _loc4_:PokerStatHit = null;
         var _loc2_:* = "";
         _loc2_.split(",");
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.server_list_stat) && this.ptModel.tableConfig.server_list_stat.length > 0)
         {
            _loc3_ = this.ptModel.tableConfig.server_list_stat.indexOf(pgData.serverId);
            if(_loc3_ > -1)
            {
               _loc4_ = param1.clone();
               _loc4_.option = "svr:" + pgData.serverId;
               fireStat(_loc4_);
            }
         }
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         var _loc3_:String = _loc2_.type;
         if((this._sfxHandlers) && (this._sfxHandlers[_loc3_]))
         {
            (this._sfxHandlers[_loc3_] as Function).call(this,_loc2_);
         }
         else
         {
            if(this._tableInitialized == false)
            {
               this._sfxHandlerQueue.push(_loc2_);
            }
            else
            {
               this.handleQueuedSfxMessages();
               this.trySfxInvoke(_loc3_,_loc2_);
            }
         }
      }
      
      private function handleQueuedSfxMessages() : void {
         var _loc2_:Object = null;
         var _loc1_:* = true;
         while(this._sfxHandlerQueue.length > 0)
         {
            _loc2_ = this._sfxHandlerQueue.shift();
            _loc1_ = this.trySfxInvoke(_loc2_.type,_loc2_);
         }
      }
      
      private function trySfxInvoke(param1:String, param2:Object) : Boolean {
         if((this._sfxSecondaryHandlers) && (this._sfxSecondaryHandlers[param1]))
         {
            (this._sfxSecondaryHandlers[param1] as Function).call(this,param2);
            return true;
         }
         return false;
      }
      
      override protected function initModel() : FeatureModel {
         this.initTableModel();
         return this.ptModel;
      }
      
      override protected function initView() : FeatureView {
         this.initTableView();
         return this.ptView;
      }
      
      private function initTableModel() : void {
         var _loc2_:String = null;
         this.clearPotsTrackers();
         var _loc1_:RoomItem = pgData.getRoomById(pgData.gameRoomId);
         if(_loc1_)
         {
            this.trackTableInfoOnJoin(this.ptModel.aUsers.length,_loc1_);
            if((configModel.isFeatureEnabled("xPBoostWithPurchase")) && pgData.dailyAppEntryCount == 1)
            {
               dispatchCommand(new ShowXPBoostToasterCommand());
            }
         }
         this.hasOneHandBeenPlayedAtThisTable = false;
         if(_loc1_)
         {
            this.ptModel.room = _loc1_;
            this.ptModel.initModel();
            this.ptModel.bTableSoundMute = pgData.bTableSoundMute;
            this.ptModel.nSitinChips = pgData.points;
            this.ptModel.fgID = (this.ptModel.userConfig) && (this.ptModel.userConfig.fg)?this.ptModel.userConfig.fg:0;
            _loc2_ = "";
            if(_loc1_.type == TableType.FAST)
            {
               _loc2_ = BlindFormatter.formatBlinds(this.ptModel.nSmallblind,this.ptModel.nBigblind,"Fast");
               if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && (externalInterface.available) && !pgData.hasPlayedFastTable)
               {
                  externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.FAST_AND_THE_CURIOUS_ID);
                  pgData.hasPlayedFastTable = true;
               }
            }
            else
            {
               _loc2_ = BlindFormatter.formatBlinds(this.ptModel.nSmallblind,this.ptModel.nBigblind);
            }
            this.pControl.zoomUpdateStakes(_loc2_);
            if(externalInterface.available)
            {
               externalInterface.addCallback("showZPWCShout",this.showZPWCShout);
            }
            if(!this.ptModel.isTournament && !pgData.mttZone && this.ptModel.nMinBuyIn > pgData.points && (configModel.isFeatureEnabled("oOCTableFlow")) && !this.isSeated(pgData.zid))
            {
               this._inOutOfChipsTableFlow = true;
            }
            if(configModel.isFeatureEnabled("dailyChallenge"))
            {
               configModel.getFeatureConfig("dailyChallenge").isTournament = this.ptModel.isTournament;
            }
         }
         this.ptModel.playerPosModel = registry.getObject(PlayerPositionModel);
      }
      
      private function initTableView() : void {
         var bettingUI:Boolean = false;
         var layout:ITableLayout = null;
         var popupController:IPopupController = null;
         var popup:Popup = null;
         var tableConfig:Object = null;
         var rollover:Boolean = false;
         var tipTheDealerConfig:Object = null;
         var strace:String = null;
         try
         {
            bettingUI = configModel.getBooleanForFeatureConfig("redesign","bettingUI");
            if(this.ptView == null || (pgData.mttZone))
            {
               this.ptView = new TableView();
               if(bettingUI)
               {
                  this._bettingControls = registry.getObject(ExtBettingControls);
                  pgData.disableChipsAndGold = true;
               }
               else
               {
                  this._bettingControls = registry.getObject(BettingControls);
               }
               (this._bettingControls as FeatureController).init(this.ptView.bettingPanelContainer);
            }
            this.ptModel.nZoomFriends = this.ptModel.configModel.getIntForFeatureConfig("zoom","nZoomFriends");
            this.ptModel.didLoadChallenges = pgData.bDidGetInitialChallengeState;
            this._bettingControls.tableModel = this.ptModel;
            if(bettingUI)
            {
               this.ptView.muterButton = (this._bettingControls as ExtBettingControls).getMuteButton();
            }
            this.ptView.ptModel = this.ptModel;
            this.ptView.init(this.ptModel);
            this.ptView.updatePopupNextHand(this.ptModel.enableBetControlAds());
            this._playerPosCtrl = registry.getObject(PlayerPositionController);
            this._playerPosCtrl.init(this.ptView);
            layout = this._tableLayoutModel.getTableLayout(this.ptModel.room.gameType,this.ptModel.room.maxPlayers);
            this.ptModel.tableLayout = layout;
            popupController = registry.getObject(IPopupController);
            popup = popupController.getPopupConfigByID(Popup.DEALER_PUCK);
            this._puckControl = registry.getObject((popup.module as FeatureModule).getControllerClass());
            (this._puckControl as FeatureModuleController).init(this.ptView);
            this._chickletCtrl = registry.getObject(ChickletController);
            this._chickletCtrl.init(this.ptView);
            this._chickletCtrl.addEventListener(TVEvent.TABLE_ACE_PRESSED,this.onTableAcePressed,false,0,true);
            this._chickletCtrl.addEventListener(TVEvent.CHICKLET_LEFT,this.onChickletLeave,false,0,true);
            this.setDealer(this.ptModel.nDealerSit);
            this._seatCtrl = registry.getObject(TableSeatController);
            this._seatCtrl.init(this.ptView);
            this.checkViewerSeated();
            popup = popupController.getPopupConfigByID(Popup.CARD_CONTROLLER);
            this._cardController = registry.getObject((popup.module as FeatureModule).getControllerClass());
            (this._cardController as FeatureModuleController).init(this.ptView);
            (this._cardController as FeatureModuleController).addEventListener(GenericEvent.RUN_HSM_HANDS_EVENT,this._bettingControls.runPossibleHandsHSM,false,0,true);
            this._cardController.initCards(layout.getCardLayout());
            this._chipCtrl = registry.getObject(ChipController);
            this._chipCtrl.init(this.ptView);
            if(bettingUI)
            {
               this._invCtrl = new InviteController(this.ptView,this.ptView.invCont,469,512);
            }
            else
            {
               this._invCtrl = new InviteController(this.ptView,this.ptView.invCont);
            }
            this._chatCtrl = new ChatController(this.ptModel,this.ptView.chatCont);
            this._chatCtrl.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
            this._dealerChatCtrl = new DealerChatController(this.ptModel,this.ptView.chatCont);
            this._dealerChatCtrl.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
            this.ptView.bubbleContainer(this.ptView.chatCont);
            this.ptView.bubbleContainer(this.ptView.bettingPanelContainer);
            tableConfig = this.ptModel.tableConfig;
            if((tableConfig.tableChatZyngaCustomMessage) && !(this.ptModel.pgData.dispMode == "premium"))
            {
               this._chatCtrl.displayZyngaCustomMessage(tableConfig.tableChatZyngaCustomMessage);
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:TableChat_ZyngaCustomMessage:2011-02-24"));
            }
            if(this.ptModel.pgData.dispMode == "premium")
            {
               this._chatCtrl.displayZyngaCustomMessage(LocaleManager.localize("flash.table.chat.powerTourneyPleaseWait"));
            }
            rollover = configModel.getBooleanForFeatureConfig("redesign","rollover");
            if(rollover)
            {
               this.provCtrl = registry.getObject(PlayerRolloverController);
            }
            else
            {
               this.provCtrl = registry.getObject(ProvController);
            }
            this.provCtrl.init(this.ptView);
            if(pgData.mttZone)
            {
               commandDispatcher.dispatchCommand(new MTTGenericCommand(CommandEvent.TYPE_MTT_REQUEST_BLINDS));
            }
            this.displayTable();
            tipTheDealerConfig = this.ptModel.tipTheDealerConfig;
            if(tipTheDealerConfig != null)
            {
               this.tipController = new TipDealerController(this.ptView,tipTheDealerConfig.tipMessageArea,tipTheDealerConfig.tipAmountSmallBlind);
               this.tipController.addEventListener(TVEvent.ON_TIP_DEALER_CLICK,this.onTipDealerClick,false,0,true);
               if(configModel.isFeatureEnabled("scoreCard"))
               {
                  this.initializePokerScoreComment();
               }
            }
            if(!pgData.mttZone)
            {
               this.getPollQuestion();
            }
            if((this.ptModel.tableConfig) && this.ptModel.tableConfig.tourneyId > -1)
            {
               this.ptView.joinButton.visible = false;
            }
            if(this.ptModel.configModel.getIntForFeatureConfig("zoom","connectToZoom",1) == 1)
            {
               this.onZoomUpdate();
            }
            if(this._inOutOfChipsTableFlow)
            {
               this.startOutOfChipsDialog();
            }
         }
         catch(e:Error)
         {
            externalInterface.call("ZY.App.f.phone_home","initTableView error: " + e.message);
            strace = e.getStackTrace();
            if(strace != null)
            {
               externalInterface.call("ZY.App.f.phone_home","initTableView stacktrace: " + strace);
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:Loader:InitTableViewError:2011-05-22",null,1));
            throw e;
         }
         return;
         if(this.ptView == null || (pgData.mttZone))
         {
            this.ptView = new TableView();
            if(bettingUI)
            {
               this._bettingControls = registry.getObject(ExtBettingControls);
               pgData.disableChipsAndGold = true;
            }
            else
            {
               this._bettingControls = registry.getObject(BettingControls);
            }
            (this._bettingControls as FeatureController).init(this.ptView.bettingPanelContainer);
         }
         this.ptModel.nZoomFriends = this.ptModel.configModel.getIntForFeatureConfig("zoom","nZoomFriends");
         this.ptModel.didLoadChallenges = pgData.bDidGetInitialChallengeState;
         this._bettingControls.tableModel = this.ptModel;
         if(bettingUI)
         {
            this.ptView.muterButton = (this._bettingControls as ExtBettingControls).getMuteButton();
         }
         this.ptView.ptModel = this.ptModel;
         this.ptView.init(this.ptModel);
         this.ptView.updatePopupNextHand(this.ptModel.enableBetControlAds());
         this._playerPosCtrl = registry.getObject(PlayerPositionController);
         this._playerPosCtrl.init(this.ptView);
         layout = this._tableLayoutModel.getTableLayout(this.ptModel.room.gameType,this.ptModel.room.maxPlayers);
         this.ptModel.tableLayout = layout;
         popupController = registry.getObject(IPopupController);
         popup = popupController.getPopupConfigByID(Popup.DEALER_PUCK);
         this._puckControl = registry.getObject((popup.module as FeatureModule).getControllerClass());
         (this._puckControl as FeatureModuleController).init(this.ptView);
         this._chickletCtrl = registry.getObject(ChickletController);
         this._chickletCtrl.init(this.ptView);
         this._chickletCtrl.addEventListener(TVEvent.TABLE_ACE_PRESSED,this.onTableAcePressed,false,0,true);
         this._chickletCtrl.addEventListener(TVEvent.CHICKLET_LEFT,this.onChickletLeave,false,0,true);
         this.setDealer(this.ptModel.nDealerSit);
         this._seatCtrl = registry.getObject(TableSeatController);
         this._seatCtrl.init(this.ptView);
         this.checkViewerSeated();
         popup = popupController.getPopupConfigByID(Popup.CARD_CONTROLLER);
         this._cardController = registry.getObject((popup.module as FeatureModule).getControllerClass());
         (this._cardController as FeatureModuleController).init(this.ptView);
         (this._cardController as FeatureModuleController).addEventListener(GenericEvent.RUN_HSM_HANDS_EVENT,this._bettingControls.runPossibleHandsHSM,false,0,true);
         this._cardController.initCards(layout.getCardLayout());
         this._chipCtrl = registry.getObject(ChipController);
         this._chipCtrl.init(this.ptView);
         if(bettingUI)
         {
            this._invCtrl = new InviteController(this.ptView,this.ptView.invCont,469,512);
         }
         else
         {
            this._invCtrl = new InviteController(this.ptView,this.ptView.invCont);
         }
         this._chatCtrl = new ChatController(this.ptModel,this.ptView.chatCont);
         this._chatCtrl.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this._dealerChatCtrl = new DealerChatController(this.ptModel,this.ptView.chatCont);
         this._dealerChatCtrl.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.ptView.bubbleContainer(this.ptView.chatCont);
         this.ptView.bubbleContainer(this.ptView.bettingPanelContainer);
         tableConfig = this.ptModel.tableConfig;
         if((tableConfig.tableChatZyngaCustomMessage) && !(this.ptModel.pgData.dispMode == "premium"))
         {
            this._chatCtrl.displayZyngaCustomMessage(tableConfig.tableChatZyngaCustomMessage);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:TableChat_ZyngaCustomMessage:2011-02-24"));
         }
         if(this.ptModel.pgData.dispMode == "premium")
         {
            this._chatCtrl.displayZyngaCustomMessage(LocaleManager.localize("flash.table.chat.powerTourneyPleaseWait"));
         }
         rollover = configModel.getBooleanForFeatureConfig("redesign","rollover");
         if(rollover)
         {
            this.provCtrl = registry.getObject(PlayerRolloverController);
         }
         else
         {
            this.provCtrl = registry.getObject(ProvController);
         }
         this.provCtrl.init(this.ptView);
         if(pgData.mttZone)
         {
            commandDispatcher.dispatchCommand(new MTTGenericCommand(CommandEvent.TYPE_MTT_REQUEST_BLINDS));
         }
         this.displayTable();
         tipTheDealerConfig = this.ptModel.tipTheDealerConfig;
         if(tipTheDealerConfig != null)
         {
            this.tipController = new TipDealerController(this.ptView,tipTheDealerConfig.tipMessageArea,tipTheDealerConfig.tipAmountSmallBlind);
            this.tipController.addEventListener(TVEvent.ON_TIP_DEALER_CLICK,this.onTipDealerClick,false,0,true);
            if(configModel.isFeatureEnabled("scoreCard"))
            {
               this.initializePokerScoreComment();
            }
         }
         if(!pgData.mttZone)
         {
            this.getPollQuestion();
         }
         if((this.ptModel.tableConfig) && this.ptModel.tableConfig.tourneyId > -1)
         {
            this.ptView.joinButton.visible = false;
         }
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","connectToZoom",1) == 1)
         {
            this.onZoomUpdate();
         }
         if(this._inOutOfChipsTableFlow)
         {
            this.startOutOfChipsDialog();
         }
      }
      
      private function initTodoList() : void {
         this._todoListController = registry.getObject(TodoListController);
         this._todoListController.init(this.ptView);
      }
      
      private function startOutOfChipsDialog() : void {
         externalInterface.addCallback("onOOCGetPricePointsResp",this.onOutOfChipsGetPricePointsResponse);
         externalInterface.call("zc.feature.payments.ooctableflow.getPricePoints",this.ptModel.nMinBuyIn,this.ptModel.nMaxBuyIn);
      }
      
      private function onOutOfChipsGetPricePointsResponse(param1:Object) : void {
         var _loc2_:Array = null;
         if(!param1)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = ObjectUtil.maybeGetArray(param1,"pricePoints",[]);
         }
         if((_loc2_) && (_loc2_.length))
         {
            dispatchEvent(new OutOfChipsDialogPopupEvent("showOutOfChipsDialog",_loc2_,this.ptModel.nMinBuyIn,this.ptModel.nMaxBuyIn,this.ptModel.room.id));
         }
         else
         {
            dispatchEvent(new TBPopupEvent("showTableBuyIn",0,false,this.ptModel.postToPlayFlag,this.checkForValidRatholeState()));
         }
      }
      
      public function enableProtocol() : void {
         this.pcmConnect.addEventListener("onMessage",this.onProtocolMessage);
      }
      
      public function disableProtocol() : void {
         this.pcmConnect.removeEventListener("onMessage",this.onProtocolMessage);
      }
      
      public function autoSit(param1:Number=0) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:SSitShootout = null;
         var _loc6_:SSitNGo = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:SSit = null;
         if(configModel.getBooleanForFeatureConfig("scoreCard","showFTUE"))
         {
            externalInterface.call("zc.feature.scoreCard.incFTUECount");
         }
         if(pgData.joiningShootout)
         {
            pgData.joiningShootout = false;
            return;
         }
         if(pgData.dispMode == "shootout" || pgData.dispMode == "premium")
         {
            param1 = this.pControl.soConfig.nBuyin;
            _loc2_ = pgData.bIsFastRR?pgData.forcedSeat:-1;
            _loc3_ = pgData.bIsFastRR?pgData.assignedChips:param1;
            _loc4_ = pgData.soUser.nRound;
            _loc5_ = new SSitShootout("SSitShootout",param1,_loc2_,_loc4_,pgData.bIsFastRR,_loc3_,pgData.requiredSmallBlind);
            pgData.bIsFastRR = false;
            this.pcmConnect.sendMessage(_loc5_);
         }
         else
         {
            if(pgData.dispMode == "tournament")
            {
               _loc2_ = pgData.bIsFastRR?pgData.forcedSeat:-1;
               _loc3_ = pgData.bIsFastRR?pgData.assignedChips:param1;
               _loc6_ = new SSitNGo("SSitNGo",param1,_loc2_,pgData.bIsFastRR,_loc3_,pgData.requiredSmallBlind);
               pgData.bIsFastRR = false;
               this.pcmConnect.sendMessage(_loc6_);
            }
            else
            {
               if(!param1)
               {
                  param1 = Math.round(pgData.points / 5);
               }
               if(this.ptModel.nBigblind * 10 > param1 && this.ptModel.nMaxBuyIn <= pgData.points)
               {
                  param1 = this.ptModel.nBigblind * 10;
               }
               else
               {
                  if(this.ptModel.nMaxBuyIn < param1)
                  {
                     param1 = this.ptModel.nMaxBuyIn;
                  }
                  else
                  {
                     if(this.ptModel.nBigblind * 10 > param1 && this.ptModel.nMaxBuyIn > pgData.points)
                     {
                        param1 = this.ptModel.nBigblind * 10;
                     }
                  }
               }
               if(pgData.bIsFastRR)
               {
                  param1 = pgData.assignedChips;
               }
               pgData.rakeEnabled = (this.rakeNextHand) && (this.ptModel.isHsmEnabled())?1:0;
               _loc7_ = 0;
               _loc8_ = 0;
               _loc7_ = int(pgData.arbAutoRebuySelected);
               _loc8_ = int(pgData.arbTopUpStackSelected);
               _loc9_ = new SSit("SSit",param1,-1,this.ptModel.postToPlayFlag,this.ptModel.hsmIsFree?0:pgData.rakeEnabled,_loc7_,_loc8_,int(this._bettingControls.hsmActivated),pgData.bIsFastRR);
               pgData.bIsFastRR = false;
               pgData.assignedChips = 0;
               if(pgData.assignedSeat)
               {
                  _loc9_.sitId = pgData.assignedSeat;
               }
               this.showHSMPromo();
               this.pcmConnect.sendMessage(_loc9_);
            }
         }
      }
      
      public function applyUserPreferences() : void {
         if(this.hasAppliedUserPreferences)
         {
            return;
         }
         pgData.bTableSoundMute = pgData.userPreferencesContainer.tableIsMuted == "0"?false:true;
         this.ptModel.bTableSoundMute = pgData.bTableSoundMute;
         this.ptView.onSoundMutePressed();
         var _loc1_:PokerSoundEvent = new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_MUTE_GROUP,pgData.bTableSoundMute);
         dispatchCommand(new SoundEventCommand(_loc1_));
         pgData.rakeEnabled = int(pgData.userPreferencesContainer.HSM);
         this.rakeNextHand = pgData.rakeEnabled == 1;
         this.hasAppliedUserPreferences = true;
      }
      
      public function commitUserPreferences() : void {
         pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.TABLE_IS_MUTED,String(pgData.bTableSoundMute == true?1:0));
         this.pControl.commitUserPreferences();
      }
      
      public function updateJoinButtonSelected(param1:Boolean) : void {
         if(this.ptView != null)
         {
            this.ptView.setJoinButtonSelected(param1);
         }
      }
      
      private function onStageFullScreenChanged(param1:FullScreenEvent) : void {
         if(param1.fullScreen)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:FullScreenEnable:2011-11-15"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:FullScreenDisable:2011-11-15"));
         }
         if((pgData.rakeFullScreenMode) && !this.rakeNextHand)
         {
            if(param1.fullScreen)
            {
               this.pcmConnect.sendMessage(new SRakeEnable("SRakeEnable","fullscreen"));
            }
            else
            {
               this.pcmConnect.sendMessage(new SRakeDisable("SRakeDisable","fullscreen"));
            }
         }
         if(param1.fullScreen)
         {
            this.ptView.stage.focus = null;
         }
      }
      
      private function initStageListener() : void {
         PokerStageManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onStageFullScreenChanged);
      }
      
      private function initViewListeners() : void {
         if(this.ptView.hasEventListener(TVEvent.LEAVE_TABLE))
         {
            return;
         }
         this.ptView.addEventListener(TVEvent.TABLE_PRESSED,this.onTablePressed);
         this.ptView.addEventListener(TVEvent.LEAVE_TABLE,this.onLeaveTable);
         this.ptView.addEventListener(TVEvent.STAND_UP,this.onStandUp);
         this.ptView.addEventListener(TVEvent.SIT_PRESSED,this.onSitPressed);
         this.ptView.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.ptView.addEventListener(TVEvent.INVITE_PRESSED,this.onInvitePressed);
         this.ptView.addEventListener(TVEvent.TOGGLE_MUTE_SOUND,this.onToggleMuteSoundPressed);
         this.ptView.addEventListener(TVEvent.JOIN_USER_PRESSED,this.onJoinUserPressed);
         this.ptView.addEventListener(TVEvent.FRIEND_NET_PRESSED,this.onFriendNetworkPressed);
         this.ptView.addEventListener(TVEvent.EMPTY_GIFT_PRESSED,this.onEmptyGiftPressed);
         this.ptView.addEventListener(TVEvent.GIFT_PRESSED,this.onGiftPressed);
         this.ptView.addEventListener(TVEvent.ON_TABLE_CLEANUP,this.cleanupTable);
         this.ptView.addEventListener(TVEvent.PLAY_SOUND_ONCE,this.onPlaySoundOnce);
         this.ptView.addEventListener(TVEvent.ON_POST_TO_PLAY_CHANGE,this.onPostToPlayChange);
         this.ptView.addEventListener(TVEvent.POLL_CLOSE,this.onPollClose);
         this.ptView.addEventListener(TVEvent.POLL_YES,this.onPollYes);
         this.ptView.addEventListener(TVEvent.POLL_NO,this.onPollNo);
         this.ptView.addEventListener(TVEvent.ON_BUY_CHIPS_CLICK,this.onBuyChipsClick);
         this.ptView.addEventListener(TVEvent.ON_HILO_REDIRECT_CLICK,this.onHiloRedirectClick);
         this.ptView.addEventListener(TVEvent.POKER_SCORE_PRESSED,this.onClickPokerScore);
         this.ptView.addEventListener(TVEvent.ON_HELPING_HANDS_CLICK,this.onHelpingHandsClick);
         this.ptView.addEventListener(TVEvent.ON_HELPING_HANDS_HOVER,this.onHelpingHandsHover);
         this.ptView.addEventListener(TVEvent.ON_HELPING_HANDS_MOUSE_OUT,this.onHelpingHandsMouseOut);
         this.ptView.addEventListener(TVEvent.SHOW_LEADERBOARD,this.onShowLeaderboard);
         if(this.ptModel.hsmFreeUsage)
         {
            this.ptView.addEventListener(TVEvent.HSM_FREEUSE_PROMO_INVITE_PRESSED,this.onHSMFreeUsePromoInvitePressed);
         }
         this.initZoomModelListeners();
         if(!this._inOutOfChipsTableFlow)
         {
            this.initChickletMenuEventListeners();
         }
         this.ptView.addEventListener(TVEvent.ON_TABLE_AD_BUTTON_CLICK,this.onTableAdButtonClick);
         this.ptView.addEventListener(TVEvent.ON_SHOW_MINIGAME_HIGHLOW,this.onShowMinigameHighLow);
         this.ptView.addEventListener(TVEvent.ON_HIDE_MINIGAME_HIGHLOW,this.onHideMinigameHighLow);
         this.ptView.addEventListener(TVEvent.SHOW_DAILYCHALLENGE,this.onShowDailyChallenge,false,0,true);
         this.ptView.addEventListener(TVEvent.HIDE_DAILYCHALLENGE,this.onHideDailyChallenge,false,0,true);
         this.ptView.addEventListener(TVEvent.ON_REPOSITION_CHICKLETS_START,this.onRepositionChickletsStart,false,0,true);
         this.ptView.addEventListener(TVEvent.ON_REPOSITION_CHICKLETS_COMPLETE,this.onRepositionChickletsComplete,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_BET_POT,this.onBetPotPressed,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_BET_HALF_POT,this.onBetHalfPotPressed,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_BOT_DETECTED_BY_FOLD_POS,this.onTCont_BotDetectedByFoldPos,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_CALL,this.onCallPressed,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_FOLD,this.onFoldPressed,false,0,true);
         this._bettingControls.addEventListener(BettingPanelControllerEvent.TYPE_RAISE,this.onRaisePressed,false,0,true);
         this._bettingControls.addEventListener(TVEvent.HAND_STRENGTH_PRESSED,this.onHandStrengthPressed,false,0,true);
         this._bettingControls.addEventListener(this._bettingControls.TOGGLE_MUTE_SOUND,this.onToggleMuteSoundPressed,false,0,true);
         if(!this._inOutOfChipsTableFlow)
         {
            this.initChatCtrlListeners();
         }
         else
         {
            this._chatCtrl.readOnly = true;
         }
         this._dealerChatCtrl.addEventListener(TVEvent.ON_HILO_REDIRECT_CLICK,this.onHiloRedirectClick);
         if(pgData.jumpTablesEnabled)
         {
            this.ptView.addEventListener(TVEvent.ON_START_JUMP_TABLE_SEARCH,this.onStartJumpTableSearch,false,0,true);
            this.ptView.addEventListener(TVEvent.ON_CANCEL_JUMP_TABLE_SEARCH,this.onCancelJumpTableSearch,false,0,true);
            this.ptView.addEventListener(TVEvent.ON_JUMP_TABLE_BUTTON_SHOWN,this.onJumpTableButtonShown,false,0,true);
         }
         if(configModel.isFeatureEnabled("skipTables"))
         {
            this.ptView.addEventListener(TVEvent.SKIP_TABLE_OVERLAY,this.onSkipTableOverlay,false,0,true);
            this.ptView.addEventListener(TVEvent.SKIP_TABLE_CLEAR_OVERLAY,this.onSkipTableClearOverlay,false,0,true);
         }
      }
      
      private function initChatCtrlListeners() : void {
         this._chatCtrl.addEventListener(TVEvent.MUTE_MOD,this.onMuteMod);
         this._chatCtrl.addEventListener(TVEvent.MUTE_PRESSED,this.onMutePressed);
         this._chatCtrl.addEventListener(TVEvent.SEND_CHAT,this.onSendChat);
      }
      
      private function removeViewListeners() : void {
         this._bettingControls.removeEventListener(TVEvent.HAND_STRENGTH_PRESSED,this.onHandStrengthPressed);
         this._bettingControls.removeEventListener(this._bettingControls.TOGGLE_MUTE_SOUND,this.onToggleMuteSoundPressed);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_BET_POT,this.onBetPotPressed);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_BET_HALF_POT,this.onBetHalfPotPressed);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_BOT_DETECTED_BY_FOLD_POS,this.onTCont_BotDetectedByFoldPos);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_CALL,this.onCallPressed);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_FOLD,this.onFoldPressed);
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_RAISE,this.onRaisePressed);
         this.ptView.removeEventListener(TVEvent.LEAVE_TABLE,this.onLeaveTable);
         this.ptView.removeEventListener(TVEvent.STAND_UP,this.onStandUp);
         this.ptView.removeEventListener(TVEvent.SIT_PRESSED,this.onSitPressed);
         this.ptView.removeEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.ptView.removeEventListener(TVEvent.MUTE_MOD,this.onMuteMod);
         this.ptView.removeEventListener(TVEvent.INVITE_PRESSED,this.onInvitePressed);
         this.ptView.removeEventListener(TVEvent.TOGGLE_MUTE_SOUND,this.onToggleMuteSoundPressed);
         this.ptView.removeEventListener(TVEvent.JOIN_USER_PRESSED,this.onJoinUserPressed);
         this.ptView.removeEventListener(TVEvent.FRIEND_NET_PRESSED,this.onFriendNetworkPressed);
         this.ptView.removeEventListener(TVEvent.GIFT_PRESSED,this.onGiftPressed);
         this.ptView.removeEventListener(TVEvent.ON_TABLE_CLEANUP,this.cleanupTable);
         this.ptView.removeEventListener(TVEvent.PLAY_SOUND_ONCE,this.onPlaySoundOnce);
         this.ptView.removeEventListener(TVEvent.ON_POST_TO_PLAY_CHANGE,this.onPostToPlayChange);
         this.ptView.removeEventListener(TVEvent.POLL_CLOSE,this.onPollClose);
         this.ptView.removeEventListener(TVEvent.POLL_YES,this.onPollYes);
         this.ptView.removeEventListener(TVEvent.POLL_NO,this.onPollNo);
         this.ptView.removeEventListener(TVEvent.ON_BUY_CHIPS_CLICK,this.onBuyChipsClick);
         this.ptView.removeEventListener(TVEvent.POKER_SCORE_PRESSED,this.onClickPokerScore);
         this.ptView.removeEventListener(TVEvent.ON_HELPING_HANDS_CLICK,this.onHelpingHandsClick);
         this.ptView.removeEventListener(TVEvent.ON_HELPING_HANDS_HOVER,this.onHelpingHandsHover);
         this.ptView.removeEventListener(TVEvent.ON_HELPING_HANDS_MOUSE_OUT,this.onHelpingHandsMouseOut);
         this.ptView.removeEventListener(TVEvent.SHOW_LEADERBOARD,this.onShowLeaderboard);
         if(this.ptModel.hsmFreeUsage)
         {
            this.ptView.removeEventListener(TVEvent.HSM_FREEUSE_PROMO_INVITE_PRESSED,this.onHSMFreeUsePromoInvitePressed);
         }
         this.removeZoomModelListeners();
         this.ptView.removeEventListener(TVEvent.ON_SHOW_MINIGAME_HIGHLOW,this.onShowMinigameHighLow);
         this.ptView.removeEventListener(TVEvent.ON_HIDE_MINIGAME_HIGHLOW,this.onHideMinigameHighLow);
         this.ptView.removeEventListener(TVEvent.SHOW_DAILYCHALLENGE,this.onShowDailyChallenge);
         this.ptView.removeEventListener(TVEvent.HIDE_DAILYCHALLENGE,this.onHideDailyChallenge);
         this.ptView.removeEventListener(TVEvent.ON_REPOSITION_CHICKLETS_START,this.onRepositionChickletsStart);
         this.ptView.removeEventListener(TVEvent.ON_REPOSITION_CHICKLETS_COMPLETE,this.onRepositionChickletsComplete);
         this._chatCtrl.removeEventListener(TVEvent.MUTE_MOD,this.onMuteMod);
         this._chatCtrl.removeEventListener(TVEvent.MUTE_PRESSED,this.onMutePressed);
         this._chatCtrl.removeEventListener(TVEvent.SEND_CHAT,this.onSendChat);
         this._dealerChatCtrl.removeEventListener(TVEvent.ON_HILO_REDIRECT_CLICK,this.onHiloRedirectClick);
         if(pgData.jumpTablesEnabled)
         {
            this.ptView.removeEventListener(TVEvent.ON_START_JUMP_TABLE_SEARCH,this.onStartJumpTableSearch);
            this.ptView.removeEventListener(TVEvent.ON_CANCEL_JUMP_TABLE_SEARCH,this.onCancelJumpTableSearch);
            this.ptView.removeEventListener(TVEvent.ON_JUMP_TABLE_BUTTON_SHOWN,this.onJumpTableButtonShown);
         }
         if(configModel.isFeatureEnabled("skipTables"))
         {
            this.ptView.removeEventListener(TVEvent.SKIP_TABLE_OVERLAY,this.onSkipTableOverlay);
            this.ptView.removeEventListener(TVEvent.SKIP_TABLE_CLEAR_OVERLAY,this.onSkipTableClearOverlay);
         }
      }
      
      private function trackTableInfoOnJoin(param1:int, param2:RoomItem) : void {
         var _loc3_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Unknown o:Table:TableInfoOnJoin:<normal/fast>:<smallBlind,bigBlind>:<playersCount,maxPlayers>:<buddiesAtTableCount>:2011-05-03",null,1);
         _loc3_.sTrackingStringOrComment = "Table Other Unknown o:Table:TableInfoOnJoin:" + param2.type + ":" + param2.smallBlind + "," + param2.bigBlind + ":" + param1 + "," + param2.maxPlayers + ":" + this.pControl.commonControl.getTableBuddyCount() + ":2011-05-03";
         fireStat(_loc3_);
      }
      
      public function displayTable() : void {
         this.pControl.attachViewToLayer(this.ptView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
         this.ptView.y = 40;
         if(this.showInviteFriendsNotificationOnPrivateTableCreation)
         {
            this.showInviteFriendsNotificationOnPrivateTableCreation = false;
            this.pControl.showInviteFriendsToPlay(this.ptView as DisplayObjectContainer,185,110,3);
         }
         this.applyUserPreferences();
         this._joinTableTime = Math.round(new Date().getTime() / 1000);
         dispatchEvent(new TCEvent(TCEvent.VIEW_INIT));
      }
      
      public function cleanupTable(param1:Event=null) : void {
         this.stopGiveChipsTimer();
         this.pControl.removeViewFromLayer(this.ptView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
         this._chickletCtrl.resetTable();
         this._chatCtrl.leaveTable();
         this._invCtrl.clearInvites();
         this._cardController.cleanupCards();
         this.ptView.cleanupTable();
         this._chipCtrl.leaveTable();
         this._bettingControls.hideControls(this.isSeated());
         this.removeViewListeners();
         this.disableProtocol();
      }
      
      private function updateSessionChipMovement() : void {
         pgData.eraseLossRTLNetMovement = 0;
         if(this.pointsLostInCurrentHand >= this.blindsLostInCurrentHand)
         {
            this.blindsLostInCurrentHand = 0;
         }
         var _loc1_:Number = pgData.points - this.ptModel.nSitinChips - this.pointsLostInCurrentHand - this.blindsLostInCurrentHand;
         this.pointsLostInCurrentHand = 0;
         this.blindsLostInCurrentHand = 0;
         if(_loc1_)
         {
            if(_loc1_ > 0)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:NetChipsMovementOnRTLUp:2011-05-24","",_loc1_,""));
            }
            else
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:NetChipsMovementOnRTLDown:2011-05-24","",0 - _loc1_,""));
               this.eraseChipLossOnLeaveTable(0 - _loc1_);
            }
         }
      }
      
      public function eraseChipLossOnLeaveTable(param1:int) : void {
         if(pgData.dispMode != "challenge")
         {
            return;
         }
         if(AtTableEraseLossManager.getInstance().hasShown())
         {
            return;
         }
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.enableImprovedEraseLossRTL))
         {
            if(param1 < pgData.improvedEraseLossRTLLowerLimit || param1 < int(this.ptModel.nSitinChips * pgData.improvedEraseLossRTLpercent / 100))
            {
               pgData.eraseLossRTLNetMovement = 0;
            }
            else
            {
               pgData.eraseLossRTLNetMovement = param1;
            }
         }
         else
         {
            if(!(param1 >= pgData.eraseLossRTLLowerLimit && param1 <= pgData.eraseLossRTLUpperLimit))
            {
               return;
            }
            pgData.eraseLossRTLNetMovement = param1;
         }
      }
      
      public function hideAds() : void {
         this.ptView.updatePopupNextHand();
      }
      
      private function onTablePressed(param1:TVEvent=null) : void {
         this.ptView.clearTableAcePopups();
      }
      
      public function leaveTable() : void {
         this.onLeaveTable();
      }
      
      private function onLeaveTable(param1:TVEvent=null) : void {
         var _loc5_:* = NaN;
         var _loc2_:RoomItem = pgData.getRoomById(pgData.gameRoomId);
         if(pgData.dispMode == "shootout")
         {
            _loc5_ = pgData.soUser.nRound;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Click o:Table:GoToLobby:Shootout:Round" + _loc5_ + ":2014-03-04"));
         }
         else
         {
            if(pgData.dispMode == "tournament")
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Click o:Table:GoToLobby:Sitngo:TournamentFee" + _loc2_.entryFee + "_Speed" + _loc2_.type + ":2014-03-04"));
            }
         }
         var _loc3_:IPopupController = registry.getObject(IPopupController);
         var _loc4_:Popup = _loc3_.getPopupConfigByID(Popup.BUST_OUT);
         if(!(_loc4_ == null) && !(_loc4_.module == null))
         {
            _loc4_.module.close();
         }
         if(configModel.isFeatureEnabled("skipTables"))
         {
            dispatchCommand(new HideModuleCommand("SkipTables"));
         }
         if(configModel.isFeatureEnabled("dailyChallenge"))
         {
            dispatchCommand(new HideModuleCommand("DailyChallenge"));
         }
         if(pgData.mttZone)
         {
            dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
            return;
         }
         this.processLeaveTable();
      }
      
      private function processLeaveTable() : void {
         var _loc5_:Object = null;
         this.cleanupTable();
         this.pControl.mfsControl.removeAllRequestTwoPopUps();
         this.pControl.closeShout();
         this.updateSessionChipMovement();
         this.ptModel.handsPlayedCounter = 0;
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.showdownRoomId))
         {
            this.ptModel.tableConfig.showdownRoomId = 0;
            pgData.dispMode = "shootout";
         }
         pgData.joiningShootout = false;
         commandDispatcher.dispatchCommand(new CloseAllPHPPopupsCommand());
         var _loc1_:* = true;
         if((pgData.jumpTablesEnabled) && (pgData.willJumpTable) || (pgData.mttZone))
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            if(this.ptModel.isLeaderboardEnabled())
            {
               this.pControl.showLeaderboard({});
            }
            _loc5_ = this.ptModel.configModel.getFeatureConfig("sponsoredShootouts");
            this.pControl.notifyJS(new JSEvent(JSEvent.LEAVING_TABLE,
               {
                  "disablePopup":pgData.disableRTLPopup,
                  "showShootout":pgData.showShoutoutSponsorRequest,
                  "sponsorShootoutsAccepted":(_loc5_?_loc5_.sponsorShootoutsAccepted:0),
                  "sponsorShootoutsTotal":(_loc5_?_loc5_.sponsorShootoutsTotal:0),
                  "eraseLossRTLNetMovement":pgData.eraseLossRTLNetMovement
               }));
         }
         pgData.disableRTLPopup = false;
         pgData.showShoutoutSponsorRequest = false;
         this.stopGiveChipsTimer();
         this.pControl.removeViewFromLayer(this.ptView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
         this.removeViewListeners();
         this.disableProtocol();
         this.clearJoinFriendFlags();
         if(pgData.sn_id == pgData.SN_FACEBOOK)
         {
            pgData.bFbFeedAllow = true;
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         if(!pgData.mttZone)
         {
            dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
         }
         if(this.hasOneHandBeenPlayedAtThisTable)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:Table:GoToLobby:AtLeastOneHandPlayed:2010-01-14"));
         }
         var _loc2_:uint = Math.round(new Date().getTime() / 1000);
         var _loc3_:Number = _loc2_ - this._joinTableTime;
         ZTrack.logCount(ZTrack.THROTTLE_ALWAYS,"o:ClickToLobby:2010-04-05","table","counter","unknown",String(this.ptModel.numberOfPlayers),"",_loc3_);
         this.pControl.hideInviteFriendsToPlay();
         var _loc4_:Number = pgData.points - this.ptModel.nSitinChips;
         dispatchEvent(new MGEvent(MGEvent.MG_DESTROY_GAME_BY_TYPE,{"type":MinigameUtils.HIGHLOW}));
         dispatchCommand(new HideLeaderboardSurfacingCommand());
      }
      
      public function onReBuyInCancel() : void {
         this.onStandUp(null);
      }
      
      private function onStandUp(param1:TVEvent) : void {
         var _loc2_:PokerUser = this.ptModel.getUserByZid(pgData.viewer.zid);
         if(_loc2_ !== null)
         {
            _loc2_.sStatusText = "waiting";
         }
         this._bettingControls.updatePreBetCheckboxes();
         this._cardController.clearHoleCards();
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:StandClicks:2009-03-20","",1,"",PokerStatHit.HITTYPE_FG));
         this.bStandUp = true;
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         dispatchEvent(new TCEvent(TCEvent.STAND_UP));
      }
      
      private function onSitPressed(param1:TVESitPressed) : void {
         var _loc3_:PokerUser = null;
         var _loc4_:SSit = null;
         if(this._inOutOfChipsTableFlow)
         {
            return;
         }
         var _loc2_:int = param1.nSit;
         if(this.ptModel.getUserBySit(_loc2_) != null)
         {
            _loc3_ = this.ptModel.getUserBySit(_loc2_);
            this.getCardOptions(_loc3_.zid);
            this.chickletClicked = true;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:SitPressedAvatar:2009-03-17","",1,"",PokerStatHit.HITTYPE_FG));
            this.ptModel.nSitinChips = pgData.points;
            fireStat(new PokerStatHit("chickletclick",0,0,0,PokerStatHit.TRACKHIT_ONCE,"chicklet click","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Table%20Other%20Click%3AChicklet%20o%3AGeneralSocial%3A2009-04-17&ltsig=87f097482ff689b91ec91add57d7f8a7",1));
         }
         else
         {
            if(this.ptModel.getUserByZid(this.ptModel.viewer.zid) == null)
            {
               if(configModel.getBooleanForFeatureConfig("scoreCard","showFTUE"))
               {
                  externalInterface.call("zc.feature.scoreCard.incFTUECount");
               }
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:SitPressed:2009-03-20","",1,"",PokerStatHit.HITTYPE_FG));
               this.repeatStatBasedOnServer(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:SitPressed:2009-03-20","",1,"",PokerStatHit.HITTYPE_FG));
               this.ptModel.seatClicked = true;
               if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.showdownRoomId))
               {
                  _loc4_ = new SSit("SSit",1000,-1,1);
                  this.pcmConnect.sendMessage(_loc4_);
               }
               else
               {
                  if(!(pgData.dispMode == TableDisplayMode.SHOOTOUT_MODE) && !(pgData.dispMode == TableDisplayMode.PREMIUM_MODE))
                  {
                     if(this.ptModel.room.gameType == "Challenge")
                     {
                        if(!pgData.mttZone)
                        {
                           dispatchEvent(new TBPopupEvent("showTableBuyIn",_loc2_,false,this.ptModel.postToPlayFlag,this.checkForValidRatholeState()) as PopupEvent);
                        }
                     }
                     else
                     {
                        if(this.ptModel.room.gameType == "Tournament")
                        {
                           if(this.ptModel.sTourneyMode == "reg" && !pgData.mttZone)
                           {
                              dispatchEvent(new TourneyBuyInPopupEvent("showTournamentBuyIn",_loc2_) as PopupEvent);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function onBetPotPressed(param1:BettingPanelControllerEvent) : void {
         this._bettingControls.updateBettingSlider(this._chipCtrl.getCurrentPot() + this._chipCtrl.getTotalOnTableBets());
      }
      
      private function onBetHalfPotPressed(param1:BettingPanelControllerEvent) : void {
         this._bettingControls.updateBettingSlider(Math.ceil((this._chipCtrl.getCurrentPot() + this._chipCtrl.getTotalOnTableBets()) / 2));
      }
      
      private function onCallPressed(param1:BettingPanelControllerEvent) : void {
         var _loc2_:SAction = null;
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         if(this.ptModel.nCurrentTurn == this.ptModel.getSeatNum(this.ptModel.viewer.zid))
         {
            _loc2_ = new SAction("SAction",this.ptModel.nCallAmt,"c");
            this.pcmConnect.sendMessage(_loc2_);
         }
         this._bettingControls.updateCallPreBetButton(0);
         this.pControl.hideTutorialArrows();
      }
      
      private function onFoldPressed(param1:BettingPanelControllerEvent) : void {
         var _loc2_:SAction = null;
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Total o:HandsFolded:2009-11-06","",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_ZOOM));
         if(this.ptModel.nCurrentTurn == this.ptModel.getSeatNum(this.ptModel.viewer.zid))
         {
            _loc2_ = new SAction("SAction",-1,"f");
            this.pcmConnect.sendMessage(_loc2_);
         }
         commandDispatcher.dispatchCommand(new PlaySoundCommand(param1.type));
         this._bettingControls.updateCallPreBetButton(0);
         this.pControl.hideTutorialArrows();
         this.pControl.notifyJS(new JSEvent(JSEvent.USER_FOLDED,{"turn":this.ptModel.sHandStatus}));
         if((this.ptModel.hsmFreeUsage) && !this.ptModel.hsmIsFree)
         {
            this.ptView.hsmFreeUsagePromoShow = !this.ptView.hsmFreeUsagePromoShow;
         }
      }
      
      private function onTCont_BotDetectedByFoldPos(param1:TVEvent) : void {
         this._bettingControls.removeEventListener(BettingPanelControllerEvent.TYPE_BOT_DETECTED_BY_FOLD_POS,this.onTCont_BotDetectedByFoldPos);
         fireStat(new PokerStatHit("BotDetectedByFoldPos",5,14,-1,PokerStatHit.TRACKHIT_ONCE,"Table Other Unknown o:BotDetectedByFoldPos:2009-08-13",null,1));
         if(pgData.flashCookie)
         {
            pgData.flashCookie.SetValue("bIsBot",true);
         }
      }
      
      private function onRaisePressed(param1:BettingPanelControllerEvent) : void {
         var _loc3_:SAction = null;
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         var _loc2_:Number = param1.params as Number;
         if(this.ptModel.nCurrentTurn == this.ptModel.getSeatNum(this.ptModel.viewer.zid))
         {
            _loc3_ = new SAction("SAction",_loc2_,"r");
            this.pcmConnect.sendMessage(_loc3_);
            if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && (externalInterface.available) && !pgData.hasRaised)
            {
               externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.TAKE_CONTROL_ID);
               pgData.hasRaised = true;
            }
         }
         this._bettingControls.updateCallPreBetButton(0);
         this.pControl.hideTutorialArrows();
      }
      
      private function onFriendNetworkPressed(param1:TVEvent) : void {
         if(!pgData.mttZone)
         {
            dispatchEvent(new TCEvent(TCEvent.FRIEND_NET_PRESSED));
         }
      }
      
      private function onMutePressed(param1:TVEvent) : void {
         this.isMutePressed = true;
         var _loc2_:SGetUsersInRoom = new SGetUsersInRoom("SGetUsersInRoom",pgData.zid,pgData.gameRoomId);
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      private function onSendChat(param1:TVESendChat) : void {
         if(param1.sendMode == TVESendChat.ENTER_PRESS)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Unknown o:TableChat_MessageSend:2011-02-28"));
            fireStat(new PokerStatHit("TableChat_MessageSend_Once",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Unknown o:TableChat_MessageSend_Once:2011-02-28"));
         }
         else
         {
            if(param1.sendMode == TVESendChat.SEND_CLICK)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Unknown o:TableChat_MessageSendButton:2013-05-01"));
               fireStat(new PokerStatHit("TableChat_MessageSendButton_Once",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Unknown o:TableChat_MessageSendButton_Once:2013-05-01"));
            }
         }
         var _loc2_:SSendChat = new SSendChat("SSendChat",param1.sMessage);
         this.pcmConnect.sendMessage(_loc2_);
         this.nChatCount++;
         if(this.nChatCount == 1)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:FirstChat:2009-02-13","",1,"",PokerStatHit.HITTYPE_FG));
            if(((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && externalInterface.available && !pgData.hasChatted) && (this.ptModel.userSeat) && this.ptModel.room.players >= 2)
            {
               externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.GREET_THOSE_YOU_BEAT_ID);
               pgData.hasChatted = true;
            }
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:TotalChat:2009-02-13","",1,"",PokerStatHit.HITTYPE_FG));
         fireStat(new PokerStatHit("chatsent",0,0,0,PokerStatHit.TRACKHIT_ONCE,"chat sent","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Table%20Other%20ChatSent%20o%3AChat%3A2009-04-17&ltsig=75ba0f9130aed60f84985a3ca794f654",1));
      }
      
      private function onChatNamePressed(param1:TVEChatNamePressed) : void {
         var _loc2_:UserProfile = null;
         if(this._inOutOfChipsTableFlow)
         {
            return;
         }
         if(param1.zid == "openUrl")
         {
            externalInterface.call("ZY.App.PokerCon.OpenUrl");
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TableChat_ZyngaCustomMessageClick:2011-02-24"));
         }
         else
         {
            _loc2_ = this.ptModel.getUserProfileByZid(this.ptModel.uidObfuscator.getUIDWithObfuscationIndex(int(param1.zid)));
            if(_loc2_ != null)
            {
               this.pControl.showProfile(_loc2_.zid,_loc2_.username);
            }
         }
      }
      
      private function colorChatText(param1:String, param2:int, param3:Boolean=false, param4:Boolean=false) : String {
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc5_:String = param1;
         if(param4)
         {
            _loc6_ = String.fromCharCode(9824);
            return "<font color=\"#000000\"><b>" + _loc6_ + _loc5_ + " [Zynga Moderator] </b></font>";
         }
         if(_loc5_ != null)
         {
            _loc7_ = this.getSitColor(param2);
            if(param3)
            {
               _loc5_ = "<b>" + _loc5_ + "</b>";
            }
            _loc5_ = "<font color=\"#" + _loc7_.toString(16).toUpperCase() + "\">" + _loc5_ + "</font>";
         }
         return _loc5_;
      }
      
      private function getSitColor(param1:int) : uint {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 8388608;
               break;
            case 1:
               _loc2_ = 25600;
               break;
            case 2:
               _loc2_ = 128;
               break;
            case 3:
               _loc2_ = 9055202;
               break;
            case 4:
               _loc2_ = 255;
               break;
            case 5:
               _loc2_ = 3329330;
               break;
            case 6:
               _loc2_ = 13789470;
               break;
            case 7:
               _loc2_ = 13047896;
               break;
            case 8:
               _loc2_ = 6525114;
               break;
            case 9:
               _loc2_ = 7303023;
               break;
            case -1:
               _loc2_ = 3355443;
               break;
         }
         
         return _loc2_;
      }
      
      private function wrapChatZidLink(param1:String, param2:String) : String {
         return "<a href=\'event:" + String(this.ptModel.uidObfuscator.addUserWithUID(param1)) + "\'>" + this.htmlEncode(param2) + "</a>";
      }
      
      private function postGameRoomInit() : void {
         var _loc1_:String = null;
         var _loc2_:* = false;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(pgData.userDidSelectTableFromTableSelector)
         {
            if(this.ptModel.getTotalPlayers() == this.ptModel.room.maxPlayers)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Impression TableSelector o:JoinedTable:SeatsAreNotAvailable:2012-06-06"));
            }
            else
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Impression TableSelector o:JoinedTable:SeatsAreAvailable:2012-06-06"));
            }
            pgData.userDidSelectTableFromTableSelector = false;
         }
         if(pgData.rejoinRoom != -1)
         {
            pgData.rejoinRoom = -1;
            this._bettingControls.hideControls(this.isSeated());
            if(this.isSeated())
            {
               this.displayPopupNextHand();
               if(pgData.rakeEnabled)
               {
                  if(this.ptModel.hsmIsFree)
                  {
                     this.onRakeEnabled();
                  }
                  else
                  {
                     this.pcmConnect.sendMessage(new SRakeEnable("SRakeEnable",{"reconnect":"1"}));
                  }
               }
               else
               {
                  this.pcmConnect.sendMessage(new SRakeDisable("SRakeDisable",{"reconnect":"1"}));
               }
            }
         }
         else
         {
            _loc1_ = "hasTermsOfServiceReminderExecuted2009-08-28";
            _loc2_ = Boolean(pgData.flashCookie?pgData.flashCookie.GetValue(_loc1_,false):false);
            if(!_loc2_)
            {
               if(pgData.flashCookie)
               {
                  pgData.flashCookie.SetValue(_loc1_,true);
               }
               dispatchEvent(new ErrorPopupEvent("showTermsOfServiceReminder",LocaleManager.localize("flash.message.table.termsOfServiceReminderTitle"),LocaleManager.localize("flash.message.table.termsOfServiceReminderMessage")));
            }
            if(pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE)
            {
               externalInterface.call("zc.game.poker.recentActions.tracker.track","chipsAtLastRTL",pgData.points);
            }
         }
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.tourneyId > -1) && pgData.bonus > 0)
         {
            _loc3_ = LocaleManager.localize("flash.message.defaultTitle");
            _loc4_ = LocaleManager.localize("flash.message.table.room.initTip");
            dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc3_,_loc4_));
         }
         this._bettingControls.initHSM(pgData.mttZone);
      }
      
      private function postTourneyInit() : void {
         var _loc1_:Object = null;
         var _loc2_:RoomItem = null;
         var _loc3_:* = NaN;
         if(pgData.rejoinRoom != -1)
         {
            pgData.rejoinRoom = -1;
            if(this.isSeated())
            {
               this.displayPopupNextHand();
            }
         }
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.showdownRoomId))
         {
            dispatchEvent(new ErrorPopupEvent("showShowdownTermsOfService",LocaleManager.localize("flash.popup.showdownTermsOfService.title"),LocaleManager.localize("flash.popup.showdownTermsOfService.message")));
         }
         if(pgData.dispMode == "premium" && (this.ptModel.sfxHappyHour))
         {
            _loc1_ = new Object();
            _loc1_["type"] = ShoutPowerTourneyHappyHourView.SHOUT_TYPE;
            _loc1_["swfVars"] = new Object();
            _loc2_ = pgData.getRoomById(pgData.gameRoomId);
            _loc3_ = pgData.getRoomById(pgData.gameRoomId).prizes[0];
            _loc1_["swfVars"]["normalPrizeValue"] = _loc3_;
            _loc1_["swfVars"]["happyHourPrizeValue"] = _loc3_ * 1.2;
            this.pControl.displayShout(com.adobe.serialization.json.JSON.encode(_loc1_));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:PowerTourneyHappyHour:HappyHour:2012-12-12"));
         }
         else
         {
            if(pgData.dispMode == "premium" && !this.ptModel.powerTourneyConfig.isCurrentlyHappyHour)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:PowerTourneyHappyHour:NotHappyHour:2012-12-12"));
            }
         }
         this._bettingControls.initHSM(true);
      }
      
      private function createTableModel(param1:Object) : void {
         this.ptModel = registry.getObject(TableModel);
         this.ptModel.setUsersForModel(param1.aUsers);
         this._tableLayoutModel = registry.getObject(TableLayoutModel);
         this._tableLayoutModel.init();
      }
      
      private function commonRoomInit(param1:Object) : void {
         this.initTableView();
         this.tableViewInitialized();
         this.initViewListeners();
      }
      
      private function checkFriendStatus() : void {
         var _loc1_:SGetUsersInRoom = null;
         if(this.ptModel.getUserByZid(pgData.joinFriendId) == null)
         {
            this.isCheckSpectator = true;
            _loc1_ = new SGetUsersInRoom("SGetUsersInRoom",pgData.zid,pgData.gameRoomId);
            this.pcmConnect.sendMessage(_loc1_);
         }
      }
      
      private function clearJoinFriendFlags() : void {
         pgData.isJoinFriend = false;
         pgData.isJoinFriendSit = false;
      }
      
      private function displayPopupNextHand() : void {
         if(this.isSeated(this.ptModel.viewer.zid))
         {
            if(pgData.dispMode == TableDisplayMode.TOURNAMENT_MODE || pgData.dispMode == TableDisplayMode.SHOOTOUT_MODE || this.ptModel.aUsers.length == 1)
            {
               this.ptView.updatePopupNextHand(true,LocaleManager.localize("flash.table.message.waitPlayers"));
            }
            else
            {
               this.ptView.updatePopupNextHand(true,LocaleManager.localize("flash.table.message.waitNextHand"));
            }
         }
         else
         {
            this.ptView.updatePopupNextHand(this.ptModel.enableBetControlAds(),"");
         }
      }
      
      private function onSitJoined(param1:Object) : void {
         var _loc4_:* = false;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc2_:RSitJoined = RSitJoined(param1);
         var _loc3_:PokerUser = _loc2_.user;
         if(this.ptModel)
         {
            if(configModel.isFeatureEnabled("atTableEraseLoss"))
            {
               AtTableEraseLossManager.getInstance().chipsBeforeHandStarted = pgData.points;
            }
            _loc4_ = this.ptModel.getUserBySit(_loc3_.nSit)?true:false;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:Table:ConfirmSitDown:2012-07-13"));
            if(pgData.dispMode == "premium")
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Sit o:PowerTournamentBuyin" + this.pControl.soConfig.nBuyin + ":2011-06-05"));
            }
            if(!_loc4_)
            {
               this.ptModel.addUser(_loc2_.user);
               this.playerSat(_loc3_.nSit,this.ptModel.seatClicked);
               _loc3_.sStatusText = "waiting";
            }
            else
            {
               this.buyinUpdate(_loc3_,_loc3_.nChips,true);
            }
            _loc5_ = _loc3_.zid != this.ptModel.viewer.zid?_loc3_.nSit:-1;
            _loc6_ = LocaleManager.localize("flash.table.dealer.join",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc5_,true)});
            this.newSocialChatMessage(_loc6_);
            if(pgData.dispMode == "premium")
            {
               this.displayPopupNextHand();
            }
            if(_loc3_.zid == this.ptModel.viewer.zid)
            {
               this.publishOGStory();
               if(this.ptModel.configModel.getIntForFeatureConfig("user","newUserPopup"))
               {
                  commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("sit_table","1"));
               }
               if(pgData.dispMode == "premium")
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:PowerTourneyHappyHour:Sit:2012-10-09"));
               }
               if((pgData.isJoinFriend) && !pgData.isJoinFriendSit)
               {
                  pgData.isJoinFriendSit = true;
                  if((pgData.joinFriendId) && !(this.ptModel.getUserByZid(pgData.joinFriendId) == null))
                  {
                     fireStat(new PokerStatHit("FriendsJoinUserAndSit",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other FriendsJoinUserAndSit o:LiveJoin:2009-05-14",null,1));
                  }
               }
               if(pgData.arbAutoRebuySelected)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Unknown o:Table:SitWithAutoRebuyEnabled:2011-05-26"));
               }
               if(pgData.arbTopUpStackSelected)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Unknown o:Table:SitWithTopUpStackEnabled:2011-05-26"));
               }
               this.openHsmRakeShout();
               if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && !pgData.hasHadSecondSession && (externalInterface.available))
               {
                  externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.LAST_LONGER_THAN_MOST_MEN_ID);
                  pgData.hasHadSecondSession = true;
               }
               if(pgData.mttZone)
               {
                  this.hideAds();
               }
            }
            if(configModel.getBooleanForFeatureConfig("table","newTables"))
            {
               this.ptView.fadeOutBackgroundChair(_loc3_.nSit);
            }
            this.ptModel.seatClicked = false;
            dispatchEvent(new TCEvent(TCEvent.SEAT_JOINED));
         }
      }
      
      private function onSitTaken(param1:Object) : void {
         if(configModel.getBooleanForFeatureConfig("oOCTableFlow","customSitTakenHandler"))
         {
            dispatchEvent(new TCEvent(TCEvent.SEAT_TAKEN));
            return;
         }
         var _loc2_:String = LocaleManager.localize("flash.message.defaultTitle");
         var _loc3_:String = LocaleManager.localize("flash.message.table.sitTakenMessage");
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc2_,_loc3_));
      }
      
      private function onSpecStructure(param1:Object) : void {
         var _loc2_:Array = null;
         var _loc3_:UserProfile = null;
         if(param1 is RSpecStructure)
         {
            _loc2_ = (param1 as RSpecStructure).userProfiles;
            if(_loc2_ != null)
            {
               for each (_loc3_ in _loc2_)
               {
                  this.ptModel.addUserProfile(_loc3_);
               }
            }
         }
      }
      
      private function onSpecJoined(param1:Object) : void {
         var _loc2_:UserProfile = null;
         var _loc3_:String = null;
         if(param1 is RSpecJoined)
         {
            _loc2_ = (param1 as RSpecJoined).userProfile;
            if(Boolean(_loc2_.isMod) == true)
            {
               _loc3_ = LocaleManager.localize("flash.table.dealer.join",{"actor":this.colorChatText(this.wrapChatZidLink(_loc2_.zid,_loc2_.username),0,true,true)});
               this.newSocialChatMessage(_loc3_,true);
            }
            if(this.ptModel)
            {
               this.ptModel.addUserProfile(_loc2_);
            }
         }
      }
      
      private function onSpotlightRequest(param1:CommandEvent) : void {
         if((this.ptView) && (this.ptModel.userSeat))
         {
            this.ptView.showSpotlightOverlay("Hold your horses, we\'re moving you");
         }
      }
      
      private function onMTTStandUp(param1:CommandEvent) : void {
         this.leaveMTTTable();
         dispatchEvent(new CommandEvent("MTTStandUp",param1.params));
      }
      
      public function leaveMTTTable() : void {
         if(this.ptView)
         {
            this.processLeaveTable();
         }
      }
      
      private function onMTTBlindIncrease(param1:CommandEvent) : void {
         var _loc2_:Number = param1.params.smallBlind;
         var _loc3_:Number = param1.params.bigBlind;
         if(this.ptModel)
         {
            this.ptModel.updateBlinds(_loc2_,_loc3_);
         }
         if(this.ptView)
         {
            this.ptView.updateBlinds();
         }
         this.pControl.zoomUpdateStakes(BlindFormatter.formatBlinds(_loc2_,_loc3_));
      }
      
      private function onUserLost(param1:Object) : void {
         var _loc2_:RUserLost = RUserLost(param1);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         this.newSocialChatMessage(LocaleManager.localize("flash.table.dealer.left",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc3_.nSit,true)}));
         if(_loc3_.zid == this.ptModel.viewer.zid)
         {
            this.clearJoinFriendFlags();
            this._cardController.clearHoleCards();
            pgData.aBuddyInvites = new Array();
         }
         else
         {
            pgData.removeBuddyInvite(_loc3_.zid);
         }
         this._chickletCtrl.setState(ChickletController.STATE_LOST,_loc2_.sit);
         if(this.ptView)
         {
            this.playerLeft(_loc2_.sit);
         }
         this.ptModel.removeUser(_loc2_.sit);
         this.updateInbox();
         if(pgData.isMe(_loc3_.zid))
         {
            if(this.ptModel.room.gameType == "Challenge")
            {
               if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.tourneyId == -1) && pgData.points >= this.ptModel.nBigblind)
               {
                  if(!this.bStandUp)
                  {
                     if(this.ptModel.getUserBySit(_loc2_.sit) == null)
                     {
                        if(!pgData.mttZone)
                        {
                           commandDispatcher.dispatchCommand(new PlaySoundCommand(PokerSoundEvent.TABLE_USER_LOST));
                           dispatchEvent(new TBPopupEvent("showTableBuyIn",_loc2_.sit,false,this.ptModel.postToPlayFlag,this.checkForValidRatholeState()) as PopupEvent);
                           this.displayPopupNextHand();
                        }
                     }
                  }
               }
            }
         }
         this.bStandUp = false;
         if(this.ptModel.aUsers.length == 1 && (this.isSeated(this.ptModel.viewer.zid)))
         {
            this.displayPopupNextHand();
         }
         this.ptView.removePlayersClubChair(_loc2_.sit);
      }
      
      private function onUserSitOut(param1:Object) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = false;
         var _loc6_:Object = null;
         var _loc2_:RUserSitOut = RUserSitOut(param1);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if(_loc3_.zid == this.ptModel.viewer.zid)
         {
            this.clearJoinFriendFlags();
            this._cardController.clearHoleCards();
            pgData.aBuddyInvites = new Array();
         }
         else
         {
            pgData.removeBuddyInvite(_loc3_.zid);
         }
         this._chickletCtrl.setState(ChickletController.STATE_LOST,_loc2_.sit);
         _loc3_.sStatusText = "satout";
         this.updateInbox();
         if(pgData.isMe(_loc3_.zid))
         {
            if(this.ptModel.room.gameType == "Challenge")
            {
               this._cardController.resetModel();
               this.ptModel.resetModel();
               if(this.ptModel.getUserBySit(_loc2_.sit) != null)
               {
                  if(!pgData.mttZone)
                  {
                     dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_USER_LOST,PokerSoundEvent.CNAME_PLAY));
                     _loc4_ = this.checkForValidRatholeState()?pgData.ratholingInfoObj["minBuyin"]:this.ptModel.nMinBuyIn;
                     if(!configModel.isFeatureEnabled("bustOutMonetization") || pgData.points >= _loc4_)
                     {
                        _loc5_ = true;
                        _loc6_ = configModel.getFeatureConfig("tableCashierMonetized");
                        if((_loc6_) && (_loc6_.enabled) && _loc6_.tableCashierDelay == -1)
                        {
                           _loc5_ = false;
                           this._bettingControls.updatePreBetCheckboxes();
                           this._cardController.clearHoleCards();
                           this.bStandUp = true;
                           dispatchEvent(new TCEvent(TCEvent.STAND_UP));
                        }
                        externalInterface.call("zc.feature.pixelTrackingManager.track","Bust","MediaImage");
                        dispatchEvent(new TBPopupEvent("showTableBuyIn",_loc2_.sit,_loc5_,this.ptModel.postToPlayFlag,this.checkForValidRatholeState()) as PopupEvent);
                     }
                  }
               }
            }
         }
         else
         {
            this.ptView.removePlayersClubChair(_loc2_.sit);
         }
         if(this.ptModel.aUsers.length == 2 && (this.isSeated(this.ptModel.viewer.zid)))
         {
            if(_loc3_.sStatusText != "satout")
            {
               this.displayPopupNextHand();
            }
         }
      }
      
      private function onBustOutMonetization(param1:Object) : void {
         if(!configModel.isFeatureEnabled("bustOutMonetization"))
         {
            return;
         }
         this._isBustOut = true;
         var _loc2_:RBustOutMonetization = RBustOutMonetization(param1);
         PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateChipsCommand(_loc2_.points,false));
         this._bustOutSit = _loc2_.sit;
         var _loc3_:Object = configModel.getFeatureConfig("bustOutMonetizationV2");
         _loc3_.minBuyIn = this.ptModel.nMinBuyIn;
         dispatchEvent(new PopupEvent("showBustOut",true));
      }
      
      public function bustOutClosed() : void {
         if(this._isBustOut)
         {
            this._isBustOut = false;
            this.onStandUp(null);
         }
      }
      
      private function onUpdatePendingChips(param1:Object) : void {
         var _loc2_:IPopupController = null;
         var _loc3_:Popup = null;
         if(this._isBustOut)
         {
            this._isBustOut = false;
            _loc2_ = registry.getObject(IPopupController);
            _loc3_ = _loc2_.getPopupConfigByID(Popup.BUST_OUT);
            if(!(_loc3_ == null) && !(_loc3_.module == null))
            {
               _loc3_.module.showPendingStatus();
            }
         }
      }
      
      private function onPlayersClubUpdate(param1:Object) : void {
         var _loc2_:RPlayersClubUpdate = param1 as RPlayersClubUpdate;
         this.ptView.changeSeatByTier(_loc2_.seat,_loc2_.tier);
      }
      
      private function onHelpingHandsUserContributionUpdate(param1:Object) : void {
         var _loc2_:RHelpingHandsUserContributionUpdate = param1 as RHelpingHandsUserContributionUpdate;
         var _loc3_:Object = configModel.getFeatureConfig("helpingHands");
         if(!(_loc3_ == null) && !(_loc3_.rakeData == null))
         {
            _loc3_.rakeData.userContribution = _loc3_.rakeData.userContribution + _loc2_.contribution;
         }
      }
      
      private function onTurnChanged(param1:Object) : void {
         var _loc4_:PokerUser = null;
         var _loc2_:Object = configModel.getFeatureConfig("atTableEraseLoss");
         if(_loc2_)
         {
            AtTableEraseLossManager.getInstance().updateHighestAmountOfChips(_loc2_,pgData.points);
            AtTableEraseLossManager.getInstance().chipsBeforeHandStarted = pgData.points;
         }
         var _loc3_:RTurnChanged = RTurnChanged(param1);
         this._cardController.resetModel();
         this.ptModel.resetModel();
         this.ptModel.nHandId = _loc3_.handId;
         this.ptModel.nDealerSit = _loc3_.sit;
         this.setDealer(_loc3_.sit);
         this.pyhBlindsInCurrentHand = 0;
         for each (_loc4_ in this.ptModel.aUsersInHand)
         {
            if(_loc4_.sStatusText.toLowerCase() == "waiting")
            {
               _loc4_.sStatusText = "playing";
            }
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_SHUFFLE,PokerSoundEvent.CNAME_PLAY));
      }
      
      private function onPostBlind(param1:Object) : void {
         var _loc2_:RPostBlind = RPostBlind(param1);
         this.ptModel.updateBlind(_loc2_.sit,_loc2_.bet,_loc2_.chips);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if(_loc3_)
         {
            this._chipCtrl.postBlind(_loc2_.sit,_loc3_.nCurBet);
         }
         if(pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.blindsLostInCurrentHand = this.blindsLostInCurrentHand + _loc2_.bet;
         }
         this.pyhBlindsInCurrentHand = Math.max(this.pyhBlindsInCurrentHand,_loc2_.bet);
      }
      
      private function onDealHoles(param1:Object) : void {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:IPokerScoreService = null;
         var _loc7_:PokerUser = null;
         this.clearPotsTrackers();
         this.pyhViewerFolded = false;
         this.pyhViewerChipsOnTable = 0;
         if(!this.hasDoneFirstHandMilestone)
         {
            PokerLoadMilestone.sendLoadMilestone("client_table_firsthand");
            this.hasDoneFirstHandMilestone = true;
         }
         if(this.ptModel.configModel.getIntForFeatureConfig("user","newUserPopup"))
         {
            commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("deal_hole_cards","1"));
         }
         var _loc2_:RDealHoles = RDealHoles(param1);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         this._chickletCtrl.resetTable();
         if(_loc2_.sit >= 0)
         {
            this.hasOneHandBeenPlayedAtThisTable = true;
            this.ptModel.handsPlayedCounter++;
            this.handsAtThisTable++;
            if((this.ptModel.handsPlayedCounter == 2) && (this.ptModel.tableConfig) && (this.ptModel.tableConfig.secondHandTracking))
            {
               externalInterface.call("ZY.App.handTracking.trackSecondHand");
            }
            if(pgData.enableZPWC)
            {
               externalInterface.call("zc.feature.zpwc.playHand",false);
            }
            if(((this.ptModel.configModel.getIntForFeatureConfig("shootout","shootoutId",-1) == -1) && (this.ptModel.tableConfig)) && (this.ptModel.tableConfig.tourneyId == -1) && !(this.ptModel.room.gameType == "Tournament"))
            {
               this.normalTableHandsCounter++;
               if(this.ptModel.configModel.isFeatureEnabled("scoreCard"))
               {
                  _loc6_ = registry.getObject(IPokerScoreService);
                  _loc6_.init();
                  _loc6_.updateHandsPlayedCount(1);
               }
               if(this.normalTableHandsCounter == 4)
               {
                  if(!(this.ptModel.zpwcConfig == null) && (this.ptModel.zpwcConfig.enableShout))
                  {
                     this.pControl.displayShout("{\"type\":3,\"ttdName\":\"goldenticket_shout_6\"}");
                  }
               }
            }
            pgData.activeRoom = pgData.getRoomById(pgData.gameRoomId);
            if((_loc3_) && _loc3_.sStatusText == "satout")
            {
               _loc3_.sStatusText = "wasSatOut";
            }
            if((_loc3_) && _loc3_.sStatusText.toLowerCase() == "waiting")
            {
               _loc3_.sStatusText = "playing";
            }
            if((_loc3_) && _loc3_.nSit >= 0)
            {
               this.hsmUsedStat = false;
            }
            _loc5_ = 
               {
                  "seat":_loc2_.sit,
                  "card1":String(_loc2_.card1),
                  "suit1":_loc2_.tip1,
                  "card2":String(_loc2_.card2),
                  "suit2":_loc2_.tip2,
                  "smallSeat":_loc2_.small
               };
            this.ptModel.setupNewHand(_loc5_.smallSeat);
            this._cardController.setupNewHand(_loc5_);
            this.ptModel.userSeat = _loc5_.seat;
            this.ptModel.updateHandStartChips(_loc2_.sit);
            this._cardController.dealHoleCards(_loc5_.seat);
            this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.raiseButton"));
            this._bettingControls.setAllInButton(LocaleManager.localize("flash.table.controls.allInButton"));
            this.showViewerBet();
            this._bettingControls.postHoleCardsDealt();
            this._bettingControls.updatePreBetCheckboxes();
            if(_loc3_)
            {
               this._bettingControls.updateCallPreBetButton(this.ptModel.nBigblind - _loc3_.nCurBet);
            }
            else
            {
               this._bettingControls.updateCallPreBetButton(0);
            }
            this.clientHandOverFlag = false;
            this.pControl.navControl.incrementPlayersClubCoolDown();
            if(this.ptModel.room.tableType == "Private")
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"o:PrivateTable:HandPlayed:2010-06-09",null,1));
            }
            else
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:HandPlayed:2009-02-11","",1,"",PokerStatHit.HITTYPE_FG,PokerStatHit.HITLOC_ZOOM));
               this.repeatStatBasedOnServer(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:HandPlayed:2009-02-11","",1,"",PokerStatHit.HITTYPE_FG,PokerStatHit.HITLOC_ZOOM));
            }
            if((PokerStageManager.isFullScreenMode()) && (pgData.rakeFullScreenMode))
            {
               if(this.rakeNextHand)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Other o:FSHandPlayed:HSMEnabled:2011-11-15"));
               }
               else
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Other o:FSHandPlayed:HSMDisabled:2011-11-15"));
               }
            }
            if((pgData.isJoinFriend) && (pgData.isJoinFriendSit))
            {
               if((pgData.joinFriendId) && !(this.ptModel.getUserByZid(pgData.joinFriendId) == null))
               {
               }
               this.clearJoinFriendFlags();
            }
            this.closeHsmRakeShout("FiveHands");
         }
         else
         {
            if(_loc3_)
            {
               _loc3_.sStatusText = "satout";
            }
            for each (_loc7_ in this.ptModel.aUsersInHand)
            {
               this._cardController.dealDummyCard(_loc7_.nSit,true);
            }
            this.displayPopupNextHand();
         }
         this.ptModel.sHandStatus = HandStatus.PRE_FLOP;
         this.startHandSittingIDs = new Array();
         for each (_loc4_ in this.ptModel.aUsers)
         {
            this.startHandSittingIDs.push(_loc4_);
         }
      }
      
      private function showViewerBet() : void {
         var _loc4_:* = undefined;
         var _loc1_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         var _loc2_:Array = this.ptModel.aUsersInHand;
         var _loc3_:* = false;
         for (_loc4_ in _loc2_)
         {
            if(_loc1_ == _loc2_[_loc4_] && !(_loc1_.sStatusText == "satout"))
            {
               _loc3_ = true;
               this.ptView.onReasonToClear();
               break;
            }
         }
         if(_loc3_)
         {
            this._bettingControls.showControls();
            this.ptView.updatePopupNextHand();
         }
         else
         {
            this._bettingControls.hideControls(this.isSeated());
         }
      }
      
      private function onMarkTurn(param1:Object) : void {
         var _loc2_:RMarkTurn = RMarkTurn(param1);
         this.ptModel.nCurrentTurn = _loc2_.sit;
         this.startPlayerTurn(_loc2_.sit,_loc2_.time,_loc2_.elapsed);
         this.handleBetting(_loc2_.sit);
         if(!this.haveBettingControlsArrowsShown && (this.ptModel.isTutorialEnabled()) && pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.haveBettingControlsArrowsShown = true;
            this.pControl.showTutorialArrows(this.pControl.layerManager.getLayer(PokerControllerLayers.COMMON_LAYER) as DisplayObjectContainer,[
               {
                  "x":255,
                  "y":380,
                  "rotation":33
               },
               {
                  "x":505,
                  "y":380,
                  "rotation":147
               }],5);
         }
         if(pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.provCtrl.hideProv();
         }
      }
      
      private function handleBetting(param1:int) : void {
         var _loc2_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if(!_loc2_ && !_loc3_)
         {
            return;
         }
         var _loc4_:* = false;
         if((_loc3_) && _loc3_.sStatusText == "allin")
         {
            this._bettingControls.hideControls(this.isSeated());
            this._bettingControls.showPreBet(_loc4_);
            return;
         }
         if(_loc2_ != _loc3_)
         {
            _loc4_ = true;
         }
         if(_loc2_ == _loc3_)
         {
            if(_loc3_.sStatusText == "allin")
            {
               this._bettingControls.hideControls(this.isSeated());
            }
            else
            {
               if(_loc3_.sStatusText == "satout")
               {
                  this._bettingControls.hideControls(this.isSeated());
               }
               else
               {
                  if(this.isSeated())
                  {
                     this._bettingControls.showControls();
                  }
               }
            }
         }
         if(!this._bettingControls.isBotButtonLock() && _loc2_ == _loc3_ && _loc3_.nChips > 0)
         {
            _loc4_ = this._bettingControls.executePreBetAction(this.ptModel.nCallAmt);
         }
         this._bettingControls.showPreBet(_loc4_);
      }
      
      private function onReplayHoles(param1:Object) : void {
         var _loc2_:RReplayHoles = RReplayHoles(param1);
         var _loc3_:Object = 
            {
               "seat":_loc2_.sit,
               "card1":String(_loc2_.card1),
               "suit1":_loc2_.suit1,
               "card2":String(_loc2_.card2),
               "suit2":_loc2_.suit2,
               "smallSeat":-1
            };
         this._cardController.setupNewHand(_loc3_);
         this._cardController.replayDeal(_loc3_.seat);
         this._bettingControls.showControls();
         this.ptView.updatePopupNextHand();
      }
      
      private function onFold(param1:Object) : void {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc2_:RFold = RFold(param1);
         this.ptModel.setPlayerStatus(_loc2_.sit,"fold");
         this.playerFolded(_loc2_.sit);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if((((this.ptModel.viewer) && (this.ptModel.viewer.zid)) && (_loc3_)) && (_loc3_.zid) && !(_loc3_.zid == this.ptModel.viewer.zid))
         {
            _loc4_ = _loc3_.nSit;
         }
         else
         {
            this.pyhViewerFolded = true;
            this._cardController.clearHoleCards();
            _loc4_ = -1;
            this.pokerQuizTest();
            if((this.ptModel.configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament)
            {
               commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.UPDATE_DAILYCHALLENGE,{"winStreak":0}));
            }
            if(this.ptModel.isFirstFold)
            {
               this.ptModel.isFirstFold = false;
               if(!this.ptModel.configModel.isFeatureEnabled("dailyChallenge"))
               {
                  dispatchEvent(new MGEvent(MGEvent.MG_MAXIMIZE_GAME_BY_TYPE,{"type":MinigameUtils.HIGHLOW}));
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:Table:OpenHighLowOnFirstFold:2012-07-13"));
               }
               if(this.ptModel.configModel.getBooleanForFeatureConfig("megaBillions","surfaceFlyoutAtTable"))
               {
                  this.pControl.navControl.navView.showMegaBillionsFTUEArrow();
               }
            }
            if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && (externalInterface.available))
            {
               if(!pgData.hasFolded)
               {
                  externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.WHEN_TO_FOLD_ID);
                  pgData.hasFolded = true;
               }
            }
            this.ptView.updatePopupNextHand(true,LocaleManager.localize("flash.table.message.waitNextHand"));
         }
         if(_loc3_)
         {
            _loc5_ = LocaleManager.localize("flash.table.dealer.fold",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true)});
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_FOLD,PokerSoundEvent.CNAME_PLAY));
         this.addDealerMessage(_loc5_);
         if(_loc3_)
         {
            this.animateGiftItem(_loc2_.sit,"lose");
         }
      }
      
      private function clientHandIsOver(param1:Boolean=false) : void {
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         this.clientHandsEnded++;
         var _loc2_:Object = {};
         if(!this.clientHandOverFlag)
         {
            this.clientHandOverFlag = true;
            if((pgData.dispMode == "challenge") && (this.tipController) && !(this.tipController.tipAmountSmallBlind == 0))
            {
               this.tipController.init(this.ptModel.nSmallblind,pgData.points - this.ptModel.getViewer().nChips);
               AtTableEraseLossManager.getInstance().incrementHandCount();
               if(param1)
               {
                  _loc2_.handsWon = 1;
                  _loc2_.winStreak = 1;
                  this.tipController.showDealerCongrats(this.ptModel.getViewer().sUserName);
               }
               else
               {
                  if(this.isActiveInHand() === true)
                  {
                     _loc2_.winStreak = 0;
                  }
                  externalInterface.call("zc.game.poker.recentActions.tracker.track","handsLost",1);
                  if((this.ptModel.configModel.isFeatureEnabled("atTableEraseLoss")) && pgData.dispMode == TableDisplayMode.CHALLENGE_MODE)
                  {
                     _loc3_ = configModel.getFeatureConfig("atTableEraseLoss");
                     if((_loc3_) && (AtTableEraseLossManager.getInstance().checkIfShowAtTableEraseLoss(_loc3_,pgData.points)))
                     {
                        _loc4_ = this.ptModel.getSeatNum(this.ptModel.viewer.zid);
                        if(_loc4_ != -1)
                        {
                           _loc5_ = AtTableEraseLossManager.getInstance().chipsBeforeHandStarted;
                           AtTableEraseLossManager.getInstance().resetChipsBeforeHandStarted();
                           if(_loc5_ > 0 && _loc5_ - pgData.points > 0)
                           {
                              AtTableEraseLossManager.getInstance().shown();
                              dispatchEvent(new AtTableEraseLossPopupEvent("atTableEraseLossCheck") as PopupEvent);
                           }
                        }
                     }
                  }
               }
            }
         }
         if((this.ptModel.configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament)
         {
            commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.UPDATE_DAILYCHALLENGE,_loc2_));
         }
         if((this.ptModel.configModel.getBooleanForFeatureConfig("megaBillions","surfaceFlyoutAtTable")) && this.clientHandsEnded >= 5)
         {
            this.pControl.navControl.navView.showMegaBillionsFTUEArrow();
         }
      }
      
      private function userWonChips(param1:int) : void {
         var _loc2_:Object = null;
         if(((pgData) && (pgData.hasOwnProperty("leaderboardData"))) && (pgData.leaderboardData.hasOwnProperty("leaderBoard")) && (pgData.leaderboardData.leaderBoard.hasOwnProperty("friends")))
         {
            for each (_loc2_ in pgData.leaderboardData.leaderBoard.friends)
            {
               if((_loc2_.hasOwnProperty("user")) && _loc2_.user === true)
               {
                  if(_loc2_.hasOwnProperty("value"))
                  {
                     _loc2_.value = _loc2_.value + param1;
                  }
                  else
                  {
                     _loc2_.value = param1;
                  }
                  break;
               }
            }
            pgData.leaderboardData.leaderBoard.friends.sortOn("value",Array.DESCENDING | Array.NUMERIC);
         }
         if(param1 > 0 && (this.ptModel.configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament)
         {
            commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.UPDATE_DAILYCHALLENGE,{"chipsWon":param1}));
         }
      }
      
      private function publishOGStory() : void {
         var _loc1_:Array = null;
         var _loc2_:PokerUser = null;
         if((this.ptModel.room.gameType == "Challenge") && (this.ptModel.tableConfig) && this.ptModel.tableConfig.tourneyId == -1)
         {
            _loc1_ = new Array();
            for each (_loc2_ in this.ptModel.aUsers)
            {
               if(_loc2_ is PokerUser && !(_loc2_.zid == pgData.viewer.zid) && _loc2_.nSit > -1)
               {
                  _loc1_.push(_loc2_.zid);
               }
            }
            externalInterface.call("ZY.App.openGraph.publishMeet",_loc1_,pgData.gameRoomStakes);
         }
      }
      
      private function updatePlayerAction(param1:int, param2:Number, param3:Number, param4:String) : void {
         var _loc5_:PokerUser = this.ptModel.getUserBySit(param1);
         this.ptModel.updatePlayerAction(param1,param2,param3,param4);
         this._chickletCtrl.setState(ChickletController.STATE_ACTION,param1);
         if(!(_loc5_.sStatusText == "fold") && _loc5_.nCurBet > 0)
         {
            this.updateUserChips(param1,_loc5_.nChips,_loc5_.nCurBet,_loc5_.sStatusText);
         }
         if(_loc5_.sStatusText == "fold")
         {
            this.playerFolded(param1);
         }
      }
      
      private function onTourneyOver(param1:Object) : void {
         var _loc3_:* = false;
         var _loc2_:RTourneyOver = RTourneyOver(param1);
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.showdownRoomId))
         {
            dispatchEvent(new ShowdownCongratsPopupEvent("showShowdownCongrats",_loc2_.place,_loc2_.win) as PopupEvent);
         }
         else
         {
            if(pgData.dispMode == "shootout" || pgData.dispMode == "premium")
            {
               dispatchEvent(new ShootoutCongratsPopupEvent("showShootoutCongrats",_loc2_.place,_loc2_.win) as PopupEvent);
               _loc3_ = this.ptModel.powerTourneyConfig.isCurrentlyHappyHour;
               if(_loc3_)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:PowerTourney_HappyHour:Over:BuyIn" + this.pControl.soConfig.nBuyin + ":Place_" + _loc2_.place + ":2012-12-12"));
               }
               else
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:PowerTourney:Over:BuyIn" + this.pControl.soConfig.nBuyin + ":Place_" + _loc2_.place + ":2012-12-12"));
               }
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:PowerTourney:Over:Total:2012-12-12"));
            }
            else
            {
               if(pgData.dispMode == "tournament")
               {
                  dispatchEvent(new TourneyCongratsPopupEvent("showTournamentCongrats",_loc2_.place,_loc2_.win) as PopupEvent);
               }
            }
         }
      }
      
      private function onCall(param1:Object) : void {
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc2_:RCall = RCall(param1);
         var _loc3_:* = "";
         var _loc4_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if((((_loc4_) && (this.ptModel.viewer)) && (_loc4_.zid)) && (this.ptModel.viewer.zid) && !(_loc4_.zid == this.ptModel.viewer.zid))
         {
            _loc5_ = _loc4_.nSit;
         }
         else
         {
            _loc5_ = -1;
         }
         if(_loc2_.bet > 0)
         {
            _loc6_ = "call";
            if(_loc4_)
            {
               _loc3_ = LocaleManager.localize("flash.table.dealer.call",
                  {
                     "actor":this.colorChatText(this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),_loc5_,true),
                     "amount":StringUtility.StringToMoney(_loc2_.bet)
                  });
            }
            this.addDealerMessage(_loc3_);
            dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_CALL,PokerSoundEvent.CNAME_PLAY));
         }
         else
         {
            _loc6_ = "check";
            if(_loc4_)
            {
               _loc3_ = LocaleManager.localize("flash.table.dealer.check",{"actor":this.colorChatText(this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),_loc5_,true)});
            }
            this.addDealerMessage(_loc3_);
            dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_CHECK,PokerSoundEvent.CNAME_PLAY));
         }
         this.updatePlayerAction(_loc2_.sit,_loc2_.chips,_loc2_.bet,_loc6_);
         if(pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.pointsLostInCurrentHand = this.pointsLostInCurrentHand + _loc2_.bet;
            this.pyhViewerChipsOnTable = this.pyhViewerChipsOnTable + _loc2_.bet;
         }
      }
      
      private function onAllin(param1:Object) : void {
         var _loc6_:PokerUser = null;
         var _loc7_:* = NaN;
         var _loc2_:RAllin = RAllin(param1);
         this.updatePlayerAction(_loc2_.sit,_loc2_.chips,_loc2_.bet,"allin");
         this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.raiseButton"));
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         var _loc4_:int = _loc3_.zid != this.ptModel.viewer.zid?_loc3_.nSit:-1;
         var _loc5_:String = LocaleManager.localize("flash.table.dealer.allIn",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true)});
         this.addDealerMessage(_loc5_);
         if(this.ptModel.getSeatNum(this.ptModel.viewer.zid) != -1)
         {
            _loc6_ = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
            _loc7_ = _loc2_.bet - _loc6_.nCurBet;
            _loc7_ = Math.min(_loc7_,_loc6_.nChips);
            this._bettingControls.updateCallPreBetButton(_loc7_);
         }
         if(_loc2_.bet > this.ptModel.nMinBuyIn)
         {
            dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_WIN_CHIPS,PokerSoundEvent.CNAME_PLAY));
         }
         else
         {
            dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_RAISE,PokerSoundEvent.CNAME_PLAY));
         }
         this.animateGiftItem(_loc2_.sit,"allIn");
         if(pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.pointsLostInCurrentHand = this.pointsLostInCurrentHand + _loc2_.bet;
            this.pyhViewerChipsOnTable = this.pyhViewerChipsOnTable + _loc2_.bet;
         }
      }
      
      private function onRaise(param1:Object) : void {
         var _loc2_:RRaise = RRaise(param1);
         this.updatePlayerAction(_loc2_.sit,_loc2_.chips,_loc2_.bet,"raise");
         this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.raiseButton"));
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         var _loc4_:int = _loc3_.zid != this.ptModel.viewer.zid?_loc3_.nSit:-1;
         var _loc5_:String = LocaleManager.localize("flash.table.dealer.raise",
            {
               "actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true),
               "amount":StringUtility.StringToMoney(_loc2_.bet)
            });
         this.addDealerMessage(_loc5_);
         if(this.ptModel.getSeatNum(this.ptModel.viewer.zid) != -1)
         {
            this._bettingControls.updateCallPreBetButton(_loc2_.bet - this.ptModel.getUserByZid(this.ptModel.viewer.zid).nCurBet);
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_RAISE,PokerSoundEvent.CNAME_PLAY));
         if(pgData.viewer.zid == this.ptModel.getZidBySit(_loc2_.sit))
         {
            this.pointsLostInCurrentHand = this.pointsLostInCurrentHand + _loc2_.bet;
            this.pyhViewerChipsOnTable = this.pyhViewerChipsOnTable + _loc2_.bet;
         }
      }
      
      private function onRaiseOption(param1:Object) : void {
         var _loc2_:RRaiseOption = RRaiseOption(param1);
         this.ptModel.nMinBet = _loc2_.minVal;
         this.ptModel.nMaxBet = _loc2_.maxVal;
         this.ptModel.nCallAmt = _loc2_.chipsCall;
         this._bettingControls.showRaiseOption(this._chipCtrl.getCurrentPot() + this._chipCtrl.getTotalOnTableBets(),_loc2_.raiseCountOverLimit);
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_TURN_START,PokerSoundEvent.CNAME_PLAY));
      }
      
      private function onCallOption(param1:Object) : void {
         var _loc2_:RCallOption = RCallOption(param1);
         this.ptModel.nCallAmt = _loc2_.chipsCall;
         this._bettingControls.showCallOption(this.ptModel.nCallAmt);
         dispatchEvent(new PokerSoundEvent("playSound_YourTurn",PokerSoundEvent.CNAME_PLAY_SEQUENCE));
      }
      
      private function onReplayCards(param1:Object) : void {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc2_:RReplayCards = RReplayCards(param1);
         var _loc3_:Array = _loc2_.commCards;
         this._cardController.setFlopCards(_loc3_);
         if(_loc3_.length > 3)
         {
            this._cardController.setStreetCard(_loc3_[3]);
         }
         if(_loc3_.length > 4)
         {
            this._cardController.setRiverCard(_loc3_[4]);
         }
         for (_loc4_ in _loc3_)
         {
            _loc5_ = _loc3_[_loc4_];
            this.replayComCard(_loc4_);
         }
         this._cardController.runPossibleHands();
      }
      
      private function onFlop(param1:Object) : void {
         var _loc2_:RFlop = RFlop(param1);
         var _loc3_:Array = [
            {
               "card":_loc2_.card1,
               "suit":_loc2_.tip1
            },
            {
               "card":_loc2_.card2,
               "suit":_loc2_.tip2
            },
            {
               "card":_loc2_.card3,
               "suit":_loc2_.tip3
            }];
         this._cardController.setFlopCards(_loc3_);
         this._cardController.dealFlop(false);
         this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.betButton"));
         this._cardController.runPossibleHands();
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_CARD_FLIP,PokerSoundEvent.CNAME_PLAY));
         this._bettingControls.updatePreBetCheckboxes();
         var _loc4_:PokerUser = this.ptModel.getUserByZid(pgData.viewer.zid,true);
         if(_loc4_ !== null)
         {
            if((this.ptModel.configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament && this.isActiveInHand() === true)
            {
               commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.UPDATE_DAILYCHALLENGE,{"handsPlayed":1}));
            }
            if(!this.hasHandStrengthArrowShown && this.ptModel.handsPlayedCounter >= 2 && (this.ptModel.isTutorialEnabled()))
            {
               this.hasHandStrengthArrowShown = true;
               this.pControl.showTutorialArrow(this.ptView as DisplayObjectContainer,245,470,33,5);
            }
         }
         this.isPreFlop = false;
      }
      
      private function onStreet(param1:Object) : void {
         var _loc2_:RStreet = RStreet(param1);
         this._cardController.setStreetCard(
            {
               "card":_loc2_.card1,
               "suit":_loc2_.tip1
            });
         this.dealStreet();
         this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.betButton"));
         this._cardController.runPossibleHands();
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_CARD_FLIP,PokerSoundEvent.CNAME_PLAY));
         this._bettingControls.updatePreBetCheckboxes();
         this.isPreFlop = false;
      }
      
      private function onRiver(param1:Object) : void {
         var _loc2_:RRiver = RRiver(param1);
         this._cardController.setRiverCard(
            {
               "card":_loc2_.card1,
               "suit":_loc2_.tip1
            });
         this.dealRiver();
         this._bettingControls.setRaiseButton(LocaleManager.localize("flash.table.controls.betButton"));
         this._cardController.runPossibleHands();
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_CARD_FLIP,PokerSoundEvent.CNAME_PLAY));
         this._bettingControls.updatePreBetCheckboxes();
         this.isPreFlop = false;
      }
      
      private function onClear(param1:Object) : void {
         var _loc3_:PokerUser = null;
         var _loc4_:String = null;
         this.clearTable();
         this.isPreFlop = true;
         var _loc2_:* = 0;
         while(_loc2_ < this.ptModel.aUsersInHand.length)
         {
            _loc3_ = this.ptModel.aUsersInHand[_loc2_] as PokerUser;
            _loc4_ = _loc3_.sStatusText.toLowerCase();
            if(((_loc3_) && (!(_loc4_ === "waiting"))) && (!(_loc4_ === "satout")) && !(_loc4_ === "wassatout"))
            {
               _loc3_.sStatusText = "waiting";
            }
            _loc2_++;
         }
         if(pgData.sn_id == pgData.SN_FACEBOOK && !(this.pControl.openGraphController == null) && !(this.openGraphData == null) && (this.openGraphData.currentUserWon))
         {
            this.pControl.openGraphController.onWinHand(this.openGraphData);
            this.openGraphData.currentUserWon = false;
            this.openGraphData.chipsWonInThisHand = 0;
         }
      }
      
      private function onWinners(param1:Object) : void {
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:PokerUser = null;
         var _loc12_:* = 0;
         var _loc2_:RWinners = RWinners(param1);
         var _loc3_:String = _loc2_.winningHand;
         var _loc4_:Array = _loc2_.winningHands;
         var _loc5_:* = -1;
         var _loc6_:* = false;
         var _loc7_:int = this.ptModel.getSeatNum(this.ptModel.viewer.zid);
         this.socialChallengeTest();
         this.potsCleared++;
         for (_loc8_ in _loc4_)
         {
            _loc5_ = _loc4_[_loc8_].sit;
            this.ptModel.updateWinner(_loc4_[_loc8_].sit,_loc4_[_loc8_].chips,_loc4_[_loc8_].card1,_loc4_[_loc8_].tip1,_loc4_[_loc8_].card2,_loc4_[_loc8_].tip2,_loc4_[_loc8_].handString,this.getBubbleMessage(_loc3_,_loc5_));
            _loc6_ = _loc8_ == 0?true:false;
            this._bettingControls.hideControls(this.isSeated());
            this.showWinner(_loc4_[_loc8_].sit,_loc2_.pot - 3,_loc6_);
            _loc10_ = _loc4_[_loc8_].handString[1];
            if(_loc10_)
            {
               this._cardController.showWinningCards(_loc4_[_loc8_]);
            }
            if(this.potsWinnersSit.indexOf(_loc5_) == -1)
            {
               this.potsWinnersSit.push(_loc5_);
               this.animateGiftItem(_loc5_,"bigWin");
            }
            if(_loc5_ == _loc7_)
            {
               if((this.ptModel.configModel.isFeatureEnabled("dailyChallenge")) && !this.ptModel.isTournament)
               {
                  commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.UPDATE_DAILYCHALLENGE,{"specificHand":_loc3_.substr(0,1)}));
               }
               if(this.ptModel.configModel.getIntForFeatureConfig("user","newUserPopup"))
               {
                  commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("finished_hand","won"));
               }
               _loc11_ = this.ptModel.getUserBySit(_loc5_);
               if(externalInterface.available)
               {
                  externalInterface.call("wonHand");
                  if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && pgData.doubleNewUserInitialChips > 1 && pgData.points >= pgData.doubleNewUserInitialChips)
                  {
                     externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.SHAKE_THAT_HEALTHY_STACK_ID);
                     pgData.doubleNewUserInitialChips = 1;
                  }
                  this.openGraphData.currentUserWon = true;
                  if(this.openGraphData.hasOwnProperty("chipsWonInThisHand") == false)
                  {
                     this.openGraphData.chipsWonInThisHand = 0;
                  }
                  this.openGraphData.chipsWonInThisHand = this.openGraphData.chipsWonInThisHand + (_loc11_.nChips - _loc11_.nOldChips);
                  this.openGraphData.hand_type = _loc3_.substr(0,1);
                  this.openGraphData.winningFiveCards = _loc4_[_loc8_].handString[1];
                  this.openGraphData.hole_cards = _loc4_[_loc8_].card1 + " " + _loc4_[_loc8_].tip1 + " " + _loc4_[_loc8_].card2 + " " + _loc4_[_loc8_].tip2;
                  this.openGraphData.stakes = BlindFormatter.parseBlinds(this.ptModel.sBlinds);
               }
               this.userWonChips(_loc11_.nChips - _loc11_.nStartHandChips);
               this.clientHandIsOver(true);
            }
            else
            {
               if(_loc7_ != -1)
               {
                  if(configModel.getIntForFeatureConfig("user","newUserPopup"))
                  {
                     commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("finished_hand","lost"));
                  }
                  this.clientHandIsOver();
               }
            }
         }
         _loc9_ = this.getBubbleMessage(_loc3_,_loc5_,true);
         if(_loc9_.length > 0)
         {
            this.addDealerMessage(_loc9_);
         }
         if(_loc2_.pot - 3 == 0)
         {
            this.addDealerMessage("_____________________________");
            this.addDealerMessage(" ");
            if(_loc4_.length == 1)
            {
               this.ptView.ptModel.nUltimateWinnerSit = _loc4_[0].sit;
            }
         }
         if(_loc3_ != "-1")
         {
            _loc12_ = int(_loc3_.substr(0,1));
            this.ptView.showWinningHandOnTable(this._bettingControls.getHandString(_loc12_));
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_WIN_CHIPS,PokerSoundEvent.CNAME_PLAY));
         this.sendBuddyCount();
         if(this.potsCleared == this.ptModel.aPots.length)
         {
            this.animateGiftItemsForLosersAndKnockedOut();
         }
      }
      
      private function sendBuddyCount() : void {
         var _loc4_:* = NaN;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:BuddyJoinBonus = null;
         var _loc11_:DisplayObject = null;
         var _loc12_:Point = null;
         var _loc13_:Point = null;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Number = this.ptModel.getSeatNum(this.ptModel.viewer.zid);
         if(_loc3_ != -1)
         {
            _loc4_ = 0;
            _loc5_ = new Array();
            _loc6_ = new Array();
            _loc7_ = this.pControl.getSameIDs();
            if(this.startHandSittingIDs != null)
            {
               _loc1_ = 0;
               while(_loc1_ < this.startHandSittingIDs.length)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc7_.length)
                  {
                     if(_loc7_[_loc2_]["uid"] == "1:" + this.startHandSittingIDs[_loc1_]["uid"])
                     {
                        _loc8_ = this.ptModel.getSeatNum(_loc7_[_loc2_]["uid"]);
                        if(_loc8_ != -1)
                        {
                           _loc4_++;
                           _loc5_.push([_loc7_[_loc2_]["uid"],_loc8_]);
                           _loc6_.push(_loc7_[_loc2_]["uid"]);
                        }
                     }
                     _loc2_++;
                  }
                  _loc1_++;
               }
            }
            if(_loc4_ > 0)
            {
               this.pControl.sendTableBuddyCount(_loc4_);
               if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.joinBonusEnabled))
               {
                  _loc9_ = 0;
                  _loc1_ = 0;
                  while(_loc1_ < _loc5_.length)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < pgData.playingBonusSentIDs.length)
                     {
                        if(_loc5_[_loc1_][0] == pgData.playingBonusSentIDs[_loc2_])
                        {
                           _loc9_++;
                        }
                        _loc2_++;
                     }
                     _loc1_++;
                  }
                  _loc5_.push([this.ptModel.viewer.zid,this.ptModel.getSeatNum(this.ptModel.viewer.zid)]);
                  if(_loc9_ < _loc5_.length-1)
                  {
                     if(pgData.nBudPlayBonus < 20)
                     {
                        this.sendBuddyBonus(_loc6_);
                     }
                     _loc1_ = 0;
                     while(_loc1_ < _loc5_.length)
                     {
                        if(pgData.nBudPlayBonus < 20)
                        {
                           _loc10_ = new BuddyJoinBonus(20);
                           this.ptView.addChild(_loc10_);
                           _loc11_ = DisplayObject(this._chickletCtrl.cView.chicklets[_loc5_[_loc1_][1]]);
                           _loc12_ = new Point(_loc11_.x,_loc11_.y);
                           _loc13_ = this.ptView.localToGlobal(_loc12_);
                           _loc10_.x = _loc13_.x;
                           _loc10_.y = _loc13_.y;
                           _loc10_.showBonus("$10");
                           pgData.playingBonusSentIDs.push(_loc5_[_loc1_][0]);
                        }
                        pgData.nBudPlayBonus++;
                        _loc1_++;
                     }
                  }
               }
            }
         }
      }
      
      public function getBubbleMessage(param1:String, param2:int, param3:Boolean=false) : String {
         var _loc14_:* = 0;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc4_:Number = Number(param1.substr(0,1));
         var _loc5_:* = "";
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:PokerUser = this.ptModel.getUserBySit(param2);
         if(param2 > -1)
         {
            _loc13_ = this.ptModel.getUserBySit(param2);
            if(!((((_loc13_) && (_loc13_.zid)) && (this.ptModel.viewer)) && (this.ptModel.viewer.zid) && !(_loc13_.zid == this.ptModel.viewer.zid)))
            {
               _loc14_ = -1;
            }
         }
         var _loc15_:Number = 0;
         if(param3)
         {
            _loc15_ = _loc13_.nChips - _loc13_.nOldChips;
         }
         var _loc16_:String = _loc13_?this.colorChatText(this.wrapChatZidLink(_loc13_.zid,_loc13_.sUserName),_loc14_,true):"";
         var _loc17_:String = StringUtility.StringToMoney(_loc15_);
         switch(_loc4_)
         {
            case 0:
               _loc18_ = param1.substr(1,2);
               _loc19_ = StringUtility.getCardVal(_loc18_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winHighCard",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "high":_loc19_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winHighCard",{"high":_loc19_});
               }
               break;
            case 1:
               _loc10_ = param1.substr(1,2);
               _loc6_ = param1.substr(5,2);
               _loc11_ = StringUtility.getCardVal(_loc10_);
               _loc9_ = StringUtility.getCardVal(_loc6_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winOnePair",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "pair":_loc11_,
                        "kicker":_loc9_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winOnePair",{"pair":_loc11_});
               }
               break;
            case 2:
               _loc20_ = param1.substr(1,2);
               _loc21_ = param1.substr(5,2);
               _loc6_ = param1.substr(9,2);
               _loc22_ = StringUtility.getCardVal(_loc20_);
               _loc23_ = StringUtility.getCardVal(_loc21_);
               _loc9_ = StringUtility.getCardVal(_loc6_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winTwoPair",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "pair1":_loc22_,
                        "pair2":_loc23_,
                        "kicker":_loc9_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winTwoPair",
                     {
                        "pair1":_loc22_,
                        "pair2":_loc23_
                     });
               }
               break;
            case 3:
               _loc24_ = param1.substr(1,2);
               _loc6_ = param1.substr(7,2);
               _loc12_ = StringUtility.getCardVal(_loc24_);
               _loc9_ = StringUtility.getCardVal(_loc6_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winThreeOfAKind",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "kid":_loc12_,
                        "kicker":_loc9_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winThreeOfAKind",{"kid":_loc12_});
               }
               break;
            case 4:
               _loc25_ = param1.substr(1,2);
               _loc26_ = StringUtility.getCardVal(_loc25_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winStraight",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "straight":_loc26_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winStraight",{"straight":_loc26_});
               }
               break;
            case 5:
               _loc7_ = param1.substr(1,2);
               _loc8_ = StringUtility.getCardVal(_loc7_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winFlush",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "flush":_loc8_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winFlush",{"flush":_loc8_});
               }
               break;
            case 6:
               _loc6_ = param1.substr(1,2);
               _loc12_ = StringUtility.getCardVal(_loc6_);
               _loc10_ = param1.substr(7,2);
               _loc11_ = StringUtility.getCardVal(_loc10_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winFullHouse",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "kid":_loc12_,
                        "pair":_loc11_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winFullHouse",
                     {
                        "kid":_loc12_,
                        "pair":_loc11_
                     });
               }
               break;
            case 7:
               _loc27_ = param1.substr(1,2);
               _loc28_ = StringUtility.getCardVal(_loc27_);
               _loc6_ = param1.substr(9,2);
               _loc9_ = StringUtility.getCardVal(_loc6_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winFourOfAKind",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "careu":_loc28_,
                        "kicker":_loc9_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winFourOfAKind",{"careu":_loc28_});
               }
               break;
            case 8:
               _loc7_ = param1.substr(1,2);
               _loc8_ = StringUtility.getCardVal(_loc7_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winStraightFlush",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "flush":_loc8_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winStraightFlush",{"flush":_loc8_});
               }
               break;
            case 9:
               _loc7_ = param1.substr(1,2);
               _loc8_ = StringUtility.getCardVal(_loc7_);
               if(param3)
               {
                  _loc5_ = LocaleManager.localize("flash.table.dealer.winRoyalFlush",
                     {
                        "actor":_loc16_,
                        "amount":_loc17_,
                        "flush":_loc8_
                     });
               }
               else
               {
                  _loc5_ = LocaleManager.localize("flash.table.hand.winRoyalFlush");
               }
               break;
         }
         
         return _loc5_;
      }
      
      private var quizShown:Boolean = false;
      
      private function pokerQuizTest() : void {
         if(!this.quizShown && (externalInterface.available))
         {
            this.quizShown = true;
            externalInterface.call("open_alert",{"pokerQuiz":true});
         }
      }
      
      public function onPokerQuizNotShown() : void {
         this.quizShown = false;
      }
      
      public var handsPlayedCount:Number = 1;
      
      public var stopTrackHandCount:Boolean = false;
      
      public var firstHandChoice:Number = 0;
      
      public var timesToShowShout:Number = 2;
      
      private function socialChallengeTest() : void {
         var _loc2_:* = 0;
         if(this.ptModel.socialChallengesGroup <= 0 || (this.stopTrackHandCount))
         {
            return;
         }
         if(this.firstHandChoice == 0)
         {
            this.firstHandChoice = Math.floor(Math.random() * 6) + 2;
         }
         var _loc1_:* = false;
         if(this.handsPlayedCount == this.firstHandChoice)
         {
            _loc1_ = true;
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ < this.timesToShowShout)
            {
               if(this.handsPlayedCount == this.firstHandChoice + 10 * _loc2_)
               {
                  _loc1_ = true;
               }
               _loc2_++;
            }
         }
         if(_loc1_)
         {
            externalInterface.call("open_alert",
               {
                  "socialChallenge":this.ptModel.socialChallengesGroup,
                  "feedPoints":this.pControl.navControl.getChips()
               });
         }
         this.handsPlayedCount++;
      }
      
      public function onSocialChallengeShoutNotShown() : void {
         this.firstHandChoice++;
      }
      
      private function onDefaultWinners(param1:Object) : void {
         var _loc2_:RDefaultWinners = RDefaultWinners(param1);
         this.socialChallengeTest();
         this.ptModel.updateDefaultWinner(_loc2_.sit,_loc2_.chips,_loc2_.pots);
         this._bettingControls.hideControls(this.isSeated());
         this.showDefaultWinner(_loc2_.sit,_loc2_.pots);
         this.ptView.ptModel.nUltimateWinnerSit = _loc2_.sit;
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         var _loc4_:int = _loc3_.zid != this.ptModel.viewer.zid?_loc3_.nSit:-1;
         var _loc5_:int = this.ptModel.getSeatNum(this.ptModel.viewer.zid);
         var _loc6_:String = LocaleManager.localize("flash.table.dealer.winDefault",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true)});
         this.addDealerMessage(_loc6_);
         this.addDealerMessage("_____________________________");
         this.addDealerMessage(" ");
         this._chipCtrl.clearBets();
         this.sendBuddyCount();
         this.animateGiftItem(_loc2_.sit,"win");
         if(_loc2_.sit == _loc5_)
         {
            if(this.ptModel.configModel.getIntForFeatureConfig("user","newUserPopup"))
            {
               commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("finished_hand","won"));
            }
            if(externalInterface.available)
            {
               externalInterface.call("wonHand");
               if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && pgData.doubleNewUserInitialChips > 1 && pgData.points >= pgData.doubleNewUserInitialChips)
               {
                  externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.SHAKE_THAT_HEALTHY_STACK_ID);
                  pgData.doubleNewUserInitialChips = 1;
               }
               if(pgData.enableZPWC)
               {
                  externalInterface.call("zc.feature.zpwc.playHand",true);
               }
            }
            if(_loc3_.nChips !== _loc3_.nOldChips)
            {
               this.userWonChips(_loc3_.nChips - _loc3_.nStartHandChips);
            }
            this.clientHandIsOver(true);
         }
         else
         {
            if(_loc5_ != -1)
            {
               if(this.ptModel.configModel.getIntForFeatureConfig("user","newUserPopup"))
               {
                  commandDispatcher.dispatchCommand(new FireZTrackMilestoneHitCommand("finished_hand","lost"));
               }
               this.clientHandIsOver();
            }
         }
      }
      
      private function onAllinWar(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:RAllinWar = RAllinWar(param1);
         var _loc3_:Array = _loc2_.hands;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = 
               {
                  "seat":_loc3_[_loc4_].sit,
                  "card1":_loc3_[_loc4_].card1,
                  "suit1":_loc3_[_loc4_].tip1,
                  "card2":_loc3_[_loc4_].card2,
                  "suit2":_loc3_[_loc4_].tip2
               };
            this._cardController.setHoleCards(_loc5_);
            this.showHoleCards(_loc5_.seat);
            _loc4_++;
         }
      }
      
      private function onShowAllHoles(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:RShowAllHoles = RShowAllHoles(param1);
         var _loc3_:Array = _loc2_.hands;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = 
               {
                  "seat":_loc3_[_loc4_].sit,
                  "card1":_loc3_[_loc4_].card1,
                  "suit1":_loc3_[_loc4_].suit1,
                  "card2":_loc3_[_loc4_].card2,
                  "suit2":_loc3_[_loc4_].suit2
               };
            this._cardController.setHoleCards(_loc5_);
            this._cardController.showAllHoles(_loc3_[_loc4_].sit);
            _loc4_++;
         }
      }
      
      private function onReplayPots(param1:Object) : void {
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc2_:RReplayPots = RReplayPots(param1);
         var _loc3_:Array = _loc2_.pots;
         for (_loc4_ in _loc3_)
         {
            _loc5_ = false;
            if(_loc4_ == _loc3_.length-1)
            {
               _loc5_ = true;
            }
            this.ptModel.setPot(_loc4_,_loc3_[_loc4_]);
            this._chipCtrl.replayPot(_loc4_,_loc5_);
         }
         this._cardController.runPossibleHands();
      }
      
      private function onReplayPlayers(param1:Object) : void {
         var _loc4_:* = undefined;
         var _loc2_:RReplayPlayers = RReplayPlayers(param1);
         var _loc3_:Array = _loc2_.sits;
         for (_loc4_ in _loc3_)
         {
            this._cardController.showPlayerCards(_loc3_[_loc4_]);
         }
         this._cardController.runPossibleHands();
      }
      
      private function onMakePot(param1:Object) : void {
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc2_:RMakePot = RMakePot(param1);
         var _loc3_:Array = _loc2_.pots;
         for (_loc4_ in _loc3_)
         {
            _loc5_ = false;
            if(_loc4_ == _loc3_.length-1)
            {
               _loc5_ = true;
            }
            this.ptModel.setPot(_loc4_,_loc3_[_loc4_]);
            this.statusCleanup();
            this._chipCtrl.makePot(_loc4_,this.ptModel.getPotById(_loc4_).nAmt,_loc5_);
         }
      }
      
      private function onReceiveChat(param1:Object) : void {
         var _loc2_:RReceiveChat = RReceiveChat(param1);
         var _loc3_:Boolean = _loc2_.sZid == pgData.zid || this.ptModel.getSeatNum(_loc2_.sZid) >= 0 || !(pgData.aFriendZids == null) && pgData.aFriendZids.indexOf(_loc2_.sZid) >= 0 || (_loc2_.bIsModerator)?true:false;
         if(_loc3_)
         {
            this._chatCtrl.newChatMessage(this.htmlEncode(_loc2_.sUserName),_loc2_.sMessage,String(this.ptModel.uidObfuscator.addUserWithUID(_loc2_.sZid)),_loc2_.bIsModerator);
         }
      }
      
      private function onGetUsersInRoom(param1:Object) : void {
         var _loc2_:RGetUsersInRoom = RGetUsersInRoom(param1);
         this.ptModel.updateUsersInRoom(_loc2_.userList);
         dispatchEvent(new TCEvent(TCEvent.USERSINROOM_UPDATED));
      }
      
      private function onCheckMuteList(param1:TCEvent) : void {
         if(this.isMutePressed)
         {
            this.isMutePressed = false;
            this._chatCtrl.showMuteList();
         }
      }
      
      private function sendBuddyBonus(param1:Array) : void {
         var output:String = null;
         var bonusids:Array = param1;
         output = "";
         var myFunction:Function = function(param1:*, param2:int, param3:Array):void
         {
            output = output + (param1 + ",");
         };
         bonusids.forEach(myFunction,this);
         var blist:String = output.slice(0,output.length-1);
         externalInterface.call("issueBuddyJoinBonus","tablebonus",blist,this.pControl.navControl.getChips());
      }
      
      private function popupSpecJoin(param1:String) : void {
         externalInterface.call("ZY.App.f.showFriendNotPlayingByName",param1);
      }
      
      private function popupFriendJoinGone(param1:String) : void {
         externalInterface.call("ZY.App.f.showFriendNotAtTableByName",param1);
      }
      
      private function onCheckJoinFriend(param1:TCEvent) : void {
         if(this.isCheckSpectator)
         {
            this.isCheckSpectator = false;
            if(this.ptModel.checkUserInRoom(pgData.joinFriendId))
            {
               this.popupSpecJoin(pgData.joinFriendName);
            }
            else
            {
               this.popupFriendJoinGone(pgData.joinFriendName);
            }
         }
      }
      
      private function onUpdateChips(param1:Object) : void {
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         var _loc7_:PokerUser = null;
         var _loc8_:Object = null;
         var _loc2_:RUpdateChips = RUpdateChips(param1);
         var _loc3_:Array = _loc2_.playerChips;
         var _loc4_:Boolean = (this.ptModel.tableConfig) && this.ptModel.tableConfig.tourneyId > -1?true:false;
         for (_loc5_ in _loc3_)
         {
            _loc6_ = _loc3_[_loc5_];
            this.ptModel.updateUserTotal(_loc6_.sit,_loc6_.chips,_loc6_.total);
            _loc7_ = this.ptModel.getUserBySit(_loc6_.sit);
            if((this.isSeated()) && (pgData.isMe(_loc7_.zid)))
            {
               pgData.points = _loc6_.total;
               externalInterface.call("zc.game.poker.recentActions.tracker.track","chips",_loc6_.total);
               _loc8_ = configModel.getFeatureConfig("atTableEraseLoss");
               if(_loc8_)
               {
                  AtTableEraseLossManager.getInstance().updateHighestAmountOfChips(_loc8_,pgData.points);
               }
               dispatchEvent(new TCEvent(TCEvent.USER_CHIPS_UPDATED));
               this.pointsLostInCurrentHand = 0;
               this.blindsLostInCurrentHand = 0;
            }
            if(!_loc4_)
            {
               try
               {
                  this.pControl.ladderBridge.send("onLadderUpdate",this.ptModel.getUserBySit(_loc6_.sit).zid,this.ptModel.getUserBySit(_loc6_.sit).nTotalPoints,this.ptModel.getUserBySit(_loc6_.sit).nAchievementRank,false);
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         if(!_loc4_)
         {
            try
            {
               this.pControl.ladderBridge.send("onLadderUpdate","",-1,-1,true);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function onDealerTipped(param1:Object) : void {
         var _loc2_:RDealerTipped = null;
         var _loc3_:PokerUser = null;
         var _loc4_:PokerUser = null;
         if(this.tipController.tipAmountSmallBlind)
         {
            _loc2_ = RDealerTipped(param1);
            _loc3_ = this.ptModel.getUserBySit(_loc2_.fromSit);
            if(_loc3_ == null)
            {
               for each (_loc4_ in this.ptModel.aUsersInRoom)
               {
                  if(_loc2_.fromSit == _loc4_.nSit)
                  {
                     _loc3_ = _loc4_;
                     break;
                  }
               }
            }
            if(_loc3_)
            {
               this.tipController.showDealerThanks(_loc3_.sUserName);
            }
         }
      }
      
      private function onDealerTipTooExpensive(param1:Object) : void {
         this.tipController.showNotEnoughChips();
      }
      
      private function onBoughtGift2(param1:Object) : void {
         var _loc4_:PokerUser = null;
         var _loc5_:PokerUser = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:RBoughtGift2 = RBoughtGift2(param1);
         var _loc3_:GiftItem = GiftLibrary.GetInst().GetGift(String(_loc2_.giftId));
         if(_loc2_.giftId == 444 || _loc2_.giftId == 445)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:TipGiftReceived:2011-11-30"));
         }
         if(_loc2_.senderSit != -1)
         {
            _loc4_ = this.ptModel.getUserBySit(_loc2_.senderSit);
            if(!(_loc3_ == null) && !_loc3_.isPremium)
            {
               _loc4_.nChips = _loc2_.fromChips;
            }
            _loc5_ = this.ptModel.getUserBySit(_loc2_.toSit);
            try
            {
               this.pControl.ladderBridge.send("onLadderUpdate",this.ptModel.getUserBySit(_loc2_.senderSit).zid,this.ptModel.getUserBySit(_loc2_.senderSit).nTotalPoints,this.ptModel.getUserBySit(_loc2_.senderSit).nAchievementRank,false);
            }
            catch(e:Error)
            {
            }
            try
            {
               this.pControl.ladderBridge.send("onLadderUpdate","",-1,-1,true);
            }
            catch(e:Error)
            {
            }
            if(!this.isViewerAllowedToSeeGiftId(_loc2_.giftId))
            {
               return;
            }
            if(_loc3_ == null)
            {
               return;
            }
            this._chickletCtrl.sendGift(_loc2_.senderSit,_loc2_.toSit,_loc2_.giftId);
            _loc6_ = "";
            if(pgData.isMe(_loc5_.zid))
            {
               _loc6_ = _loc2_.senderSit == _loc5_.nSit?"flash.table.dealer.giftToSelf":"flash.table.dealer.giftFromOther";
            }
            else
            {
               if(_loc2_.senderSit != _loc2_.toSit)
               {
                  _loc6_ = pgData.isMe(_loc4_.zid)?"flash.table.dealer.giftToOther":"flash.table.dealer.otherGiftToOther";
               }
               else
               {
                  _loc6_ = "flash.table.dealer.otherGiftToSelf";
               }
            }
            _loc7_ = _loc3_.msActionText;
            _loc8_ = this.colorChatText(this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),_loc2_.senderSit,true);
            _loc9_ = this.colorChatText(this.wrapChatZidLink(_loc5_.zid,_loc5_.sUserName),_loc2_.toSit,true);
            _loc10_ = LocaleManager.localize(_loc6_,
               {
                  "gift":_loc7_,
                  "sender":_loc8_,
                  "receiver":_loc9_
               });
            if(pgData.isMe(_loc5_.zid))
            {
               this.pgData.shownGiftID = _loc2_.giftId;
               this.pControl.setShownGift(_loc2_.giftId);
               _loc5_.nGiftId = _loc2_.giftId;
            }
            else
            {
               _loc5_.nGiftId = _loc2_.giftId;
            }
            this.newSocialChatMessage(_loc10_);
         }
         else
         {
            this.pgData.shownGiftID = _loc2_.giftId;
            this.pControl.setShownGift(_loc2_.giftId);
         }
      }
      
      private function onUserGifts(param1:Object) : void {
         var _loc2_:RUserGifts = RUserGifts(param1);
         dispatchEvent(new GiftPopupEvent("showDrinkMenu",_loc2_.sit,_loc2_.gifts) as PopupEvent);
      }
      
      private function onUserGifts2(param1:Object) : void {
         var _loc2_:RUserGifts2 = RUserGifts2(param1);
         dispatchEvent(new GiftPopupEvent("showDrinkMenu",_loc2_.sit,_loc2_.gifts) as PopupEvent);
      }
      
      private function onGiftShown2(param1:Object) : void {
         var _loc3_:PokerUser = null;
         var _loc2_:RGiftShown2 = RGiftShown2(param1);
         if(_loc2_.sit != -1)
         {
            _loc3_ = this.ptModel.getUserBySit(_loc2_.sit);
            _loc3_.nGiftId = _loc2_.giftId;
            this._chickletCtrl.placeGift(_loc2_.sit,_loc2_.giftId);
         }
      }
      
      private function onBuddyRequest(param1:Object) : void {
         var _loc2_:RBuddyRequest = RBuddyRequest(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(_loc2_.zid);
         var _loc4_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if((_loc3_) && (_loc4_))
         {
            this._invCtrl.sendBI(_loc3_.nSit,_loc4_.nSit,true);
         }
         var _loc5_:PokerUser = this.ptModel.getUserByZid(_loc2_.zid);
         var _loc6_:BuddyInvite = new BuddyInvite(_loc2_.shoutId,_loc2_.zid,_loc2_.name,_loc5_.sPicURL);
         pgData.addBuddyInvite(_loc6_);
         this.updateInbox();
      }
      
      private function onNewBuddy(param1:Object) : void {
         var _loc2_:RNewBuddy = RNewBuddy(param1);
         var _loc3_:String = LocaleManager.localize("flash.table.dealer.newBuddy",{"name":this.wrapChatZidLink(_loc2_.zid,_loc2_.name)});
         this.addDealerMessage(_loc3_);
      }
      
      public function onAddBuddy(param1:String) : void {
         this.addBuddyRequestZidToRequestArray(param1);
         var _loc2_:PokerUser = this.ptModel.getUserByZid(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if((_loc2_) && (_loc3_))
         {
            this._invCtrl.sendBI(_loc3_.nSit,_loc2_.nSit,false);
         }
      }
      
      private function onCardOptions(param1:Object) : void {
         var _loc13_:* = NaN;
         var _loc2_:RCardOptions = RCardOptions(param1);
         var _loc3_:String = _loc2_.zid;
         var _loc4_:String = _loc2_.msgType;
         var _loc5_:* = false;
         var _loc6_:* = true;
         var _loc7_:Boolean = pgData.isMe(_loc3_);
         var _loc8_:Boolean = pgData.isFriend(_loc3_);
         var _loc9_:Boolean = this.hasUserAlreadySentAddBuddyInvite(_loc3_);
         var _loc10_:* = false;
         var _loc11_:* = false;
         if(!_loc7_ && (this.isSeated(_loc3_)) && (this.isSeated()) && !_loc8_)
         {
            _loc10_ = true;
         }
         if(_loc4_ == "addBuddy")
         {
            _loc6_ = false;
            if((_loc10_) && !_loc9_)
            {
               _loc5_ = true;
            }
         }
         else
         {
            if(_loc4_ == "ignoreAll")
            {
               _loc6_ = true;
               if((_loc10_) && !_loc9_)
               {
                  _loc5_ = true;
                  _loc6_ = false;
                  _loc11_ = true;
               }
            }
            else
            {
               if(_loc4_ == "ignoreBuddy")
               {
                  _loc6_ = true;
               }
               else
               {
                  _loc9_ = true;
               }
            }
         }
         var _loc12_:UserProfile = this.ptModel.getUserProfileByZid(_loc3_);
         if(_loc12_ != null)
         {
            if(this.chickletClicked)
            {
               this.chickletClicked = false;
               if(!this.isSeated(pgData.zid))
               {
                  this.pControl.showProfile(_loc3_,_loc12_.username);
               }
            }
            else
            {
               if(_loc6_)
               {
                  if((_loc7_) || (_loc5_) || (_loc8_))
                  {
                     _loc6_ = false;
                  }
               }
               _loc13_ = this.ptModel.getSeatNum(_loc3_);
               this._chickletCtrl.showChickletMenu(this.chickletMenuShowPosX,this.chickletMenuShowPosY,[_loc12_],_loc7_,_loc8_,_loc5_,(_loc9_) || (_loc6_),_loc11_,_loc13_);
            }
         }
      }
      
      private function hasUserAlreadySentAddBuddyInvite(param1:String) : Boolean {
         return this.hasUserBeenInvited(param1);
      }
      
      private function onMuteMod(param1:TVEMuteMod) : void {
         this.ptModel.muteToggle(param1.zid,param1.action);
      }
      
      private function onInvitePressed(param1:TVEvent) : void {
         if(this.isSeated())
         {
            dispatchEvent(new PopupEvent("showBuddyDialog"));
         }
      }
      
      private function onGiftPressed(param1:TVEGiftPressed) : void {
         var _loc2_:String = null;
         var _loc6_:Array = null;
         fireStat(new PokerStatHit("GiftIconClick_Table",9,23,2010,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:Player:GiftIcon:GiftShop:2009-09-23",null,1));
         var _loc3_:PokerUser = this.ptModel.getUserBySit(param1.sit);
         if(this.ptModel.getUserByZid(pgData.zid) == null)
         {
            _loc2_ = pgData.zid;
         }
         else
         {
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.zid;
            }
            else
            {
               _loc2_ = pgData.zid;
            }
         }
         var _loc4_:String = null;
         var _loc5_:Object = this.ptModel.giftConfig;
         if((!(_loc3_.zid == pgData.zid)) && (_loc5_) && (_loc5_.giftActions) && (_loc4_ = _loc5_.giftActions[String(_loc3_.nGiftId)]))
         {
            _loc6_ = _loc4_.split(",");
            switch(_loc6_[0])
            {
               case "getChips":
                  commandDispatcher.dispatchCommand(new ShowBuyPageCommand("left","specialgiftevt","chips"));
                  break;
               case "callJS":
                  externalInterface.call(_loc6_[1]);
                  break;
            }
            
         }
         else
         {
            this.bGiftIconRequestedGiftShop = true;
            this.sGiftIconRequestZid = _loc2_;
            this.pControl.getGiftPrices3(-1,_loc2_,false);
            this.pControl.navControl.setSidebarItemsSelected("giftshop");
         }
      }
      
      private function onJoinRoom(param1:Object) : void {
         this.handsAtThisTable = 0;
      }
      
      private function onSendGiftChips(param1:Object) : void {
         var _loc2_:RSendGiftChips = RSendGiftChips(param1);
         var _loc3_:String = this.ptModel.getUserBySit(_loc2_.fromSit).sUserName;
         var _loc4_:String = this.ptModel.getUserBySit(_loc2_.toSit).sUserName;
         var _loc5_:Number = _loc2_.amount;
         var _loc6_:PokerUser = this.ptModel.getUserBySit(_loc2_.fromSit);
         _loc6_.nChips = _loc2_.fromChips;
         var _loc7_:PokerUser = this.ptModel.getUserBySit(_loc2_.toSit);
         _loc7_.nChips = _loc2_.toChips;
         this._chipCtrl.sendChips(_loc5_,_loc2_.fromSit,_loc2_.toSit);
         var _loc8_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if(_loc6_ == _loc8_ && pgData.sn_id == 1)
         {
            this.fireFBFeedChipGift(_loc7_.zid);
         }
         var _loc9_:int = _loc6_.zid != this.ptModel.viewer.zid?_loc6_.nSit:-1;
         var _loc10_:int = _loc7_.zid != this.ptModel.viewer.zid?_loc7_.nSit:-1;
         var _loc11_:String = this.colorChatText(this.wrapChatZidLink(this.ptModel.getUserBySit(_loc2_.fromSit).zid,_loc3_),_loc9_);
         var _loc12_:String = this.colorChatText(this.wrapChatZidLink(this.ptModel.getUserBySit(_loc2_.toSit).zid,_loc4_),_loc10_);
         var _loc13_:String = LocaleManager.localize("flash.table.dealer.giveChips",
            {
               "sender":_loc11_,
               "receiver":_loc12_,
               "amount":StringUtility.StringToMoney(_loc5_)
            });
         this.newSocialChatMessage(_loc13_);
         if(_loc9_ != -1)
         {
            try
            {
               this.pControl.ladderBridge.send("onLadderUpdate",this.ptModel.getUserBySit(_loc9_).zid,this.ptModel.getUserBySit(_loc9_).nTotalPoints,this.ptModel.getUserBySit(_loc9_).nAchievementRank,false);
            }
            catch(e:Error)
            {
            }
         }
         if(_loc10_ != -1)
         {
            try
            {
               this.pControl.ladderBridge.send("onLadderUpdate",this.ptModel.getUserBySit(_loc10_).zid,this.ptModel.getUserBySit(_loc10_).nTotalPoints,this.ptModel.getUserBySit(_loc10_).nAchievementRank,false);
            }
            catch(e:Error)
            {
            }
         }
         try
         {
            this.pControl.ladderBridge.send("onLadderUpdate","",-1,-1,true);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onHandStrengthPressed(param1:TVEvent) : void {
         if(pgData.rakeEnabled)
         {
            this.onRakeEnabled();
         }
         else
         {
            this.onRakeDisabled(false);
         }
      }
      
      private function fireFBFeedChipGift(param1:String) : void {
         var passZid:String = null;
         var oneLine:String = null;
         var feedPause:Timer = null;
         var inZid:String = param1;
         passZid = inZid;
         if(pgData.bFbFeedAllow)
         {
            spawnFeed = function(param1:TimerEvent):void
            {
               feedPause.stop();
               feedPause = null;
               pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_GAVECHIPS,-1,passZid,oneLine);
            };
            pgData.bFbFeedAllow = false;
            oneLine = "0";
            if(pgData.bFbFeedOptin)
            {
               oneLine = "1";
            }
            feedPause = new Timer(1500,0);
            feedPause.addEventListener(TimerEvent.TIMER,spawnFeed);
            feedPause.start();
         }
      }
      
      public function onBuyinError(param1:Object) : void {
         var _loc2_:RBuyinError = RBuyinError(param1);
         var _loc3_:String = LocaleManager.localize("flash.message.defaultTitle");
         var _loc4_:String = LocaleManager.localize("flash.message.table.buyinErrorMessage",
            {
               "chips":StringUtility.StringToMoney(_loc2_.chips),
               "chip":
                  {
                     "type":"tk",
                     "key":"chip",
                     "attributes":"",
                     "count":int(_loc2_.chips)
                  }
            });
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc3_,_loc4_));
      }
      
      public function getMaxGiftSend() : Number {
         var _loc1_:Number = 1000;
         if(_loc1_ > this.ptModel.nBigblind * 20)
         {
            _loc1_ = this.ptModel.nBigblind * 20;
         }
         return _loc1_;
      }
      
      public function checkValidGift(param1:Number) : Boolean {
         if(param1 > 0 && param1 <= 1000 && param1 <= this.ptModel.nBigblind * 20 && this.ptModel.getPlayerTotalChips(this.ptModel.viewer.zid) > param1)
         {
            return true;
         }
         return false;
      }
      
      public function startGiveChipsTimer() : void {
         if(this.giveChipsTimer == null)
         {
            this.giveChipsTimer = new Timer(pgData.GIVE_CHIPS_TIME);
            this.giveChipsTimer.addEventListener(TimerEvent.TIMER,this.onGiveChips);
            this.giveChipsTimer.start();
         }
         this.bGiveChips = false;
      }
      
      public function stopGiveChipsTimer() : void {
         if(this.giveChipsTimer != null)
         {
            this.giveChipsTimer.stop();
            this.giveChipsTimer.removeEventListener(TimerEvent.TIMER,this.onGiveChips);
            this.giveChipsTimer = null;
         }
         this.bGiveChips = true;
      }
      
      private function onGiveChips(param1:TimerEvent) : void {
         this.bGiveChips = true;
      }
      
      public function getProfileURL(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:UserProfile = this.ptModel.getUserProfileByZid(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.profileURL;
         }
         return _loc2_;
      }
      
      public function isSeated(param1:String="") : Boolean {
         var _loc2_:String = param1.length == 0?this.ptModel.viewer.zid:param1;
         if(this.ptModel.getUserByZid(_loc2_) != null)
         {
            return true;
         }
         return false;
      }
      
      public function isActiveInHand(param1:String="") : Boolean {
         var _loc4_:String = null;
         var _loc2_:String = param1.length === 0?this.ptModel.viewer.zid:param1;
         var _loc3_:PokerUser = this.ptModel.getUserByZid(_loc2_,true);
         if(_loc3_ !== null)
         {
            _loc4_ = _loc3_.sStatusText.toLowerCase();
            return this.isSeated(_loc2_) === true && !(_loc4_ === "fold") && !(_loc4_ === "waiting") && !(_loc4_ === "wasSatOut") && !(_loc4_ === "satout");
         }
         return false;
      }
      
      public function getCardOptions(param1:String) : void {
         var _loc2_:SGetCardOptions = new SGetCardOptions("SGetCardOptions",param1);
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      public function getPlayerChips(param1:Boolean=false) : Number {
         if(param1)
         {
            return this.ptModel.getPlayerTotalChips(this.ptModel.viewer.zid);
         }
         return this.ptModel.getPlayerChips(this.ptModel.viewer.zid);
      }
      
      public function updateInbox() : void {
         this.ptModel.aBuddyInvites = pgData.aBuddyInvites;
         this._invCtrl.checkInbox();
      }
      
      private function dealCardSound(param1:TVEvent) : void {
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.TABLE_DEAL,PokerSoundEvent.CNAME_PLAY));
      }
      
      public function isViewerAllowedToSeeGiftId(param1:Number) : Boolean {
         if(pgData.nHideGifts == 0)
         {
            return true;
         }
         var _loc2_:GiftLibrary = GiftLibrary.GetInst();
         var _loc3_:GiftItem = _loc2_.GetGift(String(param1));
         if(_loc3_ == null)
         {
            return true;
         }
         if((_loc3_.miFilterMask & _loc2_.giftFilters) > 0)
         {
            return false;
         }
         return true;
      }
      
      private function onRefillPoints(param1:Object) : void {
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),LocaleManager.localize("flash.message.table.refillMessage")));
      }
      
      public function onPlaySoundOnce(param1:TVEPlaySound) : void {
         if(param1.sEvent == "PlayRemindSound" || param1.sEvent == "playHurrySound")
         {
            if((this.isSeated()) && int(param1.nSit) == int(this.ptModel.getUserByZid(this.ptModel.viewer.zid).nSit))
            {
               dispatchEvent(new PokerSoundEvent(param1.sEvent,PokerSoundEvent.CNAME_PLAY));
            }
         }
         if(param1.sEvent == "playSound_Deal")
         {
            dispatchEvent(new PokerSoundEvent(param1.sEvent,PokerSoundEvent.CNAME_PLAY));
         }
      }
      
      public function onToggleMuteSoundPressed(param1:Event) : void {
         this.ptModel.bTableSoundMute = !this.ptModel.bTableSoundMute;
         pgData.bTableSoundMute = this.ptModel.bTableSoundMute;
         if(this.ptModel.bTableSoundMute)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TableMute:2011-03-25"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TableUnMute:2011-03-25"));
         }
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_MUTE_GROUP,this.ptModel.bTableSoundMute));
         this.commitUserPreferences();
      }
      
      public function onEmptyGiftPressed(param1:TVEvent) : void {
         this.bGiftIconRequestedGiftShop = true;
         this.pControl.getGiftPrices3(-1,pgData.zid,false);
      }
      
      public function onGoToLobby(param1:Object) : void {
         if(!pgData.mttZone)
         {
            this.goToLobby();
         }
      }
      
      public function goToLobby() : void {
         this.stopGiveChipsTimer();
         this.pControl.removeViewFromLayer(this.ptView as DisplayObject,PokerControllerLayers.TABLE_LOBBY_LAYER);
         this.removeViewListeners();
         this.disableProtocol();
         dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
         dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
      }
      
      public function onBuyIn(param1:Object) : void {
         var _loc2_:RBuyIn = RBuyIn(param1);
         this.tourneySit(_loc2_.sit,_loc2_.points);
      }
      
      public function tourneySit(param1:int, param2:Number) : void {
         var _loc3_:SSit = new SSit("SSit",param2,param1,-1);
         this.pcmConnect.sendMessage(_loc3_);
      }
      
      public function tableJoin(param1:Object) : void {
         this.ptView.requestJoinUser(param1["uid"],param1["server_id"],param1["room_id"]);
      }
      
      public function onJoinUserPressed(param1:TVEJoinUserPressed) : void {
         var _loc2_:String = this.pControl.loadBalancer.getServerType(String(param1.nServerId));
         if(pgData.gameRoomId == param1.nRoomId && pgData.serverId == String(param1.nServerId))
         {
            dispatchEvent(new ErrorPopupEvent("onErrorPopup",LocaleManager.localize("flash.message.defaultTitle"),LocaleManager.localize("flash.message.table.joinAtThisTableMessage")));
         }
         else
         {
            fireStat(new PokerStatHit("joinuserfriendstable",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other FriendsJoinUser o:LiveJoin:2009-05-22","",1,""));
            this.pControl.updateLobbyTabs(_loc2_);
            this.cleanupTable();
            this.stopGiveChipsTimer();
            this.pControl.layerManager.removeChildFromLayer(PokerControllerLayers.TABLE_LOBBY_LAYER,this.ptView);
            this.removeViewListeners();
            this.disableProtocol();
            pgData.nNewRoomId = param1.nRoomId;
            pgData.newServerId = String(param1.nServerId);
            pgData.joiningContact = true;
            pgData.joiningShootout = true;
            dispatchEvent(new PokerSoundEvent(PokerSoundEvent.GROUP_TABLE,PokerSoundEvent.CNAME_STOP_GROUP));
            dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
            this.pcmConnect.disconnect();
         }
      }
      
      private function onHSMFreeUsePromoInvitePressed(param1:TVEvent) : void {
         if(pgData.sn_id == pgData.SN_FACEBOOK)
         {
            externalInterface.call("ZY.App.SponsoredHSM.open");
         }
      }
      
      public function showHSMPromo(param1:Number=3, param2:Boolean=false, param3:Boolean=false) : void {
         var _loc4_:Timer = null;
         if(!this.ptModel.isHsmEnabled())
         {
            return;
         }
         if(param2)
         {
            this.trackHSMShown();
            this._bettingControls.showHSMPromo();
            if(param3)
            {
               this.pControl.closeAllPopups();
            }
         }
         else
         {
            _loc4_ = new Timer(param1 * 1000,1);
            _loc4_.addEventListener(TimerEvent.TIMER,this.delayedHSMPromo,false,0,true);
            _loc4_.start();
         }
      }
      
      private function delayedHSMPromo(param1:TimerEvent) : void {
         var _loc2_:Timer = param1.target as Timer;
         _loc2_.removeEventListener(TimerEvent.TIMER,this.delayedHSMPromo);
         _loc2_.stop();
         _loc2_ = null;
         if(pgData.xpLevel > 1 && int(pgData.userPreferencesContainer.HSMPromo2) < 5 && !pgData.hasSeenHSMPromo2)
         {
            this.trackHSMShown();
            this._bettingControls.showHSMPromo();
         }
      }
      
      private function trackHSMShown() : void {
         var _loc1_:int = int(pgData.userPreferencesContainer.HSMPromo2);
         _loc1_++;
         pgData.hasSeenHSMPromo2 = true;
         pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.HSM_IMPRESSIONS2,_loc1_.toString());
         this.commitUserPreferences();
      }
      
      public function onLoadUserPresenceFriends() : void {
         var _loc1_:Object = new Object();
         _loc1_.friend_ids = pgData.aFriendZids.toString();
         var _loc2_:String = this.ptModel.configModel.getStringForFeatureConfig("core","presence_url");
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:LoadUrlVars = new LoadUrlVars();
         _loc3_.addEventListener(URLEvent.onLoaded,this.onUserPresenceFriendsLoaded);
         _loc3_.loadURL(_loc2_ + "get_friends_presence.php",_loc1_,"POST");
      }
      
      public function onLoadUserPresenceNetwork() : void {
         var _loc1_:Object = new Object();
         _loc1_.uid = this.ptModel.viewer.zid;
         if(!this.ptModel.coreConfig || !this.ptModel.coreConfig.presence_url)
         {
            return;
         }
         var _loc2_:LoadUrlVars = new LoadUrlVars();
         _loc2_.addEventListener(URLEvent.onLoaded,this.onUserPresenceNetworkLoaded);
         _loc2_.loadURL(this.ptModel.coreConfig.presence_url + "get_networks_presence.php",_loc1_,"POST");
      }
      
      public function onUserPresenceFriendsLoaded(param1:Event) : void {
         var _loc2_:Array = new Array();
         if(param1.target != null)
         {
            _loc2_ = this.onUpdateUserPresence(param1.target);
         }
         this.ptModel.aJoinFriends.splice(0);
         this.ptModel.aJoinFriends = _loc2_;
         this.ptView.refreshJoinUser("friends");
      }
      
      public function onUserPresenceNetworkLoaded(param1:Event) : void {
         var _loc2_:Array = new Array();
         if(param1.target != null)
         {
            _loc2_ = this.onUpdateUserPresence(param1.target);
         }
         this.ptModel.aJoinNetworks.splice(0);
         this.ptModel.aJoinNetworks = _loc2_;
         this.ptView.refreshJoinUser("networks");
      }
      
      public function onUpdateUserPresence(param1:Object) : Array {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc2_:Array = param1.data.toString().split("\n");
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_.length-1)
         {
            _loc5_ = _loc2_[_loc4_].split("|");
            _loc6_ = _loc5_[0];
            _loc7_ = _loc5_[1];
            _loc8_ = _loc5_[2];
            _loc9_ = _loc5_[3];
            _loc10_ = _loc5_[4];
            _loc11_ = _loc5_[5];
            _loc12_ = _loc5_[6];
            _loc13_ = this.pControl.loadBalancer.getServerType(String(_loc8_));
            if(!(_loc13_ == "tourney") && _loc13_.length > 0)
            {
               _loc14_ = this.pControl.getNetworkUserStatus(_loc8_,_loc13_,_loc9_);
               if(_loc10_ == "undefined")
               {
                  _loc10_ = "";
               }
               if(_loc11_ == "undefined")
               {
                  _loc11_ = "";
               }
               if(_loc6_ != this.ptModel.viewer.zid)
               {
                  if(!isNaN(_loc8_))
                  {
                     _loc3_.push(new UserPresence(_loc6_,_loc7_,_loc8_,_loc9_,_loc14_,_loc10_,_loc11_,_loc12_,"","",""));
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function onBlindChange(param1:Object) : void {
         var _loc2_:RBlindChange = RBlindChange(param1);
         this.ptModel.updateBlinds(_loc2_.blind / 2,_loc2_.blind);
         this.ptView.updateBlinds();
         this.pControl.zoomUpdateStakes(BlindFormatter.formatBlinds(_loc2_.blind / 2,_loc2_.blind));
      }
      
      private function onShowTableAceFTUE(param1:ModuleEvent) : void {
         externalInterface.call("zc.feature.tableAce.incFTUECount",null,null);
      }
      
      private function onTableAceUpdate(param1:Object) : void {
         var _loc2_:int = configModel.getFeatureConfig("tableAce").showTableAceFTUE;
         if(_loc2_ == 0 && (this._showTableAceFTUE))
         {
            dispatchCommand(new ShowModuleCommand("TableAceMOTD",null,this.onShowTableAceFTUE));
            this._showTableAceFTUE = false;
         }
         var _loc3_:RTableAceUpdate = RTableAceUpdate(param1);
         this.ptModel.updateTableAceData(_loc3_.tableAceSeats,_loc3_.tableAceWinAmount,_loc3_.myTableWinAmount);
         this._chickletCtrl.showTableAceAnimation(this.ptModel.currentTableAce);
      }
      
      private function onPointsUpdate(param1:Object) : void {
         var _loc4_:IPopupController = null;
         var _loc5_:Popup = null;
         var _loc2_:RPointsUpdate = RPointsUpdate(param1);
         PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateChipsCommand(_loc2_.points,false));
         this.pointsLostInCurrentHand = 0;
         this.blindsLostInCurrentHand = 0;
         var _loc3_:Number = this.checkForValidRatholeState()?pgData.ratholingInfoObj["minBuyin"]:this.ptModel.nMinBuyIn;
         if((this._isBustOut) && pgData.points >= _loc3_)
         {
            this._isBustOut = false;
            _loc4_ = registry.getObject(IPopupController);
            _loc5_ = _loc4_.getPopupConfigByID(Popup.BUST_OUT);
            if(!(_loc5_ == null) && !(_loc5_.module == null))
            {
               _loc5_.module.showSuccess();
            }
            this.pControl.onBuyInAccept(Math.min(this.ptModel.nMaxBuyIn,pgData.points),-1,0);
         }
      }
      
      private function onPointsPending(param1:Object) : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateTableCashierCommand(0));
      }
      
      public function onBuyDrinksPressed(param1:Boolean=false) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:BuyDrink:2009-03-17","",1,"",PokerStatHit.HITTYPE_FG));
         if(param1)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Table:BuyDrinksTable:2009-03-17","",1,"",PokerStatHit.HITTYPE_FG));
         }
      }
      
      private function onAchieved(param1:Object) : void {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:RAchieved = RAchieved(param1);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.nSit);
         if(!(_loc3_ == null) && _loc3_.zid == _loc2_.sZid)
         {
            _loc4_ = _loc2_.nSit;
            _loc3_.nTotalPoints = _loc2_.nPoints;
            if(_loc2_.sZid == this.ptModel.viewer.zid)
            {
               _loc4_ = -1;
               externalInterface.call("open_shout",_loc2_.nAchievmentId,_loc2_);
            }
            _loc5_ = this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true);
            if(_loc2_.nRewardBonus > 0)
            {
               _loc6_ = LocaleManager.localize("flash.table.dealer.achievementEarned",
                  {
                     "actor":_loc5_,
                     "achievement":_loc2_.sAchievmentName,
                     "amount":StringUtility.StringToMoney(_loc2_.nRewardBonus)
                  });
            }
            else
            {
               _loc6_ = LocaleManager.localize("flash.table.dealer.achievementEarnedNoReward",
                  {
                     "actor":_loc5_,
                     "achievement":_loc2_.sAchievmentName
                  });
            }
            _loc6_ = this.colorChatText(_loc6_,_loc4_);
            this.addDealerMessage(_loc6_);
         }
      }
      
      public function onRakeAmount(param1:Object) : void {
         var _loc2_:int = param1.amountFromPoints + param1.amountFromChips;
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMChipsSunk:2011-02-01","",_loc2_,""));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMChipsSunk:BB" + this.ptModel.nBigblind + ":2011-02-01","",_loc2_));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMChipsWon:2011-02-01","",param1.chipsWon,""));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMChipsWon:BB" + this.ptModel.nBigblind + ":2011-02-01","",param1.chipsWon));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMHandsWon:2011-02-01","",1));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMHandsWon:BB" + this.ptModel.nBigblind + ":2011-02-01","",1));
         if(pgData.rakeEnabled == 0)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:HSMRakeError:2011-03-04","",1));
         }
      }
      
      public function onRakeDisabled(param1:Boolean=true) : void {
         if(!this.ptModel.isHsmEnabled())
         {
            return;
         }
         this.rakeNextHand = false;
         if(param1)
         {
            this._bettingControls.setHSMTooltipText(LocaleManager.localize("flash.table.controls.hsmDisableNextHand"));
         }
         else
         {
            pgData.rakeEnabled = 0;
            this._bettingControls.activateHSM(false);
            this._cardController.runPossibleHands();
         }
      }
      
      public function onRakeEnabled(param1:Boolean=false) : void {
         if(!this.ptModel.isHsmEnabled())
         {
            return;
         }
         this.rakeNextHand = true;
         if(param1)
         {
            this._bettingControls.setHSMTooltipText(LocaleManager.localize("flash.table.controls.hsmEnableNextHand"));
         }
         else
         {
            pgData.rakeEnabled = 1;
            this._bettingControls.activateHSM(true);
            this._cardController.runPossibleHands();
            if(this.ptModel.hsmIsFree)
            {
               this._bettingControls.setHSMTooltipText(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.hsmDisable"));
            }
            else
            {
               this._bettingControls.setHSMTooltipText(LocaleManager.localize("flash.table.controls.hsmDisable"));
            }
         }
         pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.HAND_STRENGTH_METER,"1");
         this.commitUserPreferences();
      }
      
      public function onRakeInsufficientFunds(param1:Object) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:RakeInsufficientFunds","",1,param1.event));
         this.rakeNextHand = false;
         pgData.rakeEnabled = 0;
      }
      
      private function initZoomModelListeners() : void {
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         this.pControl.zoomModel.addEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.onZoomModelFriendsUpdate);
      }
      
      private function removeZoomModelListeners() : void {
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         this.pControl.zoomModel.removeEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.onZoomModelFriendsUpdate);
      }
      
      private function onZoomModelFriendsUpdate(param1:ZshimModelEvent) : void {
         var _loc2_:UserPresence = null;
         var _loc4_:String = null;
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","useZoomForFriends",1) != 1)
         {
            return;
         }
         this.ptModel.aJoinFriends.splice(0);
         var _loc3_:Number = 0;
         while(_loc3_ < param1.playerList.length)
         {
            _loc2_ = param1.playerList[_loc3_];
            if(_loc2_)
            {
               _loc4_ = this.pControl.loadBalancer.getServerType(String(_loc2_.nServerId));
               if((_loc4_) && !(_loc4_ == "tourney"))
               {
                  this.ptModel.aJoinFriends.push(_loc2_);
               }
               else
               {
                  if(_loc2_.nServerId == PokerToolbar.TOOLBAR_SERVER_ID)
                  {
                     this.ptModel.aJoinFriends.push(_loc2_);
                  }
               }
            }
            _loc3_++;
         }
         this.ptView.refreshJoinUser("friends");
      }
      
      private function onZoomModelNetworkUpdate(param1:ZshimModelEvent) : void {
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","useZoomForNetwork",1) != 1)
         {
            return;
         }
         this.ptModel.aJoinNetworks.splice(0);
         var _loc2_:Number = 0;
         while(_loc2_ < param1.playerList.length)
         {
            this.ptModel.aJoinNetworks.push(param1.playerList[_loc2_]);
            _loc2_++;
         }
         this.ptView.refreshJoinUser("networks");
      }
      
      private function onZoomUpdate() : void {
         var _loc1_:UserPresence = null;
         var _loc2_:String = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","connectToZoom",1) != 1)
         {
            return;
         }
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","useZoomForFriends",1) == 1)
         {
            this.ptModel.aJoinFriends.splice(0);
            _loc3_ = 0;
            while(_loc3_ < this.pControl.zoomModel.friendsList.length)
            {
               _loc1_ = this.pControl.zoomModel.friendsList[_loc3_];
               _loc2_ = this.pControl.loadBalancer.getServerType(String(_loc1_.nServerId));
               if((_loc2_) && !(_loc2_ == "tourney"))
               {
                  _loc1_.sRoomDesc = this.pControl.getNetworkUserStatus(_loc1_.nServerId,_loc2_,_loc1_.nRoomId);
                  this.ptModel.aJoinFriends.push(_loc1_);
               }
               else
               {
                  if(_loc1_.nServerId == PokerToolbar.TOOLBAR_SERVER_ID)
                  {
                     this.ptModel.aJoinFriends.push(_loc1_);
                  }
               }
               _loc3_++;
            }
            this.ptView.refreshJoinUser("friends");
         }
         if(this.ptModel.configModel.getIntForFeatureConfig("zoom","useZoomForNetwork",1) == 1)
         {
            this.ptModel.aJoinNetworks.splice(0);
            _loc4_ = 0;
            while(_loc4_ < this.pControl.zoomModel.networkList.length)
            {
               _loc1_ = this.pControl.zoomModel.networkList[_loc4_];
               _loc2_ = this.pControl.loadBalancer.getServerType(String(_loc1_.nServerId));
               if((_loc2_) && !(_loc2_ == "tourney"))
               {
                  _loc1_.sRoomDesc = this.pControl.getNetworkUserStatus(_loc1_.nServerId,_loc2_,_loc1_.nRoomId);
                  this.ptModel.aJoinNetworks.push(_loc1_);
               }
               _loc4_++;
            }
            this.ptView.refreshJoinUser("networks");
         }
      }
      
      public function updatezLiveButtonText(param1:Number) : void {
         if(this.ptView != null)
         {
            this.ptView.updatezLiveButtonText(param1);
         }
      }
      
      private function isFriendPlaying() : Boolean {
         var _loc1_:* = 0;
         if(pgData.aFriendZids.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < pgData.aFriendZids.length)
            {
               if(this.ptModel.getUserByZid(pgData.aFriendZids[_loc1_]) != null)
               {
                  return true;
               }
               _loc1_++;
            }
         }
         return false;
      }
      
      public function glowButton() : void {
         if(this.ptView)
         {
            this.ptView.glowButton();
         }
      }
      
      private function onShootoutBuyinChanged(param1:Object) : void {
         var _loc2_:RShootoutBuyinChanged = RShootoutBuyinChanged(param1);
         var _loc3_:String = LocaleManager.localize("flash.table.message.shootoutBuyinChanged.title");
         var _loc4_:String = LocaleManager.localize("flash.table.message.shootoutBuyinChanged.info",
            {
               "oldBuyInAmount":_loc2_.nOldBuyIn,
               "newBuyInAmount":_loc2_.nNewBuyIn
            });
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc3_,_loc4_));
      }
      
      private function onShootoutConfigChanged(param1:Object) : void {
         this.onLeaveTable(null);
      }
      
      private function onPlayerBounced(param1:Object) : void {
         this.onLeaveTable(null);
      }
      
      private function onRoundChanged(param1:Object) : void {
         this.onLeaveTable(null);
      }
      
      private function onSitPermissionRefused(param1:Object) : void {
         var _loc2_:String = LocaleManager.localize("flash.table.message.sitPermissionRefused.title");
         var _loc3_:String = LocaleManager.localize("flash.table.message.sitPermissionRefused.info");
         dispatchEvent(new ErrorPopupEvent("onErrorPopup",_loc2_,_loc3_));
      }
      
      private function onAlreadyPlayingShootout(param1:Object) : void {
         var _loc2_:String = LocaleManager.localize("flash.table.message.alreadyPlayingShootout.title");
         var _loc3_:String = LocaleManager.localize("flash.table.message.alreadyPlayingShootout.info");
         dispatchEvent(new ErrorPopupEvent("onShootoutError",_loc2_,_loc3_));
      }
      
      private function onXPEarned(param1:Object) : void {
         var _loc3_:String = null;
         var _loc4_:RegExp = null;
         var _loc5_:RegExp = null;
         var _loc6_:RegExp = null;
         var _loc7_:Object = null;
         var _loc8_:* = NaN;
         var _loc9_:RoomItem = null;
         var _loc2_:RXPEarned = RXPEarned(param1);
         if(_loc2_.xpDelta > 0)
         {
            _loc3_ = "";
            _loc4_ = new RegExp("enterShootoutRound(\\d)+");
            _loc5_ = new RegExp("finishPlace(\\d)+ShootoutRound(\\d)+");
            _loc6_ = new RegExp("finishPlace(\\d)+Sitngo");
            if(_loc2_.reason == "playHand")
            {
               _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedPlayHand",{"xpDelta":_loc2_.xpDelta});
            }
            else
            {
               if(_loc2_.reason == "wonHand")
               {
                  _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedWonHand",{"xpDelta":_loc2_.xpDelta});
               }
               else
               {
                  if(_loc2_.reason == "enterSitngo")
                  {
                     _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedEnterSitngo",{"xpDelta":_loc2_.xpDelta});
                     _loc9_ = pgData.getRoomById(pgData.gameRoomId);
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:SitngoTournamentStart:TournamentFee" + _loc9_.entryFee + "_Speed" + _loc9_.type + "2014-03-04"));
                  }
                  else
                  {
                     if(_loc6_.test(_loc2_.reason))
                     {
                        _loc7_ = _loc6_.exec(_loc2_.reason);
                        _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedPlaceSitngo",
                           {
                              "xpDelta":_loc2_.xpDelta,
                              "place":StringUtility.GetOrdinal(int(_loc7_[1]))
                           });
                     }
                     else
                     {
                        if(_loc4_.test(_loc2_.reason))
                        {
                           _loc7_ = _loc4_.exec(_loc2_.reason);
                           if(pgData.dispMode == "shootout")
                           {
                              _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedEnterShootout",
                                 {
                                    "xpDelta":_loc2_.xpDelta,
                                    "round":int(_loc7_[1])
                                 });
                              fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:ShootoutTournamentStart_Round" + pgData.soUser.nRound + ":2014-03-04"));
                           }
                           if(pgData.dispMode == "premium")
                           {
                              _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedEnterPowerTourney",{"xpDelta":_loc2_.xpDelta});
                              fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:PowerTournamentStart_Buyin" + this.pControl.soConfig.nBuyin + ":2011-06-05"));
                              fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:PowerTournamentStart_Buyin:Total:2012-12-12"));
                           }
                        }
                        else
                        {
                           if(_loc5_.test(_loc2_.reason))
                           {
                              _loc7_ = _loc5_.exec(_loc2_.reason);
                              if(pgData.dispMode == "shootout")
                              {
                                 _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedPlaceShootout",
                                    {
                                       "xpDelta":_loc2_.xpDelta,
                                       "place":StringUtility.GetOrdinal(int(_loc7_[1])),
                                       "round":int(_loc7_[2])
                                    });
                              }
                              if(pgData.dispMode == "premium")
                              {
                                 _loc3_ = LocaleManager.localize("flash.table.dealer.xpEarnedPlacePowerTourney",
                                    {
                                       "xpDelta":_loc2_.xpDelta,
                                       "place":StringUtility.GetOrdinal(int(_loc7_[1]))
                                    });
                              }
                           }
                        }
                     }
                  }
               }
            }
            if(_loc3_ != "")
            {
               _loc3_ = this.colorChatText(_loc3_,this.ptModel.getSeatNum(pgData.viewer.zid));
               this.addDealerMessage(_loc3_);
            }
            _loc8_ = this.ptModel.getSeatNum(pgData.viewer.zid);
            if(_loc8_ > -1)
            {
               this._chickletCtrl.showXPEarnedAnimation(_loc8_,_loc2_.xpDelta);
            }
         }
      }
      
      private function onUserLevelledUp(param1:Object) : void {
         var _loc5_:PokerUser = null;
         var _loc6_:String = null;
         var _loc2_:RUserLevelledUp = RUserLevelledUp(param1);
         var _loc3_:UserProfile = this.ptModel.getUserProfileByZid(_loc2_.zid);
         if(_loc3_ != null)
         {
            _loc3_.xpLevel = _loc2_.xpLevel;
         }
         var _loc4_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if(!(_loc4_ == null) && _loc4_.zid == _loc2_.zid)
         {
            _loc4_.xpLevel = _loc2_.xpLevel;
            _loc5_ = this.ptModel.getUserBySit(_loc2_.sit);
            _loc6_ = "";
            if(_loc4_.zid == pgData.viewer.zid)
            {
               _loc6_ = LocaleManager.localize("flash.table.dealer.xpLevelUpSelf",{"level":_loc2_.xpLevel});
            }
            else
            {
               _loc6_ = LocaleManager.localize("flash.table.dealer.xpLevelUpOther",
                  {
                     "actor":this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),
                     "level":_loc2_.xpLevel
                  });
            }
            if(_loc6_ != "")
            {
               _loc6_ = this.colorChatText(_loc6_,this.ptModel.getSeatNum(pgData.viewer.zid));
               this.addDealerMessage(_loc6_);
            }
         }
      }
      
      private function onUserUnderUP(param1:Object) : void {
         var _loc3_:String = null;
         var _loc4_:PokerUser = null;
         var _loc5_:* = 0;
         var _loc2_:RUserUnderUP = RUserUnderUP(param1);
         if(_loc2_.context == "timeout")
         {
            _loc3_ = "";
            this.ptModel.setPlayerStatus(_loc2_.sit,"underUP");
            this.playerUnderUP(_loc2_.sit);
            _loc4_ = this.ptModel.getUserBySit(_loc2_.sit);
            if(_loc4_)
            {
               _loc5_ = param1.sit;
               _loc3_ = LocaleManager.localize("flash.table.dealer.playerDisconnected",{"actor":this.colorChatText(this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),_loc5_,true)});
               this.addDealerMessage(_loc3_);
               _loc3_ = LocaleManager.localize("flash.table.dealer.playerUnderDP",{"actor":this.colorChatText(this.wrapChatZidLink(_loc4_.zid,_loc4_.sUserName),_loc5_,true)});
               this.addDealerMessage(_loc3_);
            }
         }
      }
      
      private function onPostToPlayChange(param1:TVEvent) : void {
         var _loc2_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         this.ptModel.postToPlayFlag = this.ptView.postToPlayFlag;
         _loc2_.nPostToPlay = this.ptModel.postToPlayFlag;
      }
      
      public function setFourColorDeck(param1:int) : void {
         var _loc2_:Boolean = Boolean(param1);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:FourColorDeckEnabled:" + _loc2_ + ":2011-12-16"));
         if(this.ptView != null)
         {
            this._cardController.setFourColorDeck(Boolean(param1));
         }
      }
      
      private function checkForValidRatholeState() : Boolean {
         var _loc1_:Date = new Date();
         if(!pgData.ratholingInfoObj)
         {
            return false;
         }
         if(_loc1_.time / 1000 - pgData.ratholingInfoObj["timestamp"] / 1000 < pgData.ratholingInfoObj["expireSecs"] && this.ptModel.room.id == pgData.ratholingInfoObj["roomId"] && pgData.serverId == pgData.ratholingInfoObj["serverId"])
         {
            return true;
         }
         return false;
      }
      
      private function getPollQuestion() : void {
         this.ptView.hidePoll();
         externalInterface.addCallback("getPollQuestionCallback",this.getPollQuestionCallback);
         externalInterface.call("idea_framework_question");
      }
      
      private function getPollQuestionCallback(param1:Object) : void {
         externalInterface.removeCallback("getPollQuestionCallback");
         if((!(param1 == null)) && (param1["id"]) && (param1["question"]))
         {
            this.ptView.showPoll(param1["id"],param1["question"]);
         }
         else
         {
            this.ptView.hidePoll();
         }
      }
      
      private function sendPollAnswer(param1:String, param2:Number) : void {
         externalInterface.call("idea_framework_answer",param1,param2);
      }
      
      private function onPollClose(param1:TVEvent) : void {
         if(!(this.ptView == null) && !(this.ptView.poll == null))
         {
            this.sendPollAnswer(this.ptView.poll.id,-1);
         }
         this.ptView.hidePoll();
      }
      
      private function onPollYes(param1:TVEvent) : void {
         if(!(this.ptView == null) && !(this.ptView.poll == null))
         {
            this.sendPollAnswer(this.ptView.poll.id,1);
         }
         this.ptView.hidePoll();
      }
      
      private function onPollNo(param1:TVEvent) : void {
         if(!(this.ptView == null) && !(this.ptView.poll == null))
         {
            this.sendPollAnswer(this.ptView.poll.id,0);
         }
         this.ptView.hidePoll();
      }
      
      private function onHSMPromoRequest(param1:CommandEvent) : void {
         this.showHSMPromo(0,true,true);
      }
      
      private function onClickPokerScore(param1:TVEvent=null) : void {
         dispatchEvent(param1);
      }
      
      private function onShowLeaderboard(param1:TVEvent=null) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:TopNav:TableLeaderboard:2013-11-13"));
         dispatchCommand(new HideLeaderboardFlyoutCommand());
         dispatchEvent(new PopupEvent("showLeaderboard",false,{"showInPopup":true}));
      }
      
      public function removeTodoIcon(param1:String) : void {
         if(this._todoListController)
         {
            this._todoListController.removeTodoIcon(param1);
         }
      }
      
      private function onBuyChipsClick(param1:TVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:WaitNextHand:GetChips:2010-03-25"));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:WaitNextHand_FG:GetChips:2011-02-28","",1,"",PokerStatHit.HITTYPE_FG));
         this.pControl.showGetGoldPanel("","table_waitnexthand");
      }
      
      private function onHiloRedirectClick(param1:TVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:ChatHiloGame:GetChips:2011-02-28"));
         this.pControl.showGetGoldPanel("","dealerchat_hilo");
      }
      
      private function tableViewInitialized() : void {
         this.pControl.notifyJS(new JSEvent(JSEvent.ENTER_TABLE));
         if(!pgData.bAutoSitMe && !(this.ptModel.sDispMode == "shootout") && !(this.ptModel.sDispMode == "weekly") && pgData.rejoinRoom == -1)
         {
            this.pControl.notifyJS(new JSEvent(JSEvent.JOINED_TABLE));
         }
      }
      
      private function onTableAdButtonClick(param1:TVEvent) : void {
         var _loc2_:String = param1.params.flFunction;
         if((_loc2_) && (this.pControl[_loc2_]))
         {
            this.pControl[_loc2_].apply(this,param1.params.flArgs);
         }
         var _loc3_:String = param1.params.jsFunction;
         if(_loc3_)
         {
            externalInterface.call(_loc3_,param1.params.jsArgs);
         }
         var _loc4_:String = param1.params.popup;
         if(_loc4_)
         {
            this.pControl.dispatchEvent(new PopupEvent(_loc4_));
         }
      }
      
      private function onTipDealerClick(param1:TVEvent) : void {
         var _loc2_:STipTheDealer = new STipTheDealer("STipTheDealer",Number(param1.params),this.ptModel.getSeatNum(pgData.viewer.zid));
         this.pcmConnect.sendMessage(_loc2_);
      }
      
      private function onShowMinigameHighLow(param1:TVEvent=null) : void {
         this.pControl.minigameControl.showGame();
      }
      
      private function onHideMinigameHighLow(param1:TVEvent=null) : void {
         this.pControl.minigameControl.hideGame();
      }
      
      private function onShowDailyChallenge(param1:TVEvent=null) : void {
         commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.SHOW_DAILYCHALLENGE));
      }
      
      private function onHideDailyChallenge(param1:TVEvent=null) : void {
         commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.HIDE_DAILYCHALLENGE));
      }
      
      public function htmlEncode(param1:String) : String {
         var param1:String = param1.replace(new RegExp("&","g"),"&amp;");
         param1 = param1.replace(new RegExp("<","g"),"&lt;");
         param1 = param1.replace(new RegExp(">","g"),"&gt;");
         return param1;
      }
      
      public function stripHTML(param1:String) : String {
         return param1.replace(new RegExp("<.*?>","g"),"");
      }
      
      private function clearPotsTrackers() : void {
         this.potsCleared = 0;
         this.potsWinnersSit = new Array();
      }
      
      public function addBuddyRequestZidToRequestArray(param1:String) : void {
         if(!this.aAddBuddyAttemptsZids)
         {
            this.aAddBuddyAttemptsZids = new Array();
         }
         if(this.aAddBuddyAttemptsZids.indexOf(param1) == -1)
         {
            this.aAddBuddyAttemptsZids.push(param1);
         }
      }
      
      public function removeBuddyRequestZidFromRequestArray(param1:String) : void {
         if(!this.aAddBuddyAttemptsZids)
         {
            return;
         }
         var _loc2_:int = this.aAddBuddyAttemptsZids.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.aAddBuddyAttemptsZids.splice(_loc2_,1);
         }
      }
      
      public function hasUserBeenInvited(param1:String) : Boolean {
         return (this.aAddBuddyAttemptsZids) && !(this.aAddBuddyAttemptsZids.indexOf(param1) == -1);
      }
      
      private function initChickletMenuEventListeners() : void {
         this.ptView.addEventListener(TVEChickletMouseEvent.MOUSEOVER,this.onTableChickletMouseOver,false,0,true);
         this.ptView.addEventListener(TVEChickletMouseEvent.MOUSEOUT,this.onTableChickletMouseOut,false,0,true);
         this.ptView.addEventListener(TVEChickletMouseEvent.MOUSECLICK,this.onTableChickletMouseClick,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.PROFILE,this.onTableChickletMenuShowProfileClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.GIFT_MENU,this.onTableChickletMenuBuyGiftClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.SHOW_ITEMS,this.onTableChickletMenuItemsInventoryClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.POKER_SCORE,this.onTableChickletMenuPokerScoreClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.SEND_CHIPS,this.onTableChickletMenuSendChipsClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.ADD_BUDDY,this.onTableChickletMenuAddBuddyClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.MODERATE,this.onTableChickletMenuModerateClicked,false,0,true);
         this.ptView.addEventListener(ChickletMenuEvent.HIDE,this.onTableChickletMenuHideClicked,false,0,true);
         addEventListener(TVEvent.TABLE_ACE_PRESSED,this.onTableAcePressed,false,0,true);
         addEventListener(TVEvent.CHICKLET_LEFT,this.onChickletLeave,false,0,true);
         this.ptView.addEventListener(TimerEvent.TIMER_COMPLETE,this.onProfileRolloverTimer,false,0,true);
      }
      
      private function onChickletLeave(param1:TVEvent) : void {
         this.ptView.removeTableAcePopup(param1.params.seat);
      }
      
      private function measureString(param1:String) : Rectangle {
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         return new Rectangle(0,0,_loc2_.textWidth,_loc2_.textHeight);
      }
      
      private function tableAcePopupStringBuilder(param1:String, param2:int) : String {
         var _loc6_:String = null;
         var _loc3_:Array = param1.split(" ");
         var _loc4_:String = new String();
         var _loc5_:Number = 0;
         for each (_loc6_ in _loc3_)
         {
            if(_loc5_ + this.measureString(_loc6_).width < param2)
            {
               _loc4_ = _loc4_ + (_loc6_ + " ");
            }
            else
            {
               _loc4_ = _loc4_ + ("\n" + _loc6_ + " ");
               _loc5_ = 0;
            }
            _loc5_ = _loc5_ + this.measureString(_loc6_).width;
         }
         return _loc4_;
      }
      
      private function createTableAceMessage(param1:Number, param2:Boolean, param3:Boolean, param4:int) : EmbeddedFontTextField {
         var _loc5_:String = PokerCurrencyFormatter.numberToCurrency(param1,false);
         var _loc6_:EmbeddedFontTextField = null;
         var _loc7_:* = "";
         var _loc8_:int = configModel.getFeatureConfig("tableAce").variant;
         if((param2) && (param3) && _loc8_ == 3)
         {
            _loc7_ = LocaleManager.localize("flash.table.chicklet.tableAce.isTableAce");
         }
         else
         {
            if(_loc8_ == 3)
            {
               if(param1 == 0)
               {
                  _loc7_ = LocaleManager.localize("flash.table.tableAce.sameScore");
               }
               else
               {
                  _loc7_ = LocaleManager.localize("flash.table.chicklet.tableAce.notTableAce",{"number":_loc5_});
               }
            }
            else
            {
               if((param2) && (param3) && _loc8_ == 4)
               {
                  _loc7_ = LocaleManager.localize("flash.table.chicklet.tableAce.isTableAce.variantfour");
               }
               else
               {
                  if(_loc8_ == 4)
                  {
                     if(param1 == 0)
                     {
                        _loc7_ = LocaleManager.localize("flash.table.tableAce.sameScore");
                     }
                     else
                     {
                        _loc7_ = LocaleManager.localize("flash.table.chicklet.tableAce.notTableAce.variantfour",{"number":_loc5_});
                     }
                  }
               }
            }
         }
         _loc7_ = this.tableAcePopupStringBuilder(_loc7_,param4);
         _loc6_ = new EmbeddedFontTextField(_loc7_,"Main",10,16777215,"center");
         return _loc6_;
      }
      
      private function onTableAcePressed(param1:TVEvent) : void {
         var _loc2_:String = param1.params.zid;
         var _loc3_:Number = param1.params.amountToTableAce;
         var _loc4_:Boolean = param1.params.isViewer;
         var _loc5_:Boolean = param1.params.isTableAce;
         var _loc6_:PokerUser = this.ptModel.getUserByZid(_loc2_);
         var _loc7_:uint = this.ptModel.playerPosModel.getMappedPosition(_loc6_.nSit);
         var _loc8_:Point = this._chickletCtrl.getChickletCoords(_loc7_);
         var _loc9_:Number = _loc8_.x;
         var _loc10_:Number = _loc8_.y;
         var _loc11_:Sprite = new Sprite();
         var _loc12_:Graphics = _loc11_.graphics;
         var _loc13_:* = 0;
         if(_loc6_.nSit > 1)
         {
            _loc13_ = _loc9_ - 130;
         }
         else
         {
            _loc13_ = _loc9_ - 80;
         }
         var _loc14_:int = _loc10_ - 20;
         var _loc15_:* = 220;
         var _loc16_:* = 20;
         var _loc17_:EmbeddedFontTextField = this.createTableAceMessage(_loc3_,_loc5_,_loc4_,_loc15_);
         var _loc18_:int = this.measureString(_loc17_.text).height;
         _loc12_.beginFill(6118762,0.6);
         _loc12_.drawRoundRect(_loc13_,_loc14_,_loc15_,_loc18_,_loc16_,_loc16_);
         _loc12_.endFill();
         _loc12_.beginFill(0,0.8);
         _loc12_.drawRoundRect(_loc13_,_loc14_,_loc15_,_loc18_,_loc16_,_loc16_);
         _loc12_.endFill();
         _loc17_.x = _loc13_;
         _loc17_.width = _loc15_;
         _loc17_.y = _loc14_;
         this.ptModel.addTableAcePopup(_loc11_,param1.params.seat);
         _loc11_.addChild(_loc17_);
         this.ptView.addChild(_loc11_);
      }
      
      private function onTableChickletMouseOver(param1:TVEChickletMouseEvent) : void {
         this.provCtrl.showProv(this.ptModel.getUserBySit(param1.sit));
      }
      
      private function onTableChickletMouseOut(param1:TVEChickletMouseEvent) : void {
         this.provCtrl.hideProv();
      }
      
      private function onProfileRolloverTimer(param1:TimerEvent) : void {
         var _loc2_:String = this.provCtrl.thisZid;
         if(this.ptModel.pgData.isMe(_loc2_))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:ProfileRollover_User:2011-05-17"));
         }
         else
         {
            if(this.ptModel.pgData.isFriend(_loc2_))
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:ProfileRollover_Friend:2011-05-17"));
            }
            else
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:ProfileRollover_Other:2011-05-17"));
            }
         }
      }
      
      private function onTableChickletMouseClick(param1:TVEChickletMouseEvent) : void {
         var _loc3_:PokerUser = null;
         var _loc2_:int = param1.sit;
         this.chickletMenuShowPosX = param1.posX;
         this.chickletMenuShowPosY = param1.posY;
         if(this.ptModel.getUserBySit(_loc2_) != null)
         {
            _loc3_ = this.ptModel.getUserBySit(_loc2_);
            this.getCardOptions(_loc3_.zid);
         }
      }
      
      private function onTableChickletMenuShowProfileClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuBuyGiftClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuItemsInventoryClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuPokerScoreClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuSendChipsClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuAddBuddyClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuModerateClicked(param1:ChickletMenuEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onTableChickletMenuHideClicked(param1:ChickletMenuEvent) : void {
         this.provCtrl.hideProv();
      }
      
      private function animateGiftItemsForLosersAndKnockedOut() : void {
         var _loc3_:PokerUser = null;
         var _loc4_:* = undefined;
         var _loc1_:* = true;
         var _loc2_:* = false;
         for each (_loc3_ in this.ptModel.aUsersInHand)
         {
            if(_loc3_)
            {
               if(this.potsWinnersSit.indexOf(_loc3_.nSit) != -1)
               {
                  _loc1_ = false;
               }
               if(_loc1_)
               {
                  if(!_loc2_ && _loc3_.sStatusText == "allin")
                  {
                     _loc2_ = true;
                  }
                  if(!(_loc3_.sStatusText == "fold") && !(_loc3_.sStatusText == "wasSatOut") && !(_loc3_.sStatusText == "satout"))
                  {
                     this.animateGiftItem(_loc3_.nSit,"lose");
                  }
               }
               else
               {
                  _loc1_ = true;
               }
            }
         }
         if(_loc2_)
         {
            for each (_loc4_ in this.potsWinnersSit)
            {
               this.animateGiftItem(_loc4_,"knockedOff");
            }
         }
      }
      
      private function buyinUpdate(param1:PokerUser, param2:Number, param3:Boolean=false) : void {
         if(param3)
         {
            param1.sStatusText = "wasSatOut";
         }
         param1.nChips = param2;
         this.playerSat(param1.nSit,true);
      }
      
      private function onAutoChips(param1:Object) : void {
         var _loc5_:String = null;
         var _loc2_:RAutoChips = RAutoChips(param1);
         var _loc3_:PokerUser = this.ptModel.getUserBySit(_loc2_.sit);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = _loc2_.sit;
         if(_loc2_.messageType == "autoBuyIn")
         {
            if(_loc2_.amount > 0)
            {
               _loc5_ = LocaleManager.localize("flash.table.dealer.autoRebuy",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true)});
               this.buyinUpdate(_loc3_,_loc2_.amount,false);
            }
         }
         else
         {
            _loc5_ = LocaleManager.localize("flash.table.dealer.autoTopUp",{"actor":this.colorChatText(this.wrapChatZidLink(_loc3_.zid,_loc3_.sUserName),_loc4_,true)});
            this.buyinUpdate(_loc3_,_loc2_.amount,false);
         }
         if(_loc5_)
         {
            this.addDealerMessage(_loc5_);
         }
      }
      
      public function performTableJump() : void {
         if(!pgData.willJumpTable)
         {
            return;
         }
         this.ptView.prepareTableViewForJump();
         this.onLeaveTable(null);
      }
      
      public function cancelJumpTableSearch() : void {
         if(this.ptView)
         {
            this.ptView.dismissJumpTablesInfoPane();
         }
         this.onCancelJumpTableSearch(null);
      }
      
      public function handleTableJumpError() : void {
         if((this.ptView) && (this.ptView.jumpTablesInfoPane))
         {
            this.ptView.jumpTablesInfoPane.showBackToLobbyDialog();
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:JumpTables:ReturnToLobbyButton:2011-07-13"));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:JumpTables:JumpTablesError:2011-07-13"));
         }
      }
      
      private function onJumpTableButtonShown(param1:TVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Immpression o:JumpTables:JumpTablesButton:2011-07-13"));
      }
      
      private function onStartJumpTableSearch(param1:TVEvent) : void {
         var _loc2_:SFindRoomRequest = new SFindRoomRequest("SFindRoomRequest",this.ptModel.room.maxPlayers,this.ptModel.nSmallblind,this.ptModel.nBigblind,this.ptModel.room.minBuyin,this.ptModel.room.gameType,0,this.ptModel.room.type,[this.ptModel.room.id],0,0);
         pgData.willJumpTable = true;
         this.pcmConnect.sendMessage(_loc2_);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:JumpTables:JumpTablesButton:2011-07-13"));
      }
      
      private function onCancelJumpTableSearch(param1:TVEvent) : void {
         if(pgData)
         {
            pgData.willJumpTable = false;
            pgData.tableIdToJumpTo = -1;
            pgData.tableNameToJumpTo = "";
         }
         if((param1) && param1.params.willJumpToLobby == true)
         {
            this.onLeaveTable(null);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:JumpTables:ReturnToLobbyButton:2011-07-13"));
         }
      }
      
      public function closeHsmRakeShout(param1:String="", param2:Boolean=false) : void {
         var _loc3_:* = false;
         if(param2)
         {
            _loc3_ = true;
         }
         else
         {
            if(this.hsmRakeIncreaseShoutState == 1)
            {
               if(this.hsmRakeShoutHandsPlayed >= 5)
               {
                  _loc3_ = true;
               }
               this.hsmRakeShoutHandsPlayed++;
            }
         }
         if(_loc3_)
         {
            this.hsmRakeIncreaseShoutState = 2;
            externalInterface.call("ZY.App.hsmRakeShout.close",param1);
         }
      }
      
      public function openHsmRakeShout() : void {
         if(((!(this.ptModel.hsmConfig == null)) && (this.ptModel.hsmConfig.showHSMShout)) && (this.hsmRakeIncreaseShoutState == 0) && !this.ptModel.isTournament)
         {
            this.hsmRakeShoutHandsPlayed = 0;
            this.hsmRakeIncreaseShoutState = 1;
            externalInterface.call("ZY.App.hsmRakeShout.lazyLoadPopup","hsmRakeShout");
         }
      }
      
      public function initializeMinigameAtTable() : void {
         var _loc1_:SMgfwAction = null;
         if(this.ptModel.isHighLowEnabled())
         {
            _loc1_ = new SMgfwAction("SMgfwAction","getSupportedMiniGameTypes",new SGetSupportedMiniGameTypes());
            this.pcmConnect.sendMessage(_loc1_);
         }
      }
      
      private function showZPWCShout() : void {
         var _loc1_:Object = null;
         if(PokerGlobalData.instance.enableZPWC)
         {
            _loc1_ = 
               {
                  "type":3,
                  "ttdName":"zpwc_shout"
               };
            this.pControl.displayShout(com.adobe.serialization.json.JSON.encode(_loc1_));
         }
      }
      
      public function activateMTTChangeTable() : void {
         this._mttChangeTable = true;
      }
      
      public function newSocialChatMessage(param1:String, param2:Boolean=false) : void {
         if(this._chatCtrl)
         {
            this._chatCtrl.addSocialChatMessage(param1,param2);
         }
      }
      
      public function addDealerMessage(param1:String) : void {
         this._dealerChatCtrl.addDealerMessage(param1);
      }
      
      public function animateGiftItem(param1:int, param2:String) : void {
         this._chickletCtrl.animateGiftItem(param1,param2);
      }
      
      private function checkViewerSeated() : void {
         var _loc3_:* = undefined;
         var _loc1_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         var _loc2_:Array = this.ptModel.aUsers;
         this.ptView.standButton.visible = false;
         for (_loc3_ in _loc2_)
         {
            if(_loc1_ == _loc2_[_loc3_])
            {
               if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.tourneyId > -1) || this.ptModel.room.gameType == "Tournament")
               {
                  this.ptView.standButton.visible = false;
               }
               else
               {
                  if(!this.ptModel.pgData.mttZone)
                  {
                     this.ptView.standButton.visible = true;
                  }
               }
               this.ptView.updateJumpTablesButtonVisibility();
               this._seatCtrl.clearSeats();
            }
            else
            {
               this._seatCtrl.hideSeat(_loc2_[_loc3_].nSit);
            }
         }
         if(this.ptModel.room.gameType == "Tournament" && (pgData.dispMode == "premium" || pgData.dispMode == "shootout" || !(this.ptModel.sTourneyMode == "reg")) || (this._isPlayNow))
         {
            this._seatCtrl.clearSeats();
            this._isPlayNow = false;
         }
      }
      
      private function playerSat(param1:int, param2:Boolean) : void {
         if(param1 < 0 || param1 >= 9)
         {
            return;
         }
         var _loc3_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc4_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         var _loc5_:* = _loc3_ === _loc4_;
         if(_loc5_)
         {
            this._playerPosCtrl.updatePlayerPosition(param1,param2);
         }
         this._chickletCtrl.setState(ChickletController.STATE_JOINED,param1);
         this._seatCtrl.hideSeat(param1);
         if(_loc5_)
         {
            this.ptView.playerSat();
            this.ptView.updateAfterSitdown();
            this._seatCtrl.repositionSeats();
            this._seatCtrl.clearSeats();
            this._bettingControls.hideControls(this.isSeated());
            this.pControl.navControl.clearPlayersClubCoolDown();
            this._chipCtrl.repositionAllUserChips();
            this._cardController.repositionCards();
            this._puckControl.repositionDealer();
            this.updateBackgroundChairs();
         }
      }
      
      private function resetSitActions() : void {
         var _loc2_:PokerUser = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.ptModel.room.maxPlayers)
         {
            this._chickletCtrl.setState(ChickletController.STATE_DEFAULT,_loc1_);
            _loc2_ = this.ptModel.getUserBySit(_loc1_);
            if(_loc2_ != null)
            {
               _loc2_.nCurBet = 0;
               _loc2_.nBlind = 0;
            }
            _loc1_++;
         }
      }
      
      private function dealStreet() : void {
         this.resetSitActions();
         this._cardController.dealCommunityCard(3,false);
         this.ptModel.sHandStatus = HandStatus.TURN;
      }
      
      private function dealRiver() : void {
         this.resetSitActions();
         this._cardController.dealCommunityCard(4,false);
         this.ptModel.sHandStatus = HandStatus.RIVER;
      }
      
      private function updateBackgroundChairs() : void {
         this.ptView.updatePlayersClubChairs();
         var _loc1_:uint = 0;
         while(_loc1_ < this._seatCtrl.seatModel.maxPlayers)
         {
            if(this._seatCtrl.seatModel.isSeatTaken(_loc1_))
            {
               this.ptView.fadeOutBackgroundChair(_loc1_);
            }
            else
            {
               this.ptView.fadeInBackgroundChair(_loc1_);
            }
            _loc1_++;
         }
      }
      
      private function clearTable() : void {
         this.resetSitActions();
         this._cardController.clearCards();
         this.ptView.clearTable();
         this._chipCtrl.clearChips();
         this._bettingControls.updateCallPreBetButton(0);
      }
      
      private function playerLeft(param1:int) : void {
         if(param1 == -1)
         {
            return;
         }
         var _loc2_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         var _loc4_:* = _loc2_ === _loc3_;
         var _loc5_:Array = this.ptModel.aUsers;
         this._chickletCtrl.setState(ChickletController.STATE_QUIT,param1);
         this._seatCtrl.leaveSeat(param1);
         this.ptView.fadeInBackgroundChair(param1);
         if(_loc4_)
         {
            if(this._bettingControls)
            {
               this._bettingControls.hideControls(false);
            }
            if(this.ptView.standButton)
            {
               this.ptView.standButton.visible = false;
            }
            this.ptView.updateJumpTablesButtonVisibility();
            if((this.ptModel.enableBetControlAds()) && !this.ptModel.pgData.disableChipsAndGold)
            {
               this.ptView.tAdController.showAd(true);
               this.ptView.tAdController.adContainer.visible = true;
            }
            this._seatCtrl.showSeats();
         }
         else
         {
            if(_loc3_ == null)
            {
               if(this.ptView.standButton)
               {
                  this.ptView.standButton.visible = false;
               }
               this._seatCtrl.showSeats();
            }
            else
            {
               this._seatCtrl.showLeave(param1);
            }
         }
         this._cardController.clearPlayerCards(param1);
         this._cardController.foldDummyCards(param1);
      }
      
      private function resetChickletState() : void {
         var _loc1_:* = 0;
         while(_loc1_ < 9)
         {
            this._chickletCtrl.setState(ChickletController.STATE_DEFAULT,_loc1_);
            _loc1_++;
         }
      }
      
      private function startPlayerTurn(param1:int, param2:Number, param3:Number) : void {
         this._chickletCtrl.setClock(param2,param3);
         this._chickletCtrl.setState(ChickletController.STATE_TIMER,param1);
      }
      
      private function playerFolded(param1:int) : void {
         var _loc2_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if(_loc2_ == _loc3_)
         {
            this._bettingControls.hideControls(this.isSeated());
            this._cardController.dimPlayerCards(param1);
         }
         else
         {
            if(_loc2_ != _loc3_)
            {
               this._cardController.foldPlayerCards(param1);
            }
         }
         this._cardController.foldDummyCards(param1);
         this._chickletCtrl.setState(ChickletController.STATE_FOLD,param1);
      }
      
      private function playerUnderUP(param1:int) : void {
         var _loc2_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc3_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if(_loc2_ == _loc3_)
         {
            this._bettingControls.hideControls(this.isSeated());
            this._cardController.dimPlayerCards(param1);
         }
         this._chickletCtrl.setState(ChickletController.STATE_DISCONNECT,param1);
      }
      
      private function showWinner(param1:int, param2:int, param3:Boolean) : void {
         if(param3)
         {
            this.statusCleanup();
         }
         var _loc4_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc5_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         this.winningCleanup();
         if(_loc5_ == null)
         {
            this._cardController.showWinningHand(param1);
         }
         else
         {
            if(_loc5_.nSit != param1)
            {
               this._cardController.showWinningHand(param1);
            }
         }
         this._chickletCtrl.setState(ChickletController.STATE_WIN,param1);
         var _loc6_:Number = Math.floor(_loc4_.nChips - _loc4_.nOldChips);
         this._chipCtrl.payoutChips(param1,param2,_loc6_);
      }
      
      private function showDefaultWinner(param1:int, param2:Array) : void {
         var _loc3_:Array = param2;
         var _loc4_:PokerUser = this.ptModel.getUserBySit(param1);
         this.statusCleanup();
         this.winningCleanup();
         if(this._chickletCtrl)
         {
            this._chickletCtrl.setState(ChickletController.STATE_WIN,param1);
         }
         var _loc5_:Number = _loc4_.nChips - _loc4_.nOldChips;
         if(this._chipCtrl)
         {
            this._chipCtrl.payoutChips(param1,0,_loc5_);
         }
      }
      
      private function winningCleanup() : void {
         this._bettingControls.hideControls(this.isSeated());
      }
      
      private function updateUserChips(param1:int, param2:Number, param3:Number, param4:String) : void {
         this._chipCtrl.updateChipsFromPlayer(param1,param3,param4);
      }
      
      private function statusCleanup() : void {
         this._chickletCtrl.clearChickletSatuses();
      }
      
      private function setDealer(param1:int) : void {
         this.statusCleanup();
         this._puckControl.setDealer(param1);
      }
      
      private function showHoleCards(param1:int) : void {
         this._bettingControls.hideControls(this.isSeated());
         this._cardController.showWinningHand(param1);
      }
      
      private function replayComCard(param1:int) : void {
         this._cardController.dealCommunityCard(param1,true);
      }
      
      private function onEnterLuckyHandCouponTimestamp(param1:Object) : void {
         var _loc2_:REnterLuckyHandCouponTimestamp = REnterLuckyHandCouponTimestamp(param1);
         pgData.luckyHandStartTime = _loc2_.timestamp;
         var _loc3_:Number = new Date().time;
         pgData.luckyHandTimeLeft = pgData.luckyHandStartTime + 300 - int(_loc3_ / 1000);
         if((pgData.luckyHandCouponEnabled) && pgData.luckyHandTimeLeft > 0 && pgData.dispMode == "challenge" && !pgData.mttZone)
         {
            commandDispatcher.dispatchCommand(new InitLuckyHandCommand());
         }
      }
      
      private function onEnterUnluckyHandCouponTimestamp(param1:Object) : void {
         var _loc2_:REnterUnluckyHandCouponTimestamp = REnterUnluckyHandCouponTimestamp(param1);
         pgData.luckyHandStartTime = _loc2_.timestamp;
         pgData.luckyHandTimeLeft = pgData.luckyHandStartTime + 300 - int(new Date().time / 1000);
         if((pgData.luckyHandCouponEnabled) && pgData.luckyHandTimeLeft > 0 && pgData.dispMode == "challenge" && !pgData.mttZone)
         {
            commandDispatcher.dispatchCommand(new InitUnluckyHandCommand());
         }
      }
      
      public function get HSMEnabled() : Boolean {
         return this._bettingControls.hsmActivated;
      }
      
      private function enableChat(param1:CommandEvent) : void {
         this.initChatCtrlListeners();
         this._chatCtrl.readOnly = false;
         this._inOutOfChipsTableFlow = false;
      }
      
      private function enableChicklet(param1:CommandEvent) : void {
         this.initChickletMenuEventListeners();
      }
      
      private function updatePokerScoreChicklet(param1:CommandEvent) : void {
         var _loc2_:PokerScoreModel = param1.params as PokerScoreModel;
         if(_loc2_ != null)
         {
            if(this._chickletCtrl != null)
            {
               this._chickletCtrl.updatePokerScore(_loc2_);
            }
            if(_loc2_.scoreHasChanged)
            {
               this.showPokerScoreComment();
               dispatchCommand(new ShowPokerScoreSideNavCommand());
            }
         }
      }
      
      private function hidePokerScoreComment() : void {
         PokerTimer.instance.removeAnchor(this.hidePokerScoreComment);
         this.tipController.commentSuppressed = false;
         TweenLite.to(this._pokerScoreComment,1,
            {
               "alpha":0,
               "onComplete":function():void
               {
                  _pokerScoreComment.visible = false;
               }
            });
      }
      
      private function showPokerScoreComment() : void {
         this._pokerScoreComment.alpha = 1;
         this._pokerScoreComment.visible = true;
         this.tipController.commentSuppressed = true;
         PokerTimer.instance.addAnchor(3000,this.hidePokerScoreComment);
      }
      
      private function initializePokerScoreComment() : void {
         this._pokerScoreComment = new DealerComment();
         this._pokerScoreComment.pokerScoreReady(pgData.name);
         this.ptView.addChild(this._pokerScoreComment);
         this._pokerScoreComment.alpha = 0;
         this._pokerScoreComment.visible = false;
      }
      
      private function onTableLeaveCommand(param1:CommandEvent) : void {
         this.onLeaveTable();
      }
      
      public function hideInvite() : void {
         this._seatCtrl.hideInvite();
      }
      
      public function onHelpingHandsClick(param1:TVEvent) : void {
         var _loc2_:Object = configModel.getFeatureConfig("helpingHands");
         if((_loc2_) && (_loc2_.rakeData) && _loc2_.rakeData.firstTimeClick == true)
         {
            dispatchCommand(new JSCommand("zc.feature.helpingHands.setFirstTimeFlag"));
            dispatchEvent(new PopupEvent("showHelpingHandsCampaignInfo"));
            _loc2_.rakeData.firstTimeClick = false;
         }
      }
      
      public function onHelpingHandsHover(param1:TVEvent) : void {
         dispatchEvent(new PopupEvent("showHelpingHandsToaster"));
      }
      
      public function onHelpingHandsMouseOut(param1:TVEvent) : void {
         var _loc2_:IPopupController = registry.getObject(IPopupController);
         var _loc3_:Popup = _loc2_.getPopupConfigByID(Popup.HELPINGHANDSTOASTER);
         if((_loc3_) && (_loc3_.module))
         {
            _loc3_.module.prepareToCloseHHToaster();
         }
      }
      
      public function onToggleHelpingHandsRake(param1:CommandEvent) : void {
         this.ptView.toggleHelpingHandsRake();
      }
      
      public function onShowCampaignInfoPopup(param1:CommandEvent=null) : void {
         dispatchEvent(new PopupEvent("showHelpingHandsCampaignInfo"));
      }
      
      private function onSkipTableOverlay(param1:TVEvent) : void {
         dispatchCommand(new ShowSkipTablesOverlayCommand());
      }
      
      private function onSkipTableClearOverlay(param1:TVEvent) : void {
         dispatchCommand(new ShowSkipTablesOverlayCommand(false));
      }
      
      private function onRepositionChickletsStart(param1:TVEvent) : void {
         this._chickletCtrl.hideGifts();
         this._chickletCtrl.hidePokerScore();
         this._seatCtrl.suppressInviteVisibility();
      }
      
      private function onRepositionChickletsComplete(param1:TVEvent) : void {
         this._chickletCtrl.showGifts();
         this._chickletCtrl.showPokerScore();
         this._seatCtrl.restoreInviteVisibility();
         this._playerPosCtrl.clearTweenPaths();
      }
      
      override public function dispose() : void {
         super.dispose();
         this.ptModel = null;
         this._tableLayoutModel = null;
         this.ptView = null;
         if(this._bettingControls)
         {
            this._bettingControls.dispose();
         }
         this._bettingControls = null;
         this.mainDisp = null;
         this.viewer = null;
         this._postTableTypeInitFunction = null;
         if(this._todoListController != null)
         {
            this._todoListController.dispose();
            this._todoListController = null;
         }
         this._chatCtrl = null;
         this._invCtrl = null;
         this._dealerChatCtrl = null;
         if(this._chickletCtrl != null)
         {
            this._chickletCtrl.dispose();
            this._chickletCtrl = null;
         }
         this._cardController = null;
         this.giveChipsTimer = null;
         this.openGraphData = null;
         this.startHandSittingIDs = null;
         this.potsWinnersSit = null;
         this.dealTimer = null;
         this.aAddBuddyAttemptsZids = null;
         this.commentTimer = null;
         this.tipController = null;
         this.provCtrl = null;
         this._sfxHandlers = null;
         this._sfxHandlerQueue.length = 0;
         this._sfxHandlerQueue = null;
      }
   }
}
