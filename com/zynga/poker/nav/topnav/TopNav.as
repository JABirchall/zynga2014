package com.zynga.poker.nav.topnav
{
   import com.zynga.poker.feature.FeatureView;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ComplexBox;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.popups.modules.XP_BoostHoverDialogProxy;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.draw.CountIndicator;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.nav.NavModel;
   import flash.geom.Point;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.utils.timers.PokerTimer;
   import com.zynga.poker.nav.events.NVEvent;
   import com.greensock.TweenLite;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.draw.ShineButton;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.PokerStatsManager;
   import flash.events.Event;
   import com.zynga.io.ExternalCall;
   import com.zynga.poker.PokerStageManager;
   import flash.display.Bitmap;
   import flash.utils.setTimeout;
   import com.zynga.draw.Box;
   import flash.display.BitmapData;
   
   public class TopNav extends FeatureView
   {
      
      public function TopNav() {
         this.TOP_NAV_CONFIG = 
            {
               "Profile":
                  {
                     "id":"Profile",
                     "icon":"ProfileIcon",
                     "label":"",
                     "tooltip":"",
                     "offsetX":12,
                     "offsetY":9,
                     "scaleX":0.8,
                     "scaleY":0.8,
                     "event":NVEvent.SHOW_USER_PROFILE,
                     "timer":-1,
                     "alertOffset":0
                  },
               "LuckyBonus":
                  {
                     "id":"LuckyBonus",
                     "icon":"LuckyBonusIcon",
                     "label":"",
                     "tooltip":"",
                     "offsetX":15,
                     "offsetY":10,
                     "scaleX":0.7,
                     "scaleY":0.7,
                     "event":NVEvent.SHOW_LUCKY_BONUS,
                     "timer":0,
                     "alertOffset":0
                  },
               "Challenge":
                  {
                     "id":"Challenge",
                     "icon":"ChallengesIcon",
                     "label":"",
                     "tooltip":"",
                     "offsetX":10,
                     "offsetY":12,
                     "scaleX":0.8,
                     "scaleY":0.8,
                     "event":NVEvent.SHOW_CHALLENGES,
                     "timer":-1,
                     "alertOffset":0
                  },
               "OnlineBuddiesIcon":
                  {
                     "id":"OnlineBuddiesIcon",
                     "icon":"OnlineBuddiesIcon",
                     "label":"",
                     "tooltip":"",
                     "separator":SEPARATOR_FOUR,
                     "offsetX":17,
                     "offsetY":10,
                     "scaleX":1,
                     "scaleY":1,
                     "event":NVEvent.TOGGLE_BUDDIES_DROPDOWN,
                     "timer":-1,
                     "alertOffset":10
                  }
            };
         this._navItems = {};
         super();
         this.bgOverlay = new Sprite();
         this.bgOverlay.graphics.beginFill(0,1);
         this.bgOverlay.graphics.drawRect(0.0,0.0,TOPNAV_WIDTH,TOPNAV_HEIGHT);
         this.bgOverlay.graphics.endFill();
         addChild(this.bgOverlay);
         this.bgCont = new Sprite();
         addChild(this.bgCont);
         var _loc1_:Object = new Object();
         _loc1_.colors = [4476240,2501935,2236962,1381653,0,1644825];
         _loc1_.alphas = [1,1,1,1,1,1];
         _loc1_.ratios = [0,2,86,86,175,255];
         var _loc2_:Box = new Box(TOPNAV_WIDTH,TOPNAV_HEIGHT,_loc1_,false);
         this.bgCont.addChild(_loc2_);
         var _loc3_:Class = PokerClassProvider.getClass("TopNavPattern");
         var _loc4_:BitmapData = new _loc3_(0,0) as BitmapData;
         var _loc5_:Sprite = new Sprite();
         _loc5_.alpha = 0.33;
         _loc5_.graphics.beginBitmapFill(_loc4_);
         _loc5_.graphics.drawRect(0,0,TOPNAV_WIDTH,12);
         _loc5_.graphics.endFill();
         _loc5_.x = 0;
         _loc5_.y = 28;
         this.bgCont.addChild(_loc5_);
         var _loc6_:ComplexBox = new ComplexBox(752,TOPNAV_HEIGHT,0,
            {
               "type":"complex",
               "ul":2,
               "ur":2,
               "ll":0,
               "lr":0
            });
         _loc6_.x = 4;
         addChild(_loc6_);
         this.bgCont.mask = _loc6_;
      }
      
      public static const XP_BOOST_SCALE_WITH_PLAYERS_CLUB_ACTIVE:Number = 1.3;
      
      public static const SEPARATOR_ONE:int = 0;
      
      public static const SEPARATOR_TWO:int = 1;
      
      public static const SEPARATOR_THREE:int = 2;
      
      public static const SEPARATOR_FOUR:int = 3;
      
      public static const SEPARATOR_FIVE:int = 4;
      
      public static const SEPARATOR_SIX:int = 5;
      
      public static const TOPNAV_WIDTH:Number = 760;
      
      public static const TOPNAV_HEIGHT:Number = 40;
      
      public static const TOPNAVITEM_WIDTH:Number = 32;
      
      private static const PLAYERS_CLUB_TOASTER_COOLDOWN:int = 10;
      
      private const TOP_NAV_CONFIG:Object;
      
      public var bgCont:Sprite;
      
      public var bgOverlay:Sprite;
      
      public var chipsField:EmbeddedFontTextField;
      
      public var casinoGoldField:EmbeddedFontTextField;
      
      public var chipsHit:ComplexBox;
      
      public var goldHit:ComplexBox;
      
      public var getChipsGold:DisplayObjectContainer;
      
      public var leveler:LevelMeter;
      
      private var xpBooster:XP_BoostHoverDialogProxy;
      
      public var achieveHitMask:Sprite;
      
      public var achievementTextField:EmbeddedFontTextField;
      
      public var gameSettingsTooltip:Tooltip;
      
      public var newsButtonTooltip:Tooltip;
      
      public var dollar:EmbeddedFontTextField;
      
      public var achievementTooltip:Tooltip;
      
      public var achievementCountIcon:CountIndicator;
      
      public var achievementIcon:MovieClip;
      
      public var cashGlow:MovieClip;
      
      public var gameSettingsIcon:MovieClip;
      
      public var goldIcon:MovieClip;
      
      public var iconTotalChips:MovieClip;
      
      public var thisChips:Number;
      
      public var thisCasinoGold:Number = 0;
      
      public var thisImageUrl:String;
      
      public var separatorSpots:Array;
      
      public var getChipsTooltip:Tooltip;
      
      private var getChipsEffectTimer:Timer;
      
      private var pgBuyAndSend:int;
      
      private var processingChipsContainer:Sprite;
      
      private var processingChipsText:EmbeddedFontTextField;
      
      private var processingChipsToolTip:Tooltip;
      
      private var processingChipsToolTipText:String;
      
      private var processingChipsToolTipTitle:String;
      
      private var processingGoldContainer:Sprite;
      
      private var processingGoldText:EmbeddedFontTextField;
      
      private var processingGoldToolTip:Tooltip;
      
      private var processingGoldToolTipText:String;
      
      private var processingGoldToolTipTitle:String;
      
      private var _approvedChips:Number = 0;
      
      private var _canceledChips:Number = 0;
      
      private var _pendingChips:Number = 0;
      
      private var _approvedGold:Number = 0;
      
      private var _canceledGold:Number = 0;
      
      private var _pendingGold:Number = 0;
      
      private var _pendingDuration:Number = 36;
      
      private var getChipsCounter:CountIndicator;
      
      private var gameCardButton:ShinyButton;
      
      public var gameCardTooltip:Tooltip;
      
      private var gameCardHorizontalOffset:Number = 0.0;
      
      private var newsButton:MovieClip;
      
      private var showNewsButton:Boolean = false;
      
      private var _gameButton:MovieClip;
      
      private var _gameButtonHitArea:Sprite;
      
      private var _disableGetChipsAndGold:Boolean = false;
      
      private var _gameNavItemsToShow:Array;
      
      private var _topNavItemsToShow:Array;
      
      private var _navItems:Object;
      
      private var _gameNavCounter:CountIndicator;
      
      private var _navFTUE:MovieClip;
      
      private var _gameDropdown:GameSelectionDropdown;
      
      private var _isGameDropdownShown:Boolean = false;
      
      private var _activeFTUEID:String = null;
      
      private var _amexPermIconTest:Boolean = false;
      
      private var _amexPromoDropdown:Sprite;
      
      private var _promoWidth:Number = 90;
      
      private var _config:Object;
      
      private var _navModel:NavModel;
      
      public function get showGameCardButton() : Boolean {
         return this._config.showGameCardButton;
      }
      
      private var _zpwcEnabled:Boolean = false;
      
      private var _thisZPWCTickets:int = 0;
      
      private var _ticketIcon:MovieClip;
      
      private var _ticketHit:ComplexBox;
      
      private var _ticketField:EmbeddedFontTextField;
      
      private var _ticketTooltip:Tooltip;
      
      private var _playersClubIcon:MovieClip;
      
      private var _playersClubCoolDown:Number = 0;
      
      private var _xpBoostAnimation:MovieClip;
      
      private var _xpBoostAnimationTime:int = 0;
      
      private var _xpLevelsHit:ComplexBox;
      
      override protected function _init() : void {
         this._navModel = featureModel as NavModel;
         this._config = this._navModel.configModel.getFeatureConfig("topNav");
         var _loc1_:* = -1;
         this.thisChips = this._navModel.nChips;
         this.thisImageUrl = this._navModel.sPicURL;
         this.pgBuyAndSend = this._navModel.configModel.getIntForFeatureConfig("gift","pgBuyAndSend",1);
         if(this._config)
         {
            this._gameNavItemsToShow = this._config.gameNav.items;
            this._topNavItemsToShow = this._config.items;
            this.showNewsButton = (this._config.displayNewsIcon) && this._topNavItemsToShow.length == 0 && this._gameNavItemsToShow.length == 0;
         }
         this._zpwcEnabled = this._navModel.pgData.enableZPWC;
         this._disableGetChipsAndGold = this._navModel.configModel.getBooleanForFeatureConfig("core","disableGetChipsAndGold");
         this._amexPermIconTest = (this._navModel.serveProgressConfig) && (this._navModel.serveProgressConfig.amexPermIconTest);
         if(this._gameNavItemsToShow.length > 0)
         {
            this.separatorSpots = [new Point(-2,20),new Point(360,20),new Point(455,20),new Point(632,20),new Point(689,20)];
         }
         else
         {
            if(this.showNewsButton)
            {
               this.separatorSpots = [new Point(-2,20),new Point(335,20),new Point(430,20),new Point(615,20),new Point(655,20),new Point(700,20)];
            }
            else
            {
               this.separatorSpots = [new Point(-2,20),new Point(360,20),new Point(455,20),new Point(645,20),new Point(695,20)];
            }
         }
         if(this._zpwcEnabled)
         {
            this.separatorSpots[SEPARATOR_TWO].x = this.separatorSpots[SEPARATOR_TWO].x - 20;
            this.separatorSpots[SEPARATOR_THREE].x = this.separatorSpots[SEPARATOR_THREE].x + 80;
            this.separatorSpots[SEPARATOR_FOUR].x = this.separatorSpots[SEPARATOR_FOUR].x + 35;
            this.separatorSpots[SEPARATOR_FIVE].x = this.separatorSpots[SEPARATOR_FIVE].x + 20;
         }
         this.clearPlayersClubCoolDown();
         this.initPlayersClubIcon();
         this.drawSeperators();
         this.drawChips(this.thisChips);
         this.drawLeveler(this.thisChips);
         this.drawCasinoGold(this.thisCasinoGold);
         if(this._zpwcEnabled)
         {
            this._thisZPWCTickets = this._navModel.zpwcTickets;
            this.drawTickets(this._thisZPWCTickets);
         }
         var _loc2_:* = "";
         this.drawGetChipsGold(_loc2_);
         if(this.showGameCardButton)
         {
            this.drawGameCardButton();
         }
         else
         {
            this.drawAchievements(this._navModel.nAchievements,this._navModel.nAchievementsTotal);
         }
         if(this.showNewsButton)
         {
            this.drawNewsButton();
         }
         if(!this._config.hideGameSettings)
         {
            this.drawGameSettings();
         }
         if(this._topNavItemsToShow.length > 0)
         {
            this.drawExtraTopNavButtons();
         }
         if(this._gameNavItemsToShow.length > 0)
         {
            this.drawGameButton();
         }
         this.initListeners();
         if(this._config.turnOnGameSettingGlow)
         {
            this.setGameSettingGlow(true);
         }
      }
      
      private function initListeners() : void {
         if(!this.showGameCardButton)
         {
            this.achieveHitMask.addEventListener(MouseEvent.CLICK,this.onAchievementsClicked);
            this.achieveHitMask.addEventListener(MouseEvent.MOUSE_OVER,this.showAchievementTooltip);
            this.achieveHitMask.addEventListener(MouseEvent.MOUSE_OUT,this.hideAchievementTooltip);
         }
         if(this.gameSettingsIcon)
         {
            this.gameSettingsIcon.addEventListener(MouseEvent.CLICK,this.onGameSettingsClicked);
            this.gameSettingsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.showGameSettingsTooltip);
            this.gameSettingsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.hideGameSettingsTooltip);
         }
         if(this.gameCardButton)
         {
            if(!this._amexPermIconTest)
            {
               this.gameCardButton.addEventListener(MouseEvent.CLICK,this.onGameCardButtonClick);
            }
            this.gameCardButton.addEventListener(MouseEvent.MOUSE_OVER,this.showGameCardTooltip);
            this.gameCardButton.addEventListener(MouseEvent.MOUSE_OUT,this.hideGameCardTooltip);
         }
         if(this.newsButton)
         {
            this.newsButton.addEventListener(MouseEvent.CLICK,this.onNewsButtonClick);
            this.newsButton.addEventListener(MouseEvent.MOUSE_OVER,this.showNewsButtonTooltip);
            this.newsButton.addEventListener(MouseEvent.MOUSE_OUT,this.hideNewsButtonTooltip);
         }
         if(this._zpwcEnabled)
         {
            this._ticketHit.addEventListener(MouseEvent.MOUSE_OVER,this.show_ticketTooltip,false,0,true);
            this._ticketHit.addEventListener(MouseEvent.MOUSE_OUT,this.hide_ticketTooltip,false,0,true);
         }
         if(this.getChipsGold)
         {
            this.getChipsGold.addEventListener(MouseEvent.CLICK,this.onGetChipsClicked);
            this.getChipsGold.addEventListener(MouseEvent.MOUSE_OVER,this.onGetChipsOver);
            this.getChipsGold.addEventListener(MouseEvent.MOUSE_OUT,this.onGetChipsOut);
            this.getChipsGold.addEventListener(MouseEvent.ROLL_OVER,this.onGetChipsRollOver);
            this.getChipsGold.addEventListener(MouseEvent.ROLL_OUT,this.onGetChipsRollOut);
         }
         if(this.goldHit)
         {
            this.goldHit.addEventListener(MouseEvent.ROLL_OVER,this.onGoldRollover);
            this.goldHit.addEventListener(MouseEvent.ROLL_OUT,this.onGoldRollout);
         }
         if(this.chipsHit)
         {
            this.chipsHit.addEventListener(MouseEvent.ROLL_OVER,this.onChipsRollover);
            this.chipsHit.addEventListener(MouseEvent.ROLL_OUT,this.onChipsRollout);
         }
         if(this._playersClubIcon)
         {
            this._playersClubIcon.addEventListener(MouseEvent.CLICK,this.onPlayersClubIconClicked,false,0,true);
         }
         this._xpLevelsHit.addEventListener(MouseEvent.ROLL_OVER,this.onShowToolTip);
         this._xpLevelsHit.addEventListener(MouseEvent.ROLL_OUT,this.onHideToolTip);
         if(this._navModel.configModel.isFeatureEnabled("xPBoostWithPurchase"))
         {
            this._xpLevelsHit.addEventListener(MouseEvent.ROLL_OVER,this.onShowXPBarHover);
            this._xpLevelsHit.addEventListener(MouseEvent.ROLL_OUT,this.onRemoveXPBarHover);
            if(this._navModel.configModel.getBooleanForFeatureConfig("xPBoostWithPurchase","openBuyPageOnXPBarClick"))
            {
               this._xpLevelsHit.addEventListener(MouseEvent.CLICK,this.openBuyPage);
            }
         }
      }
      
      private function onShowToolTip(param1:MouseEvent) : void {
         this.leveler.showToolTip();
      }
      
      private function onHideToolTip(param1:MouseEvent) : void {
         this.leveler.hideToolTip();
      }
      
      public function drawXPBoostToaster() : void {
         if(!this.xpBooster)
         {
            this.xpBooster = new XP_BoostHoverDialogProxy();
            this.xpBooster.x = this.separatorSpots[SEPARATOR_THREE].x;
            this.xpBooster.y = this.xpBooster.y + 10;
            if(this._navModel.configModel.isFeatureEnabled("playersClub") == false)
            {
               this.xpBooster.scaleX = XP_BOOST_SCALE_WITH_PLAYERS_CLUB_ACTIVE;
               this.xpBooster.scaleY = XP_BOOST_SCALE_WITH_PLAYERS_CLUB_ACTIVE;
            }
            this.xpBooster.doLayout();
            addChild(this.xpBooster);
            this.xpBooster.alpha = 0;
            this.update_xpLevelsHitBox();
         }
      }
      
      public function drawXPBoostActiveBar() : void {
         this.leveler.drawXPBoostActiveBar();
         this.drawXPBoostAnimation();
      }
      
      public function removeXPBoostActiveBar() : void {
         this.setXPBoostAnimationVisibility(false);
      }
      
      public function drawXPBoostAnimation() : void {
         if(!this._xpBoostAnimation)
         {
            if(this._navModel.configModel.isFeatureEnabled("playersClub"))
            {
               this._xpBoostAnimation = PokerClassProvider.getObject("barHighlight");
               this._xpBoostAnimationTime = 2000;
            }
            else
            {
               this._xpBoostAnimation = PokerClassProvider.getObject("barHighlight_XL");
               this._xpBoostAnimationTime = 3250;
            }
            if(this._xpBoostAnimation)
            {
               this._xpBoostAnimation.x = this.separatorSpots[SEPARATOR_THREE].x + 43;
               this._xpBoostAnimation.y = this._xpBoostAnimation.y + 24;
               addChild(this._xpBoostAnimation);
               this._xpBoostAnimation.stop();
               this.update_xpLevelsHitBox();
            }
         }
      }
      
      public function update_xpLevelsHitBox() : void {
         if(contains(this._xpLevelsHit) == true)
         {
            removeChild(this._xpLevelsHit);
         }
         addChild(this._xpLevelsHit);
      }
      
      public function playXPBoostAnimation() : void {
         if(this.leveler.xpBarBar.alpha == 1)
         {
            this.setXPBoostAnimationVisibility(true);
            this._xpBoostAnimation.play();
            PokerTimer.instance.addAnchor(this._xpBoostAnimationTime,this.stopXPBoostAnimation);
         }
      }
      
      public function stopXPBoostAnimation() : void {
         this._xpBoostAnimation.stop();
         this.setXPBoostAnimationVisibility(false);
         PokerTimer.instance.removeAnchor(this.stopXPBoostAnimation);
      }
      
      public function setXPBoostAnimationVisibility(param1:Boolean) : void {
         if(this._xpBoostAnimation)
         {
            this._xpBoostAnimation.alpha = Number(param1);
         }
      }
      
      private function openBuyPage(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_BUY_PAGE));
      }
      
      public function displayDefaultXPBoostToaster() : void {
         this.setXPBoostAnimationVisibility(false);
         this.showXPBoostToaster();
         this.xpBooster.cntrPromoHover.visible = true;
         this.xpBooster.cntrTimerHover.visible = false;
         this.xpBooster.txtPromo.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.promo.title");
         this.xpBooster.doLayout();
      }
      
      public function displayXPBoostToasterWithTimer(param1:int, param2:Array) : void {
         this.setXPBoostAnimationVisibility(false);
         this.showXPBoostToaster();
         this.xpBooster.cntrPromoHover.visible = false;
         this.xpBooster.cntrTimerHover.visible = true;
         this.xpBooster.txtMinsDigit1.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.number",{"number":param2[0]});
         this.xpBooster.txtMinsDigit2.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.number",{"number":param2[1]});
         this.xpBooster.txtSecDigit1.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.number",{"number":param2[2]});
         this.xpBooster.txtSecDigit2.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.number",{"number":param2[3]});
         this.xpBooster.txtBoostAmt.text = LocaleManager.localize("flash.nav.top.XPBoostWithPurchase.number",{"number":param1}) + "% " + LocaleManager.localize("flash.nav.top.XP");
         this.xpBooster.doLayout();
      }
      
      public function showXPBoostToaster() : void {
         this.leveler.hideElements(0.25,0);
         TweenLite.killTweensOf(this.xpBooster);
         TweenLite.to(this.xpBooster,0.25,
            {
               "alpha":1,
               "delay":0.25
            });
      }
      
      public function hideXPBoostToaster() : void {
         TweenLite.killTweensOf(this.xpBooster);
         TweenLite.to(this.xpBooster,0.25,{"alpha":0});
         this.leveler.showElements(0.25,0.25);
      }
      
      private function onShowXPBarHover(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_XP_BOOST_TOASTER));
      }
      
      private function onRemoveXPBarHover(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.REMOVE_XP_BOOST_TOASTER));
      }
      
      private function drawSeperators() : void {
         var _loc1_:String = null;
         var _loc2_:Seperator = null;
         if(this._zpwcEnabled)
         {
            for (_loc1_ in this.separatorSpots)
            {
               if(_loc1_ != "1")
               {
                  _loc2_ = new Seperator();
                  _loc2_.mouseEnabled = false;
                  _loc2_.x = this.separatorSpots[_loc1_].x;
                  _loc2_.y = this.separatorSpots[_loc1_].y;
                  this.bgCont.addChild(_loc2_);
               }
            }
         }
         else
         {
            for (_loc1_ in this.separatorSpots)
            {
               _loc2_ = new Seperator();
               _loc2_.mouseEnabled = false;
               _loc2_.x = this.separatorSpots[_loc1_].x;
               _loc2_.y = this.separatorSpots[_loc1_].y;
               this.bgCont.addChild(_loc2_);
            }
         }
      }
      
      private function drawChips(param1:Number) : void {
         this.cashGlow = PokerClassProvider.getObject("CashGlow");
         this.cashGlow.alpha = 0;
         this.cashGlow.x = 52;
         addChild(this.cashGlow);
         var _loc2_:String = PokerCurrencyFormatter.numberToCurrency(param1,false,0,false);
         this.chipsField = new EmbeddedFontTextField(LocaleManager.localize("flash.global.currency",{"amount":_loc2_}),"MainSemi",14,16777215,"left");
         this.chipsField.x = 43;
         this.chipsField.width = 160;
         this.chipsField.height = 20;
         this.chipsField.y = 11;
         this.chipsField.mouseEnabled = false;
         this.chipsField.selectable = false;
         addChild(this.chipsField);
         this.cashGlow.width = this.chipsField.width;
         this.iconTotalChips = PokerClassProvider.getObject("IconTotalChips");
         this.iconTotalChips.x = 15;
         this.iconTotalChips.y = 8;
         this.iconTotalChips.useHandCursor = true;
         addChild(this.iconTotalChips);
         this.chipsHit = new ComplexBox(159,35,0,{"type":"rect"});
         this.chipsHit.x = 3;
         this.chipsHit.y = 3;
         this.chipsHit.alpha = 0.01;
         this.chipsHit.buttonMode = true;
         this.chipsHit.addEventListener(MouseEvent.CLICK,this.onChipsHitClicked);
         addChild(this.chipsHit);
         if(this._disableGetChipsAndGold)
         {
            this.chipsHit.visible = false;
         }
      }
      
      private function drawLeveler(param1:Number) : void {
         this.leveler = new LevelMeter((this._zpwcEnabled) || (this._navModel.configModel.isFeatureEnabled("playersClub")));
         this.leveler.name = "levelMeter";
         this.leveler.x = this.separatorSpots[SEPARATOR_THREE].x;
         addChild(this.leveler);
         this._xpLevelsHit = new ComplexBox(this.leveler.width - 35,this.leveler.height,0,{"type":"rect"});
         this._xpLevelsHit.x = this.leveler.x;
         this._xpLevelsHit.y = this.leveler.y;
         this._xpLevelsHit.alpha = 0.0;
         this.enableButtonModeForLevelsHit(false);
         addChild(this._xpLevelsHit);
      }
      
      public function enableButtonModeForLevelsHit(param1:Boolean) : void {
         this._xpLevelsHit.buttonMode = param1;
      }
      
      private function drawGetChipsGold(param1:String="") : void {
         if(this.pgBuyAndSend == 1 && param1 == "")
         {
            this.getChipsGold = new ShineButton(120,22,LocaleManager.localize("flash.nav.top.getChipsAndGoldButton"),13,"gold",true);
         }
         else
         {
            if(!(this.pgBuyAndSend == 1) && param1 == "")
            {
               this.getChipsGold = new ShineButton(90,22,LocaleManager.localize("flash.nav.top.getChipsButton"),13,"gold",true);
            }
            else
            {
               if(param1 != "")
               {
                  this.getChipsGold = new ShineButton(115,22,param1,13,"gold",true);
               }
            }
         }
         this.getChipsGold.y = 20;
         if(!this._zpwcEnabled)
         {
            this.getChipsGold.x = this.separatorSpots[SEPARATOR_TWO].x - 65;
         }
         else
         {
            this.getChipsGold.x = this.separatorSpots[SEPARATOR_TWO].x + 30;
         }
         addChild(this.getChipsGold);
         if(this._disableGetChipsAndGold)
         {
            this.getChipsGold.visible = false;
         }
      }
      
      private function drawGetChipsCounter(param1:Number) : void {
         if(param1 > 0)
         {
            this.getChipsCounter = new CountIndicator(param1);
            this.getChipsCounter.x = 48;
            this.getChipsCounter.y = -3;
            this.getChipsGold.addChild(this.getChipsCounter);
         }
      }
      
      public function updateGetChipsCounter(param1:Number) : void {
         if(this.getChipsCounter)
         {
            if(param1 == 0)
            {
               this.getChipsGold.removeChild(this.getChipsCounter);
            }
            else
            {
               this.getChipsCounter.updateCount(param1);
            }
         }
         else
         {
            this.drawGetChipsCounter(param1);
         }
      }
      
      private function drawCasinoGold(param1:Number) : void {
         this.goldIcon = PokerClassProvider.getObject("GoldIcon");
         this.goldIcon.x = this.separatorSpots[SEPARATOR_TWO].x - 187;
         this.goldIcon.y = 8;
         addChild(this.goldIcon);
         var _loc2_:String = PokerCurrencyFormatter.numberToCurrency(param1,false,0,false);
         this.casinoGoldField = new EmbeddedFontTextField(_loc2_,"MainSemi",14,16777215,TextFormatAlign.LEFT);
         this.casinoGoldField.width = 100;
         this.casinoGoldField.height = 20;
         this.casinoGoldField.x = this.separatorSpots[SEPARATOR_TWO].x - 161;
         this.casinoGoldField.y = 11;
         this.casinoGoldField.mouseEnabled = false;
         this.casinoGoldField.selectable = false;
         addChild(this.casinoGoldField);
         this.goldHit = new ComplexBox(80,this.goldIcon.height,0,{"type":"rect"});
         this.goldHit.x = this.separatorSpots[SEPARATOR_TWO].x - 187;
         this.goldHit.y = this.goldIcon.y;
         this.goldHit.alpha = 0;
         this.goldHit.addEventListener(MouseEvent.CLICK,this.onGoldHitClicked);
         this.goldHit.buttonMode = true;
         addChild(this.goldHit);
         if(this.pgBuyAndSend == 0 || (this._disableGetChipsAndGold))
         {
            this.goldHit.visible = false;
         }
      }
      
      private function drawTickets(param1:Number) : void {
         this._ticketIcon = PokerClassProvider.getObject("zpwcTicket");
         this._ticketIcon.x = this.separatorSpots[SEPARATOR_TWO].x - 103;
         this._ticketIcon.y = 19;
         this._ticketIcon.rotation = -20;
         addChild(this._ticketIcon);
         var _loc2_:String = PokerCurrencyFormatter.numberToCurrency(param1,false,0,false);
         this._ticketField = new EmbeddedFontTextField(_loc2_,"MainSemi",14,16777215,TextFormatAlign.LEFT);
         this._ticketField.width = 100;
         this._ticketField.height = 20;
         this._ticketField.x = this.separatorSpots[SEPARATOR_TWO].x - 82;
         this._ticketField.y = 11;
         this._ticketField.mouseEnabled = false;
         this._ticketField.selectable = false;
         addChild(this._ticketField);
         this._ticketHit = new ComplexBox(80,this._ticketIcon.height,0,{"type":"rect"});
         this._ticketHit.x = this.separatorSpots[SEPARATOR_TWO].x - 120;
         this._ticketHit.y = this._ticketIcon.y - 11;
         this._ticketHit.alpha = 0;
         this._ticketHit.addEventListener(MouseEvent.CLICK,this.onTicketsClicked,false,0,true);
         this._ticketHit.buttonMode = true;
         addChild(this._ticketHit);
         if(this.pgBuyAndSend == 0 || (this._disableGetChipsAndGold))
         {
            this._ticketHit.visible = false;
            this.casinoGoldField.visible = false;
            this._ticketHit.visible = false;
         }
      }
      
      public function get approvedChips() : Number {
         return this._approvedChips;
      }
      
      public function set approvedChips(param1:Number) : void {
         this._approvedChips = param1;
         this.updateProcessingChips();
      }
      
      public function get canceledChips() : Number {
         return this._canceledChips;
      }
      
      public function set canceledChips(param1:Number) : void {
         this._canceledChips = param1;
         this.updateProcessingChips();
      }
      
      public function get pendingChips() : Number {
         return this._pendingChips;
      }
      
      public function set pendingChips(param1:Number) : void {
         this._pendingChips = param1;
         this.updateProcessingChips();
      }
      
      private function updateProcessingChips() : void {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc1_:* = false;
         if(this._approvedChips > 0)
         {
            _loc1_ = true;
            _loc2_ = 65280;
            _loc3_ = LocaleManager.localize("flash.nav.top.pendingChips.approved",{"amount":PokerCurrencyFormatter.numberToCurrency(this._approvedChips,false,0,false)});
            this.processingChipsToolTipTitle = LocaleManager.localize("flash.nav.top.pendingChips.approvedTooltipTitle");
            this.processingChipsToolTipText = LocaleManager.localize("flash.nav.top.pendingChips.approvedTooltipBody");
         }
         else
         {
            if(this._canceledChips > 0)
            {
               _loc1_ = true;
               _loc2_ = 16711680;
               _loc3_ = LocaleManager.localize("flash.nav.top.pendingChips.canceled",{"amount":PokerCurrencyFormatter.numberToCurrency(this._canceledChips,false,0,false)});
               this.processingChipsToolTipTitle = LocaleManager.localize("flash.nav.top.pendingChips.canceledTooltipTitle");
               this.processingChipsToolTipText = LocaleManager.localize("flash.nav.top.pendingChips.canceledTooltipBody");
            }
            else
            {
               if(this._pendingChips > 0)
               {
                  _loc1_ = true;
                  _loc2_ = 3394611;
                  _loc3_ = LocaleManager.localize("flash.nav.top.pendingChips.pending",{"amount":PokerCurrencyFormatter.numberToCurrency(this._pendingChips,false,0,false)});
                  this.processingChipsToolTipTitle = LocaleManager.localize("flash.nav.top.pendingChips.pendingTooltipTitle");
                  this.processingChipsToolTipText = LocaleManager.localize("flash.nav.top.pendingChips.pendingTooltipBody",
                     {
                        "duration":this._pendingDuration,
                        "hour":
                           {
                              "type":"tk",
                              "key":"hour",
                              "attributes":"",
                              "count":int(this._pendingDuration)
                           }
                     });
               }
            }
         }
         if(_loc1_)
         {
            if(this.processingChipsText != null)
            {
               this.processingChipsContainer.removeChild(this.processingChipsText);
               this.processingChipsText = null;
            }
            this.processingChipsText = new EmbeddedFontTextField(_loc3_,"Main",11,_loc2_,"left");
            this.processingChipsText.autoSize = TextFieldAutoSize.LEFT;
            this.processingChipsText.mouseEnabled = false;
            this.processingChipsText.height = 20;
            this.processingChipsText.x = 5;
            this.processingChipsText.y = 2;
            if(this.processingChipsContainer == null)
            {
               this.processingChipsContainer = new Sprite();
               this.processingChipsContainer.graphics.beginFill(1118481,0.75);
               this.processingChipsContainer.graphics.lineStyle(1,0,0.75,true);
               this.processingChipsContainer.graphics.drawRoundRect(0,0,this.processingChipsText.width + 10,18,10,10);
               this.processingChipsContainer.x = 40;
               this.processingChipsContainer.y = 30;
               addChild(this.processingChipsContainer);
               this.processingChipsContainer.addEventListener(MouseEvent.MOUSE_OVER,this.onProcessingChipsContainerMouseOver);
               this.processingChipsContainer.addEventListener(MouseEvent.MOUSE_OUT,this.onProcessingChipsContainerMouseOut);
            }
            this.processingChipsContainer.addChild(this.processingChipsText);
         }
         else
         {
            if(this.processingChipsContainer != null)
            {
               this.processingChipsContainer.removeEventListener(MouseEvent.MOUSE_OVER,this.onProcessingChipsContainerMouseOver);
               this.processingChipsContainer.removeEventListener(MouseEvent.MOUSE_OUT,this.onProcessingChipsContainerMouseOut);
               removeChild(this.processingChipsContainer);
               this.processingChipsContainer = null;
               this.processingChipsText = null;
            }
         }
      }
      
      public function onProcessingChipsContainerMouseOver(param1:MouseEvent) : void {
         if(this.processingChipsToolTip != null)
         {
            parent.removeChild(this.processingChipsToolTip);
            this.processingChipsToolTip = null;
         }
         this.processingChipsToolTip = new Tooltip(320,this.processingChipsToolTipText,this.processingChipsToolTipTitle);
         this.processingChipsToolTip.alpha = 0;
         this.processingChipsToolTip.x = 32;
         this.processingChipsToolTip.y = 55;
         parent.addChild(this.processingChipsToolTip);
         Tweener.addTween(this.processingChipsToolTip,
            {
               "alpha":1,
               "time":0.33,
               "transition":"easeInSine"
            });
      }
      
      public function onProcessingChipsContainerMouseOut(param1:MouseEvent) : void {
         Tweener.addTween(this.processingChipsToolTip,
            {
               "alpha":0,
               "time":0.2,
               "transition":"easeInSine",
               "onComplete":this.onFadeOutTooltip
            });
      }
      
      private function onFadeOutTooltip() : void {
         parent.removeChild(this.processingChipsToolTip);
      }
      
      public function get approvedGold() : Number {
         return this._approvedGold;
      }
      
      public function set approvedGold(param1:Number) : void {
         this._approvedGold = param1;
         this.updateProcessingGold();
      }
      
      public function get canceledGold() : Number {
         return this._canceledGold;
      }
      
      public function set canceledGold(param1:Number) : void {
         this._canceledGold = param1;
         this.updateProcessingGold();
      }
      
      public function get pendingGold() : Number {
         return this._pendingGold;
      }
      
      public function set pendingGold(param1:Number) : void {
         this._pendingGold = param1;
         this.updateProcessingGold();
      }
      
      public function get pendingDuration() : Number {
         return this._pendingDuration;
      }
      
      public function set pendingDuration(param1:Number) : void {
         this._pendingDuration = param1;
         this.updateProcessingChips();
         this.updateProcessingGold();
      }
      
      public function get gameDropdown() : GameSelectionDropdown {
         return this._gameDropdown;
      }
      
      private function updateProcessingGold() : void {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc1_:* = false;
         if(this._approvedGold > 0)
         {
            _loc1_ = true;
            _loc2_ = 65280;
            _loc3_ = LocaleManager.localize("flash.nav.top.pendingGold.approved",
               {
                  "amount":PokerCurrencyFormatter.numberToCurrency(this._approvedGold,false,0,false),
                  "gold":
                     {
                        "type":"tk",
                        "key":"gold",
                        "attributes":"",
                        "count":int(this._approvedGold)
                     }
               });
            this.processingGoldToolTipTitle = LocaleManager.localize("flash.nav.top.pendingGold.approvedTooltipTitle");
            this.processingGoldToolTipText = LocaleManager.localize("flash.nav.top.pendingGold.approvedTooltipBody");
         }
         else
         {
            if(this._canceledGold > 0)
            {
               _loc1_ = true;
               _loc2_ = 16711680;
               _loc3_ = LocaleManager.localize("flash.nav.top.pendingGold.canceled",
                  {
                     "amount":PokerCurrencyFormatter.numberToCurrency(this._canceledGold,false,0,false),
                     "gold":
                        {
                           "type":"tk",
                           "key":"gold",
                           "attributes":"",
                           "count":int(this._canceledGold)
                        }
                  });
               this.processingGoldToolTipTitle = LocaleManager.localize("flash.nav.top.pendingGold.canceledTooltipTitle");
               this.processingGoldToolTipText = LocaleManager.localize("flash.nav.top.pendingGold.canceledTooltipBody");
            }
            else
            {
               if(this._pendingGold > 0)
               {
                  _loc1_ = true;
                  _loc2_ = 3394611;
                  _loc3_ = LocaleManager.localize("flash.nav.top.pendingGold.pending",
                     {
                        "amount":PokerCurrencyFormatter.numberToCurrency(this._pendingGold,false,0,false),
                        "gold":
                           {
                              "type":"tk",
                              "key":"gold",
                              "attributes":"",
                              "count":int(this._pendingGold)
                           }
                     });
                  this.processingGoldToolTipTitle = LocaleManager.localize("flash.nav.top.pendingGold.pendingTooltipTitle");
                  this.processingGoldToolTipText = LocaleManager.localize("flash.nav.top.pendingGold.pendingTooltipBody",
                     {
                        "duration":this._pendingDuration,
                        "hour":
                           {
                              "type":"tk",
                              "key":"hour",
                              "attributes":"",
                              "count":int(this._pendingDuration)
                           }
                     });
               }
            }
         }
         if(_loc1_)
         {
            if(this.processingGoldText != null)
            {
               this.processingGoldContainer.removeChild(this.processingGoldText);
               this.processingGoldText = null;
            }
            this.processingGoldText = new EmbeddedFontTextField(_loc3_,"Main",11,_loc2_,"left");
            this.processingGoldText.autoSize = TextFieldAutoSize.LEFT;
            this.processingGoldText.mouseEnabled = false;
            this.processingGoldText.x = 5;
            this.processingGoldText.y = 2;
            if(this.processingGoldContainer == null)
            {
               this.processingGoldContainer = new Sprite();
               this.processingGoldContainer.graphics.beginFill(1118481,0.75);
               this.processingGoldContainer.graphics.lineStyle(1,0,0.75,true);
               this.processingGoldContainer.graphics.drawRoundRect(0,0,this.processingGoldText.width + 10,18,10,10);
               this.processingGoldContainer.x = 184;
               this.processingGoldContainer.y = 30;
               addChildAt(this.processingGoldContainer,getChildIndex(this.getChipsGold));
               this.processingGoldContainer.addEventListener(MouseEvent.MOUSE_OVER,this.onProcessingGoldContainerMouseOver);
               this.processingGoldContainer.addEventListener(MouseEvent.MOUSE_OUT,this.onProcessingGoldContainerMouseOut);
            }
            this.processingGoldContainer.addChild(this.processingGoldText);
         }
         else
         {
            if(this.processingGoldContainer != null)
            {
               this.processingGoldContainer.removeEventListener(MouseEvent.MOUSE_OVER,this.onProcessingGoldContainerMouseOver);
               this.processingGoldContainer.removeEventListener(MouseEvent.MOUSE_OUT,this.onProcessingGoldContainerMouseOut);
               removeChild(this.processingGoldContainer);
               this.processingGoldContainer = null;
               this.processingGoldText = null;
            }
         }
      }
      
      public function onProcessingGoldContainerMouseOver(param1:MouseEvent) : void {
         if(this.processingGoldToolTip != null)
         {
            parent.removeChild(this.processingGoldToolTip);
            this.processingGoldToolTip = null;
         }
         this.processingGoldToolTip = new Tooltip(300,this.processingGoldToolTipText,this.processingGoldToolTipTitle);
         this.processingGoldToolTip.alpha = 0;
         this.processingGoldToolTip.mouseChildren = false;
         this.processingGoldToolTip.mouseEnabled = false;
         this.processingGoldToolTip.x = 176;
         this.processingGoldToolTip.y = 55;
         parent.addChild(this.processingGoldToolTip);
         Tweener.addTween(this.processingGoldToolTip,
            {
               "alpha":1,
               "time":0.33,
               "transition":"easeInSine"
            });
      }
      
      public function onProcessingGoldContainerMouseOut(param1:MouseEvent) : void {
         Tweener.addTween(this.processingGoldToolTip,
            {
               "alpha":0,
               "time":0.2,
               "transition":"easeInSine"
            });
      }
      
      private function showAchievementTooltip(param1:MouseEvent) : void {
         if(!this.achievementTooltip)
         {
            this.achievementTooltip = new Tooltip(115,LocaleManager.localize("flash.nav.top.achievementsTooltipBody"),LocaleManager.localize("flash.nav.top.achievementsTooltipTitle"));
            this.achievementTooltip.x = this.separatorSpots[SEPARATOR_TWO].x + 10;
            this.achievementTooltip.y = 45;
            this.achievementTooltip.visible = false;
            addChild(this.achievementTooltip);
         }
         this.achievementTooltip.alpha = 0;
         this.achievementTooltip.visible = true;
         Tweener.addTween(this.achievementTooltip,
            {
               "alpha":1,
               "delay":0.25,
               "time":0.5,
               "transition":"easeInSine"
            });
      }
      
      private function hideAchievementTooltip(param1:MouseEvent) : void {
         if(this.achievementTooltip)
         {
            this.achievementTooltip.visible = false;
         }
      }
      
      private function drawAchievements(param1:int, param2:int) : void {
         if(!this.achievementIcon)
         {
            this.achievementIcon = PokerClassProvider.getObject("AchievementIcon");
            this.achievementIcon.buttonMode = true;
            this.achievementIcon.y = 11;
            addChild(this.achievementIcon);
            this.achievementTextField = new EmbeddedFontTextField("0","Main",14,16777215);
            this.achievementTextField.autoSize = TextFieldAutoSize.LEFT;
            this.achievementTextField.x = Math.round(this.achievementIcon.width) + 5;
            this.achievementTextField.y = Math.round((this.achievementIcon.height - this.achievementTextField.height) / 2);
            this.achievementIcon.addChild(this.achievementTextField);
         }
         if(!this.achieveHitMask)
         {
            this.achieveHitMask = new Sprite();
            this.achieveHitMask.graphics.beginFill(16711680,0.0);
            this.achieveHitMask.graphics.drawRect(0.0,0.0,this.separatorSpots[SEPARATOR_THREE].x - this.separatorSpots[SEPARATOR_TWO].x,TOPNAV_HEIGHT);
            this.achieveHitMask.graphics.endFill();
            this.achieveHitMask.x = this.separatorSpots[SEPARATOR_TWO].x;
            this.achieveHitMask.buttonMode = true;
            addChild(this.achieveHitMask);
         }
         this.updateAchievements(param1);
         this.achievementIcon.x = this.separatorSpots[SEPARATOR_TWO].x + 10;
      }
      
      private function drawGameCardButton() : void {
         var _loc2_:MovieClip = null;
         var _loc1_:String = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
         if(!this._amexPermIconTest)
         {
            this.gameCardButton = new ShinyButton(LocaleManager.localize("flash.nav.top.gameCardRedeemLabel"),81,24,12,16777215,ShinyButton.COLOR_CUSTOM,_loc1_,false,5,3,2,0,null,"left",false,[11141120,11141120],[11141120,11141120]);
         }
         else
         {
            this.gameCardButton = new ShinyButton(LocaleManager.localize("flash.nav.top.gameCardPromotionsLabel"),81,26,12,16777215,ShinyButton.COLOR_DARK_RED,_loc1_,false,1,1,1,0,null,"left",false,[11141120,11141120],[11141120,11141120]);
            this.gameCardButton.enabled = false;
            this.gameCardButton.buttonMode = true;
            this.gameCardButton.labelText.x = this.gameCardButton.labelText.x - 6;
            _loc2_ = PokerClassProvider.getObject("whiteArrow");
            _loc2_.x = this.gameCardButton.width - _loc2_.width - 6;
            _loc2_.y = this.gameCardButton.labelText.y + 6;
            this.gameCardButton.addChild(_loc2_);
         }
         if(this._zpwcEnabled)
         {
            this.gameCardButton.x = this.getChipsGold.x + this.getChipsGold.width / 2 - 10;
         }
         else
         {
            this.gameCardButton.x = this.separatorSpots[SEPARATOR_TWO].x + (this.separatorSpots[SEPARATOR_THREE].x - this.separatorSpots[SEPARATOR_TWO].x - this.gameCardButton.width) / 2;
         }
         this.gameCardButton.y = (TOPNAV_HEIGHT - this.gameCardButton.height) / 2;
         addChild(this.gameCardButton);
      }
      
      private function showGameCardTooltip(param1:MouseEvent) : void {
         var _loc2_:String = null;
         var _loc3_:EmbeddedFontTextField = null;
         var _loc4_:MovieClip = null;
         if(!this._amexPermIconTest)
         {
            if(this.gameCardTooltip == null)
            {
               this.gameCardTooltip = new Tooltip(200,LocaleManager.localize("flash.nav.top.gameCardTooltipBody"),LocaleManager.localize("flash.nav.top.gameCardTooltipTitle"));
               this.gameCardTooltip.x = this.gameCardButton.x;
               this.gameCardTooltip.y = 45;
               addChild(this.gameCardTooltip);
            }
            this.gameCardTooltip.alpha = 0;
            this.gameCardTooltip.visible = true;
            Tweener.addTween(this.gameCardTooltip,
               {
                  "alpha":1,
                  "delay":0.25,
                  "time":0.5,
                  "transition":"easeInSine"
               });
         }
         else
         {
            if(this._amexPromoDropdown == null)
            {
               this._amexPromoDropdown = new Sprite();
               this._amexPromoDropdown.x = this.gameCardButton.x;
               this._amexPromoDropdown.y = 35;
               this._amexPromoDropdown.addEventListener(MouseEvent.MOUSE_OVER,this.showGameCardTooltip);
               this._amexPromoDropdown.addEventListener(MouseEvent.MOUSE_OUT,this.hideGameCardTooltip);
               _loc2_ = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
               _loc3_ = new EmbeddedFontTextField(LocaleManager.localize("flash.nav.top.gameCardLabel"),_loc2_,12,16777215,"left",false);
               _loc3_.fitInWidth(this._promoWidth,5);
               _loc3_.height = _loc3_.textHeight;
               this.addPromoToDropdown(_loc3_,this.onGameCardButtonClick);
               _loc4_ = PokerClassProvider.getObject("AmexTopNav");
               this.addPromoToDropdown(_loc4_,this.onAmexPromoClick);
               addChild(this._amexPromoDropdown);
            }
            this._amexPromoDropdown.visible = true;
         }
      }
      
      private function addPromoToDropdown(param1:DisplayObject, param2:Function) : void {
         var _loc3_:Graphics = this._amexPromoDropdown.graphics;
         var _loc4_:Number = 6;
         var _loc5_:Number = 1;
         var _loc6_:Number = this._amexPromoDropdown.height;
         var _loc7_:Number = this._amexPromoDropdown.numChildren != 0?_loc5_ * 2:0;
         param1.x = (this._promoWidth - param1.width) / 2;
         param1.y = this._amexPromoDropdown.height;
         _loc3_.beginFill(6118762,1);
         _loc3_.drawRect(-_loc5_,_loc6_ - _loc4_ - _loc5_,this._promoWidth + _loc5_ * 2,param1.height + _loc4_ * 2 + _loc5_ * 2);
         _loc3_.endFill();
         _loc3_.beginFill(0,1);
         _loc3_.drawRect(0,_loc6_ - _loc4_ - _loc7_,this._promoWidth,param1.height + _loc4_ * 2 + _loc7_);
         _loc3_.endFill();
         if(this._amexPromoDropdown.numChildren != 0)
         {
            _loc3_.lineStyle(1,6118762);
            _loc3_.moveTo(5,param1.y - _loc4_);
            _loc3_.lineTo(this._promoWidth - 5,param1.y - _loc4_);
         }
         this._amexPromoDropdown.addChild(param1);
         var _loc8_:Sprite = new Sprite();
         _loc8_.graphics.beginFill(0,0.4);
         _loc8_.graphics.drawRect(0,-_loc4_,this._amexPromoDropdown.width - _loc5_ * 2,param1.height + _loc4_ * 2);
         _loc8_.graphics.endFill();
         _loc8_.x = 0;
         _loc8_.y = param1.y;
         _loc8_.buttonMode = true;
         _loc8_.addEventListener(MouseEvent.MOUSE_OVER,this.onPromoItemHover,false,0,true);
         _loc8_.addEventListener(MouseEvent.MOUSE_OUT,this.onPromoItemOut,false,0,true);
         _loc8_.addEventListener(MouseEvent.CLICK,param2,false,0,true);
         this._amexPromoDropdown.addChild(_loc8_);
      }
      
      private function onPromoItemHover(param1:MouseEvent) : void {
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_.alpha == 1)
         {
            Tweener.addTween(_loc2_,
               {
                  "alpha":0,
                  "time":0.1,
                  "transition":"easeOutSine"
               });
         }
      }
      
      private function onPromoItemOut(param1:MouseEvent) : void {
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_.alpha == 0)
         {
            Tweener.addTween(_loc2_,
               {
                  "alpha":1,
                  "time":0.1,
                  "transition":"easeOutSine"
               });
         }
      }
      
      private function hideGameCardTooltip(param1:MouseEvent) : void {
         if(this.gameCardTooltip)
         {
            this.gameCardTooltip.visible = false;
         }
         if(this._amexPromoDropdown)
         {
            this._amexPromoDropdown.visible = false;
         }
      }
      
      private function show_ticketTooltip(param1:MouseEvent) : void {
         if(this._ticketTooltip == null)
         {
            this._ticketTooltip = new Tooltip(200,LocaleManager.localize("flash.nav.top.zpwc.ticketTooltipBody"),LocaleManager.localize("flash.nav.top.zpwc.ticketTooltipTitle"));
            this._ticketTooltip.x = this._ticketHit.x - this._ticketHit.width / 2;
            this._ticketTooltip.y = 45;
            addChild(this._ticketTooltip);
         }
         this._ticketTooltip.visible = true;
      }
      
      private function hide_ticketTooltip(param1:MouseEvent) : void {
         if(this._ticketTooltip)
         {
            this._ticketTooltip.visible = false;
            removeChild(this._ticketTooltip);
            this._ticketTooltip = null;
         }
      }
      
      public function clearPlayersClubCoolDown() : void {
         this._playersClubCoolDown = PLAYERS_CLUB_TOASTER_COOLDOWN;
      }
      
      public function startPlayersClubCoolDown() : void {
         this._playersClubCoolDown = 0;
      }
      
      public function incrementPlayersClubCoolDown() : void {
         this._playersClubCoolDown++;
      }
      
      public function canShowPlayersClubToaster() : Boolean {
         return this._playersClubCoolDown >= PLAYERS_CLUB_TOASTER_COOLDOWN;
      }
      
      public function showPlayersClubToaster(param1:Object) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_PLAYERS_CLUB_TOASTER,param1));
      }
      
      private function initPlayersClubIcon() : void {
         if(this._navModel.configModel.isFeatureEnabled("playersClub"))
         {
            this.destroyPlayersClubIcon();
            this._playersClubIcon = PokerClassProvider.getObject("PlayersClubIcon");
            this._playersClubIcon.mouseEnabled = true;
            this._playersClubIcon.buttonMode = true;
            this._playersClubIcon.visible = true;
            this._playersClubIcon.x = 590;
            this._playersClubIcon.y = 8;
            addChild(this._playersClubIcon);
            this.separatorSpots.push(new Point(581,20));
         }
      }
      
      private function destroyPlayersClubIcon() : void {
         if(this._playersClubIcon)
         {
            this._playersClubIcon.removeEventListener(MouseEvent.CLICK,this.onPlayersClubIconClicked);
            this._playersClubIcon.visible = false;
            this._playersClubIcon = null;
         }
      }
      
      private function onPlayersClubIconClicked(param1:MouseEvent) : void {
         if(this._navModel.configModel.isFeatureEnabled("playersClub"))
         {
            dispatchEvent(new NVEvent(NVEvent.SHOW_PLAYERS_CLUB_REWARD_CENTER));
         }
      }
      
      private function drawNewsButton() : void {
         this.newsButton = PokerClassProvider.getObject("NewsIcon_en");
         this.newsButton.buttonMode = true;
         this.newsButton.x = this.separatorSpots[SEPARATOR_FIVE].x + 10;
         this.newsButton.y = 10;
         addChild(this.newsButton);
      }
      
      private var gameSettingGlowTimer:Timer;
      
      private var glowAlphaValue:Number = 0.3;
      
      private var glowAlphaStep:Number = 0.05;
      
      public function setGameSettingGlow(param1:Boolean=false) : void {
         if(this.gameSettingsIcon)
         {
            this.gameSettingsIcon.filters = null;
            if(param1)
            {
               this.addGlowEffectOnGameSettingIcon();
            }
            else
            {
               if(this.gameSettingGlowTimer)
               {
                  this.gameSettingGlowTimer.removeEventListener(TimerEvent.TIMER,this.onGameSettingGlow);
                  this.gameSettingGlowTimer.stop();
                  this.gameSettingGlowTimer = null;
               }
            }
            return;
         }
      }
      
      private function addGlowEffectOnGameSettingIcon() : void {
         this.gameSettingGlowTimer = new Timer(100);
         this.gameSettingGlowTimer.addEventListener(TimerEvent.TIMER,this.onGameSettingGlow);
         this.gameSettingGlowTimer.start();
      }
      
      private function onGameSettingGlow(param1:TimerEvent) : void {
         this.glowAlphaValue = this.glowAlphaValue + this.glowAlphaStep;
         var _loc2_:GlowFilter = new GlowFilter(16776960,this.glowAlphaValue,5,5,5,5,false,false);
         if(this.gameSettingsIcon)
         {
            this.gameSettingsIcon.filters = [_loc2_];
         }
         if(this.glowAlphaValue > 0.3)
         {
            this.glowAlphaStep = -0.05;
         }
         else
         {
            if(this.glowAlphaValue < 0)
            {
               this.glowAlphaStep = 0.05;
            }
         }
      }
      
      private function drawGameSettings() : void {
         if(!this.gameSettingsIcon)
         {
            this.gameSettingsIcon = PokerClassProvider.getObject("GameSettingsIcon");
            this.gameSettingsIcon.buttonMode = true;
            addChild(this.gameSettingsIcon);
         }
         if(this._gameNavItemsToShow.length > 0)
         {
            this.gameSettingsIcon.scaleX = this.gameSettingsIcon.scaleY = 0.75;
            this.gameSettingsIcon.x = this.separatorSpots[SEPARATOR_FIVE].x + 2 + (this.showNewsButton?0:4);
            this.gameSettingsIcon.y = 11;
         }
         else
         {
            this.gameSettingsIcon.x = this.separatorSpots[SEPARATOR_FOUR].x + 10 + (this.showNewsButton?0:4);
            this.gameSettingsIcon.y = 9;
         }
      }
      
      public function drawIcon(param1:String) : void {
         var _loc2_:Object = null;
         var _loc3_:TopNavItem = null;
         if(this.TOP_NAV_CONFIG.hasOwnProperty(param1))
         {
            _loc2_ = this.TOP_NAV_CONFIG[param1];
            _loc2_.gfx = PokerClassProvider.getClass(_loc2_["icon"]);
            _loc2_.itemWidth = TOPNAV_WIDTH;
            _loc2_.itemHeight = TOPNAV_HEIGHT;
            _loc3_ = new TopNavItem(_loc2_);
            _loc3_.buttonMode = true;
            _loc3_.x = this.separatorSpots[_loc2_["separator"]].x + 10;
            _loc3_.y = (TOPNAV_HEIGHT - _loc3_.height) / 2;
            _loc3_.visible = true;
            ListenerManager.addClickListener(_loc3_,this.onTopNavItemSelected);
            addChild(_loc3_);
            this._navItems[param1] = _loc3_;
         }
      }
      
      public function drawBuddiesIcon() : void {
         var _loc1_:Object = this.TOP_NAV_CONFIG["OnlineBuddiesIcon"];
         _loc1_.gfx = PokerClassProvider.getClass(_loc1_["icon"]);
         _loc1_.itemWidth = TOPNAVITEM_WIDTH;
         _loc1_.itemHeight = TOPNAV_HEIGHT;
         var _loc2_:TopNavItem = new TopNavItem(_loc1_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.onTopNavItemSelected);
         _loc2_.buttonMode = true;
         _loc2_.x = this.separatorSpots[SEPARATOR_FOUR].x - 2;
         _loc2_.y = (TOPNAV_HEIGHT - _loc2_.height) / 2 - 10;
         addChild(_loc2_);
         this._navItems["OnlineBuddiesIcon"] = _loc2_;
      }
      
      private function drawExtraTopNavButtons() : void {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:TopNavItem = null;
         this._navItems = {};
         var _loc1_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:TopNav:<topNavItemName>:2012-06-20");
         var _loc2_:Number = this.separatorSpots[SEPARATOR_FOUR].x + 1;
         for each (_loc3_ in this._topNavItemsToShow)
         {
            _loc4_ = this.TOP_NAV_CONFIG[_loc3_];
            _loc4_.gfx = PokerClassProvider.getClass(_loc4_["icon"]);
            _loc4_.itemWidth = TOPNAVITEM_WIDTH;
            _loc4_.itemHeight = TOPNAV_HEIGHT;
            _loc5_ = new TopNavItem(_loc4_);
            _loc5_.addEventListener(MouseEvent.CLICK,this.onTopNavItemSelected);
            _loc5_.buttonMode = true;
            _loc5_.x = _loc2_;
            _loc5_.y = (TOPNAV_HEIGHT - _loc5_.height) / 2;
            addChild(_loc5_);
            this._navItems[_loc3_] = _loc5_;
            _loc2_ = _loc5_.x + _loc5_.width;
            _loc1_.sTrackingStringOrComment = "Canvas Other Impression o:TopNav:" + _loc3_ + ":2012-06-20";
            PokerStatsManager.DoHitForStat(_loc1_);
         }
      }
      
      private function onTopNavItemSelected(param1:Event) : void {
         var _loc2_:TopNavItem = param1.currentTarget as TopNavItem;
         var _loc3_:Object = this.TOP_NAV_CONFIG[_loc2_.name];
         if(_loc3_ != null)
         {
            dispatchEvent(new NVEvent(_loc3_.event,null,true));
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:TopNav:" + _loc2_.name + ":2012-06-20"));
         }
      }
      
      public function updateNavItemCount(param1:String, param2:int) : void {
         var _loc3_:TopNavItem = this._navItems[param1];
         if(_loc3_ != null)
         {
            _loc3_.updateAlert(param2);
         }
         else
         {
            if(this._gameDropdown)
            {
               this._gameDropdown.updateNavItemCount(param1,param2);
            }
         }
      }
      
      public function getItem(param1:String) : TopNavItem {
         return this._navItems[param1];
      }
      
      private function showGameSettingsTooltip(param1:MouseEvent) : void {
         if(this.gameSettingsTooltip == null)
         {
            this.gameSettingsTooltip = new Tooltip(165,LocaleManager.localize("flash.nav.top.gameSettingsTooltipBody"),LocaleManager.localize("flash.nav.top.gameSettingsTooltipTitle"));
            this.gameSettingsTooltip.x = 580;
            this.gameSettingsTooltip.y = 45;
            addChild(this.gameSettingsTooltip);
         }
         this.gameSettingsTooltip.alpha = 0;
         this.gameSettingsTooltip.visible = true;
         Tweener.addTween(this.gameSettingsTooltip,
            {
               "alpha":1,
               "delay":0.25,
               "time":0.5,
               "transition":"easeInSine"
            });
      }
      
      private function hideGameSettingsTooltip(param1:MouseEvent) : void {
         if(this.gameSettingsTooltip)
         {
            this.gameSettingsTooltip.visible = false;
         }
      }
      
      private function showNewsButtonTooltip(param1:MouseEvent) : void {
         if(this.newsButtonTooltip == null)
         {
            this.newsButtonTooltip = new Tooltip(140,LocaleManager.localize("flash.nav.top.newsButtonTooltipBody"),LocaleManager.localize("flash.nav.top.newsButtonTooltipTitle"));
            this.newsButtonTooltip.x = 605;
            this.newsButtonTooltip.y = 45;
            addChild(this.newsButtonTooltip);
         }
         this.newsButtonTooltip.alpha = 0;
         this.newsButtonTooltip.visible = true;
         Tweener.addTween(this.newsButtonTooltip,
            {
               "alpha":1,
               "delay":0.25,
               "time":0.5,
               "transition":"easeInSine"
            });
      }
      
      private function hideNewsButtonTooltip(param1:MouseEvent) : void {
         if(this.newsButtonTooltip)
         {
            this.newsButtonTooltip.visible = false;
         }
      }
      
      public function updateXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void {
         this.leveler.setXPInformation(param1,param2,param3,param4,param5);
      }
      
      public function updateNextUnlockLevel(param1:Number) : void {
         this.leveler.updateNextUnlockLevel(param1);
      }
      
      public function setUnlockedAchievementCount(param1:Number) : void {
         if(!this.showGameCardButton && param1 > 0)
         {
            if(this.achievementCountIcon == null)
            {
               this.achievementCountIcon = new CountIndicator(param1);
               this.achievementCountIcon.x = 22;
               this.achievementCountIcon.y = 9;
               this.achievementIcon.addChild(this.achievementCountIcon);
            }
            this.achievementCountIcon.visible = true;
            this.achievementCountIcon.updateCount(param1);
         }
      }
      
      public function hideUnlockedAchievementCount() : void {
         if(this.achievementCountIcon)
         {
            this.achievementCountIcon.visible = false;
         }
      }
      
      public function updateChips(param1:Number) : void {
         this.chipsField.text = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(param1,false,0,false)});
         if(param1 > this.thisChips)
         {
            this.cashGlow.width = this.chipsField.width * 2;
            this.cashGlow.x = this.chipsField.x + this.chipsField.width / 2;
            Tweener.addTween(this.cashGlow,
               {
                  "alpha":0.75,
                  "time":0.4,
                  "transition":"easeInSine"
               });
            Tweener.addTween(this.dollar,
               {
                  "_color":16777215,
                  "time":0.4,
                  "transition":"easeInSine"
               });
            Tweener.addTween(this.dollar,
               {
                  "_Glow_alpha":1,
                  "_Glow_color":10092288,
                  "_Glow_blurX":13,
                  "_Glow_blurY":13,
                  "_Glow_quality":3,
                  "_Glow_strength":5,
                  "time":0.4,
                  "transition":"easeInSine"
               });
            Tweener.addTween(this.cashGlow,
               {
                  "alpha":0,
                  "delay":0.6,
                  "time":0.4,
                  "transition":"easeOutSine"
               });
            Tweener.addTween(this.dollar,
               {
                  "_color":13421772,
                  "delay":0.6,
                  "time":0.4,
                  "transition":"easeOutSine"
               });
            Tweener.addTween(this.dollar,
               {
                  "_Glow_alpha":0,
                  "_Glow_blurX":0,
                  "_Glow_blurY":0,
                  "_Glow_strength":0,
                  "delay":0.6,
                  "time":0.4,
                  "transition":"easeOutSine"
               });
         }
         this.thisChips = param1;
      }
      
      public function updateCasinoGold(param1:Number) : void {
         this.thisCasinoGold = param1;
         this.casinoGoldField.text = PokerCurrencyFormatter.numberToCurrency(this.thisCasinoGold,false,0,false);
         if(param1 > 999)
         {
            this.casinoGoldField.x = this.separatorSpots[SEPARATOR_TWO].x - 164;
         }
         else
         {
            this.casinoGoldField.x = this.separatorSpots[SEPARATOR_TWO].x - 161;
         }
      }
      
      public function updateTickets(param1:Number) : void {
         if(param1 > this._thisZPWCTickets)
         {
            this._ticketIcon.gotoAndPlay("win");
         }
         this._thisZPWCTickets = param1;
         this._ticketField.text = PokerCurrencyFormatter.numberToCurrency(param1,false,0,false);
      }
      
      public function updateAchievements(param1:int) : void {
         if(this.achievementTextField)
         {
            this.achievementTextField.text = String(param1);
         }
      }
      
      private function onAchievementsClicked(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.ACHIEVEMENTS_CLICKED));
      }
      
      private function onGameSettingsClicked(param1:MouseEvent) : void {
         if(this._config.turnOnGameSettingGlow)
         {
            this._config.turnOnGameSettingGlow = false;
            this.setGameSettingGlow(false);
            ExternalCall.getInstance().call("ZY.App.settings.turnOffGameSettingGlow");
         }
         dispatchEvent(new NVEvent(NVEvent.GAME_SETTINGS_CLICKED));
      }
      
      private function onAmexPromoClick(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.SHOW_SERVEPROGRESS));
         this.hideGameCardTooltip(null);
      }
      
      private function onGameCardButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.GAME_CARD_BUTTON_CLICK));
      }
      
      private function onNewsButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.NEWS_BUTTON_CLICK));
      }
      
      private function onGetChipsClicked(param1:MouseEvent) : void {
         var _loc2_:Object = this._navModel.configModel.getFeatureConfig("oneClickRebuy");
         if(_loc2_)
         {
            dispatchEvent(new NVEvent(NVEvent.HIDE_ONECLICKREBUY));
         }
         PokerStageManager.hideFullScreenMode();
         dispatchEvent(new NVEvent(NVEvent.GET_CHIPS_CLICKED));
      }
      
      private function onChipsHitClicked(param1:MouseEvent) : void {
         PokerStageManager.hideFullScreenMode();
         dispatchEvent(new NVEvent(NVEvent.CHIPSHIT_CLICKED));
      }
      
      private function onTicketsClicked(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.GET_CHIPS_CLICKED));
      }
      
      private function onGoldHitClicked(param1:MouseEvent) : void {
         PokerStageManager.hideFullScreenMode();
         dispatchEvent(new NVEvent(NVEvent.GOLDHIT_CLICKED));
      }
      
      private function onGoldRollover(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.GOLD_ROLLOVER));
      }
      
      private function onGetChipsRollOver(param1:MouseEvent) : void {
         this.showOneClickRebuy();
      }
      
      private function onGetChipsRollOut(param1:MouseEvent) : void {
         this.hideOneClickRebuy();
      }
      
      private function showOneClickRebuy() : void {
         var _loc1_:Object = this._navModel.configModel.getFeatureConfig("oneClickRebuy");
         if(_loc1_)
         {
            dispatchEvent(new NVEvent(NVEvent.SHOW_ONECLICKREBUY));
         }
      }
      
      private function hideOneClickRebuy() : void {
         var _loc1_:Object = this._navModel.configModel.getFeatureConfig("oneClickRebuy");
         if(_loc1_)
         {
            TweenLite.to(this,0.1,
               {
                  "onComplete":dispatchEvent,
                  "onCompleteParams":[new NVEvent(NVEvent.PREP_HIDE_ONECLICKREBUY)]
               });
         }
      }
      
      private function onGetChipsOver(param1:MouseEvent) : void {
         var _loc3_:* = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:Object = this._navModel.configModel.getFeatureConfig("oneClickRebuy");
         if(!_loc2_)
         {
            if(this.getChipsTooltip == null)
            {
               _loc3_ = 220;
               _loc4_ = "";
               _loc5_ = "";
               _loc4_ = LocaleManager.localize("flash.nav.top.getChipsTooltipTitle");
               _loc5_ = LocaleManager.localize("flash.nav.top.getChipsTooltipBody");
               this.getChipsTooltip = new Tooltip(_loc3_,_loc5_,_loc4_);
               this.getChipsTooltip.x = 212;
               this.getChipsTooltip.y = 45;
               this.getChipsTooltip.visible = false;
               addChild(this.getChipsTooltip);
            }
            this.getChipsTooltip.visible = true;
            this.getChipsTooltip.alpha = 0;
            Tweener.addTween(this.getChipsTooltip,
               {
                  "alpha":1,
                  "delay":0.25,
                  "time":0.5,
                  "transition":"easeInSine"
               });
         }
      }
      
      private function onGetChipsOut(param1:MouseEvent) : void {
         if(this.getChipsTooltip)
         {
            this.getChipsTooltip.visible = false;
         }
      }
      
      private function onGoldRollout(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.GOLD_ROLLOUT));
      }
      
      private function onChipsRollover(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.CHIPS_ROLLOVER));
      }
      
      private function onChipsRollout(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.CHIPS_ROLLOUT));
      }
      
      private function drawGameButton() : void {
         var _loc1_:* = NaN;
         if(!this._gameButton)
         {
            this._gameButton = PokerClassProvider.getObject("GameIcon");
            if(this._gameButton == null)
            {
               return;
            }
            this._gameButton.arrow.gotoAndStop(1);
            this._gameButton.mouseChildren = false;
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:GameNav:2012-06-20"));
            addChild(this._gameButton);
         }
         if(!this._gameButtonHitArea)
         {
            this._gameButtonHitArea = new Sprite();
            this._gameButtonHitArea.name = "btnTopNavGames";
            this._gameButtonHitArea.graphics.beginFill(16777215,0);
            this._gameButtonHitArea.x = this.separatorSpots[SEPARATOR_FIVE].x + 1;
            _loc1_ = TOPNAV_WIDTH - this.separatorSpots[SEPARATOR_FIVE].x - 6;
            this._gameButtonHitArea.graphics.drawRect(0,0,_loc1_,TOPNAV_HEIGHT);
            this._gameButtonHitArea.y = 0;
            this._gameDropdown = new GameSelectionDropdown(this._gameButtonHitArea.width,GameSelectionDropdown.DEFAULT_BORDER_THICKNESS,GameSelectionDropdown.DEFAULT_BORDER_RADIUS,this._navModel.configModel);
            this._gameDropdown.addEventListener(GameSelectionDropdown.EVENT_INIT_COMPLETE,this.onGameDropdownInitComplete,false,0,true);
            this._gameDropdown.addEventListener(MouseEvent.ROLL_OVER,this.onGameIconRollover);
            this._gameDropdown.addEventListener(MouseEvent.ROLL_OUT,this.onGameDropdownRollout,false,0,true);
            this._gameDropdown.gameNavConfig.PokerGenius.arrow = this._navModel.configModel.getBooleanForFeatureConfig("pokerGenius","showMarketing");
            this._gameDropdown.init(this._gameNavItemsToShow);
            this._gameDropdown.x = this._gameButtonHitArea.x;
            this._gameDropdown.y = TOPNAV_HEIGHT;
            this._gameButtonHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onGameIconRollover);
            this._gameButtonHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onGameIconRollout);
            addChild(this._gameButtonHitArea);
            this._gameButtonHitArea.buttonMode = true;
         }
         this._gameButton.x = (TOPNAV_WIDTH + this.separatorSpots[SEPARATOR_FIVE].x - this._gameButton.width) / 2;
         this._gameButton.y = 9;
      }
      
      public function showNavItemFTUE(param1:String, param2:String) : void {
         var _loc4_:EmbeddedFontTextField = null;
         var _loc3_:TopNavItem = this._navItems[param1];
         if(_loc3_ != null)
         {
            this._navFTUE = this.createNavFTUE(_loc3_.x + _loc3_.width / 2,TOPNAV_HEIGHT);
            _loc4_ = new EmbeddedFontTextField(param2,"Main",15,2449333,"center",true);
            _loc4_.multiline = true;
            _loc4_.wordWrap = true;
            _loc4_.width = 135;
            _loc4_.autoSize = TextFieldAutoSize.CENTER;
            _loc4_.x = -120 + (150 - _loc4_.width) / 2;
            _loc4_.y = 5 + (this._navFTUE.height - _loc4_.height) / 2;
            this._navFTUE.addChild(_loc4_);
            addChild(this._navFTUE);
            this._activeFTUEID = param1;
         }
      }
      
      public function hideNavItemFTUE(param1:String) : Boolean {
         if(this._activeFTUEID == param1)
         {
            this.hideNavFTUE();
            return true;
         }
         return false;
      }
      
      private function createNavFTUE(param1:Number, param2:Number) : MovieClip {
         var _loc3_:MovieClip = PokerClassProvider.getObject("NavFTUETooltip");
         _loc3_.x = param1;
         _loc3_.y = param2;
         _loc3_.challenge.visible = false;
         _loc3_.closeButton.buttonMode = true;
         _loc3_.closeButton.useHandCursor = true;
         _loc3_.closeButton.addEventListener(MouseEvent.CLICK,this.hideNavFTUE,false,0,true);
         return _loc3_;
      }
      
      public function hideNavFTUE(param1:MouseEvent=null) : void {
         if(this._navFTUE != null)
         {
            this._navFTUE.removeEventListener(MouseEvent.CLICK,this.hideNavFTUE);
            if(this._activeFTUEID != null)
            {
               dispatchEvent(new NVEvent(NVEvent.FTUE_CLICKED,this._activeFTUEID,true));
               this._activeFTUEID = null;
            }
            if(contains(this._navFTUE))
            {
               removeChild(this._navFTUE);
               this._navFTUE = null;
            }
         }
      }
      
      private function onGameDropdownInitComplete(param1:Event) : void {
         this._gameDropdown.removeEventListener(GameSelectionDropdown.EVENT_INIT_COMPLETE,this.onGameDropdownInitComplete);
         this.onAlertCountUpdated();
         this._gameDropdown.addEventListener(GameSelectionDropdown.EVENT_ALERT_COUNT_CHANGED,this.onAlertCountUpdated,false,0,true);
         this._gameDropdown.addEventListener(GameSelectionDropdown.EVENT_ITEM_CLOSED,this.onAlertItemClosed,false,0,true);
      }
      
      public function showGameDropdown(param1:MouseEvent=null) : void {
         if(!this._isGameDropdownShown)
         {
            this._isGameDropdownShown = true;
            addChildAt(this._gameDropdown,0);
            this._gameDropdown.fireImpressionStats();
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:GameNavDropdown:2012-06-20"));
         }
      }
      
      private function onGameIconRollover(param1:MouseEvent=null) : void {
         if(this._gameButton.arrow.currentFrame != 2)
         {
            this._gameButton.arrow.gotoAndStop(2);
         }
         if(!this._isGameDropdownShown)
         {
            this.showGameDropdown();
         }
      }
      
      private function onGameIconRollout(param1:MouseEvent) : void {
         if((this._gameDropdown) && (contains(this._gameDropdown)) && (this._gameDropdown.hitTestPoint(param1.stageX,param1.stageY)))
         {
            return;
         }
         if(this._gameButton.arrow.currentFrame != 1)
         {
            this._gameButton.arrow.gotoAndStop(1);
         }
         this.removeGameDropdown();
      }
      
      private function onGameDropdownRollout(param1:MouseEvent) : void {
         this.onGameIconRollout(param1);
         if(!this._gameButtonHitArea.hitTestPoint(param1.stageX,param1.stageY))
         {
            this.removeGameDropdown();
         }
      }
      
      public function removeGameDropdown() : void {
         this._isGameDropdownShown = false;
         if(this._gameDropdown)
         {
            if(contains(this._gameDropdown))
            {
               removeChild(this._gameDropdown);
            }
            this._gameButtonHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onGameIconRollout,false,0,true);
            this._gameDropdown.addEventListener(MouseEvent.ROLL_OUT,this.onGameDropdownRollout,false,0,true);
         }
      }
      
      private function updateGameNavCount(param1:int) : void {
         if(!(this._gameNavCounter == null) && param1 == this._gameNavCounter.count || this._gameNavCounter == null && param1 == 0)
         {
            return;
         }
         if(param1 > 0)
         {
            if(this._gameNavCounter == null)
            {
               this._gameNavCounter = new CountIndicator(param1);
               this._gameNavCounter.name = "imgTopNavGamesCounter";
               this._gameNavCounter.mouseChildren = false;
               this._gameNavCounter.x = 34;
               this._gameNavCounter.y = this._gameNavCounter.height / 2;
               this._gameButtonHitArea.addChild(this._gameNavCounter);
            }
            else
            {
               this._gameNavCounter.updateCount(param1);
            }
         }
         else
         {
            if(this._gameNavCounter != null)
            {
               this._gameButtonHitArea.removeChild(this._gameNavCounter);
               this._gameNavCounter = null;
            }
         }
      }
      
      public function pokerGeniusCloseAnim(param1:Bitmap) : void {
         param1.alpha = 0.5;
         param1.x = param1.x-1;
         param1.y = param1.y + 39;
         addChild(param1);
         var _loc2_:MovieClip = PokerClassProvider.getObject("PokerGeniusIconLg");
         _loc2_.x = param1.x + param1.width / 2 + _loc2_.width / 4;
         _loc2_.y = param1.y + param1.height / 2 + _loc2_.height / 2;
         _loc2_.alpha = 0;
         _loc2_.scaleX = 1;
         _loc2_.scaleY = 1;
         addChild(_loc2_);
         Tweener.addTween(param1,
            {
               "scaleX":0.1,
               "scaleY":0.1,
               "x":param1.x + param1.width / 2,
               "y":param1.y + param1.height / 2,
               "alpha":0,
               "time":0.7,
               "transition":"easeInOutSine"
            });
         Tweener.addTween(_loc2_,
            {
               "alpha":1,
               "delay":0.4,
               "time":0.6,
               "onComplete":this.pokerGeniusCloseAnim2,
               "onCompleteParams":[param1,_loc2_],
               "transition":"easeInOutSine"
            });
         this._gameButtonHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onGameIconRollout);
         this._gameButtonHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onGameIconRollover);
      }
      
      private function pokerGeniusCloseAnim2(param1:Bitmap, param2:MovieClip) : void {
         var _loc3_:GameSelectionDropdownItem = this.gameDropdown.getNavItem("PokerGenius");
         var _loc4_:Number = this.gameDropdown.x + _loc3_.x + 32;
         var _loc5_:Number = this.gameDropdown.y - 19;
         Tweener.addTween(param2,
            {
               "x":_loc4_,
               "y":_loc5_,
               "time":1.5,
               "transition":"easeInOutSine",
               "onComplete":this.pokerGeniusCloseAnimFin,
               "onCompleteParams":[param2,_loc3_.y + 38]
            });
      }
      
      private function pokerGeniusCloseAnimFin(param1:MovieClip, param2:Number) : void {
         var icon:MovieClip = param1;
         var offY:Number = param2;
         this.onShowGameDropdownForAnim(null);
         Tweener.addTween(icon,
            {
               "y":icon.y + offY,
               "scaleX":1,
               "scaleY":1,
               "time":1,
               "transition":"easeInOutSine"
            });
         Tweener.addTween(icon,
            {
               "scaleX":2 / 3,
               "scaleY":2 / 3,
               "time":0.25,
               "delay":1.25,
               "transition":"easeInOutSine"
            });
         setTimeout(function():void
         {
            removeChild(icon);
            onAnimationFinish(null);
         },3000);
      }
      
      private function onAlertCountUpdated(param1:Event=null) : void {
         this.updateGameNavCount(this._gameDropdown.getAlertCount());
      }
      
      private function onAlertItemClosed(param1:Event=null) : void {
         this.removeGameDropdown();
      }
      
      public function onShowStaticGameDropdown(param1:Event=null) : void {
         this._gameDropdown.removeEventListener(MouseEvent.ROLL_OUT,this.onGameDropdownRollout);
         this._gameButtonHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onGameIconRollout);
         this.showGameDropdown();
         setTimeout(this.removeGameDropdown,15000);
      }
      
      public function onShowGameDropdownForAnim(param1:Event=null) : void {
         this._gameDropdown.hideNavItem("PokerGenius");
         this._gameDropdown.removeEventListener(MouseEvent.ROLL_OUT,this.onGameDropdownRollout);
         this.showGameDropdown();
      }
      
      public function onAnimationFinish(param1:Event=null) : void {
         this._gameDropdown.showNavItem("PokerGenius");
         this._gameDropdown.addEventListener(MouseEvent.ROLL_OUT,this.onGameDropdownRollout);
         this._gameButtonHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onGameIconRollover);
         this._gameButtonHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onGameIconRollout);
         this.removeGameDropdown();
      }
   }
}
