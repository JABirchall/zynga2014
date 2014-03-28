package com.zynga.poker.nav
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.User;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.PokerConnectionManager;
   import flash.utils.Timer;
   import com.zynga.poker.feature.FeatureModule;
   import com.zynga.poker.nav.topnav.XPBoostWithPurchaseModel;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.commands.smartfox.GetUserInfoCommand;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.commands.navcontroller.AtTableEraseLossCommand;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.utils.timers.PokerTimer;
   import com.zynga.poker.nav.events.*;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   import flash.events.Event;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.IPokerController;
   import flash.events.TimerEvent;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.events.PopupEvent;
   import com.zynga.poker.commands.navcontroller.UpdateNavTimerCommand;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.table.shouts.views.ShoutMasteryAchievementView;
   import com.zynga.poker.nav.topnav.events.TopnavEvent;
   import com.zynga.poker.events.ProfilePopupEvent;
   import com.zynga.poker.popups.modules.profile.ProfilePanelTab;
   import com.zynga.poker.commands.selfcontained.CheckLobbyTimerCommand;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.poker.protocol.RAchieved;
   import com.zynga.poker.events.GiftPopupEvent;
   import com.zynga.poker.protocol.RGetChipsSig;
   import com.zynga.poker.protocol.RGoldUpdate;
   import com.zynga.poker.protocol.RXPEarned;
   import com.zynga.poker.protocol.RGetUserInfo;
   import com.zynga.poker.protocol.RUserLevelledUp;
   import com.zynga.poker.protocol.RAlert;
   import com.zynga.poker.nav.sidenav.events.SidenavEvents;
   import com.zynga.poker.protocol.RUpdatePendingChips;
   import com.zynga.poker.commands.pokercontroller.HideFullScreenCommand;
   import flash.display.Bitmap;
   import com.zynga.poker.events.ShowLuckyBonusPopupEvent;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.poker.popups.modules.livejoin.IBuddiesListController;
   import com.zynga.poker.nav.sidenav.Sidenav;
   import flash.display.MovieClip;
   import com.zynga.poker.events.JSEvent;
   import com.zynga.poker.commands.tablecontroller.AddLuckyHandCouponCommand;
   import com.zynga.poker.commands.pokercontroller.UpdatePokerGlobalDataCommand;
   import com.zynga.poker.events.GenericEvent;
   import com.zynga.poker.module.ModuleEvent;
   import com.zynga.poker.commands.selfcontained.module.ShowModuleCommand;
   
   public class NavController extends FeatureController implements INavController
   {
      
      public function NavController() {
         this._apploadTimeStamp = new Date().time;
         this._megaBillionsJackpotCounter = new Timer(this.JACKPOT_INCREASE_INTERVAL,0);
         super();
      }
      
      private var viewer:User;
      
      public var pControl:PokerController;
      
      public var pcmConnect:PokerConnectionManager;
      
      private var navModel:NavModel;
      
      public var navView:NavView;
      
      private var json:Object;
      
      private var getChipsLoc:String;
      
      private var entryPoint:String = "";
      
      private var bSideNavRequestedGiftShop:Boolean = false;
      
      private var bXpInfoInit:Boolean = false;
      
      public var isPopupJS:Boolean = false;
      
      private var navTimer:Timer;
      
      private var _scratchersPostLuckyBonusAdTimer:Timer;
      
      private var _blackjackPostLuckyBonusAdTimer:Timer;
      
      private var _oneclickrebuyAutoshowTimer:Timer;
      
      private var _oneclickrebuyLocalCheck:Boolean = true;
      
      private const AUTOSHOW_DURATION:int = 6000;
      
      private const POKERSCORE_TIMER:int = 120;
      
      private var _arcadePostLuckyBonusAdTimer:Timer;
      
      private var _megaBillionsJackpotInitialValue:Number;
      
      private var _megaBillionsJackpotCurrentValue:Number;
      
      private var _apploadTimeStamp:Number;
      
      private const JACKPOT_INCREASE_INTERVAL:Number = 50;
      
      private const JACKPOT_INCREASE_PER_INTERVAL:Number = 4629.6;
      
      private const ONE_BILLION:Number = 1000000000;
      
      private var _megaBillionsJackpotCounter:Timer;
      
      private var _buddiesList:FeatureModule;
      
      private var _notifController:FeatureModule;
      
      private var _userMadePurchase:Boolean = false;
      
      private const PLAYERS_CLUB_AUTOSHOW_DURATION:int = 3000;
      
      private var _xpBoostDataModel:XPBoostWithPurchaseModel = null;
      
      private const BOOST_ANIMATION_INTERVAL:Number = 15;
      
      private const BOOST_ANIMATION_TIME:Number = 6;
      
      private const BOOST_REDRAW_LEVELMETER_INTERVAL:Number = 3;
      
      override protected function preInit() : void {
         this.addDependencies();
      }
      
      private function addDependencies() : void {
         if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
         {
            addDependency(Popup.BUDDIES_LIST);
            addDependency(Popup.BUDDIES_TOASTER);
         }
      }
      
      override protected function postInit() : void {
         dispatchCommand(new GetUserInfoCommand());
         if((pgData.luckyBonusEnabled) && pgData.luckyBonusTimeUntil == 0)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyBonusSpinReady:2012-03-14"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyBonusWaiting:2012-03-26"));
         }
      }
      
      override protected function initModel() : FeatureModel {
         this.viewer = pgData.viewer;
         this.navModel = registry.getObject(NavModel);
         this.navModel.nChips = pgData.points;
         this.navModel.nAchievements = pgData.nAchievementNumber;
         this.navModel.nAchievementsTotal = configModel.getIntForFeatureConfig("achievements","ach_count");
         this.navModel.nBuddiesAlerts = 0;
         this.navModel.sPicURL = configModel.getStringForFeatureConfig("user","pic_url");
         return this.navModel;
      }
      
      override public function addListeners() : void {
         this.pcmConnect.addEventListener("onMessage",this.onProtocolMessage);
         addEventListener(CommandEvent.TYPE_HIDE_SIDENAV,this.hideSideNav);
         addEventListener(CommandEvent.TYPE_OPEN_JS_POPUP,this.onOpenJSPopup);
         addEventListener(CommandEvent.TYPE_OPEN_BUY_PAGE,this.onBuyPageRequest);
         addEventListener(CommandEvent.TYPE_SHOW_SIDENAV,this.showSideNav);
         addEventListener(CommandEvent.TYPE_SHOW_POKER_SCORE_SIDENAV,this.onShowPokerScoreSideNav);
         addEventListener(CommandEvent.TYPE_SHOW_LEADERBOARD_SURFACING,this.onShowLeaderboardSurfacing);
         addEventListener(CommandEvent.TYPE_HIDE_LEADERBOARD_SURFACING,this.onHideLeaderboardSurfacing);
         addEventListener(CommandEvent.TYPE_HIDE_LEADERBOARD_FLYOUT,this.onHideLeaderboardFlyout);
         addEventListener(CommandEvent.TYPE_UPDATE_NAV_TIMER,this.onUpdateNavTimer);
         addEventListener(CommandEvent.TYPE_UPDATE_NAV_ITEM_COUNT,this.onUpdateNavItemCount);
         addEventListener(CommandEvent.TYPE_INIT_LUCKY_HAND_COUPON,this.onInitLuckyHandBonus);
         addEventListener(CommandEvent.TYPE_INIT_UNLUCKY_HAND_COUPON,this.onInitUnluckyHandBonus);
         addEventListener(NVEvent.TOGGLE_BUDDIES_DROPDOWN,this.onToggleBuddiesList);
         addEventListener(NVEvent.SHOW_BUDDIES_DROPDOWN,this.onShowBuddiesList);
         addEventListener(NVEvent.HIDE_BUDDIES_DROPDOWN,this.onHideBuddiesList);
         addEventListener(AtTableEraseLossCommand.BUY_ATTABLEERASELOSS_COUPON,this.onBuyAtTableEraseLossCoupon);
         addEventListener(AtTableEraseLossCommand.SHOW_ATTABLEERASELOSS_SIDENAV,this.onShowAtTableEraseLossSideNav);
         if(configModel.isFeatureEnabled("helpingHands"))
         {
            externalInterface.addCallback("showHelpingHandsCampaignInfo",this.onShowCampaignInfoPopup);
         }
         externalInterface.addCallback("setSideNavAnimationByName",this.setSideNavAnimationByName);
         externalInterface.addCallback("paymentsBuySuccess",this.onPaymentsBuySuccess);
         externalInterface.addCallback("autoOpenLuckyBonus",this.onAutoOpenLuckyBonus);
         externalInterface.addCallback("displayGiftShop",this.displayGiftShop);
      }
      
      private function initViewListeners() : void {
         this.navView.addEventListener(NVEvent.USER_PIC_CLICKED,this.onShowUserProfile);
         this.navView.addEventListener(NVEvent.SHOW_GIFT_SHOP,this.onShowGiftShop);
         this.navView.addEventListener(NVEvent.HIDE_GIFT_SHOP,this.onSideNavHideGiftShop);
         this.navView.addEventListener(NVEvent.SHOW_USER_PROFILE,this.onShowUserProfile);
         this.navView.addEventListener(NVEvent.HIDE_USER_PROFILE,this.onSideNavHideUserProfile);
         this.navView.addEventListener(NVEvent.SHOW_POKER_SCORE_CARD,this.onShowPokerScoreCard);
         this.navView.addEventListener(NVEvent.SHOW_GET_CHIPS,this.onShowGetChips);
         this.navView.addEventListener(NVEvent.HIDE_GET_CHIPS,this.onSideNavHideGetChips);
         this.navView.addEventListener(NVEvent.GET_CHIPS_CLICKED,this.onGetChipsClicked);
         this.navView.addEventListener(NVEvent.CHIPSHIT_CLICKED,this.onChipsHitClicked);
         this.navView.addEventListener(NVEvent.GOLDHIT_CLICKED,this.onGoldHitClicked);
         this.navView.addEventListener(NVEvent.ACHIEVEMENTS_CLICKED,this.onAchievementsClicked);
         this.navView.addEventListener(NVEvent.GAME_SETTINGS_CLICKED,this.onGameSettingsClicked);
         this.navView.addEventListener(NVEvent.SHOW_BETTING,this.onShowBetting);
         this.navView.addEventListener(NVEvent.HIDE_BETTING,this.onSideNavHideBetting);
         this.navView.addEventListener(NVEvent.SHOW_BUDDIES,this.onShowBuddies);
         this.navView.addEventListener(NVEvent.HIDE_BUDDIES,this.onSideNavHideBuddies);
         this.navView.addEventListener(NVEvent.TOGGLE_BUDDIES_DROPDOWN,this.onToggleBuddiesList);
         this.navView.addEventListener(NVEvent.SHOW_CHALLENGES,this.onShowChallengesClicked);
         this.navView.addEventListener(NVEvent.HIDE_CHALLENGES,this.onSideNavHideChallenges);
         this.navView.addEventListener(NVEvent.GAME_CARD_BUTTON_CLICK,this.onGameCardButtonClick);
         this.navView.addEventListener(NVEvent.NEWS_BUTTON_CLICK,this.onNewsButtonClick);
         this.navView.addEventListener(NVEvent.SHOW_POKER_GENIUS,this.onShowPokerGenius);
         this.navView.addEventListener(NVEvent.HIDE_POKER_GENIUS,this.onHidePokerGenius);
         this.navView.addEventListener(NVEvent.SHOW_LUCKY_BONUS,this.onShowLuckyBonus);
         this.navView.addEventListener(NVEvent.SHOW_LUCKY_BONUS_GOLD,this.onShowLuckyBonusGold);
         this.navView.addEventListener(NVEvent.HIDE_LUCKY_BONUS,this.onSideNavHideLuckyBonus);
         this.navView.addEventListener(NVEvent.SHOW_SCRATCHERS,this.onShowScratchers);
         this.navView.addEventListener(NVEvent.HIDE_SCRATCHERS,this.onHideScratchers);
         this.navView.addEventListener(NVEvent.FTUE_CLICKED,this.onFTUEClicked);
         this.navView.addEventListener(NVEvent.SHOW_BLACKJACK,this.onShowBlackjack);
         this.navView.addEventListener(NVEvent.HIDE_BLACKJACK,this.onHideBlackjack);
         this.navView.addEventListener(NVEvent.SHOW_ONECLICKREBUY,this.onShowOneClickRebuy);
         this.navView.addEventListener(NVEvent.HIDE_ONECLICKREBUY,this.onHideOneClickRebuy);
         this.navView.addEventListener(NVEvent.PREP_HIDE_ONECLICKREBUY,this.onPrepHideOneClickRebuy);
         this.navView.addEventListener(NVEvent.SHOW_SERVEPROGRESS,this.onShowServeProgress);
         this.navView.addEventListener(NVEvent.HIDE_SERVEPROGRESS,this.onHideServeProgress);
         this.navView.addEventListener(NVEvent.ARCADE_PLAYNOW_CLICKED,this.onArcadePlayNowClicked);
         this.navView.addEventListener(NVEvent.SHOW_LUCKY_HAND_COUPON,this.onShowLuckyHandCoupon);
         this.navView.addEventListener("LBIconLoaded",this.onMegaBillionsIconLoaded);
         this.navView.addEventListener("MiniArcadeIconLoaded",this.onMegaBillionsIconLoaded);
         this.navView.addEventListener(NVEvent.SHOW_UNLUCKY_HAND_COUPON,this.onShowUnluckyHandCoupon);
         this.navView.addEventListener(AtTableEraseLossCommand.BUY_ATTABLEERASELOSS_COUPON,this.onBuyAtTableEraseLossCoupon);
         this.navView.addEventListener(NVEvent.SHOW_PLAYERS_CLUB_TOASTER,this.onShowPlayersClubToaster);
         this.navView.addEventListener(NVEvent.SHOW_PLAYERS_CLUB_REWARD_CENTER,this.onShowPlayersClubRewardCenter);
         this.navView.addEventListener(NVEvent.SHOW_LEADERBOARD,this.onShowLeaderboard);
         this.navView.topNav.leveler.addEventListener(NVEvent.PLAYING_LEVELUP_ANIMATION,this.onShowingLevelUpAnimation);
         this.navView.topNav.leveler.addEventListener(NVEvent.STOP_LEVELUP_ANIMATION,this.onStopLevelUpAnimation);
         ListenerManager.addEventListener(this.navView.topNav,NVEvent.SHOW_BUY_PAGE,this.onShowBuyPage);
         ListenerManager.addEventListener(this.navView.topNav,NVEvent.SHOW_XP_BOOST_TOASTER,this.showXPBoostToaster);
         ListenerManager.addEventListener(this.navView.topNav,NVEvent.REMOVE_XP_BOOST_TOASTER,this.hideXPBoostToaster);
         ListenerManager.addEventListener(this,CommandEvent.TYPE_SHOW_XPBOOST_TOASTER,this.onShowXPBoostToaster);
         ListenerManager.addEventListener(this,CommandEvent.TYPE_UPDATE_XPBOOST_TOASTER,this.updateXPBarAfterPurchaseData);
      }
      
      private function initXPBoostWithPurchaseView() : void {
         var _loc1_:* = NaN;
         if(this._xpBoostDataModel != null)
         {
            this.navView.topNav.drawXPBoostToaster();
            if(this._xpBoostDataModel.timeRemaining > 0)
            {
               this.navView.topNav.drawXPBoostActiveBar();
               PokerTimer.instance.removeAnchor(this.updateXPBoostTimeRemaining);
               PokerTimer.instance.removeAnchor(this.updateXPBoostLevelMeter);
               PokerTimer.instance.addAnchor(this.BOOST_ANIMATION_INTERVAL * 1000,this.updateXPBoostTimeRemaining);
               PokerTimer.instance.addAnchor(this.BOOST_REDRAW_LEVELMETER_INTERVAL * 1000,this.updateXPBoostLevelMeter);
               if(configModel.getBooleanForFeatureConfig("xPBoostWithPurchase","showOnAppEntry"))
               {
                  _loc1_ = configModel.getNumberForFeatureConfig("xPBoostWithPurchase","appEntryDisplayTime");
                  this.onShowXPBoostToaster(new CommandEvent(CommandEvent.TYPE_SHOW_XPBOOST_TOASTER,{"displayTime":_loc1_}));
               }
            }
            this.navView.topNav.enableButtonModeForLevelsHit(this._xpBoostDataModel.openBuyPageOnXPBarClick);
         }
      }
      
      private function initXPBoostWithPurchaseModel() : void {
         this._xpBoostDataModel = registry.getObject(XPBoostWithPurchaseModel);
         this._xpBoostDataModel.init();
      }
      
      public function updateXPBarAfterPurchaseData(param1:CommandEvent) : void {
         if(param1.params)
         {
            this._xpBoostDataModel.updateModel(param1.params);
            PokerTimer.instance.removeAnchor(this.updateXPBoostTimeRemaining);
            PokerTimer.instance.removeAnchor(this.updateXPBoostLevelMeter);
            this.initXPBoostWithPurchaseView();
            this.onShowXPBoostToaster(null);
         }
      }
      
      private function onShowXPBoostToaster(param1:CommandEvent) : void {
         this.showXPBoostToaster(null);
         var _loc2_:Number = this.BOOST_ANIMATION_TIME * 1000;
         if((param1) && (param1.params) && (param1.params.displayTime))
         {
            _loc2_ = param1.params.displayTime;
         }
         PokerTimer.instance.addAnchor(_loc2_,this.onHideXPBoostToaster);
      }
      
      private function onHideXPBoostToaster() : void {
         this.hideXPBoostToaster(null);
         PokerTimer.instance.removeAnchor(this.onHideXPBoostToaster);
      }
      
      private function getXPBoostTimeRemaining() : Number {
         this._xpBoostDataModel.timeRemaining = this._xpBoostDataModel.endTimestamp - new Date().time / 1000;
         return this._xpBoostDataModel.timeRemaining;
      }
      
      private function updateXPBoostLevelMeter() : void {
         if(this.getXPBoostTimeRemaining() <= 0)
         {
            this.navView.topNav.leveler.isUserXPBoosting = false;
            PokerTimer.instance.removeAnchor(this.updateXPBoostLevelMeter);
         }
         else
         {
            this.navView.topNav.leveler.isUserXPBoosting = true;
            this.navView.topNav.leveler.drawXPBoostActiveBar();
         }
      }
      
      private function updateXPBoostTimeRemaining() : void {
         var _loc2_:* = 0;
         var _loc1_:Number = this.getXPBoostTimeRemaining();
         if(_loc1_ <= 0)
         {
            this.navView.topNav.leveler.removeXPBoostActiveBar();
            PokerTimer.instance.removeAnchor(this.updateXPBoostTimeRemaining);
            PokerTimer.instance.removeAnchor(this.updateXPBoostLevelMeter);
         }
         else
         {
            this.navView.topNav.playXPBoostAnimation();
            for each (_loc2_ in XPBoostWithPurchaseModel.MILESTONE_ARRAY)
            {
               if(_loc1_ - this.BOOST_ANIMATION_INTERVAL < _loc2_ && _loc2_ < _loc1_)
               {
                  this.onShowXPBoostToaster(null);
               }
            }
         }
      }
      
      private function onShowBuyPage(param1:NVEvent) : void {
         if(!(this._xpBoostDataModel == null) && (this._xpBoostDataModel.openBuyPageOnXPBarClick))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"XPBoostWithPurchase Other Click o:XPBar:2013-07-31"));
            dispatchCommand(new ShowBuyPageCommand("xp_bar_click","","chips"));
         }
      }
      
      private function showXPBoostToaster(param1:NVEvent) : void {
         var _loc2_:Array = null;
         if(this._xpBoostDataModel != null)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"XPBoostWithPurchase Other Impression o:XPBar:2013-07-31"));
            if(this._xpBoostDataModel.timeRemaining <= 0)
            {
               this.navView.topNav.displayDefaultXPBoostToaster();
            }
            else
            {
               _loc2_ = this._xpBoostDataModel.formattedTimeRemaining;
               this.navView.topNav.displayXPBoostToasterWithTimer(this._xpBoostDataModel.XPMultiplier,_loc2_);
            }
         }
      }
      
      private function hideXPBoostToaster(param1:NVEvent) : void {
         this.navView.topNav.hideXPBoostToaster();
      }
      
      private function onShowAtTableEraseLossSideNav(param1:Event) : void {
         this.navView.showAtTableEraseLossSideNav();
      }
      
      private function onHideAtLossEraseTableCoupon(param1:NVEvent) : void {
         this.navView.hideAtTableEraseLossSideNav();
      }
      
      override protected function initView() : FeatureView {
         this.navView = new NavView();
         this.navView.visible = false;
         return this.navView;
      }
      
      private function _initModel() : void {
         this.navModel.init();
      }
      
      private function _initView() : void {
         var sideNavConfig:Object = null;
         var userConfig:Object = null;
         var megaBillionsConfig:Object = null;
         var pControl:PokerController = null;
         var popupController:PopupController = null;
         var popup:Popup = null;
         var strace:String = null;
         try
         {
            if(configModel.isFeatureEnabled("megaBillions"))
            {
               megaBillionsConfig = configModel.getFeatureConfig("megaBillions");
               if(megaBillionsConfig.enabled == true)
               {
                  pgData.megaBillionsEnabled = true;
               }
            }
            sideNavConfig = configModel.getFeatureConfig("sideNav");
            this.navView.showGetChipsStarburst = sideNavConfig?sideNavConfig.showGetChipsStartburst:false;
            this.navView.init(this.navModel);
            userConfig = configModel.getFeatureConfig("user");
            if(userConfig.approvedChips > 0)
            {
               this.navView.approvedChips = userConfig.approvedChips;
            }
            if(userConfig.canceledChips > 0)
            {
               this.navView.canceledChips = userConfig.canceledChips;
            }
            if(userConfig.pendingChips > 0)
            {
               this.navView.pendingChips = userConfig.pendingChips;
            }
            if(userConfig.approvedGold > 0)
            {
               this.navView.approvedGold = userConfig.approvedGold;
            }
            if(userConfig.canceledGold > 0)
            {
               this.navView.canceledGold = userConfig.canceledGold;
            }
            if(userConfig.pendingGold > 0)
            {
               this.navView.pendingGold = userConfig.pendingGold;
            }
            this.navView.pendingDuration = configModel.getIntForFeatureConfig("core","pendingDuration",36);
            if((sideNavConfig) && (sideNavConfig.sideNavAnimationsURL))
            {
               this.setNavAnimations(sideNavConfig.sideNavAnimationsURL);
            }
            if((pgData.luckyBonusEnabled) && pgData.luckyBonusTimeUntil <= 0)
            {
               this.updateNavItemCount("LuckyBonus",pgData.luckyBonusFriendCount);
            }
            if((megaBillionsConfig) && !megaBillionsConfig.multiplierVariant)
            {
               this.updateNavItemCount("LuckyBonus",1);
            }
            if(pgData.pokerGeniusSettings)
            {
               this.updateNavItemCount("PokerGenius",this.pControl.getQuestionCount());
            }
            if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
            {
               pControl = registry.getObject(IPokerController);
               this.updateNavItemCount("OnlineBuddiesIcon",pControl.zoomModel.friendsList.length);
            }
            if(pgData.serveProgressData)
            {
               if(pgData.serveProgressData.timeLeft <= 0 && pgData.serveProgressData.daysLeft >= 0)
               {
                  this.navView.iconFlags["AmexServe"] = "claim";
               }
               if(pgData.serveProgressData.firstAppload)
               {
                  this.navView.showAmexServeAd(pgData.serveProgressData.firstAppload);
               }
            }
            if(this.navModel.navTimers)
            {
               this.navTimer = new Timer(500);
               this.navTimer.addEventListener(TimerEvent.TIMER,this.onNavTimerUpdate,false,0,true);
               this.navTimer.start();
            }
            if(configModel.isFeatureEnabled("luckyHandCoupon"))
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyHandCoupon:2013-01-28"));
               this.processLuckyHandCouponData();
               this.navView.initLuckyHandArrow();
            }
            if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
            {
               popupController = registry.getObject(IPopupController);
               popup = popupController.getPopupConfigByID(Popup.BUDDIES_TOASTER);
               if(popup)
               {
                  this._notifController = popup.module as FeatureModule;
                  this._notifController.init(this.navView);
               }
               this.navView.topNav.drawBuddiesIcon();
            }
            if(configModel.getBooleanForFeatureConfig("xpCapIncrease","showToaster"))
            {
               dispatchEvent(new PopupEvent("showXPIncreaseToaster"));
            }
            dispatchEvent(new NCEvent(NCEvent.VIEW_INIT));
         }
         catch(e:Error)
         {
            externalInterface.call("ZY.App.f.phone_home","initNavView error: " + e.message);
            strace = e.getStackTrace();
            if(strace != null)
            {
               externalInterface.call("ZY.App.f.phone_home","initNavView stacktrace: " + strace);
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:Loader:InitNavViewError:2011-05-22",null,1));
            throw e;
         }
         addEventListener(CommandEvent.TYPE_DISPLAY_GIFT_SHOP,this.onDisplayGiftShop);
      }
      
      private function onMegaBillionsIconLoaded(param1:Event) : void {
         var _loc2_:Object = null;
         if(configModel.isFeatureEnabled("megaBillions"))
         {
            _loc2_ = configModel.getFeatureConfig("megaBillions");
            if(_loc2_.enabled == true)
            {
               this._megaBillionsJackpotInitialValue = _loc2_.jackpotInitialValue;
               this._megaBillionsJackpotCurrentValue = this._megaBillionsJackpotInitialValue + Math.round((new Date().time - this._apploadTimeStamp) / this.JACKPOT_INCREASE_INTERVAL * this.JACKPOT_INCREASE_PER_INTERVAL);
               this._megaBillionsJackpotCounter.addEventListener(TimerEvent.TIMER,this.updateMegaBillionsArcade);
               this._megaBillionsJackpotCounter.start();
               this.navView.initMegaBillionsThresholdArrow();
               this.navView.initMegaBillionsFTUEArrow();
               this.navView.initMegaBillionsWinnerArrow();
            }
         }
      }
      
      private function updateMegaBillionsArcade(param1:TimerEvent) : void {
         this._megaBillionsJackpotCurrentValue = this._megaBillionsJackpotCurrentValue + this.JACKPOT_INCREASE_PER_INTERVAL;
         this.navView.updateMegaBillionsArcade(Math.round(this._megaBillionsJackpotCurrentValue));
      }
      
      private function processLuckyHandCouponData() : void {
         var _loc4_:* = NaN;
         if(!configModel.isFeatureEnabled("luckyHandCoupon"))
         {
            return;
         }
         var _loc1_:Object = configModel.getFeatureConfig("luckyHandCoupon");
         pgData.luckyHandCouponEnabled = true;
         var _loc2_:Number = new Date().time;
         var _loc3_:Number = _loc1_.LuckyHandCouponTimestamp + 300 - int(_loc2_ / 1000);
         if(_loc3_ > 0 && _loc3_ <= 300)
         {
            _loc4_ = Math.floor((_loc2_ - pgData.timeStamp) / 1000);
            dispatchCommand(new UpdateNavTimerCommand("LuckyHandCoupon",_loc3_ + _loc4_));
            pgData.luckyHandTimeLeft = _loc3_;
            this.navView.hideGetChipsSideNav();
            this.navView.showLuckyHandSideNav();
         }
      }
      
      private function onDisplayGiftShop(param1:CommandEvent) : void {
         this.displayGiftShop();
      }
      
      public function displayNav() : void {
         this.navView.visible = true;
         this.updateChips();
      }
      
      private function onNavTimerUpdate(param1:TimerEvent) : void {
         var _loc2_:String = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         for (_loc2_ in this.navModel.navTimers)
         {
            if(this.navModel.navTimers[_loc2_])
            {
               _loc3_ = new Date().time;
               _loc4_ = Math.max(0,this.navModel.navTimers[_loc2_] + Math.floor((pgData.timeStamp - _loc3_) / 1000));
               if(_loc4_ <= 0)
               {
                  if(_loc2_ == "LuckyBonus")
                  {
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyBonusSpinReady:2012-03-14"));
                     pgData.luckyBonusTimeUntil = 0;
                     this.navView.updateNavTimer(_loc2_,_loc4_);
                  }
                  else
                  {
                     if(_loc2_ == "AmexServe")
                     {
                        fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:AmexServeDripReady:2013-10-31"));
                        PokerGlobalData.instance.serveProgressData.timeLeft = 0;
                        this.navView.updateNavTimer("AmexServe",0);
                     }
                     else
                     {
                        if(_loc2_ == "LuckyHandCoupon")
                        {
                           fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyHandCouponTimeout:2013-01-17"));
                           pgData.luckyHandTimeLeft = 0;
                           this.navView.updateNavTimer("LuckyHandCoupon",0);
                           this.hideLuckyHandDiscount();
                        }
                        else
                        {
                           if(_loc2_ == "AtTableEraseLossCoupon")
                           {
                              this.navView.hideAtTableEraseLossSideNav();
                           }
                           else
                           {
                              if(_loc2_ == "LuckyHandV2Coupon")
                              {
                                 fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyHandV2CouponTimeout:2013-03-06"));
                                 pgData.luckyHandTimeLeft = 0;
                                 this.navView.updateNavTimer("LuckyHandV2Coupon",0);
                                 this.hideLuckyHandDiscount();
                              }
                              else
                              {
                                 if(_loc2_ == "PokerScore")
                                 {
                                    this.navView.updateNavTimer("PokerScore",0);
                                 }
                              }
                           }
                        }
                     }
                  }
                  this.navModel.navTimers[_loc2_] = null;
               }
               else
               {
                  this.navView.updateNavTimer(_loc2_,_loc4_);
                  if(_loc2_ == "LuckyBonus")
                  {
                     pgData.luckyBonusTimeUntil = _loc4_;
                  }
               }
            }
         }
      }
      
      public function updateNavTimer(param1:String, param2:Number) : void {
         if(param1 == "AmexServe")
         {
            if(pgData.serveProgressData.daysLeft >= 0)
            {
               this.navModel.navTimers[param1] = param2;
               this.navView.showNavTimer(param1,param2);
            }
         }
         else
         {
            this.navModel.navTimers[param1] = param2;
            this.navView.showNavTimer(param1,param2);
         }
      }
      
      public function showSideNav(param1:Event=null) : void {
         if((this.navView) && !configModel.getBooleanForFeatureConfig("videoPoker","isActive"))
         {
            this.navView.showSideNav();
         }
      }
      
      public function hideSideNav(param1:Event=null) : void {
         if(this.navView)
         {
            this.navView.hideSideNav();
         }
      }
      
      public function enableSideNav() : void {
         if(this.navView)
         {
            this.navView.enableSideNav();
         }
      }
      
      public function disableSideNav() : void {
         if(this.navView)
         {
            this.navView.disableSideNav();
         }
      }
      
      public function hideNavFTUEs() : void {
         if(this.navView)
         {
            this.navView.hideNavFTUEs();
         }
      }
      
      public function showBuddies() : void {
         this.navView.setSidebarItemsSelected("buddies");
         this.onShowBuddies(null);
      }
      
      public function setSidebarItemsSelected(param1:String="") : void {
         this.navView.setSidebarItemsSelected(param1);
      }
      
      public function setSidebarItemsDeselected(param1:String="") : void {
         if(this.navView)
         {
            this.navView.setSidebarItemsDeselected(param1);
         }
      }
      
      public function setSidebarItemIsEnabled(param1:String="", param2:Boolean=true) : void {
         if(this.navView)
         {
            this.navView.setSidebarItemIsEnabled(param1,param2);
         }
      }
      
      public function setSidebarItemVisibility(param1:String, param2:Boolean) : void {
         if(this.navView)
         {
            this.navView.setSidebarItemVisibility(param1,param2);
         }
      }
      
      public function clearPlayersClubCoolDown() : void {
         this.navView.topNav.clearPlayersClubCoolDown();
      }
      
      public function startPlayersClubCoolDown() : void {
         this.navView.topNav.startPlayersClubCoolDown();
      }
      
      public function incrementPlayersClubCoolDown() : void {
         this.navView.topNav.incrementPlayersClubCoolDown();
      }
      
      public function canShowPlayersClubToaster() : Boolean {
         return this.navView.topNav.canShowPlayersClubToaster();
      }
      
      public function showPlayersClubToaster(param1:Object) : void {
         this.navView.topNav.showPlayersClubToaster(param1);
      }
      
      private function onShowPlayersClubToaster(param1:NVEvent) : void {
         dispatchEvent(new PopupEvent("showPlayersClubToaster",false,param1.params));
         PokerTimer.instance.addAnchor(this.PLAYERS_CLUB_AUTOSHOW_DURATION,this.onHidePlayersClubToaster);
      }
      
      private function onShowPlayersClubRewardCenter(param1:NVEvent) : void {
         dispatchEvent(new PopupEvent("showPlayersClubRewardCenter"));
      }
      
      public function onHidePlayersClubToaster() : void {
         var _loc1_:PopupController = registry.getObject(IPopupController);
         var _loc2_:Popup = _loc1_.getPopupConfigByID(Popup.PLAYERSCLUBTOASTER);
         if((_loc2_) && (_loc2_.module))
         {
            _loc2_.module.dispose();
         }
         PokerTimer.instance.removeAnchor(this.onHidePlayersClubToaster);
      }
      
      public function showOneClickRebuy() : void {
         var _loc1_:Object = configModel.getFeatureConfig("oneClickRebuy");
         if((this._oneclickrebuyLocalCheck) && (_loc1_) && (_loc1_.autoShow))
         {
            if(this._oneclickrebuyAutoshowTimer)
            {
               this._oneclickrebuyAutoshowTimer.stop();
            }
            this._oneclickrebuyAutoshowTimer = null;
            this._oneclickrebuyAutoshowTimer = new Timer(6000,1);
            this._oneclickrebuyAutoshowTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onAutoHideOneClickRebuyPopup,false,0,true);
            this._oneclickrebuyAutoshowTimer.start();
            externalInterface.call("zc.feature.payments.oneclickrebuyimpression.logOneClickRebuyAutoImpression");
            this._oneclickrebuyLocalCheck = false;
            this.onShowOneClickRebuy();
         }
      }
      
      private function onAutoHideOneClickRebuyPopup(param1:TimerEvent) : void {
         this._oneclickrebuyAutoshowTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onAutoHideOneClickRebuyPopup);
         this._oneclickrebuyAutoshowTimer = null;
         this.onHideOneClickRebuy();
      }
      
      public function updateChips(param1:Boolean=false) : void {
         if(!(pgData.dispMode == "weekly") || (param1))
         {
            this.navModel.nChips = pgData.points;
            this.navView.updateChips(this.navModel.nChips);
         }
      }
      
      public function updateTickets() : void {
         this.navModel.nTickets = pgData.zpwcTickets;
         this.navView.updateTickets(this.navModel.nTickets);
      }
      
      public function getChips() : Number {
         return this.navModel.nChips;
      }
      
      public function updateNavItemCount(param1:String, param2:int) : void {
         if(this.navView != null)
         {
            this.navView.updateSidenavItemCount(param1,param2);
            this.navView.updateTopnavItemCount(param1,param2);
         }
      }
      
      public function updateWaitingChallengesCount(param1:int) : void {
         this.updateNavItemCount("Challenge",param1);
      }
      
      public function onZoomShout(param1:Object) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1.type == ShoutMasteryAchievementView.SHOUT_TYPE)
         {
            if(param1.achievementName)
            {
               pgData.newAchievementItemCount++;
            }
            else
            {
               _loc3_ = (param1.achievementIds as Array).length;
               pgData.newAchievementItemCount = _loc3_;
            }
            _loc2_ = pgData.newCollectionItemCount + pgData.newAchievementItemCount;
            this.updateNewProfileItemCount(_loc2_);
         }
      }
      
      public function updateNewProfileItemCount(param1:int) : void {
         this.updateNavItemCount("Profile",param1);
      }
      
      public function setNavAnimations(param1:Object) : void {
         this.navView.loadNavAnimations(param1);
      }
      
      private function setSideNavAnimationByName(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.name;
         var _loc3_:String = param1.url;
         if(!_loc2_ || !_loc3_)
         {
            return;
         }
         this.navView.loadSideNavAnimationByName(_loc2_,_loc3_);
         if(pgData.revPromoID)
         {
            pgData.revPromoAnimationApplied = true;
         }
      }
      
      private function onAchievementsClicked(param1:NVEvent) : void {
         this.navView.setSidebarItemsSelected("profile");
         this.navView.dispatchEvent(new TopnavEvent(TopnavEvent.NEW_ACHIEVEMENTS_NOTIFICATION_RESET));
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
         var _loc2_:Object = 
            {
               "zid":pgData.zid,
               "playerName":pgData.name
            };
         this.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,_loc2_,ProfilePanelTab.ACHIEVEMENTS));
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:TopNav:Achievements:2010-04-06"));
               fireStat(new PokerStatHit("lobbyTopNavClickAchievementsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:TopNav:AchievementsOnce:2010-04-08"));
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TopNav:Achievements:2010-08-19"));
            fireStat(new PokerStatHit("tableTopNavClickAchievementsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:TopNav:AchievementsOnce:2010-08-19"));
         }
      }
      
      private function onGameSettingsClicked(param1:NVEvent) : void {
         if(externalInterface.available)
         {
            externalInterface.call("ZY.App.settings.open");
         }
         dispatchCommand(new CheckLobbyTimerCommand());
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc3_:RAchieved = null;
         var _loc2_:Object = param1.msg;
         switch(_loc2_.type)
         {
            case "RAchieved":
               _loc3_ = RAchieved(param1.msg);
               if(_loc3_.sZid == pgData.viewer.zid)
               {
                  this.navModel.nAchievements++;
                  this.navView.updateAchievements(this.navModel.nAchievements);
               }
               break;
            case "RGiftPrices3":
               if(this.bSideNavRequestedGiftShop)
               {
                  this.pControl.closeAllPopups();
                  dispatchEvent(new GiftPopupEvent("showDrinkMenu",-1,[],pgData.zid) as PopupEvent);
               }
               this.bSideNavRequestedGiftShop = false;
               break;
            case "RUpdateChips":
               break;
            case "RXPEarned":
               this.onXPEarned(_loc2_);
               break;
            case "RGetUserInfo":
               if(pgData.smartfoxVars.xpCapVariant < 3 && _loc2_.level >= 101)
               {
                  _loc2_.xpLevelEnd = -1;
               }
               if(!this.bXpInfoInit)
               {
                  this.onGetUserInfo(_loc2_);
               }
               this.bXpInfoInit = true;
               break;
            case "RAlert":
               this.onRAlert(_loc2_);
               break;
            case "RUserLevelledUp":
               this.onUserLevelledUp(_loc2_);
               break;
            case "RGoldUpdate":
               this.onGoldUpdate(_loc2_);
               break;
            case "RGetChipsSig":
               if(_loc2_ is RGetChipsSig)
               {
                  this.showGetChipsPanelWithSig(_loc2_ as RGetChipsSig);
               }
               break;
            case "RMegaBillionsUpdate":
               this.onMegaBillionsUpdate(_loc2_);
               break;
         }
         
      }
      
      private function onGoldUpdate(param1:Object) : void {
         var _loc2_:RGoldUpdate = RGoldUpdate(param1);
         pgData.casinoGold = _loc2_.amt;
         this.updateCasinoGold();
      }
      
      private function onXPEarned(param1:Object) : void {
         if(param1 is RXPEarned)
         {
            pgData.xpLevel = param1.level;
            pgData.currentXP = param1.xpTotal;
            pgData.xpToNextLevel = param1.xpToNextLevel;
            this.navView.updateXPInformation(param1.xpTotal,param1.xpDelta,param1.level,pgData.getXPLevelName(Number(param1.level)),param1.xpToNextLevel);
         }
      }
      
      private function onGetUserInfo(param1:Object) : void {
         var _loc2_:* = NaN;
         if(param1 is RGetUserInfo)
         {
            pgData.xpLevel = param1.level;
            pgData.currentXP = param1.xp;
            pgData.xpToNextLevel = param1.xpLevelEnd;
            this._initModel();
            this._initView();
            this.initViewListeners();
            this.navView.updateXPInformation(param1.xp,0,param1.level,pgData.getXPLevelName(Number(param1.level)),param1.xpLevelEnd);
            if(configModel.isFeatureEnabled("xPBoostWithPurchase"))
            {
               this.initXPBoostWithPurchaseModel();
               this.initXPBoostWithPurchaseView();
            }
            _loc2_ = param1.nextGiftUnlock < param1.nextAchievementUnlock?param1.nextGiftUnlock:param1.nextAchievementUnlock;
            this.navView.updateNextUnlockLevel(_loc2_);
            this.updateCasinoGold();
            this.pControl.postNavLoad_loadLobby();
         }
      }
      
      private function onUserLevelledUp(param1:Object) : void {
         var _loc2_:* = NaN;
         if(param1 is RUserLevelledUp)
         {
            if(param1.zid == pgData.viewer.zid)
            {
               _loc2_ = param1.nextGiftUnlock < param1.nextAchievementUnlock?param1.nextGiftUnlock:param1.nextAchievementUnlock;
               if(this.navView != null)
               {
                  this.navView.updateNextUnlockLevel(_loc2_);
               }
            }
         }
      }
      
      private function onRAlert(param1:Object) : void {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:RAlert = RAlert(param1);
         var _loc3_:Object = _loc2_.oJSON;
         if(_loc3_["levelUppedXP"] != undefined)
         {
            _loc4_ = _loc3_["levelUppedXP"]["giftIdsUnlocked"];
            _loc5_ = _loc3_["levelUppedXP"]["achieveUnlocks"];
            if(_loc4_ != null)
            {
               if(_loc4_ is Array)
               {
                  this.updateNavItemCount("Gift Shop",int(_loc4_.length));
               }
            }
            if(_loc5_ != null)
            {
               if(_loc5_ is Array)
               {
                  this.navView.setUnlockedAchievementCount(_loc4_.length);
               }
            }
         }
      }
      
      private function showGetChipsPanel(param1:String, param2:String) : void {
         this.getChipsLoc = param1;
         this.entryPoint = param2;
         if(configModel.getBooleanForFeatureConfig("core","useSFSigGen"))
         {
            dispatchEvent(new NCEvent(NCEvent.REQUEST_GETCHIPS_SIG));
         }
         else
         {
            this.showGetChipsPanelWithSig({"sig":null});
         }
      }
      
      private function showGetChipsPanelWithSig(param1:Object) : void {
         this.navView.dispatchEvent(new SidenavEvents(SidenavEvents.PANEL_SELECTED,{"panel":"getchips"}));
         this.openJSPopup("getchips",
            {
               "loc":this.getChipsLoc,
               "sig":param1.sig,
               "ref":this.entryPoint
            });
         this.entryPoint = "";
         if(pgData.revPromoAnimationApplied)
         {
            switch(pgData.revPromoID)
            {
               case 1:
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:GetChips:Abandonment:2010-08-26"));
                  break;
               case 2:
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:GetChips:RepeatBuyer:2010-08-26"));
                  break;
               case "RUpdatePendingChips":
                  this.navView.pendingChips = (param1 as RUpdatePendingChips).sum;
                  break;
            }
            
         }
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onBuyPageRequest(param1:CommandEvent) : void {
         if(param1.params)
         {
            if(param1.params.currency == "gold")
            {
               this.showGetGoldPanel(param1.params.ref,param1.params.entryPt);
            }
            else
            {
               if(param1.params.currency == "chips")
               {
                  this.showGetChipsPanel("left",param1.params.entryPt);
               }
            }
         }
      }
      
      private function showGetGoldPanel(param1:String, param2:String) : void {
         this.entryPoint = param2;
         commandDispatcher.dispatchCommand(new HideFullScreenCommand());
         this.openJSGoldBuyPage(param2,param1);
      }
      
      private function onShowGetChips(param1:NVEvent) : void {
         commandDispatcher.dispatchCommand(new HideFullScreenCommand());
         if(this.entryPoint == "")
         {
            if(pgData.inLobbyRoom)
            {
               this.entryPoint = "sidenavlobby";
            }
            else
            {
               this.entryPoint = "sidenavtable";
            }
         }
         this.showGetChipsPanel("left",this.entryPoint);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:GetChips:2010-01-27"));
         if(this.pControl.tableControl)
         {
            this.pControl.tableControl.cancelJumpTableSearch();
         }
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:SideNav:GetChips:2010-04-06"));
               fireStat(new PokerStatHit("lobbySideNavClickGetChipsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:GetChipsOnce:2010-04-08"));
            }
            dispatchCommand(new CheckLobbyTimerCommand());
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:SideNav:GetChips:2010-08-19"));
            fireStat(new PokerStatHit("tableSideNavClickGetChipsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:GetChipsOnce:2010-08-19"));
         }
      }
      
      public function onChipsHitClicked(param1:NVEvent) : void {
         fireStat(new PokerStatHit("chipCounterClick",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"ChipCounter Other Click o:Lobby:TopNav:ChipCounter:2012-08-30"));
         if(pgData.inLobbyRoom)
         {
            this.entryPoint = "topnavlobby_chips";
         }
         else
         {
            this.entryPoint = "topnavtable_chips";
         }
         commandDispatcher.dispatchCommand(new HideFullScreenCommand());
         this.showGetChipsPanel("top",this.entryPoint);
      }
      
      public function onGoldHitClicked(param1:NVEvent) : void {
         fireStat(new PokerStatHit("goldCounterClick",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"GoldCounter Other Click o:Lobby:TopNav:GoldCounter:2012-08-30"));
         if(pgData.inLobbyRoom)
         {
            this.entryPoint = "topnavlobby_gold";
         }
         else
         {
            this.entryPoint = "topnavtable_gold";
         }
         commandDispatcher.dispatchCommand(new HideFullScreenCommand());
         this.showGetGoldPanel("top",this.entryPoint);
      }
      
      public function onGetChipsClicked(param1:NVEvent) : void {
         if(pgData.inLobbyRoom)
         {
            this.entryPoint = "topnavlobby";
         }
         else
         {
            this.entryPoint = "topnavtable";
         }
         this.showGetChipsPanel("top",this.entryPoint);
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:TopNav:GetChips:2010-04-06"));
               fireStat(new PokerStatHit("lobbyTopNavClickGetChipsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:TopNav:GetChipsOnce:2010-04-08"));
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TopNav:GetChips:2010-08-19"));
            fireStat(new PokerStatHit("tableTopNavClickGetChipsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:TopNav:GetChipsOnce:2010-08-19"));
         }
      }
      
      public function onGetGoldClicked(param1:NVEvent) : void {
         this.showGetGoldPanel("top","topnav_getgold");
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:TopNav:GetGold:2010-04-06"));
               fireStat(new PokerStatHit("lobbyTopNavClickGetGoldOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:TopNav:GetGoldOnce:2010-04-08"));
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TopNav:GetGold:2010-08-19"));
            fireStat(new PokerStatHit("tableTopNavClickGetGoldOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:TopNav:GetGoldOnce:2010-08-19"));
         }
      }
      
      private function onArcadePlayNowClicked(param1:NVEvent) : void {
         if(pgData.inLobbyRoom)
         {
            this.entryPoint = "sidenavlobby_arcade";
            fireStat(new PokerStatHit("arcadePlayNowClick",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:Lobby:SideNav:Arcade:2012-10-03"));
         }
         else
         {
            this.entryPoint = "sidenavtable_arcade";
            fireStat(new PokerStatHit("arcadePlayNowClick",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:Table:SideNav:Arcade:2012-10-03"));
         }
         commandDispatcher.dispatchCommand(new HideFullScreenCommand());
         this.showGetGoldPanel("side",this.entryPoint);
      }
      
      private function onShowChallengesClicked(param1:NVEvent) : void {
         param1.stopPropagation();
         this.showChallengesPanel(0);
      }
      
      public function showPokerGenius() : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
         this.pControl.closeAllPopups();
         dispatchEvent(new PopupEvent("showPokerGenius"));
      }
      
      public function pokerGeniusCloseAnim(param1:Bitmap) : void {
         this.navView.hasSeenGeniusAnim = true;
         this.navView.topNav.pokerGeniusCloseAnim(param1);
      }
      
      public function hasSeenGeniusAnim() : Boolean {
         return this.navView.hasSeenGeniusAnim;
      }
      
      public function showStaticGameDropdown() : void {
         this.navView.showStaticGameDropdown();
      }
      
      public function removeGameDropdown() : void {
         this.navView.topNav.removeGameDropdown();
      }
      
      private function onShowPokerGenius(param1:NVEvent) : void {
         param1.stopPropagation();
         this.showPokerGenius();
      }
      
      private function onShowLuckyBonusGold(param1:NVEvent) : void {
         param1.stopPropagation();
         dispatchEvent(new ShowLuckyBonusPopupEvent(true));
      }
      
      private function onShowLuckyBonus(param1:NVEvent) : void {
         param1.stopPropagation();
         dispatchEvent(new ShowLuckyBonusPopupEvent(false));
      }
      
      private function onAutoOpenLuckyBonus() : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
         dispatchEvent(new ShowLuckyBonusPopupEvent(false));
         this.setSidebarItemsSelected("LuckyBonus");
      }
      
      private function onSideNavHideLuckyBonus(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      public function showScratchersPostLuckyBonusAd() : void {
         if((this.navModel.scratchersConfig) && (this.navModel.scratchersConfig.showScratchersPostLuckyBonusAd))
         {
            this.navView.showScratchersPostLuckyBonusAd();
            if(!this._scratchersPostLuckyBonusAdTimer)
            {
               this._scratchersPostLuckyBonusAdTimer = new Timer(5000,1);
               this._scratchersPostLuckyBonusAdTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onScratchersPostLuckyBonusAdTimeComplete,false,0,true);
               this._scratchersPostLuckyBonusAdTimer.start();
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:Scratchers:PostLuckyBonusUnit:2012-07-16"));
         }
      }
      
      private function onScratchersPostLuckyBonusAdTimeComplete(param1:TimerEvent) : void {
         this._scratchersPostLuckyBonusAdTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onScratchersPostLuckyBonusAdTimeComplete);
         this._scratchersPostLuckyBonusAdTimer = null;
         this.navView.hideScratchersPostLuckyBonusAd();
      }
      
      public function showArcadeLuckyBonusAd() : void {
         if((pgData.showArcadePostLuckyBonusAd) && (this.navView.getSideNavItemByName("MiniArcade").visible))
         {
            this.navView.showArcadePostLuckyBonusAd();
            if(!this._arcadePostLuckyBonusAdTimer)
            {
               this._arcadePostLuckyBonusAdTimer = new Timer(5000,1);
               this._arcadePostLuckyBonusAdTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onArcadeAdTimerComplete,false,0,true);
               this._arcadePostLuckyBonusAdTimer.start();
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:MiniArcade:PostLuckyBonusUnit:2012-07-16"));
         }
      }
      
      private function onArcadeAdTimerComplete(param1:TimerEvent) : void {
         this._arcadePostLuckyBonusAdTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onArcadeAdTimerComplete);
         this._arcadePostLuckyBonusAdTimer = null;
         this.navView.hideArcadePostLuckyBonusAd();
      }
      
      public function showBlackjackPostLuckyBonusAd() : void {
         if((this.navModel.blackjackConfig) && (this.navModel.blackjackConfig.showPostLuckyBonusAd))
         {
            this.navView.showBlackjackPostLuckyBonusAd();
            if(!this._blackjackPostLuckyBonusAdTimer)
            {
               this._blackjackPostLuckyBonusAdTimer = new Timer(5000,1);
               this._blackjackPostLuckyBonusAdTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBlackjackPostLuckyBonusAdTimeComplete,false,0,true);
               this._blackjackPostLuckyBonusAdTimer.start();
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:Blackjack:PostLuckyBonusUnit:2012-07-16"));
         }
      }
      
      private function onBlackjackPostLuckyBonusAdTimeComplete(param1:TimerEvent) : void {
         this._blackjackPostLuckyBonusAdTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBlackjackPostLuckyBonusAdTimeComplete);
         this._blackjackPostLuckyBonusAdTimer = null;
         this.navView.hideBlackjackPostLuckyBonusAd();
      }
      
      private function onShowScratchers(param1:NVEvent) : void {
         if((param1.params) && (param1.params.fromArrow))
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new JSCommand("zc.feature.miniGame.scratchers.showFromArrow"));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:Scratchers:PostLuckyBonusUnit:2012-07-16"));
         }
         else
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new JSCommand("zc.feature.miniGame.scratchers.showFromNav"));
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:Scratchers:2012-07-16"));
         }
         this.setSidebarItemsSelected("Scratchers");
      }
      
      private function onHideScratchers(param1:NVEvent) : void {
         this.setSidebarItemsDeselected("Scratchers");
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onFTUEClicked(param1:NVEvent) : void {
         var _loc2_:String = "ftue" + param1.params;
         if(pgData.userPreferencesContainer[_loc2_])
         {
            pgData.userPreferencesContainer.commitValueWithKey(_loc2_,"1");
            this.pControl.commitUserPreferences();
         }
      }
      
      private function onShowBlackjack(param1:NVEvent) : void {
         dispatchEvent(new PopupEvent("showBlackjack"));
         if((param1.params) && (param1.params.fromArrow))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:Blackjack:PostLuckyBonusUnit:2012-08-16"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:Blackjack:2012-08-16"));
         }
         this.setSidebarItemsSelected("Blackjack");
      }
      
      private function onHideBlackjack(param1:NVEvent) : void {
         this.setSidebarItemsDeselected("Blackjack");
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onShowOneClickRebuy(param1:NVEvent=null) : void {
         var _loc2_:PopupEvent = new PopupEvent("showOneClickRebuy");
         _loc2_.closePHPPopups = false;
         dispatchEvent(_loc2_);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:OneClickRebuyImpression:2013-04-23"));
      }
      
      private function onHideOneClickRebuy(param1:NVEvent=null) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onPrepHideOneClickRebuy(param1:NVEvent) : void {
         var _loc2_:PopupController = registry.getObject(IPopupController);
         var _loc3_:Popup = _loc2_.getPopupConfigByID(Popup.ONECLICKREBUY);
         if((_loc3_) && (_loc3_.module))
         {
            _loc3_.module.prepareToCloseRebuyPopup();
         }
      }
      
      private function onHidePokerGenius(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onShowServeProgress(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
         if((param1.params) && (param1.params.fromArrow))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:AmexServeSidenavAd:2013-10-31"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:AmexServe:2013-10-31"));
         }
         this.setSidebarItemsSelected("AmexServe");
         PokerCommandDispatcher.getInstance().dispatchCommand(new JSCommand("ZY.App.amexServe.openFlashPopup"));
      }
      
      private function onHideServeProgress(param1:NVEvent) : void {
         this.setSidebarItemsDeselected("AmexServe");
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onSideNavHideChallenges(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onSideNavHideBetting(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
      }
      
      private function onSideNavHideBuddies(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
      }
      
      private function onSideNavHideGetChips(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
      }
      
      private function onSideNavHideGiftShop(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onSideNavHideUserProfile(param1:NVEvent) : void {
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onShowPokerScoreCard(param1:NVEvent) : void {
         dispatchEvent(new PopupEvent("showPokerScoreCard"));
      }
      
      private function onShowLeaderboard(param1:NVEvent) : void {
         this.navView.hideLeaderboardSideNavFlyout();
         this.navView.hideLeaderboardTopRightFlyout();
         if((param1.params) && (param1.params.hasOwnProperty("showInPopup")))
         {
            dispatchEvent(new PopupEvent("showLeaderboard",false,{"showInPopup":param1.params.showInPopup}));
         }
         else
         {
            dispatchEvent(new PopupEvent("showLeaderboard"));
         }
      }
      
      private function onShowBetting(param1:NVEvent) : void {
         externalInterface.call("ZY.App.AsyncLadderGames.Bets.openConsole");
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
         var _loc2_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:Bets:2010-06-25");
         var _loc3_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:Bets:2010-06-25");
         var _loc4_:PokerStatHit = new PokerStatHit("lobbySideNavClickBetsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:BetsOnce:2010-06-25");
         var _loc5_:int = configModel.getIntForFeatureConfig("user","fg");
         if(!(_loc5_ == -1) && !(_loc5_ == 0))
         {
            _loc2_.type = PokerStatHit.HITTYPE_FG;
            _loc2_.nThrottle = PokerStatHit.TRACKHIT_ALWAYS;
            _loc3_.type = PokerStatHit.HITTYPE_FG;
            _loc3_.nThrottle = PokerStatHit.TRACKHIT_ALWAYS;
            _loc4_.type = PokerStatHit.HITTYPE_FG;
         }
         fireStat(_loc2_);
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(_loc3_);
               fireStat(_loc4_);
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:Bets:2010-08-19"));
            fireStat(new PokerStatHit("tableSideNavClickBetsOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:BetsOnce:2010-08-19"));
         }
      }
      
      private function onShowBuddiesList(param1:Event) : void {
         if(!this._buddiesList)
         {
            this.onToggleBuddiesList(null);
         }
      }
      
      private function onHideBuddiesList(param1:Event) : void {
         if(this._buddiesList)
         {
            (this._buddiesList as IBuddiesListController).hide();
            this._buddiesList = null;
         }
      }
      
      private function onToggleBuddiesList(param1:Event) : void {
         var _loc2_:PopupController = null;
         var _loc3_:Popup = null;
         if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
         {
            if(this._buddiesList)
            {
               (this._buddiesList as IBuddiesListController).hide();
               this._buddiesList = null;
            }
            else
            {
               _loc2_ = registry.getObject(IPopupController);
               _loc3_ = _loc2_.getPopupConfigByID(Popup.BUDDIES_LIST);
               if(_loc3_)
               {
                  this._buddiesList = _loc3_.module as FeatureModule;
                  this._buddiesList.init(this.navView);
                  (this._buddiesList as IBuddiesListController).show();
               }
            }
         }
      }
      
      private function onShowBuddies(param1:NVEvent) : void {
         this.openJSPopup("buddies",{"zid":pgData.zid});
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:Buddies:2010-01-27"));
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:Buddies:2010-04-06"));
               fireStat(new PokerStatHit("lobbySideNavClickBuddiesOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:BuddiesOnce:2010-04-08"));
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:Buddies:2010-08-19"));
            fireStat(new PokerStatHit("tableSideNavClickBuddiesOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:BuddiesOnce:2010-08-19"));
         }
         dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
      }
      
      private function onShowLeaderboardSurfacing(param1:CommandEvent) : void {
         var _loc2_:Object = null;
         if((configModel.isFeatureEnabled("leaderboardAtTable")) && pgData.xpLevel >= configModel.getIntForFeatureConfig("leaderboard","levelRequirement"))
         {
            _loc2_ = configModel.getFeatureConfig("leaderboardAtTable");
            if(_loc2_.showSideNav === true)
            {
               this.navView.sideNav.addSideItem(Sidenav.LEADERBOARD);
               if(_loc2_.showFTUE === true)
               {
                  this.navView.showLeaderboardSideNavFlyout();
                  externalInterface.call("zc.feature.leaderboardAtTable.incFTUECount");
                  _loc2_.showFTUE = false;
               }
            }
            if(_loc2_.showTopRight === true && _loc2_.showFTUE === true)
            {
               this.navView.showLeaderboardTopRightFlyout();
               externalInterface.call("zc.feature.leaderboardAtTable.incFTUECount");
               _loc2_.showFTUE = false;
            }
         }
      }
      
      private function onHideLeaderboardSurfacing(param1:CommandEvent) : void {
         var _loc2_:Object = null;
         if(configModel.isFeatureEnabled("leaderboardAtTable"))
         {
            _loc2_ = configModel.getFeatureConfig("leaderboardAtTable");
            if(_loc2_.showSideNav === true)
            {
               this.navView.sideNav.removeSideItem(Sidenav.LEADERBOARD);
               this.navView.hideLeaderboardSideNavFlyout();
            }
            if(_loc2_.showTopRight === true)
            {
               this.navView.hideLeaderboardTopRightFlyout();
            }
         }
      }
      
      private function onHideLeaderboardFlyout(param1:CommandEvent) : void {
         this.navView.hideLeaderboardSideNavFlyout();
         this.navView.hideLeaderboardTopRightFlyout();
      }
      
      public function onShowPokerScoreSideNav(param1:CommandEvent) : void {
         this.setSidebarItemVisibility(Sidenav.POKER_SCORE,true);
         var _loc2_:MovieClip = this.navView.sideNav.getSideItem(Sidenav.POKER_SCORE).icon;
         _loc2_.alpha = 1;
         _loc2_.gotoAndPlay(0);
         _loc2_.addEventListener("pokerScoreSideNavAnimComplete",this.onPokerScoreSideNavAnimComplete,false,0,true);
      }
      
      private function onPokerScoreSideNavAnimComplete(param1:Event) : void {
         this.triggerPokerScoreTimer(this.POKERSCORE_TIMER);
      }
      
      private function triggerPokerScoreTimer(param1:Number) : void {
         var _loc2_:Number = new Date().time;
         var _loc3_:Number = Math.floor((_loc2_ - pgData.timeStamp) / 1000);
         this.updateNavTimer("PokerScore",param1 + _loc3_);
      }
      
      private function onShowingLevelUpAnimation(param1:NVEvent=null) : void {
         pgData.showingLevelUpAnimation = true;
         this.pControl.notifyJS(new JSEvent("userLeveledUp"));
      }
      
      private function onStopLevelUpAnimation(param1:NVEvent) : void {
         pgData.showingLevelUpAnimation = false;
      }
      
      private function displayGiftShop() : void {
         this.bSideNavRequestedGiftShop = true;
         this.pControl.closeAllPopups();
         this.pControl.getGiftPrices3(-1,pgData.zid,pgData.inLobbyRoom);
         this.setSidebarItemsSelected("giftshop");
         this.updateNavItemCount("Gift Shop",0);
      }
      
      private function onShowGiftShop(param1:NVEvent) : void {
         this.displayGiftShop();
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:GiftShop:2010-01-27"));
         if(pgData.inLobbyRoom)
         {
            if(pgData.lobbyStats)
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:GiftShop:2010-04-06"));
               fireStat(new PokerStatHit("lobbySideNavClickGiftShopOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:GiftShopOnce:2010-04-08"));
            }
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:GiftShop:2010-08-19"));
            fireStat(new PokerStatHit("tableSideNavClickGiftShopOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:GiftShopOnce:2010-08-19"));
         }
      }
      
      private function onShowUserProfile(param1:NVEvent) : void {
         var _loc3_:String = null;
         param1.stopPropagation();
         var _loc2_:Object = 
            {
               "zid":pgData.zid,
               "playerName":pgData.name,
               "gender":pgData.gender
            };
         if((param1.params) && (param1.params.tab))
         {
            _loc3_ = param1.params.tab;
         }
         else
         {
            if(pgData.newAchievementItemCount > 0)
            {
               _loc3_ = ProfilePanelTab.ACHIEVEMENTS;
            }
            else
            {
               if(pgData.newCollectionItemCount > 0)
               {
                  _loc3_ = ProfilePanelTab.COLLECTIONS;
               }
               else
               {
                  _loc3_ = ProfilePanelTab.OVERVIEW;
               }
            }
         }
         this.dispatchEvent(new ProfilePopupEvent(ProfilePopupEvent.SHOW_PROFILE,_loc2_,_loc3_));
      }
      
      private function onGameCardButtonClick(param1:NVEvent) : void {
         if(this.pControl.tableControl)
         {
            this.pControl.tableControl.cancelJumpTableSearch();
         }
         this.pControl.showGameCardPopup();
      }
      
      private function onNewsButtonClick(param1:NVEvent) : void {
         this.pControl.notifyJS(new JSEvent(JSEvent.NEWS_CLICKED));
      }
      
      public function updateCasinoGold() : void {
         this.navModel.nCasinoGold = pgData.casinoGold;
         this.navView.updateCasinoGold(pgData.casinoGold);
      }
      
      private function onOpenJSPopup(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.openJSPopup(_loc2_.id,_loc2_.data);
      }
      
      private function openJSGoldBuyPage(param1:String, param2:String) : void {
         externalInterface.call("closeNav");
         externalInterface.call("ZY.App.outOfChips.openBuyPage",param1,param2,2);
      }
      
      private function openJSPopup(param1:String, param2:Object) : void {
         var _loc3_:* = !(param1 == "buddies");
         if(_loc3_)
         {
            externalInterface.call("closeNav");
            externalInterface.call("ZY.App.launch.openPopup",param1,param2);
         }
         else
         {
            externalInterface.call("ZY.App.launch.closePopup");
            externalInterface.call("openNav",param1,param2);
         }
      }
      
      public function lockUI() : void {
         this.navView.lockUI();
      }
      
      public function unlockUI() : void {
         this.navView.unlockUI();
      }
      
      public function onUpdateNavTimer(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.updateNavTimer(_loc2_.id,_loc2_.time);
      }
      
      public function onUpdateNavItemCount(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.updateNavItemCount(_loc2_.id,_loc2_.count);
      }
      
      public function onInitLuckyHandBonus(param1:CommandEvent) : void {
         if(this._userMadePurchase)
         {
            return;
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:LuckyHandCoupon:2013-01-28"));
         this.initLuckyHandBonus(true);
      }
      
      public function onInitUnluckyHandBonus(param1:CommandEvent) : void {
         if(this._userMadePurchase)
         {
            return;
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Impression o:SideNav:UnluckyHandCoupon:2013-03-06"));
         this.initLuckyHandBonus(false);
      }
      
      public function onShowCampaignInfoPopup(param1:CommandEvent=null) : void {
         dispatchEvent(new PopupEvent("showHelpingHandsCampaignInfo"));
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"HelpingHands Other Click o:FluidCanvasClick:2013-07-31"));
      }
      
      private function initLuckyHandBonus(param1:Boolean) : void {
         var _loc4_:* = NaN;
         this.navView.isLuckyHand = param1;
         this.navView.hideGetChipsSideNav();
         commandDispatcher.dispatchCommand(new AddLuckyHandCouponCommand(this.navView.luckyHandDealerCoupon));
         this.navView.showLuckyHandV2DealerCoupon();
         var _loc2_:Number = new Date().time;
         var _loc3_:Number = pgData.luckyHandStartTime + 300 - int(_loc2_ / 1000);
         if(_loc3_ > 0)
         {
            _loc4_ = Math.floor((_loc2_ - pgData.timeStamp) / 1000);
            dispatchCommand(new UpdatePokerGlobalDataCommand("luckyHandTimeLeft",_loc3_));
            dispatchCommand(new UpdateNavTimerCommand("LuckyHandCoupon",_loc3_ + _loc4_));
         }
      }
      
      private function onPaymentsBuySuccess() : void {
         this._userMadePurchase = true;
         this.hideAtTableEraseLoss();
         this.hideLuckyHandDiscount();
      }
      
      private function hideAtTableEraseLoss() : void {
         this.navView.hideAtTableEraseLossSideNav();
         var _loc1_:PopupController = registry.getObject(IPopupController);
         if(_loc1_)
         {
            _loc1_.onAtTableEraseLossClose();
         }
      }
      
      private function hideLuckyHandDiscount() : void {
         this.navView.hideLuckyHandSideNav();
         this.navView.hideLuckyHandV2DealerCoupon();
         this.navView.hideLuckyHandCouponArrow();
         this.navView.showGetChipsSideNav();
      }
      
      private function onShowLuckyHandCoupon(param1:NVEvent) : void {
         if(externalInterface.available)
         {
            externalInterface.call("zc.feature.payments.luckyHandInAppPurchase.open","LuckyHandCouponPurchase");
         }
         this.navView.allowLuckyHandSideNavClick();
      }
      
      private function onBuyAtTableEraseLossCoupon(param1:Event=null) : void {
         var _loc2_:Object = configModel.getFeatureConfig("atTableEraseLoss");
         externalInterface.call("zc.feature.payments.atTableEraseLossInAppPurchase.open",_loc2_.response["itemCode"],_loc2_.response["chipAmount"],_loc2_.response["hash"],"AtTableEraseLossCouponPurchase");
         this.navView.allowAtTableEraseLossSideNavClick();
      }
      
      private function onMegaBillionsUpdate(param1:Object) : void {
         var _loc2_:Object = null;
         if(configModel.isFeatureEnabled("megaBillions"))
         {
            _loc2_ = configModel.getFeatureConfig("megaBillions");
            commandDispatcher.dispatchEvent(new GenericEvent("onMegaBillionsJackpotUpdate",param1));
            if(param1.isJackpotWin == "jackpotWin")
            {
               this.navView.showMegaBillionsWinnerArrow(param1.firstWinnerName,param1.firstWinnerAmount);
            }
            this._megaBillionsJackpotCurrentValue = param1.updatedChipAmount;
            _loc2_.jackpotInitialValue = this._megaBillionsJackpotCurrentValue;
            this.navView.updateMegaBillionsArcade(this._megaBillionsJackpotCurrentValue);
         }
      }
      
      private function onShowUnluckyHandCoupon(param1:NVEvent) : void {
         if(externalInterface.available)
         {
            externalInterface.call("zc.feature.payments.luckyHandInAppPurchase.open","UnluckyHandCouponPurchase");
         }
      }
      
      private function onChallengesOpen(param1:ModuleEvent) : void {
         this.setSidebarItemsSelected("challenge");
      }
      
      public function showChallengesPanel(param1:int) : void {
         commandDispatcher.dispatchCommand(new ShowModuleCommand("challenges",{"defaultTab":param1},this.onChallengesOpen));
      }
      
      public function showHappyHourLuckyBonusFlyout(param1:Boolean) : void {
         this.navView.showHappyHourLuckyBonusFlyout(param1);
      }
   }
}
