package com.zynga.poker.nav
{
   import com.zynga.poker.feature.FeatureView;
   import __AS3__.vec.Vector;
   import com.zynga.poker.nav.topnav.TopNav;
   import com.zynga.poker.nav.sidenav.Sidenav;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.zynga.poker.nav.assets.NavFTUE;
   import com.zynga.poker.nav.assets.ScratchersPostLuckyBonusAd;
   import com.zynga.poker.nav.assets.SideNavMarketingTooltipView;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.nav.events.NVEvent;
   import com.zynga.poker.nav.sidenav.events.SidenavEvents;
   import com.zynga.poker.nav.topnav.events.TopnavEvent;
   import flash.events.MouseEvent;
   import com.zynga.poker.nav.sidenav.SidenavItem;
   import flash.text.TextFormat;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.display.Loader;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.rad.util.ZuiUtil;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import flash.display.DisplayObject;
   import com.zynga.poker.nav.sidenav.ServeProgressAdCopy;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.AtTableEraseLossManager;
   import com.zynga.rad.buttons.ZButton;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.events.Event;
   import com.greensock.easing.Cubic;
   import com.zynga.poker.nav.topnav.TopNavItem;
   import com.zynga.poker.nav.assets.SideNavMiniArcade;
   import com.zynga.poker.PokerGlobalData;
   import com.greensock.easing.Expo;
   import com.greensock.easing.Sine;
   import flash.events.TimerEvent;
   import com.zynga.poker.popups.modules.profile.ProfilePanelTab;
   import com.zynga.poker.commands.navcontroller.AtTableEraseLossCommand;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.display.LoaderInfo;
   import flash.display.Shape;
   
   public class NavView extends FeatureView
   {
      
      public function NavView() {
         this.ChallengesIconClass = PokerClassProvider.getClass("ChallengesIcon");
         this.GiftShopIconClass = PokerClassProvider.getClass("GiftShopIcon");
         this.ProfileIconClass = PokerClassProvider.getClass("ProfileIcon");
         this.BuddiesIconClass = PokerClassProvider.getClass("BuddiesIcon");
         this.GetChipsIconClass = PokerClassProvider.getClass("GetChipsIcon");
         this.LuckyBonusIconClass = PokerClassProvider.getClass("LuckyBonusIcon");
         this.ScratchersIconClass = PokerClassProvider.getClass("ScratchersIcon");
         this.BlackjackIconClass = PokerClassProvider.getClass("BlackjackIcon");
         this.AmexServeIconClass = PokerClassProvider.getClass("AmexServeIcon");
         this.PokerGeniusIconClass = PokerClassProvider.getClass("PokerGeniusIcon");
         this.LuckyHandCouponClass = PokerClassProvider.getClass(Sidenav.LUCKY_HAND_COUPON);
         this.LuckyHandV2CouponClass = PokerClassProvider.getClass("LuckyHandV2Coupon");
         this.PokerScoreClass = PokerClassProvider.getClass(Sidenav.POKER_SCORE);
         this.AtTableEraseLossCouponClass = PokerClassProvider.getClass(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         this.LeaderboardIconClass = PokerClassProvider.getClass(Sidenav.LEADERBOARD);
         this._sideNavData = [
            {
               "id":Sidenav.CHALLENGE,
               "label":"flash.nav.side.challengeItem",
               "gfx":this.ChallengesIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.GIFT_SHOP,
               "label":"flash.nav.side.giftShopItem",
               "gfx":this.GiftShopIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.LUCKY_BONUS,
               "label":"",
               "gfx":this.LuckyBonusIconClass,
               "offsetX":0,
               "offsetY":-5,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.PROFILE,
               "label":"flash.nav.side.profileItem",
               "gfx":this.ProfileIconClass,
               "offsetX":0,
               "offsetY":-5,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.BUDDIES,
               "label":"flash.nav.side.buddiesItem",
               "gfx":this.BuddiesIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.GET_CHIPS,
               "label":"flash.nav.side.getChipsItem",
               "gfx":this.GetChipsIconClass,
               "offsetX":0,
               "offsetY":-5,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.AMEX_SERVE,
               "label":"",
               "gfx":this.AmexServeIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.LUCKY_HAND_COUPON,
               "label":"",
               "gfx":this.LuckyHandCouponClass,
               "offsetX":-25,
               "offsetY":-30,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.LUCKY_HAND_V2_COUPON,
               "label":"",
               "gfx":this.LuckyHandV2CouponClass,
               "offsetX":-25,
               "offsetY":-30,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.AT_TABLE_ERASE_LOSS_COUPON,
               "label":"",
               "gfx":this.AtTableEraseLossCouponClass,
               "offsetX":-25,
               "offsetY":-30,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.POKER_SCORE,
               "label":"",
               "gfx":this.PokerScoreClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":0
            },
            {
               "id":Sidenav.LEADERBOARD,
               "label":"",
               "gfx":this.LeaderboardIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":0
            }];
         this.arcadeData = [
            {
               "id":Sidenav.SCRATCHERS,
               "label":"",
               "gfx":this.ScratchersIconClass,
               "offsetX":0,
               "offsetY":25,
               "alerts":0,
               "showNew":false,
               "timer":-1
            },
            {
               "id":Sidenav.BLACKJACK,
               "label":"",
               "gfx":this.BlackjackIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":true,
               "timer":-1
            },
            {
               "id":Sidenav.LUCKY_BONUS_ARCADE,
               "label":"",
               "gfx":this.LuckyBonusIconClass,
               "offsetX":0,
               "offsetY":0,
               "alerts":0,
               "showNew":false,
               "timer":-1
            }];
         this._ftueStrings = {};
         super();
      }
      
      public static const SIDENAV_POSITION_LOBBY_KEY:int = 0;
      
      public static const SIDENAV_POSITION_TABLE_KEY:int = 1;
      
      private var _sideNavPosition:Vector.<Number>;
      
      private const NAV_ITEM_ANIMATION_CHILD_NAME:String = "animation";
      
      private const SIDENAV_LOBBYMODE_POSITION_Y:Number = 222.0;
      
      private const SIDENAV_TABLEMODE_POSITION_Y:Number = 170.0;
      
      private const ONE_BILLION:Number = 1000000000;
      
      private const FOUR_BILLION:Number = 4.0E9;
      
      private const TEN_BILLION:Number = 1.0E10;
      
      private const ONE_TRILLION:Number = 1.0E12;
      
      public var topNav:TopNav;
      
      public var sideNav:Sidenav;
      
      public var buddiesAlerts:int = 0;
      
      public var casinoGoldTip:Tooltip;
      
      public var chipsTip:Tooltip;
      
      public var showGetChipsStarburst:Boolean;
      
      public var tooltipTimer:Timer;
      
      public var removeThis:String;
      
      public var iconFlags:Dictionary;
      
      private var _luckyHandMessage:String = "";
      
      private var ChallengesIconClass:Class;
      
      private var GiftShopIconClass:Class;
      
      private var ProfileIconClass:Class;
      
      private var BuddiesIconClass:Class;
      
      private var GetChipsIconClass:Class;
      
      private var LuckyBonusIconClass:Class;
      
      private var ScratchersIconClass:Class;
      
      private var BlackjackIconClass:Class;
      
      private var AmexServeIconClass:Class;
      
      private var PokerGeniusIconClass:Class;
      
      private var LuckyHandCouponClass:Class;
      
      private var LuckyHandV2CouponClass:Class;
      
      private var PokerScoreClass:Class;
      
      private var AtTableEraseLossCouponClass:Class;
      
      private var LeaderboardIconClass:Class;
      
      private var _sideNavData:Array;
      
      public var arcadeData:Array;
      
      private var _ftueStrings:Object;
      
      public var navFTUE:NavFTUE;
      
      private var _scratchersPostLuckyBonusAd:ScratchersPostLuckyBonusAd;
      
      private var _blackjackPostLuckyBonusAd:SideNavMarketingTooltipView;
      
      private var _arcadePostLuckyBonusAd:SideNavMarketingTooltipView;
      
      private var _luckyHandCouponArrow:SideNavMarketingTooltipView;
      
      private var _megaBillionsThresholdArrow:SideNavMarketingTooltipView;
      
      private var _megaBillionsWinnerArrow:SideNavMarketingTooltipView;
      
      private var _megaBillionsFTUEArrow:SideNavMarketingTooltipView;
      
      private var _megaBillionsFTUEArrowShouldOpenLBOnClick:Boolean = false;
      
      private var _megaBillionsLuckyBonusSideNavText:EmbeddedFontTextField;
      
      private var _megaBillionsArcadeSideNavText:EmbeddedFontTextField;
      
      private var _amexServeAd:SideNavMarketingTooltipView;
      
      private var _leaderboardSideNavFlyout:SideNavMarketingTooltipView;
      
      private var _leaderboardTopRightFlyout:SideNavMarketingTooltipView;
      
      private var _happyHourLuckyBonusFlyout:SideNavMarketingTooltipView;
      
      private var gameCardHorizontalOffset:Number = 0.0;
      
      private var lockUIOverlay:MovieClip;
      
      private var screenOverlay:Sprite;
      
      private var playerXpLevel:int;
      
      private var _navTimers:Array;
      
      public var hasSeenGeniusAnim:Boolean = false;
      
      private var _navModel:NavModel;
      
      public var isLuckyHand:Boolean = false;
      
      private var m_luckyHandDealerCoupon:SafeAssetLoader;
      
      public function get luckyHandDealerCoupon() : SafeAssetLoader {
         return this.m_luckyHandDealerCoupon;
      }
      
      private var m_luckyHandTextField:EmbeddedFontTextField;
      
      override protected function _init() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         this._navModel = featureModel as NavModel;
         this.iconFlags = new Dictionary(true);
         this.topNav = new TopNav();
         this.topNav.y = 0;
         this.topNav.init(this._navModel);
         addChild(this.topNav);
         this._navTimers = this._navModel.navTimers;
         this.playerXpLevel = this._navModel.pgData.xpLevel;
         this.buddiesAlerts = this._navModel.nBuddiesAlerts;
         if(this.topNav.showGameCardButton)
         {
            this.gameCardHorizontalOffset = -20;
         }
         var _loc4_:Array = this._navModel.sideNavItemsToHide;
         _loc1_ = this._sideNavData.length;
         for each (_loc5_ in _loc4_)
         {
            _loc2_ = _loc1_-1;
            while(_loc2_ >= 0)
            {
               _loc3_ = this._sideNavData[_loc2_];
               if((_loc3_) && _loc3_["id"] == _loc5_)
               {
                  this._sideNavData.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         _loc6_ = this._navModel.itemsToShowNewStarburst;
         if(_loc6_)
         {
            _loc9_ = _loc6_.length;
            _loc10_ = this._sideNavData.length;
            _loc2_ = 0;
            while(_loc2_ < _loc9_)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc10_)
               {
                  if(_loc6_[_loc2_] == this._sideNavData[_loc11_].id)
                  {
                     this._sideNavData[_loc11_].showNew = true;
                  }
                  _loc11_++;
               }
               _loc2_++;
            }
         }
         this.sideNav = new Sidenav();
         this._sideNavPosition = new Vector.<Number>();
         if(this._navModel.configModel.getBooleanForFeatureConfig("lobby","isNewLobby"))
         {
            this._sideNavPosition.push(this.SIDENAV_LOBBYMODE_POSITION_Y + 40);
         }
         else
         {
            this._sideNavPosition.push(this.SIDENAV_LOBBYMODE_POSITION_Y);
         }
         if(this._navModel.configModel.isFeatureEnabled("skipTables"))
         {
            this._sideNavPosition.push(this.SIDENAV_LOBBYMODE_POSITION_Y + 25);
         }
         else
         {
            this._sideNavPosition.push(this.SIDENAV_LOBBYMODE_POSITION_Y);
         }
         this.sideNav.y = this._sideNavPosition[0];
         this.sideNav.initSideNav(this._sideNavData,this.showGetChipsStarburst);
         this.sideNav.initMiniArcade(this.arcadeData);
         addChild(this.sideNav);
         this.casinoGoldTip = new Tooltip(340,LocaleManager.localize("flash.nav.top.goldTooltipBody"),LocaleManager.localize("flash.nav.top.goldTooltipTitle"));
         this.casinoGoldTip.x = 160 + this.gameCardHorizontalOffset;
         this.casinoGoldTip.y = 45;
         this.casinoGoldTip.visible = false;
         addChild(this.casinoGoldTip);
         var _loc7_:Boolean = this._navModel.configModel.getBooleanForFeatureConfig("core","disableGetChipsAndGold");
         var _loc8_:String = _loc7_?LocaleManager.localize("flash.nav.top.chipsTooltipBodyDisabledGetGoldAndChips"):LocaleManager.localize("flash.nav.top.chipsTooltipBody");
         this.chipsTip = new Tooltip(350,_loc8_,LocaleManager.localize("flash.nav.top.chipsTooltipTitle"));
         this.chipsTip.x = 15;
         this.chipsTip.y = 45;
         this.chipsTip.visible = false;
         addChild(this.chipsTip);
         this.initListeners();
         if((this._navModel.scratchersConfig) && (this._navModel.scratchersConfig.showScratchersPostLuckyBonusAd))
         {
            this.initScratchersPostLuckyBonusAd();
         }
         if((this._navModel.blackjackConfig) && (this._navModel.blackjackConfig.showPostLuckyBonusAd))
         {
            this.initBlackjackPostLuckyBonusAd();
         }
         if(this._navModel.pgData.showArcadePostLuckyBonusAd)
         {
            this.initArcadePostLuckyBonusAd();
         }
         if(this._navModel.configModel.getFeatureConfig("megaBillions"))
         {
            this.initMegaBillionsSideNav();
         }
         if(this._navModel.configModel.isFeatureEnabled("luckyHandCoupon"))
         {
            this._luckyHandMessage = "flash.nav.side.luckyHandCoupon.tooltipText";
         }
      }
      
      public function initListeners() : void {
         this.topNav.addEventListener(NVEvent.USER_PIC_CLICKED,this.onUserPicClicked);
         this.topNav.addEventListener(NVEvent.GET_CHIPS_CLICKED,this.onGetChipsClicked);
         this.topNav.addEventListener(NVEvent.CHIPSHIT_CLICKED,this.onChipsHitClicked);
         this.topNav.addEventListener(NVEvent.GOLDHIT_CLICKED,this.onGoldHitClicked);
         this.topNav.addEventListener(NVEvent.GOLD_ROLLOVER,this.onGoldRollover);
         this.topNav.addEventListener(NVEvent.GOLD_ROLLOUT,this.onGoldRollout);
         this.topNav.addEventListener(NVEvent.CHIPS_ROLLOVER,this.onChipsRollover);
         this.topNav.addEventListener(NVEvent.CHIPS_ROLLOUT,this.onChipsRollout);
         this.topNav.addEventListener(NVEvent.ACHIEVEMENTS_CLICKED,this.onAchievementsClicked);
         this.topNav.addEventListener(NVEvent.GAME_SETTINGS_CLICKED,this.onGameSettingsClicked);
         this.topNav.addEventListener(NVEvent.GAME_CARD_BUTTON_CLICK,this.onGameCardButtonClick);
         this.topNav.addEventListener(NVEvent.NEWS_BUTTON_CLICK,this.onNewsButtonClick);
         this.topNav.addEventListener(NVEvent.SHOW_SERVEPROGRESS,this.onAmexPromoClicked);
         this.topNav.addEventListener(NVEvent.SHOW_ONECLICKREBUY,this.onShowOneClickRebuy);
         this.topNav.addEventListener(NVEvent.HIDE_ONECLICKREBUY,this.onHideOneClickRebuy);
         this.topNav.addEventListener(NVEvent.PREP_HIDE_ONECLICKREBUY,this.onPrepHideOneClickRebuy);
         this.topNav.addEventListener(NVEvent.SHOW_PLAYERS_CLUB_TOASTER,this.onShowPlayersClubToaster);
         this.topNav.addEventListener(NVEvent.SHOW_PLAYERS_CLUB_REWARD_CENTER,this.onShowPlayersClubRewardCenter);
         addEventListener(NVEvent.PG_CLOSE_ANIM,this.onGeniusClose);
         addEventListener(NVEvent.PG_CLOSE_ANIM_FIN,this.onGeniusCloseFin);
         SidenavEvents.disp.addEventListener(SidenavEvents.REQUEST_PANEL,this.onSideNavRequestPanel);
         SidenavEvents.disp.addEventListener(SidenavEvents.CLOSE_PANEL,this.onSideNavClosePanel);
         addEventListener(SidenavEvents.PANEL_SELECTED,this.onSetSidebarItemsSelected);
         addEventListener(TopnavEvent.NEW_ACHIEVEMENTS_NOTIFICATION_RESET,this.onAchievementsNotificationReset);
         this.sideNav.addEventListener(MouseEvent.MOUSE_OVER,this.onSideNavMouseOver);
         this.sideNav.addEventListener(MouseEvent.MOUSE_OUT,this.onSideNavMouseOut);
         this.sideNav.addEventListener(NVEvent.HIDE_ARCADE_LUCKYBONUS_AD,this.hideArcadePostLuckyBonusAd);
         this.sideNav.addEventListener(NVEvent.ARCADE_PLAYNOW_CLICKED,this.onArcadePlayNowClicked);
      }
      
      public function initNavFTUE(param1:String, param2:Array) : void {
         var _loc3_:SidenavItem = null;
         var _loc4_:Object = null;
         if(param2.length > 0)
         {
            this._ftueStrings[param1] = param2;
            _loc3_ = this.sideNav.getSideItem(param1);
            if(_loc3_ != null)
            {
               if(!this.navFTUE)
               {
                  this.navFTUE = new NavFTUE();
                  addChild(this.navFTUE);
               }
               this.navFTUE.x = _loc3_.x + this.sideNav.x + this.sideNav.siCont.x;
               this.navFTUE.y = _loc3_.y + this.sideNav.y + this.sideNav.siCont.y;
               _loc3_.ftueActive = true;
               _loc3_.rollOver();
               _loc4_ = {"text":param2};
               this.navFTUE.init(_loc4_);
            }
            else
            {
               this.topNav.showNavItemFTUE(param1,param2.shift());
            }
         }
      }
      
      private function initMegaBillionsSideNav() : void {
         this._megaBillionsLuckyBonusSideNavText = new EmbeddedFontTextField("","_sans",17,16764444,"center",true,false);
         this._megaBillionsLuckyBonusSideNavText.defaultTextFormat = new TextFormat("_sans",17,16764444,true,null,null,null,null,"center");
         this._megaBillionsArcadeSideNavText = new EmbeddedFontTextField("","_sans",17,16764444,"center",true,false);
         this._megaBillionsArcadeSideNavText.defaultTextFormat = new TextFormat("_sans",17,16764444,true,null,null,null,null,"center");
         this._megaBillionsLuckyBonusSideNavText.embedFonts = this._megaBillionsArcadeSideNavText.embedFonts = false;
         this._megaBillionsLuckyBonusSideNavText.multiline = this._megaBillionsArcadeSideNavText.multiline = true;
         this._megaBillionsLuckyBonusSideNavText.x = this._megaBillionsArcadeSideNavText.x = -22;
         this._megaBillionsLuckyBonusSideNavText.y = this._megaBillionsArcadeSideNavText.y = -11.05;
         this._megaBillionsLuckyBonusSideNavText.width = this._megaBillionsArcadeSideNavText.width = 43;
         this._megaBillionsLuckyBonusSideNavText.height = this._megaBillionsArcadeSideNavText.height = 43;
         var _loc1_:GlowFilter = new GlowFilter(16711680,1,4,4,10,BitmapFilterQuality.LOW);
         this._megaBillionsLuckyBonusSideNavText.filters = this._megaBillionsArcadeSideNavText.filters = [_loc1_];
      }
      
      public function updateMegaBillionsArcade(param1:Number) : void {
         var _loc3_:Loader = null;
         var _loc4_:MovieClip = null;
         var _loc6_:EmbeddedFontTextField = null;
         var _loc7_:Sprite = null;
         var _loc8_:MovieClip = null;
         var _loc2_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
         var _loc5_:Number = 2;
         if(param1 >= this.ONE_BILLION && param1 < this.TEN_BILLION)
         {
            _loc5_ = 1;
         }
         else
         {
            if(param1 >= this.TEN_BILLION && param1 < this.ONE_TRILLION)
            {
               _loc5_ = 0;
            }
         }
         if(param1 % this.FOUR_BILLION < 5000)
         {
            this.showMegaBillionsThresholdArrow(Math.round(param1 / this.ONE_BILLION) * this.ONE_BILLION);
         }
         if(_loc2_.visible)
         {
            _loc3_ = _loc2_.animLayer.getChildAt(0) as Loader;
            _loc4_ = _loc3_.content as MovieClip;
            if(!(_loc4_ == null) && !(_loc4_.megaBillionsSideNav == null) && !(_loc4_.megaBillionsSideNav.numbers == null) && !(_loc4_.megaBillionsSideNav.numbers.text == null))
            {
               if(_loc4_.megaBillionsSideNav.numbers.text.numChildren == 0)
               {
                  _loc4_.megaBillionsSideNav.numbers.text.addChildAt(this._megaBillionsLuckyBonusSideNavText,0);
                  _loc6_ = _loc4_.megaBillionsSideNav.numbers.text.getChildAt(0) as EmbeddedFontTextField;
                  if(_loc6_ != null)
                  {
                     _loc6_.text = PokerCurrencyFormatter.numberToCurrency(param1,true,_loc5_,false);
                     ZuiUtil.shrinkFontToHSize(_loc6_,43);
                  }
               }
               else
               {
                  _loc6_ = _loc4_.megaBillionsSideNav.numbers.text.getChildAt(0) as EmbeddedFontTextField;
                  if(_loc6_ != null)
                  {
                     _loc6_.text = PokerCurrencyFormatter.numberToCurrency(param1,true,_loc5_,false);
                  }
               }
            }
         }
         else
         {
            _loc2_ = this.sideNav.getSideItem(Sidenav.MINI_ARCADE);
            _loc7_ = _loc2_.getChildAt(0) as Sprite;
            _loc8_ = _loc7_.getChildAt(0) as MovieClip;
            if(!(_loc8_ == null) && !(_loc8_.jackpotText == null))
            {
               _loc8_.jackpotText.text = PokerCurrencyFormatter.numberToCurrency(param1,false);
            }
            _loc3_ = _loc2_.animLayer.getChildAt(0) as Loader;
            _loc4_ = _loc3_.content as MovieClip;
            if(!(_loc4_ == null) && !(_loc4_.arcadeSideNav == null) && !(_loc4_.arcadeSideNav.numbers == null) && !(_loc4_.arcadeSideNav.numbers.text == null))
            {
               if(_loc4_.arcadeSideNav.numbers.text.numChildren == 0)
               {
                  _loc4_.arcadeSideNav.numbers.text.addChildAt(this._megaBillionsArcadeSideNavText,0);
                  _loc6_ = _loc4_.arcadeSideNav.numbers.text.getChildAt(0) as EmbeddedFontTextField;
                  if(_loc6_ != null)
                  {
                     _loc6_.text = PokerCurrencyFormatter.numberToCurrency(param1,true,_loc5_,false);
                     ZuiUtil.shrinkFontToHSize(_loc6_,43);
                  }
               }
               else
               {
                  _loc6_ = _loc4_.arcadeSideNav.numbers.text.getChildAt(0) as EmbeddedFontTextField;
                  if(_loc6_ != null)
                  {
                     _loc6_.text = PokerCurrencyFormatter.numberToCurrency(param1,true,_loc5_,false);
                  }
               }
            }
         }
      }
      
      public function initScratchersPostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.SCRATCHERS);
         if(_loc1_)
         {
            if(!this._scratchersPostLuckyBonusAd)
            {
               this._scratchersPostLuckyBonusAd = new ScratchersPostLuckyBonusAd();
               this._scratchersPostLuckyBonusAd.closeButton.addEventListener(MouseEvent.CLICK,this.onScratchersPostLuckyBonusAdCloseClick,false,0,true);
               this._scratchersPostLuckyBonusAd.base.addEventListener(MouseEvent.CLICK,this.onScratchersPostLuckyBonusAdClick,false,0,true);
               this._scratchersPostLuckyBonusAd.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._scratchersPostLuckyBonusAd.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      public function showScratchersPostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = null;
         if((this._scratchersPostLuckyBonusAd) && !contains(this._scratchersPostLuckyBonusAd))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.SCRATCHERS);
            if(_loc1_)
            {
               _loc1_.rollOver();
            }
            this._scratchersPostLuckyBonusAd.alpha = 0.0;
            TweenLite.to(this._scratchersPostLuckyBonusAd,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._scratchersPostLuckyBonusAd);
         }
      }
      
      public function hideScratchersPostLuckyBonusAd() : void {
         var navItem:SidenavItem = null;
         if((this._scratchersPostLuckyBonusAd) && (contains(this._scratchersPostLuckyBonusAd)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.SCRATCHERS);
            if(navItem)
            {
               navItem.rollOut();
            }
            TweenLite.to(this._scratchersPostLuckyBonusAd,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._scratchersPostLuckyBonusAd]
               });
         }
      }
      
      public function showAmexServeAd(param1:int) : void {
         var _loc2_:SidenavItem = this.sideNav.getSideItem(Sidenav.AMEX_SERVE);
         if(_loc2_)
         {
            if(!this._amexServeAd)
            {
               this._amexServeAd = new SideNavMarketingTooltipView();
               this._amexServeAd.labelText = ServeProgressAdCopy.COPY[param1-1];
               this._amexServeAd.closeButton.addEventListener(MouseEvent.CLICK,this.onAmexServeAdClose,false,0,true);
               this._amexServeAd.base.addEventListener(MouseEvent.CLICK,this.onAmexServeAdClick,false,0,true);
               this._amexServeAd.x = _loc2_.x + this.sideNav.x + this.sideNav.siCont.x + _loc2_.w;
               this._amexServeAd.y = _loc2_.y + this.sideNav.y + this.sideNav.siCont.y;
               _loc2_.rollOver();
               this._amexServeAd.alpha = 0.0;
               TweenLite.to(this._amexServeAd,0.25,
                  {
                     "alpha":1,
                     "ease":Linear.easeNone
                  });
               addChild(this._amexServeAd);
            }
         }
      }
      
      public function initBlackjackPostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.BLACKJACK);
         if(_loc1_)
         {
            if(!this._blackjackPostLuckyBonusAd)
            {
               this._blackjackPostLuckyBonusAd = new SideNavMarketingTooltipView();
               this._blackjackPostLuckyBonusAd.labelText = LocaleManager.localize("flash.nav.blackjackPostLuckyBonusAdCopy",{"amount":PokerCurrencyFormatter.numberToCurrency(34000000,false,1,true)});
               this._blackjackPostLuckyBonusAd.closeButton.addEventListener(MouseEvent.CLICK,this.onBlackjackPostLuckyBonusAdCloseClick,false,0,true);
               this._blackjackPostLuckyBonusAd.base.addEventListener(MouseEvent.CLICK,this.onBlackjackPostLuckyBonusAdClick,false,0,true);
               this._blackjackPostLuckyBonusAd.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._blackjackPostLuckyBonusAd.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      public function showBlackjackPostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = null;
         if((this._blackjackPostLuckyBonusAd) && !contains(this._blackjackPostLuckyBonusAd))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.BLACKJACK);
            if(_loc1_)
            {
               _loc1_.rollOver();
            }
            this._blackjackPostLuckyBonusAd.alpha = 0.0;
            TweenLite.to(this._blackjackPostLuckyBonusAd,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._blackjackPostLuckyBonusAd);
         }
      }
      
      public function hideAmexServeAd() : void {
         var _loc1_:SidenavItem = null;
         if((this._amexServeAd) && (contains(this._amexServeAd)))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.AMEX_SERVE);
            if(_loc1_)
            {
               _loc1_.rollOut();
            }
            removeChild(this._amexServeAd);
            this._amexServeAd = null;
         }
      }
      
      public function showLeaderboardTopRightFlyout() : void {
         if(!this._leaderboardTopRightFlyout)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:TopNavFlyout:LeaderboardTable:2013-11-13"));
            this._leaderboardTopRightFlyout = new SideNavMarketingTooltipView(false);
            this._leaderboardTopRightFlyout.labelText = LocaleManager.localize("flash.nav.leaderboardFlyout");
            this._leaderboardTopRightFlyout.closeButton.addEventListener(MouseEvent.CLICK,this.onLeaderboardTopRightFlyoutClose,false,0,true);
            this._leaderboardTopRightFlyout.base.addEventListener(MouseEvent.CLICK,this.onLeaderboardTopRightFlyoutClick,false,0,true);
            this._leaderboardTopRightFlyout.x = 657;
            this._leaderboardTopRightFlyout.y = 36;
            this._leaderboardTopRightFlyout.alpha = 0.0;
            addChild(this._leaderboardTopRightFlyout);
            TweenLite.to(this._leaderboardTopRightFlyout,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            TweenLite.delayedCall(10,this.fadeOutLeaderboardTopRightFlyout);
         }
      }
      
      private function fadeOutLeaderboardTopRightFlyout() : void {
         if(this._leaderboardTopRightFlyout !== null)
         {
            TweenLite.to(this._leaderboardTopRightFlyout,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":this.hideLeaderboardTopRightFlyout
               });
         }
      }
      
      public function hideLeaderboardTopRightFlyout() : void {
         if((this._leaderboardTopRightFlyout) && (contains(this._leaderboardTopRightFlyout)))
         {
            TweenLite.killTweensOf(this._leaderboardTopRightFlyout);
            removeChild(this._leaderboardTopRightFlyout);
            this._leaderboardTopRightFlyout = null;
         }
      }
      
      public function showLeaderboardSideNavFlyout() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LEADERBOARD);
         if(_loc1_)
         {
            if(!this._leaderboardSideNavFlyout)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:SideNavFlyout:LeaderboardTable:2013-11-13"));
               this._leaderboardSideNavFlyout = new SideNavMarketingTooltipView();
               this._leaderboardSideNavFlyout.labelText = LocaleManager.localize("flash.nav.leaderboardFlyout");
               this._leaderboardSideNavFlyout.closeButton.addEventListener(MouseEvent.CLICK,this.onLeaderboardSideNavFlyoutClose,false,0,true);
               this._leaderboardSideNavFlyout.base.addEventListener(MouseEvent.CLICK,this.onLeaderboardSideNavFlyoutClick,false,0,true);
               this._leaderboardSideNavFlyout.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._leaderboardSideNavFlyout.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
               _loc1_.rollOver();
               this._leaderboardSideNavFlyout.alpha = 0.0;
               addChild(this._leaderboardSideNavFlyout);
               TweenLite.to(this._leaderboardSideNavFlyout,0.25,
                  {
                     "alpha":1,
                     "ease":Linear.easeNone
                  });
               TweenLite.delayedCall(10,this.fadeOutLeaderboardSideNavFlyout);
            }
         }
      }
      
      public function showHappyHourLuckyBonusFlyout(param1:Boolean) : void {
         var _loc2_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
         if(_loc2_)
         {
            if(!this._happyHourLuckyBonusFlyout)
            {
               this._happyHourLuckyBonusFlyout = new SideNavMarketingTooltipView();
               if(param1 === true)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:LBHappyHourOFFToaster:2014-02-06"));
                  this._happyHourLuckyBonusFlyout.labelText = LocaleManager.localize("flash.nav.luckyBonus.preHappyHourFlyout");
               }
               else
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:LBHappyHourONToaster:2014-02-06"));
                  this._happyHourLuckyBonusFlyout.labelText = LocaleManager.localize("flash.nav.luckyBonus.inHappyHourFlyout");
               }
               this._happyHourLuckyBonusFlyout.closeButton.addEventListener(MouseEvent.CLICK,this.onHappyHourLuckyBonusSideNavFlyoutClose,false,0,true);
               this._happyHourLuckyBonusFlyout.base.addEventListener(MouseEvent.CLICK,this.onHappyHourLuckyBonusSideNavFlyoutClose,false,0,true);
               this._happyHourLuckyBonusFlyout.x = _loc2_.x + this.sideNav.x + this.sideNav.siCont.x + _loc2_.w;
               this._happyHourLuckyBonusFlyout.y = _loc2_.y + this.sideNav.y + this.sideNav.siCont.y;
               _loc2_.rollOver();
               this._happyHourLuckyBonusFlyout.alpha = 0.0;
               addChild(this._happyHourLuckyBonusFlyout);
               TweenLite.to(this._happyHourLuckyBonusFlyout,0.25,
                  {
                     "alpha":1,
                     "ease":Linear.easeNone
                  });
               TweenLite.delayedCall(15,this.fadeOutHappyHourLuckyBonusSideNavFlyout);
            }
         }
      }
      
      private function fadeOutLeaderboardSideNavFlyout() : void {
         if(this._leaderboardSideNavFlyout !== null)
         {
            TweenLite.to(this._leaderboardSideNavFlyout,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":this.hideLeaderboardSideNavFlyout
               });
         }
      }
      
      private function fadeOutHappyHourLuckyBonusSideNavFlyout() : void {
         if(this._happyHourLuckyBonusFlyout !== null)
         {
            TweenLite.to(this._happyHourLuckyBonusFlyout,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":this.hideHappyHourLuckyBonusSideNavFlyout
               });
         }
      }
      
      public function hideLeaderboardSideNavFlyout() : void {
         var _loc1_:SidenavItem = null;
         if((this._leaderboardSideNavFlyout) && (contains(this._leaderboardSideNavFlyout)))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.LEADERBOARD);
            if(_loc1_)
            {
               _loc1_.rollOut();
            }
            TweenLite.killTweensOf(this._leaderboardSideNavFlyout);
            removeChild(this._leaderboardSideNavFlyout);
            this._leaderboardSideNavFlyout = null;
         }
      }
      
      public function hideHappyHourLuckyBonusSideNavFlyout() : void {
         var _loc1_:SidenavItem = null;
         if((this._happyHourLuckyBonusFlyout) && (contains(this._happyHourLuckyBonusFlyout)))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
            if(_loc1_)
            {
               _loc1_.rollOut();
            }
            TweenLite.killTweensOf(this._happyHourLuckyBonusFlyout);
            removeChild(this._happyHourLuckyBonusFlyout);
            this._happyHourLuckyBonusFlyout = null;
         }
      }
      
      public function hideBlackjackPostLuckyBonusAd() : void {
         var navItem:SidenavItem = null;
         if((this._blackjackPostLuckyBonusAd) && (contains(this._blackjackPostLuckyBonusAd)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.BLACKJACK);
            if(navItem)
            {
               navItem.rollOut();
            }
            TweenLite.to(this._blackjackPostLuckyBonusAd,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._blackjackPostLuckyBonusAd]
               });
         }
      }
      
      public function initArcadePostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.MINI_ARCADE);
         if(_loc1_)
         {
            if(!this._arcadePostLuckyBonusAd)
            {
               this._arcadePostLuckyBonusAd = new SideNavMarketingTooltipView();
               this._arcadePostLuckyBonusAd.labelText = LocaleManager.localize("flash.nav.arcadePostLuckyBonusAd",{"amount":PokerCurrencyFormatter.numberToCurrency(175000000,false,1,true)});
               this._arcadePostLuckyBonusAd.closeButton.addEventListener(MouseEvent.CLICK,this.onArcadePostLuckyBonusAdCloseClick,false,0,true);
               this._arcadePostLuckyBonusAd.base.addEventListener(MouseEvent.CLICK,this.onArcadePostLuckyBonusAdCloseClick,false,0,true);
               this._arcadePostLuckyBonusAd.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._arcadePostLuckyBonusAd.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      public function showArcadePostLuckyBonusAd() : void {
         var _loc1_:SidenavItem = null;
         if((this._arcadePostLuckyBonusAd) && !contains(this._arcadePostLuckyBonusAd))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.MINI_ARCADE);
            this._arcadePostLuckyBonusAd.alpha = 0.0;
            TweenLite.to(this._arcadePostLuckyBonusAd,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._arcadePostLuckyBonusAd);
         }
      }
      
      public function hideArcadePostLuckyBonusAd(param1:NVEvent=null) : void {
         var navItem:SidenavItem = null;
         var e:NVEvent = param1;
         if((this._arcadePostLuckyBonusAd) && (contains(this._arcadePostLuckyBonusAd)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.MINI_ARCADE);
            TweenLite.to(this._arcadePostLuckyBonusAd,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._arcadePostLuckyBonusAd]
               });
         }
      }
      
      public function showGetChipsSideNav() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.GET_CHIPS);
         _loc1_.visible = true;
         _loc1_.enabled = true;
      }
      
      public function hideGetChipsSideNav() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.GET_CHIPS);
         _loc1_.visible = false;
         _loc1_.enabled = false;
      }
      
      public function showLuckyHandSideNav() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
         _loc1_.visible = true;
         _loc1_.enabled = true;
         this.displaySideNavActFast();
      }
      
      private function displaySideNavActFast() : void {
         var _loc2_:Loader = null;
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.animLayer.numChildren > 0?_loc1_.animLayer.getChildAt(0) as Loader:null;
            if(!(_loc2_ == null) && !(_loc2_.content == null))
            {
               _loc2_.content["coupon"].actfast.visible = false;
               _loc2_.content["coupon"].discount.visible = true;
            }
         }
      }
      
      public function showAtTableEraseLossSideNav() : void {
         var _loc2_:Object = null;
         this.hideGetChipsSideNav();
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         if(_loc1_)
         {
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.slideAtTableEaseLossSidenav,false,0,true);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.slideOutAtTAbleEaseLossSidenav,false,0,true);
            _loc1_.visible = true;
            _loc1_.enabled = true;
            _loc2_ = _loc1_.animLayer.getChildAt(0);
            if((_loc2_) && (_loc2_.content))
            {
               AtTableEraseLossManager.getInstance().initsidenav(_loc2_.content);
            }
         }
      }
      
      private function slideOutAtTAbleEaseLossSidenav(param1:MouseEvent) : void {
         var _loc3_:Object = null;
         var _loc2_:SidenavItem = this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         if(_loc2_)
         {
            _loc3_ = _loc2_.animLayer.getChildAt(0);
            if((_loc3_) && (_loc3_.content))
            {
               AtTableEraseLossManager.getInstance().slideOut(_loc3_.content);
            }
         }
      }
      
      private function slideAtTableEaseLossSidenav(param1:MouseEvent) : void {
         var _loc4_:Object = null;
         var _loc2_:SidenavItem = this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         var _loc3_:Object = _loc2_.animLayer.getChildAt(0);
         if((_loc3_) && (_loc3_.content))
         {
            _loc4_ = this._navModel.configModel.getFeatureConfig("atTableEraseLoss");
            AtTableEraseLossManager.getInstance().slide(_loc3_.content,_loc4_);
         }
      }
      
      public function hideLuckyHandSideNav() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
         _loc1_.visible = false;
         _loc1_.enabled = false;
         this.hideLuckyHandCouponArrow();
      }
      
      public function hideAtTableEraseLossSideNav() : void {
         var _loc2_:Object = null;
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         if(_loc1_)
         {
            _loc1_.visible = false;
            _loc1_.enabled = false;
            _loc2_ = this._navModel.configModel.getFeatureConfig("atTableEraseLoss");
            if(_loc2_)
            {
               _loc2_.timeLeft = 0;
            }
            this.showGetChipsSideNav();
         }
      }
      
      public function hideLuckyHandCouponArrow() : void {
         var navItem:SidenavItem = null;
         if((this._luckyHandCouponArrow) && (contains(this._luckyHandCouponArrow)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
            TweenLite.to(this._luckyHandCouponArrow,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._luckyHandCouponArrow]
               });
         }
      }
      
      public function allowLuckyHandSideNavClick() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
         _loc1_.makeSelected(false);
         SidenavEvents.quickThrow(SidenavEvents.CLOSE_PANEL,_loc1_.id);
      }
      
      public function allowAtTableEraseLossSideNavClick() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON);
         if(_loc1_)
         {
            _loc1_.makeSelected(false);
            SidenavEvents.quickThrow(SidenavEvents.CLOSE_PANEL,_loc1_.id);
         }
      }
      
      public function initLuckyHandArrow() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
         if(_loc1_)
         {
            if(!this._luckyHandCouponArrow)
            {
               this._luckyHandCouponArrow = new SideNavMarketingTooltipView();
               this._luckyHandCouponArrow.closeButton.addEventListener(MouseEvent.CLICK,this.onLuckyHandCouponArrowCloseClick,false,0,true);
               this._luckyHandCouponArrow.base.addEventListener(MouseEvent.CLICK,this.onClickLuckyHandCouponArrow,false,0,true);
               this._luckyHandCouponArrow.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._luckyHandCouponArrow.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      public function showLuckyHandCouponArrow() : void {
         var _loc1_:SidenavItem = null;
         if((this._luckyHandCouponArrow) && !contains(this._luckyHandCouponArrow))
         {
            _loc1_ = this.sideNav.getSideItem(Sidenav.LUCKY_HAND_COUPON);
            if(this.isLuckyHand)
            {
               this._luckyHandCouponArrow.labelText = LocaleManager.localize("flash.nav.side.luckyHandCoupon.tooltipText",
                  {
                     "chips":PokerCurrencyFormatter.getFormattedNumber(1710000),
                     "amount":"2"
                  });
            }
            else
            {
               this._luckyHandCouponArrow.labelText = LocaleManager.localize("flash.nav.side.unluckyHandCoupon.tooltipText",
                  {
                     "chips":PokerCurrencyFormatter.getFormattedNumber(1710000),
                     "amount":"2"
                  });
            }
            this._luckyHandCouponArrow.alpha = 0.0;
            TweenLite.to(this._luckyHandCouponArrow,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._luckyHandCouponArrow);
         }
      }
      
      public function initMegaBillionsThresholdArrow() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
         if(_loc1_)
         {
            if(!this._megaBillionsThresholdArrow)
            {
               this._megaBillionsThresholdArrow = new SideNavMarketingTooltipView();
               this._megaBillionsThresholdArrow.closeButton.addEventListener(MouseEvent.CLICK,this.onMegaBillionsThresholdArrowCloseClick,false,0,true);
               this._megaBillionsThresholdArrow.base.addEventListener(MouseEvent.CLICK,this.onMegaBillionsThresholdArrowBaseClick,false,0,true);
               this._megaBillionsThresholdArrow.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._megaBillionsThresholdArrow.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      private function onMegaBillionsThresholdArrowCloseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsThresholdArrow();
      }
      
      private function onMegaBillionsThresholdArrowBaseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsThresholdArrow();
         dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_BONUS));
      }
      
      public function showMegaBillionsThresholdArrow(param1:Number) : void {
         var _loc2_:SidenavItem = null;
         if((this._megaBillionsThresholdArrow) && !contains(this._megaBillionsThresholdArrow))
         {
            _loc2_ = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
            this._megaBillionsThresholdArrow.labelText = LocaleManager.localize("popups.megaBillions.threshold",
               {
                  "jackpotName":"Mega Billions",
                  "amount":PokerCurrencyFormatter.numberToCurrency(param1,false,1,true)
               });
            this._megaBillionsThresholdArrow.alpha = 0.0;
            TweenLite.to(this._megaBillionsThresholdArrow,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._megaBillionsThresholdArrow);
         }
      }
      
      private function hideMegaBillionsThresholdArrow() : void {
         var navItem:SidenavItem = null;
         if((this._megaBillionsThresholdArrow) && (contains(this._megaBillionsThresholdArrow)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
            TweenLite.to(this._megaBillionsThresholdArrow,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._megaBillionsThresholdArrow]
               });
         }
      }
      
      public function initMegaBillionsFTUEArrow() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem("LuckyBonus");
         if(_loc1_)
         {
            if(!this._megaBillionsFTUEArrow)
            {
               this._megaBillionsFTUEArrow = new SideNavMarketingTooltipView();
               this._megaBillionsFTUEArrow.closeButton.addEventListener(MouseEvent.CLICK,this.onMegaBillionsFTUEArrowCloseClick,false,0,true);
               if(this._navModel.configModel.getBooleanForFeatureConfig("megaBillions","surfaceFlyoutAtTable"))
               {
                  this._megaBillionsFTUEArrow.base.buttonMode = true;
               }
               this._megaBillionsFTUEArrow.base.addEventListener(MouseEvent.CLICK,this.onMegaBillionsFTUEArrowBaseClick,false,0,true);
               this._megaBillionsFTUEArrow.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._megaBillionsFTUEArrow.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      private function onMegaBillionsFTUEArrowCloseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsFTUEArrow();
         if(this._megaBillionsFTUEArrowShouldOpenLBOnClick)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:MegaBillionsFTUEFlyoutClose:AtTable:2013-08-07"));
         }
         else
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:MegaBillionsFTUEFlyoutClose:AfterFTUE:2013-08-07"));
         }
      }
      
      private function onMegaBillionsFTUEArrowBaseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsFTUEArrow();
         if(this._megaBillionsFTUEArrowShouldOpenLBOnClick)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:MegaBillionsFTUEFlyout:AtTable:2013-08-07"));
            dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_BONUS));
         }
         else
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:MegaBillionsFTUEFlyout:AfterFTUE:2013-08-07"));
         }
      }
      
      public function showMegaBillionsFTUEArrow() : void {
         var _loc1_:SidenavItem = null;
         if((this._megaBillionsFTUEArrow) && !contains(this._megaBillionsFTUEArrow))
         {
            _loc1_ = this.sideNav.getSideItem("LuckyBonus");
            if(this._navModel.configModel.getBooleanForFeatureConfig("megaBillions","surfaceFlyoutAtTable"))
            {
               this._megaBillionsFTUEArrow.labelText = LocaleManager.localize("popups.megaBillions.FTUEBefore");
               this._navModel.configModel.getFeatureConfig("megaBillions").surfaceFlyoutAtTable = false;
               this._megaBillionsFTUEArrowShouldOpenLBOnClick = true;
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:SideNav:MegaBillionsFTUEFlyout:AtTable:2013-08-07"));
            }
            else
            {
               if(this._navModel.configModel.getBooleanForFeatureConfig("megaBillions","surfaceOnAppEntry"))
               {
                  TweenLite.delayedCall(5,this.hideMegaBillionsFTUEArrow);
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:SideNav:MegaBillionsFTUEFlyout:AfterFTUE:2013-08-07"));
               }
               else
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:SideNav:MegaBillionsFTUEFlyout:Unknown:2013-08-07"));
               }
               this._megaBillionsFTUEArrow.labelText = LocaleManager.localize("popups.megaBillions.FTUEAfter");
               this._navModel.configModel.getFeatureConfig("megaBillions").surfaceOnAppEntry = false;
               this._megaBillionsFTUEArrowShouldOpenLBOnClick = false;
            }
            this._megaBillionsFTUEArrow.alpha = 0.0;
            TweenLite.to(this._megaBillionsFTUEArrow,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._megaBillionsFTUEArrow);
         }
      }
      
      public function hideMegaBillionsFTUEArrow() : void {
         var navItem:SidenavItem = null;
         if((this._megaBillionsFTUEArrow) && (contains(this._megaBillionsFTUEArrow)))
         {
            navItem = this.sideNav.getSideItem("LuckBonus");
            TweenLite.to(this._megaBillionsFTUEArrow,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._megaBillionsFTUEArrow]
               });
         }
      }
      
      public function initMegaBillionsWinnerArrow() : void {
         var _loc1_:SidenavItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
         if(_loc1_)
         {
            if(!this._megaBillionsWinnerArrow)
            {
               this._megaBillionsWinnerArrow = new SideNavMarketingTooltipView();
               this._megaBillionsWinnerArrow.closeButton.addEventListener(MouseEvent.CLICK,this.onMegaBillionsWinnerArrowCloseClick,false,0,true);
               this._megaBillionsWinnerArrow.base.addEventListener(MouseEvent.CLICK,this.onMegaBillionsWinnerArrowBaseClick,false,0,true);
               this._megaBillionsWinnerArrow.x = _loc1_.x + this.sideNav.x + this.sideNav.siCont.x + _loc1_.w;
               this._megaBillionsWinnerArrow.y = _loc1_.y + this.sideNav.y + this.sideNav.siCont.y;
            }
         }
      }
      
      private function onMegaBillionsWinnerArrowCloseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsWinnerArrow();
      }
      
      private function onMegaBillionsWinnerArrowBaseClick(param1:MouseEvent) : void {
         this.hideMegaBillionsWinnerArrow();
         dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_BONUS));
      }
      
      public function showMegaBillionsWinnerArrow(param1:String, param2:Number) : void {
         var _loc3_:SidenavItem = null;
         if((this._megaBillionsWinnerArrow) && !contains(this._megaBillionsWinnerArrow))
         {
            _loc3_ = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
            this._megaBillionsWinnerArrow.labelText = LocaleManager.localize("popups.megaBillions.justWon",
               {
                  "name":param1,
                  "amount":PokerCurrencyFormatter.numberToCurrency(param2,false,1,true)
               });
            this._megaBillionsWinnerArrow.alpha = 0.0;
            TweenLite.to(this._megaBillionsWinnerArrow,0.25,
               {
                  "alpha":1,
                  "ease":Linear.easeNone
               });
            addChild(this._megaBillionsWinnerArrow);
         }
      }
      
      private function hideMegaBillionsWinnerArrow() : void {
         var navItem:SidenavItem = null;
         if((this._megaBillionsWinnerArrow) && (contains(this._megaBillionsWinnerArrow)))
         {
            navItem = this.sideNav.getSideItem(Sidenav.LUCKY_BONUS);
            TweenLite.to(this._megaBillionsWinnerArrow,0.25,
               {
                  "alpha":0.0,
                  "ease":Linear.easeNone,
                  "onComplete":function(param1:DisplayObject):void
                  {
                     removeChild(param1);
                  },
                  "onCompleteParams":[this._megaBillionsWinnerArrow]
               });
         }
      }
      
      public function showLuckyHandV2DealerCoupon() : void {
         var _loc2_:ZButton = null;
         var _loc3_:* = 0;
         var _loc4_:Sprite = null;
         var _loc1_:* = false;
         if(this.m_luckyHandDealerCoupon != null)
         {
            AtTableEraseLossManager.getInstance().luckyHandIsBeingShown();
            _loc2_ = PokerClassProvider.getObject("standardCloseButton") as ZButton;
            _loc2_.name = "closeButton";
            _loc2_.init();
            _loc2_.addEventListener(ZButtonEvent.RELEASE,this.tweenLuckyHandV2DealerCoupon);
            _loc2_.scaleX = 0.83;
            _loc2_.scaleY = 0.83;
            _loc2_.y = 30;
            _loc2_.x = _loc2_.x + 103;
            _loc3_ = 1710000;
            _loc4_ = this.m_luckyHandDealerCoupon.content as Sprite;
            if(_loc4_ != null)
            {
               _loc4_.buttonMode = true;
               _loc4_.useHandCursor = true;
               _loc4_.addChild(_loc2_);
            }
            TweenLite.delayedCall(12,this.tweenLuckyHandV2DealerCoupon,[null]);
            this.m_luckyHandDealerCoupon.content["coupon"].addEventListener(MouseEvent.CLICK,this.onLuckyHandV2DealerCouponClick);
            this.m_luckyHandDealerCoupon.content["coupon"].close.addEventListener(MouseEvent.CLICK,this.tweenLuckyHandV2DealerCoupon);
            this.m_luckyHandDealerCoupon.content["coupon"].actfast.visible = false;
            this.m_luckyHandDealerCoupon.content["coupon"].discount.visible = true;
            this.m_luckyHandDealerCoupon.x = 380;
            this.m_luckyHandDealerCoupon.y = 65;
            this.m_luckyHandDealerCoupon.alpha = 1;
            this.m_luckyHandDealerCoupon.content["mask"].width = 231;
            if(this.isLuckyHand)
            {
               this.m_luckyHandTextField.text = LocaleManager.localize(this._luckyHandMessage,
                  {
                     "username":this._navModel.pgData.name,
                     "amount":"2",
                     "chips":PokerCurrencyFormatter.getFormattedNumber(_loc3_)
                  });
            }
            else
            {
               this.m_luckyHandTextField.text = LocaleManager.localize("flash.nav.side.unluckyHandCoupon.tooltipText",
                  {
                     "chips":PokerCurrencyFormatter.getFormattedNumber(_loc3_),
                     "amount":"2"
                  });
            }
         }
         this.showLuckyHandSideNav();
      }
      
      private function onLuckyHandV2DealerCouponClick(param1:MouseEvent) : void {
         this.tweenLuckyHandV2DealerCoupon(null);
         var _loc2_:String = this.isLuckyHand?"Lucky":"Unlucky";
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:" + _loc2_ + "HandV2DealerCoupon:2013-03-11"));
         if(this.isLuckyHand)
         {
            dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_HAND_COUPON));
         }
         else
         {
            dispatchEvent(new NVEvent(NVEvent.SHOW_UNLUCKY_HAND_COUPON));
         }
      }
      
      private function tweenLuckyHandV2DealerCoupon(param1:Event) : void {
         var a_event:Event = param1;
         TweenLite.killDelayedCallsTo(this.tweenLuckyHandV2DealerCoupon);
         this.m_luckyHandDealerCoupon.content["coupon"].removeEventListener(MouseEvent.CLICK,this.onLuckyHandV2DealerCouponClick);
         this.m_luckyHandDealerCoupon.content["coupon"].close.removeEventListener(MouseEvent.CLICK,this.tweenLuckyHandV2DealerCoupon);
         TweenLite.to(this.m_luckyHandDealerCoupon,1,
            {
               "delay":0.25,
               "x":this.m_luckyHandDealerCoupon.x - 277,
               "y":this.m_luckyHandDealerCoupon.y + 72,
               "ease":Cubic.easeOut,
               "onComplete":function():void
               {
                  m_luckyHandDealerCoupon.parent.removeChild(m_luckyHandDealerCoupon);
               }
            });
         TweenLite.to(this.m_luckyHandDealerCoupon,1.3,
            {
               "delay":0.7,
               "alpha":0.3,
               "ease":Cubic.easeOut
            });
         TweenLite.to(this.m_luckyHandDealerCoupon.content["mask"],0.5,{"width":71});
      }
      
      public function hideLuckyHandV2DealerCoupon(param1:Event=null) : void {
         if(!(this.m_luckyHandDealerCoupon == null) && !(this.m_luckyHandDealerCoupon.parent == null))
         {
            this.m_luckyHandDealerCoupon.parent.removeChild(this.m_luckyHandDealerCoupon);
         }
      }
      
      public function enableSideNav() : void {
         if((this.sideNav) && !this.sideNav.enabled)
         {
            this.sideNav.enabled = true;
         }
      }
      
      public function disableSideNav() : void {
         if((this.sideNav) && (this.sideNav.enabled))
         {
            this.sideNav.enabled = false;
         }
      }
      
      public function get approvedChips() : Number {
         return this.topNav.approvedChips;
      }
      
      public function set approvedChips(param1:Number) : void {
         this.topNav.approvedChips = param1;
      }
      
      public function get canceledChips() : Number {
         return this.topNav.canceledChips;
      }
      
      public function set canceledChips(param1:Number) : void {
         this.topNav.canceledChips = param1;
      }
      
      public function get pendingChips() : Number {
         return this.topNav.pendingChips;
      }
      
      public function set pendingChips(param1:Number) : void {
         this.topNav.pendingChips = param1;
      }
      
      public function get approvedGold() : Number {
         return this.topNav.approvedGold;
      }
      
      public function set approvedGold(param1:Number) : void {
         this.topNav.approvedGold = param1;
      }
      
      public function get canceledGold() : Number {
         return this.topNav.canceledGold;
      }
      
      public function set canceledGold(param1:Number) : void {
         this.topNav.canceledGold = param1;
      }
      
      public function get pendingGold() : Number {
         return this.topNav.pendingGold;
      }
      
      public function set pendingGold(param1:Number) : void {
         this.topNav.pendingGold = param1;
      }
      
      public function get pendingDuration() : Number {
         return this.topNav.pendingDuration;
      }
      
      public function set pendingDuration(param1:Number) : void {
         this.topNav.pendingDuration = param1;
      }
      
      public function updateXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void {
         this.topNav.updateXPInformation(param1,param2,param3,param4,param5);
      }
      
      public function updateNextUnlockLevel(param1:Number) : void {
         this.topNav.updateNextUnlockLevel(param1);
      }
      
      public function setUnlockedAchievementCount(param1:Number) : void {
         this.topNav.setUnlockedAchievementCount(param1);
      }
      
      public function updateChips(param1:Number) : void {
         this.topNav.updateChips(param1);
      }
      
      public function updateCasinoGold(param1:Number) : void {
         this.topNav.updateCasinoGold(param1);
      }
      
      public function updateTickets(param1:Number) : void {
         this.topNav.updateTickets(param1);
      }
      
      public function updateAchievements(param1:int) : void {
         this.topNav.updateAchievements(param1);
      }
      
      public function showNavTimer(param1:String, param2:Number) : void {
         var _loc3_:SidenavItem = null;
         var _loc4_:TopNavItem = null;
         if(param1 == Sidenav.LUCKY_BONUS)
         {
            _loc3_ = this.sideNav.getSideItem(param1);
            if(_loc3_ != null)
            {
               if(_loc3_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME))
               {
                  _loc3_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME).visible = false;
               }
            }
            _loc4_ = this.topNav.getItem(param1);
            if(_loc4_ != null)
            {
               if(_loc4_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME))
               {
                  _loc4_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME).visible = false;
               }
            }
         }
         else
         {
            if(param1 == Sidenav.AMEX_SERVE)
            {
               this.updateNavTimer(param1,param2);
            }
            else
            {
               if(param1 == Sidenav.LUCKY_HAND_COUPON)
               {
                  this.updateNavTimer(param1,param2);
               }
               else
               {
                  if(param1 == Sidenav.POKER_SCORE)
                  {
                     this.updateNavTimer(param1,param2);
                  }
               }
            }
         }
      }
      
      public function updateNavTimer(param1:String, param2:Number) : void {
         var _loc4_:TopNavItem = null;
         var _loc5_:SideNavMiniArcade = null;
         var _loc6_:SafeAssetLoader = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc3_:SidenavItem = this.sideNav.getSideItem(param1);
         if(param2 <= 0 || param1 == Sidenav.LUCKY_BONUS && this._navModel.configModel.getBooleanForFeatureConfig("happyHour","isHappyHourLuckyBonusSpin") === true)
         {
            if(param1 == Sidenav.AMEX_SERVE)
            {
               _loc3_.timerText = "";
               _loc6_ = _loc3_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME) as SafeAssetLoader;
               _loc6_.content["sidenavClaimChips"]();
               _loc3_.updateAlert(1);
            }
            else
            {
               if(param1 == Sidenav.LUCKY_BONUS)
               {
                  if(_loc3_ != null)
                  {
                     _loc3_.timerText = "";
                     if(_loc3_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME))
                     {
                        _loc3_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME).visible = true;
                     }
                     else
                     {
                        this.loadSideNavAnimationByName(param1,PokerGlobalData.instance.luckyBonusAnimationURL);
                     }
                  }
                  _loc5_ = this.sideNav.getSideItem(Sidenav.MINI_ARCADE) as SideNavMiniArcade;
                  _loc5_.timerText = "";
                  _loc3_.icon.y = 0;
                  _loc3_.visible = true;
                  _loc5_.visible = false;
                  _loc4_ = this.topNav.getItem(param1);
                  if(_loc4_ != null)
                  {
                     _loc4_.timerText = "";
                     if(_loc4_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME))
                     {
                        _loc4_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME).visible = true;
                     }
                     else
                     {
                        this.loadTopNavAnimationByName(param1,PokerGlobalData.instance.luckyBonusAnimationURL);
                     }
                  }
               }
               else
               {
                  if(param1 == Sidenav.POKER_SCORE)
                  {
                     _loc3_.visible = false;
                     _loc3_.timerText = "";
                  }
               }
            }
         }
         else
         {
            _loc7_ = Math.floor(param2 / 3600);
            _loc8_ = Math.floor(param2 / 60) % 60;
            _loc9_ = param2 % 60;
            _loc10_ = "" + (_loc7_ < 10?"0":"") + _loc7_ + ":" + (_loc8_ < 10?"0":"") + _loc8_;
            if(_loc3_ != null)
            {
               if(param2 <= 15 * 60)
               {
                  _loc10_ = _loc10_ + (":" + (_loc9_ < 10?"0":"") + _loc9_);
               }
               _loc3_.timerText = _loc10_;
            }
            if(param1 == Sidenav.LUCKY_BONUS)
            {
               _loc5_ = this.sideNav.getSideItem(Sidenav.MINI_ARCADE) as SideNavMiniArcade;
               _loc5_.timerText = _loc10_;
               _loc3_.timerText = " ";
               _loc3_.icon.y = 25;
               _loc3_.visible = false;
               _loc5_.visible = true;
            }
            else
            {
               if(param1 == Sidenav.POKER_SCORE)
               {
                  if(param2 > 120)
                  {
                     _loc8_ = 2;
                     _loc9_ = 0;
                  }
                  _loc10_ = (_loc8_ < 10?"0":"") + _loc8_ + ":" + (_loc9_ < 10?"0":"") + _loc9_;
                  _loc3_.timerText = _loc10_;
               }
               else
               {
                  if(param1 == Sidenav.LUCKY_HAND_COUPON)
                  {
                     _loc10_ = (_loc8_ < 10?"0":"") + _loc8_ + ":" + (_loc9_ < 10?"0":"") + _loc9_;
                     _loc3_.timerText = _loc10_;
                     this.sideNav.getSideItem(Sidenav.LUCKY_HAND_V2_COUPON).timerText = _loc10_;
                     if(!(this.m_luckyHandDealerCoupon == null) && !(this.m_luckyHandDealerCoupon.content == null))
                     {
                        this.m_luckyHandDealerCoupon.content["coupon"].timer.text = _loc10_;
                     }
                  }
                  else
                  {
                     if(param1 == Sidenav.AT_TABLE_ERASE_LOSS_COUPON)
                     {
                        _loc10_ = (_loc8_ < 10?"0":"") + _loc8_ + ":" + (_loc9_ < 10?"0":"") + _loc9_;
                        _loc3_.timerText = _loc10_;
                        this.sideNav.getSideItem(Sidenav.AT_TABLE_ERASE_LOSS_COUPON).timerText = _loc10_;
                        _loc11_ = this._navModel.configModel.getFeatureConfig("atTableEraseLoss");
                        if(_loc11_)
                        {
                           _loc11_.timeLeft = param2;
                        }
                     }
                  }
               }
            }
            _loc4_ = this.topNav.getItem(param1);
            if(_loc4_ != null)
            {
               if(param2 < 60)
               {
                  _loc10_ = ":" + _loc9_;
               }
               _loc4_.timerText = _loc10_;
            }
         }
      }
      
      public function showSideNav() : void {
         if(this.sideNav != null)
         {
            TweenLite.to(this.sideNav,0.5,
               {
                  "x":0.0,
                  "ease":Expo.easeOut
               });
         }
      }
      
      public function hideSideNav() : void {
         TweenLite.to(this.sideNav,0.5,
            {
               "x":-(this.sideNav.width + 4),
               "ease":Expo.easeIn
            });
         this.hideArcadePostLuckyBonusAd();
      }
      
      public function setSidebarItemsDeselected(param1:String="") : void {
         if(!param1)
         {
            return;
         }
         if(param1 == Sidenav.LUCKY_BONUS)
         {
            if((this.navFTUE) && (this.navFTUE.active))
            {
               this.navFTUE.updateText();
            }
            else
            {
               if(!(this._ftueStrings[param1] == null) && this._ftueStrings[param1].length > 0)
               {
                  this.topNav.showNavItemFTUE(param1,this._ftueStrings[param1][0]);
               }
            }
         }
         this.sideNav.setSidebarItemsDeselected(param1);
      }
      
      public function setSidebarItemIsEnabled(param1:String="", param2:Boolean=true) : void {
         this.sideNav.setSidebarItemIsEnabled(param1,param2);
      }
      
      public function setSidebarItemVisibility(param1:String, param2:Boolean) : void {
         this.sideNav.setSidebarItemVisibility(param1,param2);
      }
      
      private function onAchievementsClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onGameSettingsClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onGameCardButtonClick(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onNewsButtonClick(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onGetChipsClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onGoldHitClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onChipsHitClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onArcadePlayNowClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      public function showCasinoGoldTip(param1:int=0) : void {
         var _loc2_:PokerStatHit = new PokerStatHit("chipCounterHover",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"ChipCounter Other Hover o:Lobby:TopNav:ChipCounter:2012-08-30");
         PokerStatsManager.DoHitForStat(_loc2_);
         setChildIndex(this.casinoGoldTip,numChildren-1);
         this.casinoGoldTip.alpha = 0;
         this.casinoGoldTip.visible = true;
         TweenLite.to(this.casinoGoldTip,0.5,
            {
               "alpha":1,
               "delay":0.25,
               "ease":Sine.easeIn
            });
         if(param1 == 0)
         {
            if(this.tooltipTimer != null)
            {
               this.tooltipTimer.stop();
            }
         }
         else
         {
            if(this.tooltipTimer == null)
            {
               this.tooltipTimer = new Timer(param1,1);
               this.tooltipTimer.addEventListener(TimerEvent.TIMER,this.onTooltipTimer);
            }
            else
            {
               this.tooltipTimer.reset();
               this.tooltipTimer.delay = param1;
            }
            this.tooltipTimer.start();
         }
      }
      
      public function hideCasinoGoldTip() : void {
         this.casinoGoldTip.visible = false;
      }
      
      public function showChipsTip() : void {
         var _loc1_:PokerStatHit = new PokerStatHit("goldCounterHover",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"GoldCounter Other Hover o:Lobby:TopNav:GoldCounter:2012-08-30");
         PokerStatsManager.DoHitForStat(_loc1_);
         setChildIndex(this.chipsTip,numChildren-1);
         this.chipsTip.alpha = 0;
         this.chipsTip.visible = true;
         TweenLite.to(this.chipsTip,0.5,
            {
               "alpha":1,
               "delay":0.25,
               "ease":Sine.easeIn
            });
      }
      
      public function hideChipsTip() : void {
         this.chipsTip.visible = false;
      }
      
      public function getSideNavItemByName(param1:String) : SidenavItem {
         if(this.sideNav)
         {
            return this.sideNav.getSideItem(param1);
         }
         return null;
      }
      
      public function getTopNavItemByName(param1:String) : TopNavItem {
         return this.topNav.getItem(param1);
      }
      
      private function onTooltipTimer(param1:TimerEvent) : void {
         this.tooltipTimer.stop();
         this.tooltipTimer.reset();
         this.hideCasinoGoldTip();
      }
      
      private function onGoldRollover(param1:NVEvent) : void {
         this.showCasinoGoldTip();
      }
      
      private function onGoldRollout(param1:NVEvent) : void {
         this.hideCasinoGoldTip();
      }
      
      private function onChipsRollover(param1:NVEvent) : void {
         this.showChipsTip();
      }
      
      private function onChipsRollout(param1:NVEvent) : void {
         this.hideChipsTip();
      }
      
      private function onUserPicClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onSideNavRequestPanel(param1:SidenavEvents) : void {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc2_:PokerGlobalData = PokerGlobalData.instance;
         var _loc3_:String = String(param1.data);
         if(_loc3_ != null)
         {
            switch(_loc3_)
            {
               case Sidenav.GIFT_SHOP:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_GIFT_SHOP));
                  break;
               case Sidenav.PROFILE:
                  this.fireProfileStatHits();
                  _loc4_ = this._navModel.configModel.getBooleanForFeatureConfig("holidayCollectible","shouldShowAnimation")?{"tab":ProfilePanelTab.COLLECTIONS}:null;
                  dispatchEvent(new NVEvent(NVEvent.SHOW_USER_PROFILE,_loc4_));
                  break;
               case Sidenav.POKER_SCORE:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_POKER_SCORE_CARD));
                  break;
               case Sidenav.LEADERBOARD:
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:LeaderboardTable:2013-11-13"));
                  dispatchEvent(new NVEvent(NVEvent.SHOW_LEADERBOARD,{"showInPopup":true}));
                  break;
               case Sidenav.BUDDIES:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_BUDDIES));
                  break;
               case Sidenav.BETS:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_BETTING));
                  break;
               case Sidenav.GET_CHIPS:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_GET_CHIPS));
                  break;
               case Sidenav.LUCKY_HAND_COUPON:
                  _loc5_ = this.isLuckyHand?"Lucky":"Unlucky";
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:" + _loc5_ + "HandCoupon:2013-01-28"));
                  dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_HAND_COUPON));
                  break;
               case Sidenav.AT_TABLE_ERASE_LOSS_COUPON:
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:AtTableEraseLoss:2013-06-27"));
                  dispatchEvent(new Event(AtTableEraseLossCommand.BUY_ATTABLEERASELOSS_COUPON));
                  break;
               case Sidenav.CHALLENGE:
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:Challenges:2012-01-27"));
                  if(_loc2_.inLobbyRoom)
                  {
                     if(_loc2_.lobbyStats)
                     {
                        PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:Challenges:2010-04-06"));
                        PokerStatsManager.DoHitForStat(new PokerStatHit("lobbySideNavClickChallengesOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:ChallengesOnce:2010-04-08"));
                     }
                  }
                  else
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:Challenges:2010-08-19"));
                     PokerStatsManager.DoHitForStat(new PokerStatHit("tableSideNavClickChallengesOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:ChallengesOnce:2010-08-19"));
                  }
                  dispatchEvent(new NVEvent(NVEvent.SHOW_CHALLENGES));
                  break;
               case Sidenav.LUCKY_BONUS:
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:LuckyBonus:2012-05-15"));
                  if((this.navFTUE) && (this.navFTUE.active))
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:LuckyBonusFTUE:2012-03-26"));
                  }
                  else
                  {
                     if(this._navTimers[Sidenav.LUCKY_BONUS])
                     {
                        PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:LuckyBonusWaiting:2012-06-20"));
                     }
                     else
                     {
                        PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:LuckyBonusSpinReady:2012-03-26"));
                     }
                  }
                  if(this._navModel.configModel.getBooleanForFeatureConfig("happyHour","isHappyHourLuckyBonusSpin") === true)
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:LBHappyHourSidenav:2014-02-06"));
                  }
                  dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_BONUS));
                  break;
               case Sidenav.LUCKY_BONUS_ARCADE:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_BONUS_GOLD));
                  break;
               case Sidenav.SCRATCHERS:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_SCRATCHERS));
                  break;
               case Sidenav.BLACKJACK:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_BLACKJACK));
                  break;
               case Sidenav.AMEX_SERVE:
                  dispatchEvent(new NVEvent(NVEvent.SHOW_SERVEPROGRESS));
                  break;
            }
            
         }
      }
      
      private function fireProfileStatHits() : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Canvas Other Click o:SideNav:Profile:2010-01-27"));
         var _loc1_:PokerGlobalData = PokerGlobalData.instance;
         if(_loc1_.inLobbyRoom)
         {
            if(_loc1_.lobbyStats)
            {
               if(_loc1_.newCollectionItemCount > 0)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:ProfileCounter:2011-03-22"));
               }
               else
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:SideNav:Profile:2010-04-06"));
               }
               PokerStatsManager.DoHitForStat(new PokerStatHit("lobbySideNavClickProfileOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:SideNav:ProfileOnce:2010-04-08"));
            }
         }
         else
         {
            if(_loc1_.newCollectionItemCount > 0)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:ProfileCounter:2011-03-22"));
            }
            else
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:SideNav:Profile:2010-08-19"));
            }
            PokerStatsManager.DoHitForStat(new PokerStatHit("tableSideNavClickProfileOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Table Other Click o:SideNav:ProfileOnce:2010-08-19"));
         }
      }
      
      private function onSideNavClosePanel(param1:SidenavEvents) : void {
         var _loc2_:String = String(param1.data);
         if(_loc2_ != null)
         {
            switch(_loc2_)
            {
               case Sidenav.GIFT_SHOP:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_GIFT_SHOP));
                  break;
               case Sidenav.PROFILE:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_USER_PROFILE));
                  break;
               case Sidenav.BUDDIES:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_BUDDIES));
                  break;
               case Sidenav.BETS:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_BETTING));
                  break;
               case Sidenav.GET_CHIPS:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_GET_CHIPS));
                  break;
               case Sidenav.CHALLENGE:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_CHALLENGES));
                  break;
               case Sidenav.LUCKY_BONUS:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_LUCKY_BONUS));
                  break;
               case Sidenav.LUCKY_BONUS_ARCADE:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_LUCKY_BONUS));
                  break;
               case Sidenav.SCRATCHERS:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_SCRATCHERS));
                  break;
               case Sidenav.BLACKJACK:
                  dispatchEvent(new NVEvent(NVEvent.HIDE_BLACKJACK));
                  break;
            }
            
         }
      }
      
      private function onSetSidebarItemsSelected(param1:SidenavEvents) : void {
         this.setSidebarItemsSelected(param1.data.panel);
      }
      
      public function setSidebarItemsSelected(param1:String) : void {
         if(((this.navFTUE) && (this.navFTUE.active)) && (this.sideNav.getSideItem(param1)) && (this.sideNav.getSideItem(param1).ftueActive))
         {
            this.navFTUE.hideFTUE();
            this.sideNav.getSideItem(param1).ftueActive = false;
            dispatchEvent(new NVEvent(NVEvent.FTUE_CLICKED,param1));
         }
         else
         {
            this.topNav.hideNavItemFTUE(param1);
         }
         if((this._scratchersPostLuckyBonusAd) && (contains(this._scratchersPostLuckyBonusAd)) && param1 == Sidenav.SCRATCHERS)
         {
            this.hideScratchersPostLuckyBonusAd();
         }
         if((this._blackjackPostLuckyBonusAd) && (contains(this._blackjackPostLuckyBonusAd)) && param1 == Sidenav.BLACKJACK)
         {
            this.hideBlackjackPostLuckyBonusAd();
         }
         if((this._amexServeAd) && (contains(this._amexServeAd)) && param1 == Sidenav.AMEX_SERVE)
         {
            this.hideAmexServeAd();
         }
         if((this._arcadePostLuckyBonusAd) && (contains(this._arcadePostLuckyBonusAd)))
         {
            this.hideArcadePostLuckyBonusAd();
         }
         this.sideNav.setSidebarItemsSelected(param1);
      }
      
      private function onAchievementsNotificationReset(param1:TopnavEvent) : void {
         this.topNav.hideUnlockedAchievementCount();
      }
      
      public function updateSidenavItemCount(param1:String, param2:int) : void {
         var _loc4_:* = 0;
         var _loc3_:SidenavItem = this.getSideNavItemByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.updateAlert(param2);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               if(_loc3_.getChildAt(_loc4_).name == "starburst")
               {
                  _loc3_.getChildAt(_loc4_).visible = param2 == 0?true:false;
               }
               _loc4_++;
            }
         }
      }
      
      public function updateTopnavItemCount(param1:String, param2:int) : void {
         if(this.topNav)
         {
            this.topNav.updateNavItemCount(param1,param2);
         }
      }
      
      public function loadNavAnimations(param1:Object) : void {
         var _loc2_:SidenavItem = null;
         var _loc3_:TopNavItem = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:String = null;
         var _loc6_:SafeAssetLoader = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:SafeAssetLoader = null;
         if(param1)
         {
            _loc2_ = null;
            _loc3_ = null;
            for (_loc5_ in param1)
            {
               if(param1[_loc5_])
               {
                  _loc2_ = this.getSideNavItemByName(_loc5_);
                  if(_loc2_)
                  {
                     _loc6_ = new SafeAssetLoader();
                     _loc6_.name = this.NAV_ITEM_ANIMATION_CHILD_NAME;
                     _loc4_ = _loc2_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME);
                     if(_loc4_ != null)
                     {
                        _loc2_.animLayer.removeChild(_loc2_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME));
                     }
                     if(_loc5_ != "")
                     {
                        _loc7_ = _loc2_.getChildByName("starburst");
                        if(_loc7_ != null)
                        {
                           _loc2_.removeChild(_loc7_);
                        }
                        _loc2_.animLayer.addChild(_loc6_);
                        if(_loc5_ == Sidenav.AMEX_SERVE)
                        {
                           _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAmexServeIconLoadComplete);
                        }
                        else
                        {
                           if(_loc5_ == Sidenav.LUCKY_BONUS)
                           {
                              _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLuckyBonusIconLoadComplete);
                           }
                           else
                           {
                              if(_loc5_ == Sidenav.MINI_ARCADE)
                              {
                                 _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMiniArcadeIconLoadComplete);
                              }
                              else
                              {
                                 if(_loc5_ == Sidenav.LUCKY_HAND_COUPON)
                                 {
                                    _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLuckyHandIconLoadComplete);
                                 }
                                 else
                                 {
                                    if(_loc5_ == Sidenav.PROFILE)
                                    {
                                       _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onProfileIconLoadComplete);
                                    }
                                 }
                              }
                           }
                        }
                        _loc6_.load(new URLRequest(param1[_loc5_]));
                        if(_loc7_)
                        {
                           _loc2_.addChild(_loc7_);
                        }
                     }
                  }
                  if(_loc5_ == Sidenav.LUCKY_BONUS)
                  {
                     _loc3_ = this.getTopNavItemByName(_loc5_);
                     if(_loc3_)
                     {
                        _loc8_ = new SafeAssetLoader();
                        _loc8_.name = this.NAV_ITEM_ANIMATION_CHILD_NAME;
                        _loc4_ = _loc3_.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME);
                        if(_loc4_ != null)
                        {
                           _loc3_.removeChild(_loc4_);
                        }
                        _loc3_.animLayer.addChild(_loc8_);
                        _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLuckyBonusTopNavAnimationLoadComplete);
                        _loc8_.load(new URLRequest(param1[_loc5_]));
                     }
                  }
                  else
                  {
                     if(_loc5_ == "LuckyHandDealerCoupon")
                     {
                        this.m_luckyHandDealerCoupon = new SafeAssetLoader();
                        this.m_luckyHandDealerCoupon.name = this.NAV_ITEM_ANIMATION_CHILD_NAME;
                        this.m_luckyHandDealerCoupon.addEventListener(MouseEvent.CLICK,this.tweenLuckyHandV2DealerCoupon);
                        this.m_luckyHandDealerCoupon.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLuckyHandDealerCouponComplete);
                        this.m_luckyHandDealerCoupon.load(new URLRequest(param1[_loc5_]));
                     }
                  }
               }
            }
         }
      }
      
      private function onLuckyHandDealerCouponComplete(param1:Event) : void {
         this.m_luckyHandDealerCoupon.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLuckyHandDealerCouponComplete);
         var _loc2_:TextField = this.m_luckyHandDealerCoupon.content["coupon"].msg as TextField;
         _loc2_.visible = false;
         this.m_luckyHandTextField = new EmbeddedFontTextField("","Main",11,16777215,"center",true);
         this.m_luckyHandTextField.x = _loc2_.x;
         this.m_luckyHandTextField.y = _loc2_.y;
         this.m_luckyHandTextField.width = _loc2_.width;
         this.m_luckyHandTextField.height = _loc2_.height;
         this.m_luckyHandTextField.multiline = true;
         this.m_luckyHandTextField.wordWrap = true;
         this.m_luckyHandDealerCoupon.content["coupon"].addChild(this.m_luckyHandTextField);
      }
      
      private function onLuckyHandIconLoadComplete(param1:Event) : void {
         this.displaySideNavActFast();
      }
      
      private function onLuckyBonusIconLoadComplete(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.onLuckyBonusIconLoadComplete);
         this.dispatchEvent(new Event("LBIconLoaded"));
      }
      
      private function onMiniArcadeIconLoadComplete(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.onMiniArcadeIconLoadComplete);
         this.dispatchEvent(new Event("MiniArcadeIconLoaded"));
      }
      
      private function onProfileIconLoadComplete(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.onProfileIconLoadComplete);
         var _loc3_:SidenavItem = this.getSideNavItemByName(Sidenav.PROFILE);
         if((_loc3_) && (_loc3_.animLayer))
         {
            this.profileAnimationFadeIn(_loc3_.animLayer);
         }
      }
      
      private function profileAnimationFadeIn(param1:Sprite) : void {
         param1.alpha = 0;
         TweenLite.to(param1,0.25,
            {
               "alpha":1,
               "delay":60,
               "onComplete":this.profileAnimationFadeOut,
               "onCompleteParams":[param1]
            });
      }
      
      private function profileAnimationFadeOut(param1:Sprite) : void {
         param1.alpha = 1;
         TweenLite.to(param1,0.25,
            {
               "alpha":0,
               "delay":30,
               "onComplete":this.profileAnimationFadeIn,
               "onCompleteParams":[param1]
            });
      }
      
      private function onLuckyBonusTopNavAnimationLoadComplete(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.onLuckyBonusTopNavAnimationLoadComplete);
         _loc2_.loader.scaleX = 0.7;
         _loc2_.loader.scaleY = 0.7;
         _loc2_.loader.x = _loc2_.loader.x-1;
         _loc2_.loader.y = 4;
      }
      
      public function showAmexClaimIcon() : void {
         var _loc2_:SafeAssetLoader = null;
         var _loc1_:SidenavItem = this.getSideNavItemByName(Sidenav.AMEX_SERVE);
         if(_loc1_)
         {
            _loc2_ = _loc1_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME) as SafeAssetLoader;
            _loc1_.updateAlert(1);
            _loc2_.content["sidenavClaimChips"]();
         }
      }
      
      public function showAmexServeIcon() : void {
         var _loc2_:SafeAssetLoader = null;
         var _loc1_:SidenavItem = this.getSideNavItemByName(Sidenav.AMEX_SERVE);
         if(_loc1_)
         {
            _loc2_ = _loc1_.animLayer.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME) as SafeAssetLoader;
            _loc1_.updateAlert(0);
            _loc2_.content["sidenavServe"]();
         }
      }
      
      private function onAmexServeIconLoadComplete(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.onAmexServeIconLoadComplete);
         if((this.iconFlags[Sidenav.AMEX_SERVE]) && this.iconFlags[Sidenav.AMEX_SERVE] == "claim")
         {
            this.showAmexClaimIcon();
         }
         else
         {
            this.showAmexServeIcon();
         }
      }
      
      public function loadSideNavAnimationByName(param1:String, param2:String) : void {
         var _loc5_:DisplayObject = null;
         var _loc3_:SidenavItem = this.getSideNavItemByName(param1);
         var _loc4_:SafeAssetLoader = new SafeAssetLoader();
         _loc4_.name = this.NAV_ITEM_ANIMATION_CHILD_NAME;
         if(_loc3_)
         {
            if(param2 != "")
            {
               _loc5_ = _loc3_.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME);
               if(_loc5_ != null)
               {
                  _loc3_.removeChild(_loc5_);
               }
               _loc3_.animLayer.addChild(_loc4_);
               _loc4_.load(new URLRequest(param2));
            }
         }
      }
      
      public function loadTopNavAnimationByName(param1:String, param2:String) : void {
         var _loc5_:DisplayObject = null;
         var _loc3_:TopNavItem = this.getTopNavItemByName(param1);
         var _loc4_:SafeAssetLoader = new SafeAssetLoader();
         _loc4_.name = this.NAV_ITEM_ANIMATION_CHILD_NAME;
         if(_loc3_)
         {
            if(param2 != "")
            {
               _loc5_ = _loc3_.getChildByName(this.NAV_ITEM_ANIMATION_CHILD_NAME);
               if(_loc5_ != null)
               {
                  _loc3_.removeChild(_loc5_);
               }
               _loc3_.animLayer.addChild(_loc4_);
               _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLuckyBonusTopNavAnimationLoadComplete);
               _loc4_.load(new URLRequest(param2));
            }
         }
      }
      
      private function onSideNavMouseOver(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.BOUNDARYUI_FADE_IN));
      }
      
      private function onSideNavMouseOut(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.BOUNDARYUI_FADE_OUT));
      }
      
      private function onGeniusClose(param1:Event) : void {
         this.topNav.onShowGameDropdownForAnim();
      }
      
      private function onGeniusCloseFin(param1:Event) : void {
         this.topNav.onAnimationFinish();
      }
      
      public function showStaticGameDropdown() : void {
         this.topNav.onShowStaticGameDropdown();
      }
      
      public function lockUI() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:Shape = null;
         var _loc4_:MovieClip = null;
         if(!this.lockUIOverlay)
         {
            this.lockUIOverlay = new MovieClip();
            _loc1_ = 760;
            _loc2_ = 570;
            _loc3_ = new Shape();
            _loc3_.graphics.beginFill(0,0.7);
            _loc3_.graphics.drawRect(0,0,_loc1_,_loc2_);
            _loc3_.graphics.endFill();
            this.lockUIOverlay.addChild(_loc3_);
            _loc4_ = PokerClassProvider.getObject("GiftItemInstSpinner");
            _loc4_.scaleX = _loc4_.scaleY = 1.5;
            _loc4_.x = _loc1_ / 2 - _loc4_.width / 2;
            _loc4_.y = _loc2_ / 2 - _loc4_.height / 2;
            this.lockUIOverlay.addChild(_loc4_);
            this.lockUIOverlay.visible = true;
            addChild(this.lockUIOverlay);
         }
         if(!this.lockUIOverlay)
         {
            return;
         }
      }
      
      public function unlockUI() : void {
         if(this.lockUIOverlay)
         {
            removeChild(this.lockUIOverlay);
            this.lockUIOverlay.visible = false;
            this.lockUIOverlay = null;
         }
      }
      
      public function hideNavFTUEs() : void {
         this.topNav.hideNavFTUE();
      }
      
      private function onScratchersPostLuckyBonusAdCloseClick(param1:MouseEvent) : void {
         this.hideScratchersPostLuckyBonusAd();
      }
      
      private function onScratchersPostLuckyBonusAdClick(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_SCRATCHERS,{"fromArrow":true}));
      }
      
      private function onBlackjackPostLuckyBonusAdCloseClick(param1:MouseEvent) : void {
         this.hideBlackjackPostLuckyBonusAd();
      }
      
      private function onBlackjackPostLuckyBonusAdClick(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_BLACKJACK,{"fromArrow":true}));
      }
      
      private function onArcadePostLuckyBonusAdCloseClick(param1:MouseEvent) : void {
         this.hideArcadePostLuckyBonusAd();
      }
      
      private function onAmexPromoClicked(param1:NVEvent) : void {
         this.onAmexServeAdClick(null);
      }
      
      private function onShowPlayersClubToaster(param1:NVEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_PLAYERS_CLUB_TOASTER,param1.params));
      }
      
      private function onShowPlayersClubRewardCenter(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onShowOneClickRebuy(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onHideOneClickRebuy(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onPrepHideOneClickRebuy(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onAmexServeAdClick(param1:MouseEvent) : void {
         this.hideAmexServeAd();
         dispatchEvent(new NVEvent(NVEvent.SHOW_SERVEPROGRESS,{"fromArrow":true}));
      }
      
      private function onAmexServeAdClose(param1:MouseEvent) : void {
         var _loc2_:SidenavItem = null;
         if((this._amexServeAd) && (this.contains(this._amexServeAd)))
         {
            _loc2_ = this.sideNav.getSideItem(Sidenav.AMEX_SERVE);
            _loc2_.rollOut();
            removeChild(this._amexServeAd);
            this._amexServeAd = null;
         }
      }
      
      private function onLeaderboardTopRightFlyoutClick(param1:MouseEvent) : void {
         this._leaderboardTopRightFlyout.base.removeEventListener(MouseEvent.CLICK,this.onLeaderboardTopRightFlyoutClick);
         this.hideLeaderboardTopRightFlyout();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:TopNavFlyout:LeaderboardTable:2013-11-13"));
         dispatchEvent(new NVEvent(NVEvent.SHOW_LEADERBOARD,{"showInPopup":true}));
      }
      
      private function onLeaderboardTopRightFlyoutClose(param1:MouseEvent) : void {
         this._leaderboardTopRightFlyout.closeButton.removeEventListener(MouseEvent.CLICK,this.onLeaderboardTopRightFlyoutClose);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Close o:TopNavFlyout:LeaderboardTable:2013-11-13"));
         this.hideLeaderboardTopRightFlyout();
      }
      
      private function onLeaderboardSideNavFlyoutClick(param1:MouseEvent) : void {
         this._leaderboardSideNavFlyout.base.removeEventListener(MouseEvent.CLICK,this.onLeaderboardSideNavFlyoutClick);
         this.hideLeaderboardSideNavFlyout();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNavFlyout:LeaderboardTable:2013-11-13"));
         dispatchEvent(new NVEvent(NVEvent.SHOW_LEADERBOARD,{"showInPopup":true}));
      }
      
      private function onLeaderboardSideNavFlyoutClose(param1:MouseEvent) : void {
         this._leaderboardSideNavFlyout.closeButton.removeEventListener(MouseEvent.CLICK,this.onLeaderboardSideNavFlyoutClose);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Close o:SideNavFlyout:LeaderboardTable:2013-11-13"));
         this.hideLeaderboardSideNavFlyout();
      }
      
      private function onHappyHourLuckyBonusSideNavFlyoutClose(param1:MouseEvent) : void {
         this._happyHourLuckyBonusFlyout.closeButton.removeEventListener(MouseEvent.CLICK,this.onHappyHourLuckyBonusSideNavFlyoutClose);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Close o:SideNavFlyout:HappyHourLuckyBonus:2014-02-06"));
         this.hideHappyHourLuckyBonusSideNavFlyout();
      }
      
      private function onLuckyHandCouponArrowCloseClick(param1:MouseEvent) : void {
         this.hideLuckyHandCouponArrow();
      }
      
      private function onClickLuckyHandCouponArrow(param1:MouseEvent) : void {
         var _loc2_:String = this.isLuckyHand?"Lucky":"Unlucky";
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:SideNav:" + _loc2_ + "HandCouponArrow:2013-03-11"));
         dispatchEvent(new NVEvent(NVEvent.SHOW_LUCKY_HAND_COUPON));
         this.hideLuckyHandCouponArrow();
      }
      
      public function positionSideNav(param1:int) : void {
         if(this._sideNavPosition !== null)
         {
            this.sideNav.y = this._sideNavPosition[param1];
         }
      }
   }
}
