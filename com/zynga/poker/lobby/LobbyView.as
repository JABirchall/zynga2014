package com.zynga.poker.lobby
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import com.zynga.poker.lobby.asset.LobbyGrid;
   import com.zynga.poker.lobby.asset.LobbyGameSelector;
   import com.zynga.poker.lobby.asset.LobbyPlayerInfo;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.rad.buttons.ZButton;
   import com.zynga.poker.lobby.asset.LobbyGridAtThisTable;
   import flash.display.DisplayObjectContainer;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.poker.lobby.asset.LobbyShootoutRoundButton;
   import com.zynga.poker.lobby.asset.LobbyCasinoSelector;
   import flash.text.TextField;
   import fl.controls.CheckBox;
   import com.zynga.poker.lobby.asset.LobbyAdContainer;
   import com.zynga.ui.tabBanner.TabBannerController;
   import com.zynga.poker.lobby.asset.DrawFrame;
   import fl.controls.TileList;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.ui.pulldown.PulldownMenu;
   import com.zynga.poker.UserPreferencesContainer;
   import flash.utils.Timer;
   import flash.display.DisplayObject;
   import flash.text.TextFormat;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import com.zynga.ui.tabBanner.TabBanner;
   import flash.geom.Point;
   import com.zynga.poker.lobby.events.view.LobbyAdContainerEvent;
   import com.zynga.ui.tabBanner.TabBannerEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import com.zynga.draw.CasinoSprite;
   import com.zynga.geom.Size;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.lobby.asset.WeeklyLeader;
   import com.zynga.text.HtmlTextBox;
   import com.zynga.poker.SSLMigration;
   import com.zynga.poker.controls.listClasses.SeatedPlayersImageCell;
   import com.zynga.poker.controls.listClasses.CustomCellBg;
   import fl.controls.ScrollBarDirection;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import com.zynga.text.GlowTextBox;
   import com.zynga.text.FontManager;
   import com.zynga.utils.ObjectUtil;
   import flash.events.Event;
   import com.zynga.utils.ExternalAssetManager;
   import com.zynga.poker.lobby.events.LVEvent;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import caurina.transitions.Tweener;
   import com.zynga.poker.constants.TableType;
   import com.zynga.events.UIComponentEvent;
   import com.zynga.poker.UnlockComponentsLevel;
   import fl.managers.StyleManager;
   import com.zynga.poker.lobby.skins.LobbyGridCell;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import fl.controls.dataGridClasses.DataGridColumn;
   import com.zynga.poker.lobby.skins.LobbyGridLockCell;
   import com.zynga.poker.lobby.skins.LobbyGridPlayersCell;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.poker.table.GiftLibrary;
   import fl.events.DataGridEvent;
   import fl.events.ListEvent;
   import com.zynga.rad.buttons.ZButtonEvent;
   import fl.controls.DataGrid;
   import com.zynga.poker.lobby.events.view.SortTablesEvent;
   import com.zynga.poker.lobby.events.view.TableSelectedEvent;
   import fl.controls.listClasses.CellRenderer;
   import flash.events.TimerEvent;
   import com.zynga.poker.lobby.events.view.CasinoSelectedEvent;
   import com.zynga.poker.shootout.ShootoutConfig;
   import com.zynga.poker.shootout.ShootoutUser;
   import com.zynga.poker.lobby.asset.PowerTournamentsHappyHourView;
   import fl.data.DataProvider;
   import flash.utils.Dictionary;
   import com.zynga.poker.events.MTTEvent;
   
   public class LobbyView extends MovieClip
   {
      
      public function LobbyView() {
         this.displayRestoreContainer = new Array();
         super();
      }
      
      public static const SHOOTOUT_HOWTOPLAYBUTTON_X:Number = 323;
      
      public static const SHOOTOUT_HOWTOPLAYBUTTON_Y:Number = 226;
      
      public static const WEEKLY_HOWTOPLAYBUTTON_X:Number = 200;
      
      public static const WEEKLY_HOWTOPLAYBUTTON_Y:Number = 220;
      
      public static const POWER_HOWTOPLAYBUTTON_X:Number = 309;
      
      public static const POWER_HOWTOPLAYBUTTON_Y:Number = 41;
      
      public static const POWERTOURNEY_TOASTER_NAME:String = "PowerTournamentsHappyHourToaster";
      
      public static const LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET:Number = 12;
      
      public static const LOBBY_LEARNTOPLAY_BUTTON_X:Number = 112;
      
      public static const LOBBY_LEARNTOPLAY_BUTTON_Y:Number = 70;
      
      public static const LOBBY_LEARNTOPLAY_BUTTON_WIDTH:Number = 176;
      
      public static const LOBBY_REFRESH_BUTTON_OFFSET_Y:Number = 7;
      
      public static const LOBBY_JOIN_BUTTON_OFFSET_Y:Number = 7;
      
      public var lobbyGridContainer:Sprite;
      
      public var lobbyGrid:LobbyGrid;
      
      public var lobbyGameSelector:LobbyGameSelector;
      
      public var mcLobby:MovieClip;
      
      public var lobbyPlayerInfo:LobbyPlayerInfo;
      
      public var userInfo:MovieClip;
      
      public var online:EmbeddedFontTextField;
      
      public var playerNum:EmbeddedFontTextField;
      
      public var mcPic:MovieClip;
      
      public var findSeatButton:MovieClip;
      
      public var bigFindSeatButton:ZButton;
      
      public var learnToPlayButton:MovieClip;
      
      public var playMTT:Sprite;
      
      private var zpwcTicket:MovieClip;
      
      private var zpwcSparkle:MovieClip;
      
      private var plModel:LobbyModel;
      
      public var atThisTable:LobbyGridAtThisTable;
      
      public var atThisTableParent:DisplayObjectContainer;
      
      public var atThisTableY:Number;
      
      private var shootoutLogoLoader:SafeImageLoader;
      
      private var shootoutPrizeTextField:EmbeddedFontTextField;
      
      private var shootoutRoundOneButton:LobbyShootoutRoundButton;
      
      private var shootoutRoundTwoButton:LobbyShootoutRoundButton;
      
      private var shootoutRoundThreeButton:LobbyShootoutRoundButton;
      
      public var clickedRoomId:int;
      
      public var casinoSelectorContainer:LobbyCasinoSelector;
      
      public var casinoSelector:MovieClip;
      
      public var hideLabel:TextField;
      
      public var hideFullTables:CheckBox;
      
      public var hideRunningTables:CheckBox;
      
      public var hideEmptyTables:CheckBox;
      
      public var casinoList:MovieClip;
      
      public var fastTableTypeTabs:MovieClip;
      
      public var normalSubTabLabel:EmbeddedFontTextField;
      
      public var fastSubTabLabel:EmbeddedFontTextField;
      
      public var buzzAd:BuzzAd;
      
      public var lobbyAdContainer:LobbyAdContainer;
      
      public var tabBannerController:TabBannerController;
      
      public var dfSeatedPlayers:DrawFrame;
      
      public var tlSeatedPlayers:TileList;
      
      public var dfBuzzBox:DrawFrame;
      
      public var tourneyViewMode:String;
      
      public var weekly:MovieClip;
      
      public var weeklySpinner:MovieClip;
      
      public var bIsShowingWeeklyLeaders:Boolean = false;
      
      private var _shootoutBadgeUrl:String = "";
      
      private var shootoutBadgeLoader:SafeImageLoader;
      
      private var _emptyChickletButton:MovieClip;
      
      private var _displayedGiftOnChicklet:MovieClip;
      
      private var _lobbyBackgroundUrl:String = "";
      
      private var lobbyBackgroundLoader:SafeAssetLoader;
      
      private var tooltip:Tooltip;
      
      private var tooltipParent:DisplayObjectContainer;
      
      public var lobbyStats:Boolean;
      
      public var tabsToHide:Array = null;
      
      private var minMaxBuyInLabel:EmbeddedFontTextField;
      
      private var roomSortDropDown:PulldownMenu;
      
      public var lockOverlay:MovieClip = null;
      
      private var unlockAtLevelTF:EmbeddedFontTextField;
      
      private var displayRestoreContainer:Array;
      
      public var userPreferencesContainer:UserPreferencesContainer;
      
      public var disableTutorial:Boolean = false;
      
      public var disableMultiTournament:Boolean = false;
      
      public var enablePremiumShootout:Boolean = false;
      
      public var enablePowerTourneyLobbyTab:Boolean = false;
      
      private var atThisTableSlowTimer:Timer;
      
      private var atThisTablePreviousRoom:int = -1;
      
      private var _highLowArrow:MovieClip;
      
      private var _highLowArrowEnabled:Boolean;
      
      private var _tableRebalFTUE:MovieClip;
      
      public var enableMTTSurfacing:Boolean;
      
      private var _hasClosedTableRebalFTUE:Boolean = false;
      
      public var shouldShowPowerTourneyTabToaster:Boolean = false;
      
      public var showHappyHourMarketting:Boolean = false;
      
      public var isCurrentlyHappyHour:Boolean = false;
      
      private var powerTourneyTabToaster:MovieClip;
      
      public var showZPWCLobbyArrow:Boolean = false;
      
      private var zpwcLobbyArrow:MovieClip;
      
      private var _resetPlayNowUserPreference:Boolean = false;
      
      private var _fastRibbonLabel:DisplayObject = null;
      
      private var _fastRibbonLabelDelayedVisible:Boolean = false;
      
      private var _videoPokerButton:ZButton;
      
      public var isLobbyRedesign:Boolean = false;
      
      private var _lobbyChromeHeightDefault:Number = 0;
      
      private var _lobbyJoinRoomButtonYDefault:Number = 0;
      
      public function preflight() : void {
         this.casinoSelectorContainer = new LobbyCasinoSelector();
         addChild(this.casinoSelectorContainer);
         this.casinoSelector = this.casinoSelectorContainer.assets;
         this.lobbyGameSelector = new LobbyGameSelector(!this.enablePremiumShootout || (this.enablePowerTourneyLobbyTab));
         addChild(this.lobbyGameSelector);
         this.mcLobby = this.lobbyGameSelector.assets;
         this.lobbyGridContainer = new Sprite();
         this.lobbyGrid = new LobbyGrid();
         this.lobbyGridContainer.addChild(this.lobbyGrid);
         addChild(this.lobbyGridContainer);
         this.hideLabel = new TextField();
         this.hideLabel.defaultTextFormat = new TextFormat("_sans",11);
         addChild(this.hideLabel);
         this.hideLabel.x = 63.1;
         this.hideLabel.y = 346;
         this.hideLabel.selectable = false;
         this.hideEmptyTables = new CheckBox();
         this.hideEmptyTables.textField.defaultTextFormat = new TextFormat("_sans",11);
         this.hideEmptyTables.enabled = true;
         this.hideEmptyTables.selected = true;
         this.hideEmptyTables.x = 125;
         this.hideEmptyTables.y = 344;
         addChild(this.hideEmptyTables);
         this.hideFullTables = new CheckBox();
         this.hideFullTables.textField.defaultTextFormat = new TextFormat("_sans",11);
         this.hideFullTables.enabled = true;
         this.hideFullTables.selected = true;
         this.hideFullTables.x = 185;
         this.hideFullTables.y = 344;
         addChild(this.hideFullTables);
         this.hideRunningTables = new CheckBox();
         this.hideRunningTables.textField.defaultTextFormat = new TextFormat("_sans",11);
         this.hideRunningTables.enabled = true;
         this.hideRunningTables.selected = true;
         this.hideRunningTables.visible = false;
         this.hideRunningTables.x = 176;
         this.hideRunningTables.y = 344;
         addChild(this.hideRunningTables);
         this.weeklySpinner = this.mcLobby.weekly_mc.loading_icon;
         this.mcLobby.weekly_mc.removeChild(this.weeklySpinner);
         this.lobbyPlayerInfo = new LobbyPlayerInfo(PokerGlobalData.instance.hideChangeCasinoButton);
         this.userInfo = this.lobbyPlayerInfo.assets;
         this.findSeatButton = PokerClassProvider.getObject("PlayNowButton");
         this.findSeatButton.x = 112;
         this.findSeatButton.y = 28;
         this.learnToPlayButton = PokerClassProvider.getObject("LearnToPlayButton") as MovieClip;
         this.learnToPlayButton.x = 112;
         this.learnToPlayButton.y = 70;
         this.online = new EmbeddedFontTextField("","CalibriBold",12,16777215,"center");
         this.online.x = 100;
         this.online.y = 6;
         this.online.width = 200;
         this.online.height = 20;
         this.bigFindSeatButton = PokerClassProvider.getObject("largePrimaryButton") as ZButton;
         this.bigFindSeatButton.x = 57;
         this.bigFindSeatButton.y = 18;
         this.bigFindSeatButton.width = 210;
         this.bigFindSeatButton.height = 55;
         this.bigFindSeatButton.init();
         this.bigFindSeatButton.text = "";
         if(!this.isLobbyRedesign)
         {
            addChild(this.lobbyPlayerInfo);
            addChild(this.findSeatButton);
            addChild(this.learnToPlayButton);
            addChild(this.online);
         }
         else
         {
            addChild(this.bigFindSeatButton);
            this.lobbyGameSelector.addNewTableSelectorAssetsToPage();
            this._lobbyChromeHeightDefault = this.mcLobby.lobbyChrome.height;
            this._lobbyJoinRoomButtonYDefault = this.mcLobby.joinRoom_btn.y;
            this.mcLobby.y = 94;
            this.lobbyGridContainer.y = this.lobbyGridContainer.y - LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET;
            this.hideLabel.y = this.hideLabel.y - LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET;
            this.hideRunningTables.y = this.hideRunningTables.y - LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET;
            this.hideFullTables.y = this.hideFullTables.y - LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET;
            this.hideEmptyTables.y = this.hideEmptyTables.y - LOBBY_REDESIGN_TABLE_SELECTOR_OFFSET;
            this.mcLobby.refresh_btn.y = this.mcLobby.refresh_btn.y + LOBBY_REFRESH_BUTTON_OFFSET_Y;
            this.adjustControlsLocation();
         }
      }
      
      public function initMTT(param1:Sprite) : void {
         this.playMTT = param1;
         addChildAt(this.playMTT,getChildIndex(this.learnToPlayButton));
         if(this.enableMTTSurfacing)
         {
            this.playMTT.visible = true;
            this.playMTT.addEventListener(MouseEvent.CLICK,this.onPlayMTTClick,false,0,true);
            this.playMTT.addEventListener(MouseEvent.MOUSE_OVER,this.onPlayMTTMouseOver,false,0,true);
            this.playMTT.addEventListener(MouseEvent.MOUSE_OUT,this.onPlayMTTMouseOut,false,0,true);
            this.learnToPlayButton.visible = false;
         }
         else
         {
            removeChild(this.playMTT);
            this.playMTT.visible = true;
            this.playMTT = null;
         }
      }
      
      public function initZPWC(param1:MovieClip, param2:MovieClip, param3:MovieClip) : void {
         var ticket:MovieClip = param1;
         var sparkle:MovieClip = param2;
         var tabBanner:MovieClip = param3;
         if(this.canShowZPWC())
         {
            this.zpwcTicket = ticket;
            this.zpwcTicket.width = this.zpwcTicket.width * 0.2;
            this.zpwcTicket.height = this.zpwcTicket.height * 0.2;
            this.zpwcTicket.rotation = -20;
            this.zpwcTicket.x = 290;
            this.zpwcTicket.y = 117;
            addChild(this.zpwcTicket);
            this.zpwcSparkle = sparkle;
            this.zpwcSparkle.width = this.zpwcSparkle.width * 0.3;
            this.zpwcSparkle.height = this.zpwcSparkle.height * 0.3;
            this.zpwcSparkle.x = 290;
            this.zpwcSparkle.y = 115;
            this.zpwcSparkle.addFrameScript(72,function():void
            {
               zpwcSparkle.gotoAndPlay(1);
            });
            addChild(this.zpwcSparkle);
            if(this.plModel.xpLevel > 5)
            {
               this.tabBannerController.addView(tabBanner as TabBanner,TabBanner.ZPWC);
            }
         }
      }
      
      public function initView(param1:LobbyModel, param2:Array=null, param3:Object=null) : void {
         this.plModel = param1;
         this.tabsToHide = param2;
         this.initLobbyUI();
         this.initUserInfo();
         this.loadPointGames();
         this.initSeatedPlayersGrid();
         this.initSeatedPlayers();
         this.setLobbyButtons(true);
         this.initWeekly();
         this.initLobbyAd(param3);
         this.initTabBanner();
         this.initUIListeners();
         this.casinoSelector.visible = false;
      }
      
      private function initLobbyAd(param1:Object=null) : void {
         if(!this.lobbyAdContainer)
         {
            this.lobbyAdContainer = new LobbyAdContainer();
            this.lobbyAdContainer.position = new Point(this.mcLobby.x,570 - (this.lobbyAdContainer.height + 44));
            this.lobbyAdContainer.addEventListener(LobbyAdContainerEvent.ON_AD_PRE_DISPLAY,this.onAdContainerPreDisplay,false,0,true);
            this.lobbyAdContainer.addEventListener(LobbyAdContainerEvent.ON_AD_DISPLAY,this.onAdContainerDisplay,false,0,true);
         }
         if(!this.lobbyAdContainer.urlInfoObject && (param1))
         {
            this.lobbyAdContainer.urlInfoObject = param1;
         }
         if((!contains(this.lobbyAdContainer)) && (this.lobbyAdContainer.adCount) && !this.isLobbyRedesign)
         {
            addChildAt(this.lobbyAdContainer,0);
         }
      }
      
      private function initTabBanner() : void {
         this.tabBannerController = new TabBannerController();
         this.tabBannerController.init(this);
         this.tabBannerController.addEventListener(TabBannerEvent.ZPWC_REDIRECT,this.onZPWCRedirect,false,0,true);
         this.tabBannerController.setActiveView(TabBanner.ZPWC);
      }
      
      private function onZPWCRedirect(param1:TabBannerEvent) : void {
         this.onZPWCClick(null);
      }
      
      public function showLobbyBanner() : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Lobby Other Impression o:LobbyBanner:2013-01-28"));
         this.tabBannerController.showView();
      }
      
      private function onAdContainerPreDisplay(param1:LobbyAdContainerEvent) : void {
         var _loc3_:PokerUIButton = null;
         var _loc4_:EmbeddedFontTextField = null;
         var _loc5_:EmbeddedFontTextField = null;
         var _loc6_:PokerUIButton = null;
         var _loc7_:EmbeddedFontTextField = null;
         var _loc8_:EmbeddedFontTextField = null;
         var _loc9_:PokerUIButton = null;
         var _loc10_:MovieClip = null;
         var _loc11_:EmbeddedFontTextField = null;
         var _loc2_:CasinoSprite = this.lobbyAdContainer.getAdForKey(param1.adNameKey);
         if(_loc2_.numChildren == 1)
         {
            if(param1.adNameKey == "ZPWC")
            {
               _loc3_ = new PokerUIButton();
               _loc3_.style = PokerUIButton.BUTTONSTYLE_SHINY;
               _loc3_.buttonSize = new Size(100,25);
               _loc3_.addEventListener(MouseEvent.CLICK,this.onBuzzboxZPWCClick,false,0,true);
               _loc3_.position = new Point(310,105);
               _loc4_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.zpwc.getStarted"),"Main",16,16777215,TextFormatAlign.CENTER);
               _loc4_.autoSize = TextFieldAutoSize.CENTER;
               _loc3_.width = _loc4_.textWidth + 20;
               _loc4_.x = (_loc3_.width >> 1) - (_loc4_.width >> 1);
               _loc4_.y = (_loc3_.height >> 1) - (_loc4_.height >> 1);
               _loc3_.addChild(_loc4_);
               _loc5_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.zpwc.lobbyAd"),"Main",14,16763904,TextFormatAlign.CENTER);
               _loc5_.wordWrap = true;
               _loc5_.width = 250;
               _loc5_.height = 80;
               _loc5_.x = 5;
               _loc5_.y = 70;
               _loc5_.filters = [new DropShadowFilter()];
               _loc2_.addChild(_loc3_);
               _loc2_.addChild(_loc5_);
               this.showZPWCMarketing();
            }
            else
            {
               if(param1.adNameKey == "MTT")
               {
                  _loc6_ = new PokerUIButton();
                  _loc6_.style = PokerUIButton.BUTTONSTYLE_SHINY;
                  _loc6_.buttonSize = new Size(130,26);
                  _loc6_.labelTextFormat = new TextFormat("Main",14,16777215,null,null,null,null,null,"center");
                  _loc6_.label = LocaleManager.localize("flash.lobby.mtt.registerNow");
                  _loc6_.addEventListener(MouseEvent.CLICK,this.onBuzzboxMTTClick,false,0,true);
                  _loc6_.position = new Point(55,75);
                  _loc7_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.mtt.lobbyAd"),"Main",24,16777215,TextFormatAlign.LEFT);
                  _loc7_.wordWrap = true;
                  _loc7_.width = 200;
                  _loc7_.height = 80;
                  _loc7_.x = _loc7_.y = 4;
                  _loc7_.filters = [new DropShadowFilter()];
                  _loc8_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.mtt.beta"),"Main",16,16763904,TextFormatAlign.LEFT);
                  _loc8_.width = 80;
                  _loc8_.height = 40;
                  _loc8_.x = 182;
                  _loc8_.y = 122;
                  _loc8_.filters = [new DropShadowFilter()];
                  _loc2_.addChild(_loc6_);
                  _loc2_.addChild(_loc7_);
                  _loc2_.addChild(_loc8_);
               }
               else
               {
                  if(param1.adNameKey == "Poker Genius")
                  {
                     _loc9_ = new PokerUIButton();
                     _loc9_.style = PokerUIButton.BUTTONSTYLE_SHINY;
                     _loc9_.buttonSize = new Size(100,30);
                     _loc9_.labelTextFormat = new TextFormat("Main",18,16777215);
                     _loc9_.label = LocaleManager.localize("flash.lobby.playNowButton");
                     _loc9_.addEventListener(MouseEvent.CLICK,this.onPokerGeniusAdClick,false,0,true);
                     _loc9_.position = new Point(125,105);
                     _loc2_.addChild(_loc9_);
                  }
                  else
                  {
                     if(param1.adNameKey == "Blackjack")
                     {
                        _loc10_ = PokerClassProvider.getObject("ScratchersPlayNowBtn");
                        _loc10_.x = 65;
                        _loc10_.y = this.lobbyAdContainer.containerSize.height - 25;
                        _loc11_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.playNowButton"),"Main",11,16777215,TextFormatAlign.CENTER);
                        _loc11_.autoSize = TextFieldAutoSize.CENTER;
                        _loc11_.x = _loc10_.x - _loc11_.width / 2;
                        _loc11_.y = _loc10_.y - _loc11_.height / 2;
                        _loc10_.width = _loc11_.textWidth + 20;
                        _loc2_.addChild(_loc10_);
                        _loc2_.addChild(_loc11_);
                        _loc2_.buttonMode = true;
                        _loc2_.useHandCursor = true;
                        _loc2_.addEventListener(MouseEvent.CLICK,this.onBlackjackAdClick,false,0,true);
                     }
                  }
               }
            }
         }
      }
      
      private function onAdContainerDisplay(param1:LobbyAdContainerEvent) : void {
         if(param1.adNameKey == "Poker Genius")
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PokerGenius:LobbyInit:2012-08-16"));
         }
         else
         {
            if(param1.adNameKey == "Blackjack")
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:Blackjack:LobbyUnit:2012-08-16"));
            }
         }
      }
      
      private function initWeekly() : void {
         var _loc16_:WeeklyLeader = null;
         var _loc17_:String = null;
         this.weekly = this.mcLobby.weekly_mc;
         var _loc1_:* = 10;
         var _loc2_:* = 130;
         var _loc3_:* = 95;
         var _loc4_:HtmlTextBox = new HtmlTextBox("Main","Current Potsize:",14,16777215,"left");
         _loc4_.y = _loc3_;
         _loc4_.x = _loc1_;
         _loc4_.name = "potSizeLabel";
         this.weekly.addChild(_loc4_);
         var _loc5_:HtmlTextBox = new HtmlTextBox("Main","$999,999,999",18,65331,"left");
         _loc5_.y = _loc3_ + 18;
         _loc5_.x = _loc1_;
         _loc5_.name = "potSize";
         this.weekly.addChild(_loc5_);
         var _loc6_:Array = [
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":"Your Rank: "
            },
            {
               "font":"Main",
               "color":16763904,
               "size":14,
               "text":"Top 20%"
            }];
         var _loc7_:HtmlTextBox = new HtmlTextBox("Main","",14,16777215,"left");
         _loc7_.updateHtmlText(HtmlTextBox.getHtmlString(_loc6_));
         _loc7_.y = _loc3_;
         _loc7_.x = _loc2_;
         _loc7_.name = "ranking";
         this.weekly.addChild(_loc7_);
         var _loc8_:Array = [
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":"Tourney Chips: "
            },
            {
               "font":"Main",
               "color":65331,
               "size":14,
               "text":"$999,999,999"
            }];
         var _loc9_:HtmlTextBox = new HtmlTextBox("Main","",14,16777215,"left");
         _loc9_.updateHtmlText(HtmlTextBox.getHtmlString(_loc8_));
         _loc9_.y = _loc3_ + 18;
         _loc9_.x = _loc2_;
         _loc9_.name = "tourneyChips";
         this.weekly.addChild(_loc9_);
         var _loc10_:HtmlTextBox = new HtmlTextBox("Main","5 of 10 Friends Left",14,16777215,"left");
         _loc10_.y = _loc3_ + 36;
         _loc10_.x = _loc2_;
         _loc10_.name = "friendsLeft";
         this.weekly.addChild(_loc10_);
         var _loc11_:HtmlTextBox = new HtmlTextBox("Main","Tell friends I\'m playing in the Tourney + share bonus",11,16777215,"left");
         _loc11_.y = _loc3_ + 60;
         _loc11_.x = _loc1_ + 20;
         _loc11_.name = "tellFriends";
         this.weekly.addChild(_loc11_);
         var _loc12_:HtmlTextBox = new HtmlTextBox("Main","",16,16777215,"center");
         var _loc13_:String = HtmlTextBox.getHtmlString([
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":"Get "
            },
            {
               "font":"Main",
               "color":52224,
               "size":14,
               "text":"$1,000 "
            },
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":"chips immediately\rand start playing now!"
            }]);
         _loc12_.updateHtmlText(_loc13_);
         _loc12_.x = 102;
         _loc12_.y = 93;
         _loc12_.name = "buyBackHead";
         this.weekly.addChild(_loc12_);
         var _loc14_:HtmlTextBox = new HtmlTextBox("Main","Texas Hold\'em Poker chips provide entertainment value only and are not refundable, exchangeable, replaceable, redeemable or transferable for real-world funds or prizes under any circumstances.",11,16777215,"left",true,true,false,280);
         _loc14_.x = 10;
         _loc14_.y = 110;
         _loc14_.name = "buyBackDisc";
         this.weekly.addChild(_loc14_);
         var _loc15_:* = 0;
         while(_loc15_ < 3)
         {
            _loc16_ = new WeeklyLeader(_loc15_ + 1);
            _loc17_ = "http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png";
            _loc16_.loadData("Player #" + (_loc15_ + 1).toString(),"$560.3K",SSLMigration.getSecureURL(_loc17_));
            _loc16_.y = _loc15_ * 42 + 4;
            _loc16_.x = 3;
            _loc16_.name = _loc15_.toString();
            this.weekly.leaders.addChild(_loc16_);
            _loc15_++;
         }
      }
      
      private function initSeatedPlayers() : void {
         this.dfSeatedPlayers = new DrawFrame(201,120,true,false);
         this.dfSeatedPlayers.renderTitle(LocaleManager.localize("flash.lobby.seatedPlayersLabel"));
         this.dfSeatedPlayers.x = 64;
         this.dfSeatedPlayers.y = 396;
         var _loc1_:EmbeddedFontTextField = new EmbeddedFontTextField("","MainLight",11,16777215,"right");
         _loc1_.name = "tableName";
         _loc1_.width = 100;
         _loc1_.x = 100;
         _loc1_.y = -18;
         _loc1_.multiline = false;
      }
      
      private function initSeatedPlayersGrid() : void {
         this.tlSeatedPlayers = new TileList();
         this.tlSeatedPlayers.setStyle("cellRenderer",SeatedPlayersImageCell);
         this.tlSeatedPlayers.setStyle("contentPadding",0);
         this.tlSeatedPlayers.setStyle("skin",CustomCellBg);
         this.tlSeatedPlayers.columnWidth = 201;
         this.tlSeatedPlayers.rowHeight = 36;
         this.tlSeatedPlayers.columnCount = 0;
         this.tlSeatedPlayers.width = 201;
         this.tlSeatedPlayers.height = 120;
         this.tlSeatedPlayers.direction = ScrollBarDirection.VERTICAL;
      }
      
      private function initLobbyUI() : void {
         var _loc7_:URLRequest = null;
         var _loc8_:LoaderContext = null;
         var _loc9_:SafeImageLoader = null;
         var _loc10_:EmbeddedFontTextField = null;
         var _loc11_:String = null;
         var _loc12_:GlowTextBox = null;
         if(FontManager.minFontSize > 11)
         {
            this.hideLabel.defaultTextFormat = new TextFormat("_sans",FontManager.minFontSize);
            this.hideEmptyTables.textField.defaultTextFormat = new TextFormat("_sans",FontManager.minFontSize);
            this.hideFullTables.textField.defaultTextFormat = new TextFormat("_sans",FontManager.minFontSize);
            this.hideRunningTables.textField.defaultTextFormat = new TextFormat("_sans",FontManager.minFontSize);
         }
         this.hideLabel.text = LocaleManager.localize("flash.lobby.gameSelector.hideLabel");
         this.hideLabel.autoSize = TextFieldAutoSize.LEFT;
         this.hideEmptyTables.label = LocaleManager.localize("flash.lobby.gameSelector.hideEmptyTablesLabel");
         this.hideEmptyTables.x = this.hideLabel.x + this.hideLabel.textWidth + (this.hideLabel.text.length > 15?2:10);
         this.hideFullTables.label = LocaleManager.localize("flash.lobby.gameSelector.hideFullTablesLabel");
         this.hideFullTables.x = this.hideEmptyTables.x + this.hideEmptyTables.textField.textWidth + (this.hideLabel.text.length > 15?27:35);
         this.hideRunningTables.label = LocaleManager.localize("flash.lobby.gameSelector.hideRunningTablesLabel");
         this.hideRunningTables.x = this.hideEmptyTables.x + this.hideEmptyTables.textField.textWidth + (this.hideLabel.text.length > 15?27:35);
         this.mcLobby.mcTournTabOff.buttonMode = true;
         this.mcLobby.mcPrivateTabOff.buttonMode = true;
         this.mcLobby.mcPointsTabOff.buttonMode = true;
         this.mcLobby.mcPremiumTabOff.buttonMode = true;
         this.mcLobby.mcPremiumTabOff.visible = (this.enablePremiumShootout) && (this.enablePowerTourneyLobbyTab);
         this.mcLobby.joinRoom_btn.buttonMode = true;
         this.mcLobby.createRoom_btn.buttonMode = true;
         this.mcLobby.refresh_btn.buttonMode = true;
         this.mcLobby.shootoutSubTab.buttonMode = true;
         this.mcLobby.shootoutSubTab.mouseChildren = false;
         this.mcLobby.sitngoSubTab.buttonMode = true;
         this.mcLobby.sitngoSubTab.mouseChildren = false;
         this.mcLobby.weeklySubTab.buttonMode = true;
         this.mcLobby.weeklySubTab.mouseChildren = false;
         if((this._highLowArrowEnabled) && this._highLowArrow == null)
         {
            this.initHighLowArrow();
         }
         var _loc1_:MovieClip = PokerClassProvider.getObject("EnterRoundButton");
         _loc1_.name = "enterRoundButton";
         _loc1_.x = this.mcLobby.buyin_btn.x;
         _loc1_.y = this.mcLobby.buyin_btn.y;
         var _loc2_:HtmlTextBox = new HtmlTextBox("Main","Play Round 1",20,16777215,"center");
         _loc2_.name = "enterRoundButtonText";
         _loc2_.x = Math.round(_loc1_.width) / 2;
         _loc2_.y = Math.round(_loc2_.height) / 2;
         _loc1_.addChild(_loc2_);
         if((this.mcLobby.buyin_btn) && (this.mcLobby.contains(this.mcLobby.buyin_btn)))
         {
            this.mcLobby.removeChild(this.mcLobby.buyin_btn);
         }
         this.mcLobby.buyin_btn = _loc1_;
         this.mcLobby.addChild(_loc1_);
         this.mcLobby.buyin_btn.buttonMode = true;
         this.mcLobby.buyin_btn.mouseChildren = false;
         this.mcLobby.buyin_btn.gotoAndStop(1);
         var _loc3_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.playNowButton"),"Main",20,16777215,"center",true);
         _loc3_.name = "lblLobbyPlayNowButton";
         if(this.isLobbyRedesign)
         {
            _loc3_.width = 170;
            _loc3_.height = 26;
            _loc3_.x = 0;
            _loc3_.y = 8;
            _loc3_.scaleX = 1.235;
            this.bigFindSeatButton.addChild(_loc3_);
         }
         else
         {
            _loc3_.width = 175;
            _loc3_.height = 26;
            _loc3_.x = 0;
            _loc3_.y = 4;
            this.findSeatButton.buttonObj.addChild(_loc3_);
         }
         if(this.plModel.configModel.isFeatureEnabled("videoPoker"))
         {
            this.initVideoPokerEntryPoint();
         }
         var _loc4_:String = ObjectUtil.maybeGetString(this.plModel.lobbyConfig,"playNowFastRibbonImg",null);
         if(_loc4_)
         {
            _loc7_ = new URLRequest(_loc4_);
            _loc8_ = new LoaderContext();
            _loc8_.checkPolicyFile = true;
            _loc9_ = new SafeImageLoader(SafeAssetLoader.DEFAULT_PROFILE_IMAGE_URL);
            _loc9_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._onPlayNowFastRibbonLoaded);
            _loc9_.load(_loc7_,_loc8_);
         }
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.shootout.bonusPrizeLabel"),"Main",13,15452160,"center");
         _loc5_.name = "bonusPrizeLabel";
         _loc5_.width = 120;
         _loc5_.x = -5;
         _loc5_.y = -19;
         this.mcLobby.shootout_mc.badgeContainer.addChild(_loc5_);
         this.mcLobby.shootout_mc.badgeContainer.visible = false;
         this.mcLobby.shootout_mc.learnmore_btn.visible = false;
         this.mcLobby.howToPlayButton.x = SHOOTOUT_HOWTOPLAYBUTTON_X;
         this.mcLobby.howToPlayButton.y = SHOOTOUT_HOWTOPLAYBUTTON_Y;
         var _loc6_:String = ExternalAssetManager.getUrl("logoShootoutLobby");
         if(_loc6_)
         {
            this.shootoutLogoLoader = new SafeImageLoader();
            this.shootoutLogoLoader.x = -230;
            this.shootoutLogoLoader.y = -98;
            this.mcLobby.shootout_mc.addChild(this.shootoutLogoLoader);
            this.shootoutLogoLoader.load(new URLRequest(_loc6_));
         }
         this.shootoutPrizeTextField = new EmbeddedFontTextField("","Impact",26,16768256,"center");
         this.shootoutPrizeTextField.autoSize = TextFieldAutoSize.LEFT;
         this.shootoutPrizeTextField.height = 40;
         this.shootoutPrizeTextField.y = -72;
         this.shootoutPrizeTextField.width = 300;
         this.mcLobby.shootout_mc.addChild(this.shootoutPrizeTextField);
         if(this.shootoutPrizeTextField.embedFonts)
         {
            this.shootoutPrizeTextField.filters = [new DropShadowFilter()];
         }
         this.shootoutRoundOneButton = new LobbyShootoutRoundButton(1,LobbyShootoutRoundButton.STATUS_BUY_IN,2000);
         this.shootoutRoundOneButton.x = -232;
         this.shootoutRoundOneButton.y = -39;
         this.mcLobby.shootout_mc.addChild(this.shootoutRoundOneButton);
         this.shootoutRoundOneButton.playButton.addEventListener(MouseEvent.CLICK,this.onShootoutRoundButtonClick,false,0,true);
         this.shootoutRoundTwoButton = new LobbyShootoutRoundButton(2,LobbyShootoutRoundButton.STATUS_SKIP);
         this.shootoutRoundTwoButton.x = -135;
         this.shootoutRoundTwoButton.y = -39;
         this.mcLobby.shootout_mc.addChild(this.shootoutRoundTwoButton);
         this.shootoutRoundTwoButton.playButton.addEventListener(MouseEvent.CLICK,this.onShootoutRoundButtonClick,false,0,true);
         this.shootoutRoundThreeButton = new LobbyShootoutRoundButton(3,LobbyShootoutRoundButton.STATUS_SKIP);
         this.shootoutRoundThreeButton.x = -39;
         this.shootoutRoundThreeButton.y = -39;
         this.mcLobby.shootout_mc.addChild(this.shootoutRoundThreeButton);
         this.shootoutRoundThreeButton.playButton.addEventListener(MouseEvent.CLICK,this.onShootoutRoundButtonClick,false,0,true);
         if(!this.enableMTTSurfacing)
         {
            this.learnToPlayButton.visible = this.canShowLearnToPlayButton();
            this.learnToPlayButton.buttonMode = true;
            _loc10_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.learnToPlayButton"),"Main",14,16777215,"center");
            _loc10_.name = "learnToPlayButtonLabel";
            _loc10_.width = 175;
            _loc10_.height = 26;
            _loc10_.y = 3;
            this.learnToPlayButton.addChild(_loc10_);
            this.learnToPlayButton.addEventListener(MouseEvent.CLICK,this.onLearnToPlayButtonClick,false,0,true);
            if(this.playMTT)
            {
               this.playMTT.visible = false;
            }
         }
         if(this.userPreferencesContainer)
         {
            this.minMaxBuyInLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.minMaxBuyInLabel"),"Main",12);
            this.minMaxBuyInLabel.name = "minMaxBuyInLabel";
            this.minMaxBuyInLabel.x = 4;
            this.minMaxBuyInLabel.y = 28;
            this.minMaxBuyInLabel.visible = false;
            this.mcLobby.addChild(this.minMaxBuyInLabel);
            this.roomSortDropDown = new PulldownMenu(136,18,20);
            this.roomSortDropDown.dataProvider = this.getLobbyStakesList(this.plModel.lobbyGridData);
            this.roomSortDropDown.x = this.mcLobby.x + this.minMaxBuyInLabel.x + this.minMaxBuyInLabel.width;
            this.roomSortDropDown.y = this.mcLobby.y + 28;
         }
         this.fastTableTypeTabs = PokerClassProvider.getObject("GameSelectorSubTabs");
         if(this.roomSortDropDown)
         {
            this.fastTableTypeTabs.x = this.roomSortDropDown.x + this.roomSortDropDown.width - this.fastTableTypeTabs.width / 2 + 32;
         }
         else
         {
            this.fastTableTypeTabs.x = 10;
         }
         this.fastTableTypeTabs.y = 30;
         this.fastTableTypeTabs.left.buttonMode = true;
         this.fastTableTypeTabs.left.mouseChildren = false;
         this.fastTableTypeTabs.right.buttonMode = true;
         this.fastTableTypeTabs.right.mouseChildren = false;
         this.fastTableTypeTabs.left.gotoAndStop("active");
         this.fastTableTypeTabs.right.gotoAndStop("inactive");
         this.normalSubTabLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.normalSubTab"),"MainSemi",11,16777215,"center");
         this.normalSubTabLabel.name = "normalSubTabLabel";
         this.normalSubTabLabel.autoSize = TextFieldAutoSize.LEFT;
         this.normalSubTabLabel.width = this.normalSubTabLabel.width + 1;
         this.normalSubTabLabel.x = Math.round((this.fastTableTypeTabs.left.width - this.normalSubTabLabel.width) / 2);
         this.normalSubTabLabel.y = Math.round((this.fastTableTypeTabs.left.height - this.normalSubTabLabel.height) / 2);
         this.fastTableTypeTabs.left.labelContainer.addChild(this.normalSubTabLabel);
         this.fastSubTabLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.fastSubTab"),"MainSemi",11,0,"center");
         this.fastSubTabLabel.name = "fastSubTabLabel";
         this.fastSubTabLabel.autoSize = TextFieldAutoSize.LEFT;
         this.fastSubTabLabel.x = Math.round((this.fastTableTypeTabs.right.width - this.fastSubTabLabel.width) / 2);
         this.fastSubTabLabel.y = Math.round((this.fastTableTypeTabs.right.height - this.fastSubTabLabel.height) / 2);
         this.fastTableTypeTabs.right.labelContainer.addChild(this.fastSubTabLabel);
         this.fastTableTypeTabs.left.addEventListener(MouseEvent.CLICK,this.onFastTableTypeTabsClick,false,0,true);
         this.fastTableTypeTabs.right.addEventListener(MouseEvent.CLICK,this.onFastTableTypeTabsClick,false,0,true);
         this.fastTableTypeTabs.right.addEventListener(MouseEvent.MOUSE_OVER,this.onFastTableTypeTabsMouseOver,false,0,true);
         this.fastTableTypeTabs.right.addEventListener(MouseEvent.MOUSE_OUT,this.onFastTableTypeTabsMouseOut,false,0,true);
         this.mcLobby.addChild(this.fastTableTypeTabs);
         this.initLobbyDataGridUI();
         if(this.tabsToHide)
         {
            for each (_loc15_ in this.tabsToHide)
            {
               switch(_loc11_)
               {
                  case "tournaments":
                     this.mcLobby.mcTournTabOn.visible = false;
                     this.mcLobby.mcTournTabOff.visible = false;
                     continue;
                  default:
                     continue;
               }
               
            }
         }
         if(this.plModel.tabsGlowingTags)
         {
            _loc12_ = null;
            if(this.plModel.tabsGlowingTags["holdem"])
            {
               if(!this.mcLobby.mcPointsTabOn.getChildByName("glowText"))
               {
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["holdem"]);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcPointsTabOn.addChild(_loc12_);
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["holdem"]);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcPointsTabOff.addChild(_loc12_);
               }
            }
            if(this.plModel.tabsGlowingTags["tournaments"])
            {
               if(!this.mcLobby.mcTournTabOn.getChildByName("glowText"))
               {
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["tournaments"],"Main",11,16777215,16711680,-16,0,4);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcTournTabOn.addChild(_loc12_);
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["tournaments"],"Main",11,16777215,16711680,-16,0,4);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcTournTabOff.addChild(_loc12_);
               }
            }
            if(this.plModel.tabsGlowingTags["private"])
            {
               if(!this.mcLobby.mcPrivateTabOn.getChildByName("glowText"))
               {
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["private"]);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcPrivateTabOn.addChild(_loc12_);
                  _loc12_ = new GlowTextBox(this.plModel.tabsGlowingTags["private"]);
                  _loc12_.name = "glowText";
                  this.mcLobby.mcPrivateTabOff.addChild(_loc12_);
               }
            }
         }
         this.showHappyHourMarketing();
      }
      
      private function showZPWCMarketing() : void {
         var _loc1_:EmbeddedFontTextField = null;
         if(this.showZPWCLobbyArrow)
         {
            this.zpwcLobbyArrow = PokerClassProvider.getObject("ZPWCLobbyArrow");
            _loc1_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.zpwc.arrow"),"Main",14,0,"left",false);
            _loc1_.width = 150;
            _loc1_.wordWrap = false;
            _loc1_.fitInWidth(140,10);
            _loc1_.x = (this.zpwcLobbyArrow.width - _loc1_.width) / 2;
            _loc1_.y = this.zpwcLobbyArrow.height / 2 - 14;
            this.zpwcLobbyArrow.x = 500;
            this.zpwcLobbyArrow.y = 420;
            this.zpwcLobbyArrow.closeButton.addEventListener(MouseEvent.CLICK,this.removeZPWCArrow,false,0,true);
            this.zpwcLobbyArrow.addEventListener(MouseEvent.CLICK,this.onZPWCArrowClick,false,0,true);
            this.zpwcLobbyArrow.addChild(_loc1_);
            this.zpwcLobbyArrow.buttonMode = true;
            dispatchEvent(new LVEvent(LVEvent.ADD_VIEW_TO_LAYER,
               {
                  "view":this.zpwcLobbyArrow,
                  "layer":PokerControllerLayers.MTT_LAYER
               }));
            this.showZPWCLobbyArrow = false;
            this.bounceArrowOut();
         }
      }
      
      public function removeZPWCArrow(param1:MouseEvent=null) : void {
         if((this.zpwcLobbyArrow) && !(this.zpwcLobbyArrow.parent == null))
         {
            removeEventListener(MouseEvent.CLICK,this.onZPWCArrowClick,false);
            removeEventListener(MouseEvent.CLICK,this.removeZPWCArrow,false);
            Tweener.removeTweens(this.zpwcLobbyArrow);
            this.zpwcLobbyArrow.parent.removeChild(this.zpwcLobbyArrow);
         }
      }
      
      private function bounceArrowIn(param1:Number=0) : void {
         if(param1 <= 10)
         {
            Tweener.addTween(this.zpwcLobbyArrow,
               {
                  "x":500,
                  "time":1.5,
                  "onComplete":this.bounceArrowOut,
                  "onCompleteParams":[param1 + 1.5],
                  "transition":"easeInOutSine"
               });
         }
         else
         {
            this.removeZPWCArrow();
         }
      }
      
      private function bounceArrowOut(param1:Number=0) : void {
         if(param1 <= 10)
         {
            Tweener.addTween(this.zpwcLobbyArrow,
               {
                  "x":500 + 25,
                  "time":1.5,
                  "onComplete":this.bounceArrowIn,
                  "onCompleteParams":[param1 + 1.5],
                  "transition":"easeInOutSine"
               });
         }
         else
         {
            this.removeZPWCArrow();
         }
      }
      
      private function showHappyHourMarketing() : void {
         var _loc1_:String = null;
         var _loc2_:EmbeddedFontTextField = null;
         var _loc3_:GlowTextBox = null;
         var _loc4_:GlowTextBox = null;
         if(this.shouldShowPowerTourneyTabToaster)
         {
            this.powerTourneyTabToaster = PokerClassProvider.getObject(POWERTOURNEY_TOASTER_NAME);
            _loc1_ = "Main";
            _loc2_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.toaster"),_loc1_,12,16777215,"left",false);
            _loc2_.width = 200;
            _loc2_.x = 4;
            _loc2_.y = 8;
            _loc2_.wordWrap = true;
            _loc2_.fitInWidth(190,10);
            this.powerTourneyTabToaster.name = POWERTOURNEY_TOASTER_NAME;
            this.powerTourneyTabToaster.x = this.mcLobby.x + this.mcLobby.mcTournTabOff.x + 4;
            this.powerTourneyTabToaster.y = this.mcLobby.y + this.mcLobby.mcTournTabOff.y - this.powerTourneyTabToaster.height;
            this.powerTourneyTabToaster.addEventListener(MouseEvent.CLICK,this.onHappyHourToasterClick,false,0,true);
            this.powerTourneyTabToaster.addChild(_loc2_);
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PowerTourneyHappyHour:Toaster:2012-10-09"));
            this.shouldShowPowerTourneyTabToaster = false;
         }
         else
         {
            if(!PokerGlobalData.instance.enableMTT && (this.showHappyHourMarketting))
            {
               if(!this.mcLobby.mcTournTabOn.getChildByName("newHappyHourStarburstOn"))
               {
                  _loc3_ = new GlowTextBox(LocaleManager.localize("flash.global.new"));
                  _loc3_.name = "newHappyHourStarburstOn";
                  _loc3_.y = 7;
                  _loc4_ = new GlowTextBox(LocaleManager.localize("flash.global.new"));
                  _loc4_.name = "newHappyHourStarburstOff";
                  _loc4_.y = 7;
                  this.mcLobby.mcTournTabOn.addChild(_loc3_);
                  this.mcLobby.mcTournTabOff.addChild(_loc4_);
               }
            }
         }
      }
      
      private function onZPWCArrowClick(param1:MouseEvent=null) : void {
         if(this.zpwcLobbyArrow.parent != null)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click ZPWCArrow o:LobbyUI:2013-1-28"));
            removeEventListener(MouseEvent.CLICK,this.onZPWCArrowClick,false);
            removeEventListener(MouseEvent.CLICK,this.removeZPWCArrow,false);
            this.onZPWCClick(null);
         }
      }
      
      private function onHappyHourToasterClick(param1:MouseEvent=null) : void {
         this.powerTourneyTabToaster = getChildByName(POWERTOURNEY_TOASTER_NAME) as MovieClip;
         removeEventListener(MouseEvent.CLICK,this.onHappyHourToasterClick,false);
         if(this.powerTourneyTabToaster)
         {
            removeChild(this.powerTourneyTabToaster);
         }
         this.showHappyHourMarketing();
      }
      
      private function canShowLearnToPlayButton() : Boolean {
         return !this.disableTutorial && (!this.tabsToHide || this.tabsToHide.indexOf("learnToPlay") == 0);
      }
      
      private function canShowMTT() : Boolean {
         return (this.enableMTTSurfacing) && this.plModel.xpLevel > 7;
      }
      
      private function canShowZPWC() : Boolean {
         return PokerGlobalData.instance.enableZPWC;
      }
      
      public function applyUserPreferences() : void {
         var _loc1_:* = false;
         var _loc2_:* = 0;
         var _loc3_:String = null;
         var _loc4_:* = false;
         if(this.userPreferencesContainer)
         {
            _loc1_ = ObjectUtil.maybeGetBoolean(this.plModel.lobbyConfig,"setToFastTables",false);
            if(!this._resetPlayNowUserPreference && (_loc1_))
            {
               this._resetPlayNowUserPreference = true;
               this.plModel.filterTableType = TableType.FAST;
               this.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.TABLE_TYPE,TableType.FAST);
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:PlayNow:SetToFast:2013-05-13"));
            }
            _loc2_ = ObjectUtil.maybeGetInt(this.plModel.lobbyConfig,"playNowFastTables",0);
            if(_loc2_ == 5 || this.userPreferencesContainer.tableTypeValue == TableType.FAST)
            {
               if(_loc2_ > 2)
               {
                  this._showPlayNowFastRibbon();
               }
               if(this.userPreferencesContainer.tableTypeValue == TableType.FAST)
               {
                  this.onFastTableTypeTabsClick(null,"right");
               }
            }
            if(!(this.userPreferencesContainer.normalFilterValue == "") && !(this.userPreferencesContainer.fastFilterValue == ""))
            {
               _loc3_ = this.plModel.filterTableType == TableType.NORMAL?this.userPreferencesContainer.normalFilterValue:this.userPreferencesContainer.fastFilterValue;
               _loc4_ = false;
               _loc3_ = _loc3_ == "default"?"All":_loc3_;
               if(this.roomSortDropDown)
               {
                  if(this.roomSortDropDown.setSelected(_loc3_))
                  {
                     _loc4_ = true;
                  }
                  else
                  {
                     if(this.roomSortDropDown.setSelected("All"))
                     {
                        _loc3_ = "All";
                        _loc4_ = true;
                     }
                  }
                  if(_loc4_)
                  {
                     this.onMinMaxFilterKeySelected(new UIComponentEvent(UIComponentEvent.ON_UICOMPONENT_CLICK,_loc3_));
                  }
               }
            }
            dispatchEvent(new LVEvent(LVEvent.REFRESH_LOBBY_ROOMS));
         }
      }
      
      public function get lobbyBackgroundUrl() : String {
         return this._lobbyBackgroundUrl;
      }
      
      public function set lobbyBackgroundUrl(param1:String) : void {
         if(this._lobbyBackgroundUrl != param1)
         {
            this._lobbyBackgroundUrl = param1;
            if(this._lobbyBackgroundUrl)
            {
               if(this.lobbyBackgroundLoader == null)
               {
                  this.lobbyBackgroundLoader = new SafeAssetLoader();
                  addChildAt(this.lobbyBackgroundLoader,0);
               }
               this.lobbyBackgroundLoader.load(new URLRequest(this._lobbyBackgroundUrl));
            }
            else
            {
               if(this.lobbyBackgroundLoader != null)
               {
                  removeChild(this.lobbyBackgroundLoader);
                  this.lobbyBackgroundLoader = null;
               }
            }
         }
      }
      
      private function onShootoutRoundButtonClick(param1:MouseEvent) : void {
         var _loc2_:LobbyShootoutRoundButton = param1.currentTarget.parent as LobbyShootoutRoundButton;
         if(_loc2_)
         {
            switch(_loc2_.status)
            {
               case LobbyShootoutRoundButton.STATUS_SKIP:
                  dispatchEvent(new LVEvent(LVEvent.SKIP_SHOOTOUT_ROUND_CLICK,{"targetRound":_loc2_.round}));
                  break;
               case LobbyShootoutRoundButton.STATUS_BUY_IN:
               case LobbyShootoutRoundButton.STATUS_ELIGIBLE:
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Shootout Other Click o:ShootoutPlayButtonRound" + _loc2_.round + ":2014-03-04"));
                  dispatchEvent(new LVEvent(LVEvent.BUYIN_CLICK));
                  break;
            }
            
         }
      }
      
      private function onShootoutSponsoredButtonClick(param1:MouseEvent) : void {
         var _loc2_:LobbyShootoutRoundButton = param1.currentTarget.parent as LobbyShootoutRoundButton;
         if(_loc2_)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Shootout Other Click o:ShootoutSponsorshipRequest:2010-12-16"));
            switch(_loc2_.sponsoredStatus)
            {
               case LobbyShootoutRoundButton.SPONSORED_STATUS_GET_SPONSOR:
                  dispatchEvent(new LVEvent(LVEvent.REQUEST_SPONSORED_SHOOTOUTS,
                     {
                        "sponsorShootoutsAccepted":this.plModel.sponsorShootoutsAccepted,
                        "sponsorShootoutsTotal":this.plModel.sponsorShootoutsTotal
                     }));
                  break;
               case LobbyShootoutRoundButton.SPONSORED_STATUS_CLAIM:
                  dispatchEvent(new LVEvent(LVEvent.CLAIM_SPONSORED_SHOOTOUTS,{}));
                  break;
               case LobbyShootoutRoundButton.SPONSORED_STATUS_CLAIMED:
                  break;
            }
            
         }
      }
      
      private function onFastTableTypeTabsClick(param1:MouseEvent, param2:String="") : void {
         var _loc3_:String = null;
         if(param2 != "")
         {
            _loc3_ = param2;
         }
         else
         {
            _loc3_ = param1.currentTarget.name;
         }
         var _loc4_:int = ObjectUtil.maybeGetInt(this.plModel.lobbyConfig,"playNowFastTables",0);
         switch(_loc3_)
         {
            case "right":
               if(this.fastTableTypeTabs.right.currentLabel == "inactive")
               {
                  this.fastTableTypeTabs.left.gotoAndStop("inactive");
                  this.fastTableTypeTabs.right.gotoAndStop("active");
                  this.normalSubTabLabel.fontColor = 0;
                  this.fastSubTabLabel.fontColor = 16777215;
                  this.plModel.filterTableType = TableType.FAST;
                  if(_loc4_ > 2)
                  {
                     this._showPlayNowFastRibbon();
                  }
                  if((this.userPreferencesContainer) && (this.userPreferencesContainer.getHasAppliedPreferences()))
                  {
                     if(this.userPreferencesContainer.everFiltered == "0")
                     {
                        this.userPreferencesContainer.everFiltered = "1";
                     }
                     this.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.TABLE_TYPE,this.plModel.filterTableType);
                  }
                  if(this.plModel.newbieMaxLevel <= 0)
                  {
                     this.plModel.newbieMaxLevel = UnlockComponentsLevel.fastTables;
                  }
                  dispatchEvent(new LVEvent(LVEvent.FAST_TABLES_SELECTED));
                  if(this.lobbyStats == true)
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click FastTableTab o:LobbyUI:2010-04-08"));
                     PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyClickFastTableTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click FastTableTabOnce o:LobbyUI:2010-04-08"));
                  }
               }
               break;
            case "left":
               if(this.fastTableTypeTabs.left.currentLabel == "inactive")
               {
                  this.fastTableTypeTabs.left.gotoAndStop("active");
                  this.fastTableTypeTabs.right.gotoAndStop("inactive");
                  this.normalSubTabLabel.fontColor = 16777215;
                  this.fastSubTabLabel.fontColor = 0;
                  this.plModel.filterTableType = TableType.NORMAL;
                  if(_loc4_ < 5)
                  {
                     this._hidePlayNowFastRibbon();
                  }
                  if((this.userPreferencesContainer) && (this.userPreferencesContainer.getHasAppliedPreferences()))
                  {
                     if(this.userPreferencesContainer.everFiltered == "0")
                     {
                        this.userPreferencesContainer.everFiltered = "1";
                     }
                     this.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.TABLE_TYPE,this.plModel.filterTableType);
                  }
                  dispatchEvent(new LVEvent(LVEvent.NORMAL_TABLES_SELECTED));
                  if(this.lobbyStats == true)
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Click NormalTableTab o:LobbyUI:2010-04-08"));
                     PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyClickNormalTableTabOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Click NormalTableTabOnce o:LobbyUI:2010-04-08"));
                  }
               }
               break;
         }
         
         if((this.roomSortDropDown) && this.plModel.sLobbyMode == "challenge")
         {
            this.refreshRoomFilterDropDown();
         }
      }
      
      private function onFastTableTypeTabsMouseOver(param1:MouseEvent) : void {
         var _loc2_:Number = 220;
         var _loc3_:Number = this.fastTableTypeTabs.right.x + this.fastTableTypeTabs.right.width / 2 - _loc2_ / 2;
         var _loc4_:Number = this.fastTableTypeTabs.right.y + 32;
         var _loc5_:Point = this.globalToLocal(this.fastTableTypeTabs.localToGlobal(new Point(_loc3_,_loc4_)));
         _loc3_ = _loc5_.x;
         _loc4_ = _loc5_.y;
         this.showTooltip(LocaleManager.localize("flash.lobby.gameSelector.subTabs.subTab.tip"),_loc2_,_loc3_,_loc4_);
      }
      
      private function onFastTableTypeTabsMouseOut(param1:MouseEvent) : void {
         this.hideTooltip();
      }
      
      private function onRoomSortDropdownMouseOver(param1:MouseEvent) : void {
         var _loc2_:Number = 220;
         var _loc3_:Number = this.roomSortDropDown.x + this.roomSortDropDown.width / 2 - _loc2_ / 2;
         var _loc4_:Number = this.roomSortDropDown.y - 56;
         this.showTooltip(LocaleManager.localize("flash.lobby.minMaxFilterDropdown.tooltip"),_loc2_,_loc3_,_loc4_);
      }
      
      private function onRoomSortDropdownMouseOut(param1:MouseEvent) : void {
         this.hideTooltip();
      }
      
      private function onPlayMTTMouseOver(param1:MouseEvent) : void {
         var _loc2_:Number = 220;
         var _loc3_:Number = this.playMTT.x + this.playMTT.width / 2 - _loc2_ / 2;
         var _loc4_:Number = this.playMTT.y + 32;
         this.showTooltip(LocaleManager.localize("flash.lobby.playInMultiTournamentButton.tooltip"),_loc2_,_loc3_,_loc4_,500);
      }
      
      private function onPlayMTTMouseOut(param1:MouseEvent) : void {
         this.hideTooltip();
      }
      
      private function initLobbyDataGridUI() : void {
         this.lobbyGrid.setStyle("headerUpSkin","lobbyGridHeader_upSkin");
         this.lobbyGrid.headerHeight = 20;
         var _loc1_:TextFormat = new TextFormat();
         if(FontManager.minFontSize > 11)
         {
            _loc1_.bold = false;
            _loc1_.size = FontManager.minFontSize;
         }
         else
         {
            _loc1_.bold = true;
            _loc1_.size = 11;
         }
         _loc1_.color = 0;
         _loc1_.font = "Arial";
         this.lobbyGrid.setStyle("headerTextFormat",_loc1_);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 0;
         _loc2_.size = FontManager.sanitizeFontSize(11);
         _loc2_.font = "Arial";
         StyleManager.setStyle("highlightTextFormat",_loc2_);
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = 0;
         _loc3_.size = FontManager.sanitizeFontSize(11);
         _loc3_.font = "Arial";
         StyleManager.setStyle("defaultTextFormat",_loc3_);
         this.lobbyGrid.setStyle("cellRenderer",LobbyGridCell);
         this.lobbyGrid.setRendererStyle("textFormat",_loc3_);
      }
      
      public function createAndDisplayLobbyGridBitmapCache() : void {
         var _loc1_:BitmapData = null;
         var _loc2_:Bitmap = null;
         if(!this.lobbyGrid)
         {
            throw new Error(this + " createAndDisplayLobbyGridBitmapCache() called before ivar \"lobbyGrid\" has been assigned.");
         }
         else
         {
            if(!getChildByName("lobbyGridDisplayCache"))
            {
               _loc1_ = new BitmapData(this.lobbyGrid.width,this.lobbyGrid.height,false,4.294967295E9);
               _loc1_.draw(this.lobbyGrid);
               _loc2_ = new Bitmap(_loc1_);
               _loc2_.x = this.lobbyGrid.x;
               _loc2_.y = this.lobbyGrid.y;
               _loc2_.name = "lobbyGridDisplayCache";
               addChild(_loc2_);
            }
            return;
         }
      }
      
      public function destroyLobbyGridBitmapCache() : void {
         if(getChildByName("lobbyGridDisplayCache"))
         {
            removeChild(getChildByName("lobbyGridDisplayCache"));
         }
      }
      
      public function refreshRoomFilterDropDown() : void {
         var filterValue:String = null;
         if((this.roomSortDropDown) && this.plModel.sLobbyMode == "challenge")
         {
            this.roomSortDropDown.close();
            try
            {
               removeChild(this.roomSortDropDown);
            }
            catch(e:Error)
            {
            }
            try
            {
               this.roomSortDropDown.removeEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onMinMaxFilterKeySelected);
               this.roomSortDropDown.removeEventListener(MouseEvent.MOUSE_OVER,this.onRoomSortDropdownMouseOver);
               this.roomSortDropDown.removeEventListener(MouseEvent.MOUSE_OUT,this.onRoomSortDropdownMouseOut);
               this.roomSortDropDown.removeEventListener(Event.CHANGE,this.onRoomSortDropDownClick);
               this.roomSortDropDown.removeEventListener(Event.SCROLL,this.onRmSrtDrpDwnScrlBrClick);
            }
            catch(e:Error)
            {
            }
            this.roomSortDropDown.destroy();
            this.roomSortDropDown = null;
            this.roomSortDropDown = new PulldownMenu(136,18,20);
            this.roomSortDropDown.dataProvider = this.getLobbyStakesList(this.plModel.lobbyGridData);
            this.roomSortDropDown.x = this.mcLobby.x + this.minMaxBuyInLabel.x + this.minMaxBuyInLabel.width;
            this.roomSortDropDown.y = this.mcLobby.y + 28;
            this.roomSortDropDown.addEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onMinMaxFilterKeySelected,false,0,true);
            this.roomSortDropDown.addEventListener(MouseEvent.MOUSE_OVER,this.onRoomSortDropdownMouseOver,false,0,true);
            this.roomSortDropDown.addEventListener(MouseEvent.MOUSE_OUT,this.onRoomSortDropdownMouseOut,false,0,true);
            this.roomSortDropDown.addEventListener(Event.CHANGE,this.onRoomSortDropDownClick,false,0,true);
            this.roomSortDropDown.addEventListener(Event.SCROLL,this.onRmSrtDrpDwnScrlBrClick,false,0,true);
            filterValue = this.plModel.filterTableType == TableType.NORMAL?this.userPreferencesContainer.normalFilterValue:this.userPreferencesContainer.fastFilterValue;
            this.roomSortDropDown.setSelected(filterValue == "default"?"All":filterValue);
            addChild(this.roomSortDropDown);
         }
      }
      
      public function refreshLobby() : void {
         dispatchEvent(new LVEvent(LVEvent.REFRESH_LOBBY_ROOMS));
      }
      
      public function loadPointGames() : void {
         var _loc8_:DataGridColumn = null;
         var _loc1_:DataGridColumn = new DataGridColumn("locked");
         _loc1_.headerText = "";
         _loc1_.width = 18;
         _loc1_.cellRenderer = LobbyGridLockCell;
         _loc1_.labelFunction = this.lockedCellFormatter;
         var _loc2_:DataGridColumn = new DataGridColumn("name");
         _loc2_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.nameHeader");
         if(this.plModel.configModel.isFeatureEnabled("playersClub"))
         {
            _loc2_.width = this.plModel.playerSpeedTestVariant?56:FontManager.minFontSize > 11?86:96;
         }
         else
         {
            _loc2_.width = this.plModel.playerSpeedTestVariant?80:FontManager.minFontSize > 11?110:120;
         }
         if(LocaleManager.locale == "de")
         {
            _loc2_.width = FontManager.minFontSize > 11?80:90;
         }
         if(this.plModel.configModel.isFeatureEnabled("playersClub"))
         {
            _loc8_ = new DataGridColumn("vipPoints");
            _loc8_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.vip");
            _loc8_.width = 24;
         }
         var _loc3_:DataGridColumn = new DataGridColumn("stakes");
         _loc3_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.stakesHeader");
         _loc3_.width = FontManager.minFontSize > 11?70:60;
         _loc3_.labelFunction = this.stakesCellFormatter;
         if(LocaleManager.locale == "de")
         {
            _loc3_.width = FontManager.minFontSize > 11?85:75;
         }
         var _loc4_:DataGridColumn = new DataGridColumn("players");
         _loc4_.headerText = PokerGlobalData.instance.enableHyperJoin?LocaleManager.localize("flash.lobby.gameSelector.grid.headers.playersHeaderMax"):LocaleManager.localize("flash.lobby.gameSelector.grid.headers.playersHeader");
         _loc4_.width = _loc4_.headerText.length <= 8?44:54;
         _loc4_.labelFunction = this.playersCellFormatter;
         _loc4_.cellRenderer = LobbyGridPlayersCell;
         var _loc5_:DataGridColumn = new DataGridColumn("minMaxBuyIn");
         _loc5_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.blindsHeader");
         _loc5_.width = this.plModel.playerSpeedTestVariant?60:_loc4_.headerText.length == 54?60:75;
         _loc5_.labelFunction = this.minBuyInCellFormatter;
         var _loc6_:DataGridColumn = null;
         if(this.plModel.playerSpeedTestVariant)
         {
            _loc6_ = new DataGridColumn("playerSpeed");
            _loc6_.headerText = "Player Speed";
            _loc6_.width = 72;
            _loc6_.labelFunction = this.playerSpeedCellFormatter;
         }
         this.lobbyGrid.removeAllColumns();
         this.lobbyGrid.addColumn(_loc1_);
         var _loc7_:DisplayObject = getChildByName("MTTLobby");
         if(!PokerGlobalData.instance.hideTableNamesInLobby || (_loc7_) && (_loc7_.visible))
         {
            this.lobbyGrid.addColumn(_loc2_);
         }
         if(this.plModel.configModel.isFeatureEnabled("playersClub"))
         {
            this.lobbyGrid.addColumn(_loc8_);
         }
         this.lobbyGrid.addColumn(_loc3_);
         this.lobbyGrid.addColumn(_loc5_);
         if(_loc6_)
         {
            this.lobbyGrid.addColumn(_loc6_);
         }
         this.lobbyGrid.addColumn(_loc4_);
      }
      
      public function loadTourney() : void {
         var _loc1_:DataGridColumn = new DataGridColumn("locked");
         _loc1_.headerText = "";
         _loc1_.width = 18;
         _loc1_.cellRenderer = LobbyGridLockCell;
         _loc1_.labelFunction = this.lockedCellFormatter;
         var _loc2_:DataGridColumn = new DataGridColumn("name");
         _loc2_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.nameHeader");
         _loc2_.width = 120;
         var _loc3_:DataGridColumn = new DataGridColumn("fee");
         _loc3_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.feeHeader");
         _loc3_.width = 60;
         _loc3_.labelFunction = this.feeCellFormatter;
         var _loc4_:DataGridColumn = new DataGridColumn("players");
         _loc4_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.playersHeader");
         _loc4_.width = 54;
         _loc4_.labelFunction = this.playersCellFormatter;
         _loc4_.cellRenderer = LobbyGridPlayersCell;
         var _loc5_:DataGridColumn = new DataGridColumn("status");
         _loc5_.headerText = LocaleManager.localize("flash.lobby.gameSelector.grid.headers.statusHeader");
         _loc5_.width = 60;
         this.lobbyGrid.removeAllColumns();
         this.lobbyGrid.addColumn(_loc1_);
         this.lobbyGrid.addColumn(_loc2_);
         this.lobbyGrid.addColumn(_loc3_);
         this.lobbyGrid.addColumn(_loc5_);
         this.lobbyGrid.addColumn(_loc4_);
      }
      
      public function loadPrivate() : void {
         this.loadPointGames();
      }
      
      private function initUserInfo() : void {
         this.lobbyPlayerInfo.welcome.text = LocaleManager.localize("flash.lobby.playerInfo.welcome",{"name":
            {
               "type":"tn",
               "name":this.plModel.playerName,
               "gender":this.plModel.playerGender
            }});
         this.lobbyPlayerInfo.points.text = PokerCurrencyFormatter.numberToCurrency(this.plModel.totalChips,false);
         this.setOnlinePlayers();
         this.casinoSelector.connectButton.label = LocaleManager.localize("flash.lobby.casinoSelector.connectButton");
         this.casinoSelector.cancelButton.label = LocaleManager.localize("flash.popup.tableCashier.cancelButton");
         var _loc1_:SafeImageLoader = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onUserPicComplete);
         _loc1_.load(new URLRequest(this.plModel.pic_url));
         this._emptyChickletButton = PokerClassProvider.getObject("EmptyGiftButtonClip");
         this._emptyChickletButton.gotoAndStop(1);
         this._emptyChickletButton.buttonMode = true;
         this._emptyChickletButton.addEventListener(MouseEvent.CLICK,this._emptyChickletButtonClickHandler);
         this._emptyChickletButton.x = -42;
         this._emptyChickletButton.y = 48;
         this._emptyChickletButton.width = 30;
         this._emptyChickletButton.height = 30;
         this.userInfo.addChild(this._emptyChickletButton);
      }
      
      public function displayGiftChicklet(param1:int) : void {
         if((this._displayedGiftOnChicklet) && (this.userInfo.contains(this._displayedGiftOnChicklet)))
         {
            this.userInfo.removeChild(this._displayedGiftOnChicklet);
         }
         if(param1 != -1)
         {
            this._emptyChickletButton.visible = false;
            if(this._displayedGiftOnChicklet)
            {
               GiftLibrary.GetInst().ReleaseGiftMovieClip(this._displayedGiftOnChicklet);
            }
            this._displayedGiftOnChicklet = GiftLibrary.GetInst().CreateGiftMovieClip(GiftLibrary.knIMAGE_SIZE_40x40,String(param1));
            if(this._displayedGiftOnChicklet)
            {
               this._displayedGiftOnChicklet.buttonMode = true;
               this._displayedGiftOnChicklet.mouseChildren = false;
               this._displayedGiftOnChicklet.x = this._emptyChickletButton.x;
               this._displayedGiftOnChicklet.y = this._emptyChickletButton.y;
               this._displayedGiftOnChicklet.addEventListener(MouseEvent.CLICK,this._displayedGiftOnChickletClickHandler,false,0,true);
               this.userInfo.addChild(this._displayedGiftOnChicklet);
            }
         }
         else
         {
            this._emptyChickletButton.visible = true;
            this._displayedGiftOnChicklet = null;
         }
      }
      
      private function _displayedGiftOnChickletClickHandler(param1:MouseEvent) : void {
         this.dispatchEvent(new LVEvent(LVEvent.GIFT_SHOP_CLICK));
      }
      
      private function _emptyChickletButtonClickHandler(param1:MouseEvent) : void {
         this.dispatchEvent(new LVEvent(LVEvent.GIFT_SHOP_CLICK));
      }
      
      public function refreshUserInfo() : void {
         this.lobbyPlayerInfo.welcome.text = LocaleManager.localize("flash.lobby.playerInfo.welcome",{"name":
            {
               "type":"tn",
               "name":this.plModel.playerName,
               "gender":this.plModel.playerGender
            }});
         this.lobbyPlayerInfo.points.text = PokerCurrencyFormatter.numberToCurrency(this.plModel.totalChips,false);
         this.setOnlinePlayers();
         dispatchEvent(new LVEvent(LVEvent.REFRESHED_USER_INFO));
      }
      
      private function onUserPicComplete(param1:Event) : void {
         var _loc5_:* = NaN;
         var _loc2_:Number = 55;
         var _loc3_:Number = 55;
         var _loc4_:SafeImageLoader = param1.target.loader as SafeImageLoader;
         _loc4_.name = "userPic";
         if(_loc4_.width > _loc2_ || _loc4_.height > _loc3_)
         {
            _loc5_ = 1 / Math.max(_loc4_.height / _loc3_,_loc4_.width / _loc2_);
            _loc4_.scaleX = _loc4_.scaleX * _loc5_;
            _loc4_.scaleY = _loc4_.scaleY * _loc5_;
         }
         this.userInfo.mcPic.addChild(_loc4_);
      }
      
      private function initUIListeners() : void {
         if(PokerGlobalData.instance.enableZPWC)
         {
            this.mcLobby.mcPrivateTabOff.addEventListener(MouseEvent.CLICK,this.onZPWCClick,false,0,true);
         }
         else
         {
            if(PokerGlobalData.instance.configModel.getFeatureConfig("tournamentImprovements") != null)
            {
               this.mcLobby.mcPrivateTabOff.addEventListener(MouseEvent.CLICK,this.onSitNGoClick,false,0,true);
               this.mcLobby.mcTournTabOff.addEventListener(MouseEvent.CLICK,this.onShootoutClick,false,0,true);
            }
            else
            {
               this.mcLobby.mcPrivateTabOff.addEventListener(MouseEvent.CLICK,this.onMcPrivateTabOff,false,0,true);
               this.mcLobby.mcTournTabOff.addEventListener(MouseEvent.CLICK,this.onMcTournTabOff,false,0,true);
            }
         }
         this.mcLobby.mcPointsTabOff.addEventListener(MouseEvent.CLICK,this.onMcPointsTabOff,false,0,true);
         this.mcLobby.mcPremiumTabOff.addEventListener(MouseEvent.CLICK,this.onMcPremiumTabOff,false,0,true);
         this.mcLobby.joinRoom_btn.addEventListener(MouseEvent.CLICK,this.onJoinRoomClick,false,0,true);
         this.mcLobby.createRoom_btn.addEventListener(MouseEvent.CLICK,this.onCreateRoomClick,false,0,true);
         this.mcLobby.refresh_btn.addEventListener(MouseEvent.CLICK,this.onRefreshButtonClick,false,0,true);
         this.mcLobby.powerSubTab.addEventListener(MouseEvent.CLICK,this.onMcPremiumTabOff,false,0,true);
         this.mcLobby.shootoutSubTab.addEventListener(MouseEvent.CLICK,this.onShootoutClick,false,0,true);
         this.mcLobby.sitngoSubTab.addEventListener(MouseEvent.CLICK,this.onSitNGoClick,false,0,true);
         if(PokerGlobalData.instance.enableMTT)
         {
            this.mcLobby.weeklySubTab.addEventListener(MouseEvent.CLICK,this.onMTTClick,false,0,true);
         }
         else
         {
            this.mcLobby.weeklySubTab.addEventListener(MouseEvent.CLICK,this.onWeeklyClick,false,0,true);
         }
         this.mcLobby.buyin_btn.addEventListener(MouseEvent.CLICK,this.onBuyInClick,false,0,true);
         this.mcLobby.buyin_btn.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            mcLobby.buyin_btn.gotoAndStop(2);
         },false,0,true);
         this.mcLobby.buyin_btn.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            mcLobby.buyin_btn.gotoAndStop(1);
         },false,0,true);
         this.mcLobby.howToPlayButton.addEventListener(MouseEvent.CLICK,this.onHowToPlayClick,false,0,true);
         this.lobbyGridContainer.addEventListener(MouseEvent.ROLL_OVER,this.onLobbyGridRollover,false,0,true);
         this.lobbyGridContainer.addEventListener(MouseEvent.ROLL_OUT,this.onLobbyGridRollout,false,0,true);
         this.lobbyGrid.addEventListener(DataGridEvent.HEADER_RELEASE,this.onLobbyGridHeaderRelease,false,0,true);
         this.lobbyGrid.addEventListener(Event.CHANGE,this.onLobbyGridChange,false,0,true);
         this.lobbyGrid.addEventListener(ListEvent.ITEM_ROLL_OVER,this.onLobbyGridItemRollOver,false,0,true);
         this.lobbyGrid.addEventListener(ListEvent.ITEM_ROLL_OUT,this.onLobbyGridItemRollOut,false,0,true);
         this.lobbyGrid.addEventListener(ListEvent.ITEM_CLICK,this.onLobbyGridItemClick,false,0,true);
         this.lobbyGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onLobbyGridItemDoubleClick,false,0,true);
         this.lobbyGrid.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_DOWN,this.onLobbyGridScrollBarMouseDown,false,0,true);
         this.lobbyGrid.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_CLICK,this.onLobbyGridScrollBarClick,false,0,true);
         this.lobbyGrid.addEventListener(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_UP,this.onLobbyGridScrollBarMouseUp,false,0,true);
         this.lobbyGrid.addEventListener(LVEvent.LOBBYGRIDLOCK_PURCHASEFASTTABLES,this.onLobbyGridPurchaseFastTablesClick,false,0,true);
         if(this.roomSortDropDown)
         {
            this.roomSortDropDown.addEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onMinMaxFilterKeySelected,false,0,true);
            this.roomSortDropDown.addEventListener(MouseEvent.MOUSE_OVER,this.onRoomSortDropdownMouseOver,false,0,true);
            this.roomSortDropDown.addEventListener(MouseEvent.MOUSE_OUT,this.onRoomSortDropdownMouseOut,false,0,true);
            this.roomSortDropDown.addEventListener(Event.CHANGE,this.onRoomSortDropDownClick,false,0,true);
            this.roomSortDropDown.addEventListener(Event.SCROLL,this.onRmSrtDrpDwnScrlBrClick,false,0,true);
         }
         this.findSeatButton.addEventListener(MouseEvent.CLICK,this.onBtnFindSeat,false,0,true);
         this.findSeatButton.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            findSeatButton.gotoAndPlay("on");
         },false,0,true);
         this.bigFindSeatButton.addEventListener(ZButtonEvent.RELEASE,this.onBtnBigFindSeat,false,0,true);
         if(!PokerGlobalData.instance.hideChangeCasinoButton)
         {
            this.userInfo.changeCasinoButton.addEventListener(MouseEvent.CLICK,this.onChangeCasinoClick,false,0,true);
         }
         this.casinoSelector.connectButton.addEventListener(MouseEvent.CLICK,this.onCasinoSelectorConnectButtonClick,false,0,true);
         this.casinoSelector.cancelButton.addEventListener(MouseEvent.CLICK,this.onCasinoSelectorCancelButtonClick,false,0,true);
         this.hideFullTables.addEventListener(Event.CHANGE,this.toggleHideFullTables,false,0,true);
         this.hideRunningTables.addEventListener(Event.CHANGE,this.toggleHideRunningTables,false,0,true);
         this.hideEmptyTables.addEventListener(Event.CHANGE,this.toggleHidEmptyTables,false,0,true);
         this.casinoSelector.casinoList.addEventListener(Event.CHANGE,this.pickNewCasino,false,0,true);
         this.mcLobby.mcTournTabOff.addEventListener(MouseEvent.MOUSE_OVER,this.onMcTournTabOver,false,0,true);
         this.mcLobby.mcTournTabOff.addEventListener(MouseEvent.MOUSE_OUT,this.onMcTournTabOut,false,0,true);
         this.mcLobby.mcTournTabOn.addEventListener(MouseEvent.MOUSE_OVER,this.onMcTournTabOver,false,0,true);
         this.mcLobby.mcTournTabOn.addEventListener(MouseEvent.MOUSE_OUT,this.onMcTournTabOut,false,0,true);
      }
      
      private function toggleHideFullTables(param1:Event) : void {
         dispatchEvent(new LVEvent(LVEvent.FULL_TABLES));
      }
      
      private function toggleHideRunningTables(param1:Event) : void {
         dispatchEvent(new LVEvent(LVEvent.RUNNING_TABLES));
      }
      
      private function toggleHidEmptyTables(param1:Event) : void {
         dispatchEvent(new LVEvent(LVEvent.EMPTY_TABLES));
      }
      
      private function onLobbyGridHeaderRelease(param1:DataGridEvent) : void {
         param1.preventDefault();
         var _loc2_:String = ((param1.target as DataGrid).getColumnAt(param1.columnIndex) as DataGridColumn).dataField;
         var _loc3_:Boolean = this.plModel.currentSortDataField == _loc2_?!this.plModel.currentSortDescending:_loc2_ == "id" || _loc2_ == "name"?false:true;
         dispatchEvent(new SortTablesEvent(SortTablesEvent.SORT_TABLES,_loc2_,_loc3_));
      }
      
      private function onLobbyGridChange(param1:Event) : void {
         var _loc2_:DataGrid = DataGrid(param1.target);
         dispatchEvent(new TableSelectedEvent(LVEvent.TABLE_SELECTED,_loc2_.selectedItem.id,_loc2_.selectedItem));
         this.clickedRoomId = _loc2_.selectedItem.id;
      }
      
      private function onLobbyGridItemRollOver(param1:ListEvent) : void {
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:Point = null;
         var _loc11_:* = 0;
         var _loc12_:LobbyGridPlayersCell = null;
         var _loc13_:Point = null;
         var _loc2_:* = 0;
         var _loc3_:CellRenderer = null;
         if(param1.index > -1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.lobbyGrid.getColumnCount())
            {
               _loc3_ = this.lobbyGrid.getCellRendererAt(param1.index,_loc2_) as CellRenderer;
               if(_loc3_ != null)
               {
                  _loc3_.setStyle("textFormat",StyleManager.getStyle("highlightTextFormat"));
               }
               _loc2_++;
            }
         }
         var _loc4_:Object = param1.item;
         if(_loc4_)
         {
            this.plModel.mouseOverRoomId = _loc4_["id"];
            _loc5_ = "";
            if(_loc4_["levelLocked"])
            {
               _loc5_ = LocaleManager.localize("flash.lobby.gameSelector.levelLocked.tip",
                  {
                     "unlockLevel1":_loc4_["unlockLevel"],
                     "unlockLevel2":_loc4_["unlockLevel"]
                  });
            }
            else
            {
               if(_loc4_["chipLocked"])
               {
                  _loc6_ = this.plModel.sLobbyMode == "tournament"?_loc4_["entryFee"] + _loc4_["hostFee"]:_loc4_["minBuyIn"];
                  _loc5_ = LocaleManager.localize("flash.lobby.gameSelector.chipLocked.tip",{"amount":PokerCurrencyFormatter.numberToCurrency(_loc6_,_loc6_ > 9999?true:false,2,false,false)});
               }
               else
               {
                  if(_loc4_["starred"])
                  {
                     _loc5_ = LocaleManager.localize("flash.lobby.gameSelector.starred.tip",{"unlockLevel":_loc4_["unlockLevel"]});
                  }
               }
            }
            if(_loc5_)
            {
               _loc7_ = 230;
               _loc8_ = this.lobbyGrid.width / 2 - _loc7_ / 2;
               _loc9_ = this.lobbyGrid.mouseY + 20;
               _loc10_ = this.globalToLocal(this.lobbyGrid.localToGlobal(new Point(_loc8_,_loc9_)));
               _loc8_ = _loc10_.x;
               _loc9_ = _loc10_.y;
               this.showTooltip(_loc5_,_loc7_,_loc8_,_loc9_);
            }
            else
            {
               this.hideTooltip();
            }
            if(!(this.atThisTablePreviousRoom == this.plModel.mouseOverRoomId) && this.plModel.mouseOverRoomId >= 0)
            {
               this.atThisTablePreviousRoom = this.plModel.mouseOverRoomId;
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby MouseOver RoomTable o:LobbyUI:2012-01-06"));
               if(!this.atThisTableSlowTimer)
               {
                  this.atThisTableSlowTimer = new Timer(500,1);
                  this.atThisTableSlowTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSlowTimerAtThisTableComplete);
               }
               this.atThisTableSlowTimer.reset();
               this.atThisTableSlowTimer.start();
            }
            if(this.lobbyGrid.getColumnAt(param1.columnIndex).dataField == "players")
            {
               _loc11_ = this.lobbyGrid.columns.length-1;
               _loc12_ = this.lobbyGrid.getCellRendererAt(int(param1.rowIndex),_loc11_) as LobbyGridPlayersCell;
               if(_loc12_)
               {
                  _loc13_ = new Point(_loc12_.x,_loc12_.y + _loc12_.height / 2);
                  _loc13_ = _loc12_.parent.localToGlobal(_loc13_);
                  this.atThisTableY = Math.round(_loc13_.y);
                  dispatchEvent(new TableSelectedEvent(LVEvent.TABLE_MOUSE_OVER,int(_loc4_["id"])));
               }
            }
            else
            {
               dispatchEvent(new TableSelectedEvent(LVEvent.TABLE_MOUSE_OUT,-1));
            }
         }
         else
         {
            this.plModel.mouseOverRoomId = -1;
         }
      }
      
      private function onSlowTimerAtThisTableComplete(param1:TimerEvent) : void {
         if(this.atThisTablePreviousRoom == this.plModel.mouseOverRoomId)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby LongMouseOver RoomTable o:LobbyUI:2012-01-06"));
         }
      }
      
      private function onLobbyGridItemRollOut(param1:ListEvent) : void {
         this.plModel.mouseOverRoomId = -1;
         var _loc2_:* = 0;
         var _loc3_:CellRenderer = null;
         if(param1.index > -1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.lobbyGrid.getColumnCount())
            {
               _loc3_ = this.lobbyGrid.getCellRendererAt(param1.index,_loc2_) as CellRenderer;
               if(_loc3_ != null)
               {
                  _loc3_.setStyle("textFormat",StyleManager.getStyle("defaultTextFormat"));
               }
               _loc2_++;
            }
         }
         this.hideTooltip();
         dispatchEvent(new TableSelectedEvent(LVEvent.TABLE_MOUSE_OUT,-1));
      }
      
      private function onLobbyGridItemClick(param1:ListEvent) : void {
         var _loc3_:* = NaN;
         var _loc2_:Object = param1.item;
         if(_loc2_)
         {
            if((_loc2_["chipLocked"]) && !_loc2_["levelLocked"])
            {
               if(_loc2_.minBuyIn)
               {
                  _loc3_ = _loc2_.minBuyIn;
               }
               else
               {
                  if((_loc2_.entryFee) || (_loc2_.hostFee))
                  {
                     _loc3_ = _loc2_.entryFee + _loc2_.hostFee;
                  }
               }
               dispatchEvent(new LVEvent(LVEvent.LOCKED_ROOM_CLICK,{"minBuyIn":_loc3_}));
            }
         }
      }
      
      private function onLobbyGridRollover(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_ROLLOVER));
      }
      
      private function onLobbyGridRollout(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_ROLLOUT));
      }
      
      private function onLobbyGridItemDoubleClick(param1:ListEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.JOIN_ROOM));
      }
      
      private function onLobbyGridScrollBarMouseDown(param1:LVEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_DOWN));
      }
      
      private function onLobbyGridScrollBarClick(param1:LVEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_CLICK));
      }
      
      private function onLobbyGridScrollBarMouseUp(param1:LVEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_UP));
      }
      
      private function onJoinRoomClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.JOIN_ROOM));
      }
      
      public function setLobbyButtons(param1:Boolean) : void {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          */
         throw new IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onMcTournTabOff(param1:MouseEvent) : void {
         this.onHappyHourToasterClick();
         dispatchEvent(new LVEvent(LVEvent.onTourneyTabClick));
      }
      
      private function onMcTournTabOver(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.onTourneyTabOver));
      }
      
      private function onMcTournTabOut(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.onTourneyTabOut));
      }
      
      private function onMcPrivateTabOff(param1:MouseEvent) : void {
         this.dfSeatedPlayers.visible = false;
         dispatchEvent(new LVEvent(LVEvent.onPrivateTabClick));
      }
      
      private function onMcPointsTabOff(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.onPointsTabClick));
      }
      
      public function setLobbyDisplay() : void {
         switch(this.plModel.sLobbyMode)
         {
            case "challenge":
               this.setPointsGames();
               break;
            case "private":
               this.setPrivateGames();
               break;
            case "tournament":
               this.setTourneyGames();
               break;
            case "shootout":
               this.setShootoutGames();
               break;
            case "weekly":
               this.setWeeklyGames();
               break;
            case "premium":
               this.setPremiumGames();
               break;
            case "mtt":
               this.setMTTGames();
               break;
            case "zpwc":
               this.setZPWCGames();
               break;
         }
         
      }
      
      public function setPointsGames() : void {
         this.resetSelection();
         this.loadPointGames();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setPrivateGames() : void {
         this.resetSelection();
         this.loadPrivate();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setTourneyGames() : void {
         this.resetSelection();
         this.loadTourney();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setShootoutGames() : void {
         this.resetSelection();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setWeeklyGames() : void {
         this.resetSelection();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setPremiumGames() : void {
         this.resetSelection();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setMTTGames() : void {
         this.resetSelection();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      public function setZPWCGames() : void {
         this.resetSelection();
         this.setLobbyButtons(false);
         this.dfSeatedPlayers.visible = false;
      }
      
      private function setOnlinePlayers() : void {
         this.online.text = LocaleManager.localize("flash.lobby.playersOnline",
            {
               "players":PokerCurrencyFormatter.numberToCurrency(this.plModel.playersOnline,false,0,false),
               "player":
                  {
                     "type":"tk",
                     "key":"player",
                     "attributes":"",
                     "count":int(this.plModel.playersOnline)
                  }
            });
         this.casinoSelectorContainer.playersOnline.text = LocaleManager.localize("flash.lobby.casinoSelector.playersOnline",{"players":PokerCurrencyFormatter.numberToCurrency(this.plModel.playersOnline,false,0,false)});
         this.lobbyGameSelector.setOnlinePlayers(this.plModel.playersOnline);
      }
      
      public function adjustControlsLocation() : void {
         if(PokerGlobalData.instance.enableRoomTypeOnly)
         {
            this.mcLobby.lobbyChrome.height = this._lobbyChromeHeightDefault;
            this.mcLobby.joinRoom_btn.y = this._lobbyJoinRoomButtonYDefault;
         }
         else
         {
            this.mcLobby.lobbyChrome.height = this._lobbyChromeHeightDefault + 16;
            this.mcLobby.joinRoom_btn.y = this._lobbyJoinRoomButtonYDefault + LOBBY_JOIN_BUTTON_OFFSET_Y;
         }
         this.lobbyGameSelector.adjustPlayersOnlineLocation();
      }
      
      public function resetSelection() : void {
         if(this.plModel.sLobbyMode != "mtt")
         {
            this.hideMTT();
         }
         if(this.plModel.sLobbyMode != "zpwc")
         {
            this.hideZPWC();
         }
         this.plModel.nSelectedTable = -1;
         this.lobbyGrid.selectedIndex = -1;
         if((stage) && (this.lobbyGrid))
         {
            this.lobbyGrid.scrollToIndex(0);
         }
         this.resetJoinRoomButton();
         this.dfSeatedPlayers.visible = false;
      }
      
      public function highlightJoinRoomButton() : void {
         this.mcLobby.joinRoom_btn.defaultBackground.visible = false;
         this.mcLobby.joinRoom_btn.highlightBackground.visible = true;
         if(this.mcLobby.joinTableButtonLabel)
         {
            (this.mcLobby.joinTableButtonLabel as EmbeddedFontTextField).fontColor = 16777215;
         }
      }
      
      public function resetJoinRoomButton() : void {
         this.mcLobby.joinRoom_btn.defaultBackground.visible = true;
         this.mcLobby.joinRoom_btn.highlightBackground.visible = false;
         if(this.mcLobby.joinTableButtonLabel)
         {
            (this.mcLobby.joinTableButtonLabel as EmbeddedFontTextField).fontColor = 0;
         }
      }
      
      private function onMcPremiumTabOff(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.onPremiumTabClick));
      }
      
      private function onRefreshButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.REFRESH_LIST));
      }
      
      public function showAtThisTable(param1:String, param2:String, param3:Array) : void {
         if(stage)
         {
            this.hideAtThisTable();
            this.atThisTableParent = stage;
            this.atThisTable = new LobbyGridAtThisTable(param1,param2,param3);
            this.atThisTable.x = 495;
            this.atThisTable.y = this.atThisTableY - Math.round(this.atThisTable.height / 2);
            this.atThisTableParent.addChild(this.atThisTable);
         }
      }
      
      public function hideAtThisTable() : void {
         if((this.atThisTable) && (this.atThisTableParent) && (this.atThisTableParent.contains(this.atThisTable)))
         {
            this.atThisTableParent.removeChild(this.atThisTable);
         }
         this.atThisTable = null;
      }
      
      public function onCreateRoomClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.CREATE_TABLE));
      }
      
      public function onChangeCasinoClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
      }
      
      public function onBtnFindSeat(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.FIND_SEAT));
      }
      
      public function onBtnBigFindSeat(param1:ZButtonEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.FIND_SEAT));
      }
      
      private function onLearnToPlayButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SHOW_TUTORIAL));
      }
      
      private function onPlayMTTClick(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click MTTPlayInTournamentNow o:LobbyUI:2012-12-12"));
         dispatchEvent(new LVEvent(LVEvent.PLAY_TOURNAMENT));
      }
      
      private function onBuzzboxMTTClick(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click MTTBuzzboxRegisterNow o:LobbyUI:2012-12-12"));
         dispatchEvent(new LVEvent(LVEvent.PLAY_TOURNAMENT));
      }
      
      private function onBuzzboxZPWCClick(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click ZPWCBuzzboxGetStarted o:LobbyUI:2013-01-23"));
         if(PokerGlobalData.instance.dispMode == "zpwc")
         {
            this.showLobbyBanner();
         }
         else
         {
            this.onZPWCClick(null);
         }
      }
      
      public function hideAll() : void {
         if(this.userInfo.visible)
         {
            this.userInfo.visible = false;
            this.displayRestoreContainer.push(this.userInfo);
         }
         if(this.online.visible)
         {
            this.online.visible = false;
            this.displayRestoreContainer.push(this.online);
         }
         if((this.playerNum) && (this.playerNum.visible))
         {
            this.playerNum.visible = false;
            this.displayRestoreContainer.push(this.playerNum);
         }
         if(this.findSeatButton.visible)
         {
            this.findSeatButton.visible = false;
            this.displayRestoreContainer.push(this.findSeatButton);
         }
         if(this.mcLobby.visible)
         {
            this.mcLobby.visible = false;
            this.displayRestoreContainer.push(this.mcLobby);
         }
         if(this.dfSeatedPlayers.visible)
         {
            this.dfSeatedPlayers.visible = false;
            this.displayRestoreContainer.push(this.dfSeatedPlayers);
         }
         if(this.lobbyGrid.visible)
         {
            this.lobbyGrid.visible = false;
            this.displayRestoreContainer.push(this.lobbyGrid);
         }
         if((this.roomSortDropDown) && (this.roomSortDropDown.visible))
         {
            this.roomSortDropDown.visible = false;
            this.displayRestoreContainer.push(this.roomSortDropDown);
         }
         if(this.fastTableTypeTabs.visible)
         {
            this.fastTableTypeTabs.visible = false;
            this.displayRestoreContainer.push(this.fastTableTypeTabs);
         }
         if(this.hideLabel.visible)
         {
            this.hideLabel.visible = false;
            this.displayRestoreContainer.push(this.hideLabel);
         }
         if(this.hideFullTables.visible)
         {
            this.hideFullTables.visible = false;
            this.displayRestoreContainer.push(this.hideFullTables);
         }
         if(this.hideRunningTables.visible)
         {
            this.hideRunningTables.visible = false;
            this.displayRestoreContainer.push(this.hideRunningTables);
         }
         if(this.hideEmptyTables.visible)
         {
            this.hideEmptyTables.visible = false;
            this.displayRestoreContainer.push(this.hideEmptyTables);
         }
         if((this.playMTT) && (this.playMTT.visible))
         {
            this.playMTT.visible = false;
            this.displayRestoreContainer.push(this.playMTT);
         }
         if((this.zpwcTicket) && (this.zpwcTicket.visible))
         {
            this.zpwcTicket.visible = false;
            this.displayRestoreContainer.push(this.zpwcTicket);
         }
         if((this.zpwcSparkle) && (this.zpwcSparkle.visible))
         {
            this.zpwcSparkle.visible = false;
            this.displayRestoreContainer.push(this.zpwcSparkle);
         }
         if((this.tabBannerController.container) && (this.tabBannerController.container.visible))
         {
            this.tabBannerController.container.visible = false;
            this.displayRestoreContainer.push(this.tabBannerController.container);
         }
         if((this.learnToPlayButton) && (this.learnToPlayButton.visible))
         {
            this.learnToPlayButton.visible = false;
            this.displayRestoreContainer.push(this.learnToPlayButton);
         }
         if((this._videoPokerButton) && (this._videoPokerButton.visible))
         {
            this._videoPokerButton.visible = false;
            this.displayRestoreContainer.push(this._videoPokerButton);
         }
         if((this.dfBuzzBox) && (this.dfBuzzBox.visible))
         {
            this.dfBuzzBox.visible = false;
            this.displayRestoreContainer.push(this.dfBuzzBox);
         }
         if((this.lockOverlay) && (this.lockOverlay.visible))
         {
            this.lockOverlay.visible = false;
            this.displayRestoreContainer.push(this.lockOverlay);
         }
         if((contains(this.lobbyAdContainer)) && (this.lobbyAdContainer.visible))
         {
            this.lobbyAdContainer.visible = false;
            this.displayRestoreContainer.push(this.lobbyAdContainer);
         }
         if((this.powerTourneyTabToaster) && (this.powerTourneyTabToaster.visible))
         {
            this.powerTourneyTabToaster.visible = false;
            this.displayRestoreContainer.push(this.powerTourneyTabToaster);
         }
         var _loc1_:DisplayObject = getChildByName("MTTLobby");
         if((_loc1_) && (_loc1_.visible))
         {
            _loc1_.visible = false;
            this.displayRestoreContainer.push(_loc1_);
         }
         var _loc2_:DisplayObject = getChildByName("ZPWCLobby");
         if((_loc2_) && (_loc2_.visible))
         {
            _loc2_.visible = false;
            this.displayRestoreContainer.push(_loc2_);
         }
         if((this.zpwcLobbyArrow) && (this.zpwcLobbyArrow.visible))
         {
            this.zpwcLobbyArrow.visible = false;
            this.displayRestoreContainer.push(this.zpwcLobbyArrow);
         }
         if((this.bigFindSeatButton) && (this.bigFindSeatButton.visible))
         {
            this.bigFindSeatButton.visible = false;
            this.displayRestoreContainer.push(this.bigFindSeatButton);
         }
         if((this._fastRibbonLabel) && (this._fastRibbonLabel.visible))
         {
            this._fastRibbonLabel.visible = false;
            this.displayRestoreContainer.push(this._fastRibbonLabel);
         }
      }
      
      public function restoreHiddenAll() : void {
         var _loc1_:DisplayObject = this.displayRestoreContainer.pop() as DisplayObject;
         while(_loc1_)
         {
            _loc1_.visible = true;
            _loc1_ = this.displayRestoreContainer.pop() as DisplayObject;
         }
      }
      
      public function clearDisplayRestoreContainer() : void {
         this.displayRestoreContainer.splice(0,this.displayRestoreContainer.length);
      }
      
      public function showCasinoList() : void {
         this.casinoSelector.visible = true;
      }
      
      public function hideCasinoList() : void {
         this.casinoSelector.visible = false;
      }
      
      public function onCasinoSelectorConnectButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.CONNECT_TO_NEW_CASINO));
      }
      
      public function onCasinoSelectorCancelButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.CANCEL_NEW_CASINO_CONNECT));
      }
      
      public function updateCasinoList() : void {
         this.casinoSelector.casinoList.dataProvider = this.plModel.casinoListData;
      }
      
      public function pickNewCasino(param1:Event) : void {
         dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED,param1.target.selectedItem.data,param1.target.selectedItem.label,param1.target.selectedItem.id));
      }
      
      public function loadNewServerLobby() : void {
         if(this.plModel.sLobbyMode == "tournament" || this.plModel.sLobbyMode == "premium")
         {
            this.loadTourney();
         }
         else
         {
            this.loadPointGames();
         }
         this.setLobbyButtons(true);
         if(!this.lobbyAdContainer.visible)
         {
            this.lobbyAdContainer.visible = true;
         }
         dispatchEvent(new LVEvent(LVEvent.REFRESH_LOBBY_ROOMS));
      }
      
      public function onFriendSelect(param1:Event) : void {
         dispatchEvent(new LVEvent(LVEvent.ON_SELECT_FRIEND));
      }
      
      public function onGetMorePointsClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.GET_MORE_CHIPS));
      }
      
      public function onShootoutClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_CLICK));
      }
      
      public function onSitNGoClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SITNGO_CLICK));
      }
      
      private function onMTTClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.MTT_CLICK));
      }
      
      private function onZPWCClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.ZPWC_CLICK));
      }
      
      public function onWeeklyClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.WEEKLY_CLICK));
      }
      
      public function setSubTab(param1:MovieClip, param2:Boolean) : void {
         var _loc3_:MovieClip = param1;
         if(param2)
         {
            _loc3_.backgroundOn.visible = true;
            _loc3_.backgroundOff.visible = false;
            (_loc3_.getChildByName("label") as EmbeddedFontTextField).fontColor = 16777215;
         }
         else
         {
            _loc3_.backgroundOn.visible = false;
            _loc3_.backgroundOff.visible = true;
            (_loc3_.getChildByName("label") as EmbeddedFontTextField).fontColor = 0;
         }
      }
      
      public function setDefaultSubtab(param1:String) : void {
         this.hideMTT();
         this.hideZPWC();
         this.setSubTab(this.mcLobby.weeklySubTab,false);
         if(param1.toLowerCase() == "shootout")
         {
            this.setSubTab(this.mcLobby.shootoutSubTab,true);
            this.setSubTab(this.mcLobby.sitngoSubTab,false);
            this.setSubTab(this.mcLobby.weeklySubTab,false);
         }
         if(param1.toLowerCase() == "sitngo")
         {
            this.setSubTab(this.mcLobby.shootoutSubTab,false);
            this.setSubTab(this.mcLobby.sitngoSubTab,true);
            this.setSubTab(this.mcLobby.weeklySubTab,false);
         }
         if(param1.toLowerCase() == "weekly")
         {
            this.setSubTab(this.mcLobby.shootoutSubTab,false);
            this.setSubTab(this.mcLobby.sitngoSubTab,false);
            this.setSubTab(this.mcLobby.weeklySubTab,true);
         }
      }
      
      public function onBuyInClick(param1:MouseEvent) : void {
         if((this.plModel.nWeeklyTourneyState) || this.plModel.sLobbyMode == "shootout")
         {
            dispatchEvent(new LVEvent(LVEvent.BUYIN_CLICK));
         }
         else
         {
            dispatchEvent(new LVEvent(LVEvent.REGISTER_WEEKLY_CLICK));
         }
      }
      
      public function onHowToPlayClick(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:PowerTourneyHappyHour:HowToPlay:2012-10-09"));
         dispatchEvent(new LVEvent(LVEvent.HOWTOPLAY_CLICK));
      }
      
      public function onLearnMoreClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_LEARNMORE_CLICK));
      }
      
      public function initBuzzAd(param1:String) : void {
         this.dfBuzzBox = new DrawFrame(201,120,true,false);
         this.dfBuzzBox.renderTitle("");
         this.dfBuzzBox.x = 285;
         this.dfBuzzBox.y = 396;
         addChild(this.dfBuzzBox);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0,1);
         _loc2_.graphics.drawRect(0,0,201,120);
         _loc2_.graphics.endFill();
         _loc2_.name = "buzzBoxBk";
         _loc2_.visible = false;
         this.dfBuzzBox.addChild(_loc2_);
         this.buzzAd = new BuzzAd(param1);
         this.dfBuzzBox.addChild(this.buzzAd);
      }
      
      public function initRoomSortDropDown() : void {
         if(this.roomSortDropDown)
         {
            this.refreshRoomFilterDropDown();
         }
      }
      
      public function updateShootoutConfig(param1:ShootoutConfig, param2:ShootoutUser) : void {
         this.setDefaultSubtab(this.mcLobby.shootoutSubTab);
         this.mcLobby.weekly_mc.visible = false;
         if(PokerGlobalData.instance.configModel.getFeatureConfig("tournamentImprovements") !== null)
         {
            this.mcLobby.shootout_mc.y = 134;
            this.mcLobby.howToPlayButton.y = this.mcLobby.howToPlayButton.y - 20;
            this.mcLobby.lobbyChrome.height = 238;
            this.lobbyGameSelector.adjustPlayersOnlineForTournamentImprovements();
         }
         this.mcLobby.shootout_mc.visible = true;
         this.mcLobby.howToPlayButton.visible = true;
         var _loc3_:Number = param1.aPayouts[param1.nRounds-1][0];
         this.shootoutPrizeTextField.text = LocaleManager.localize("flash.lobby.gameSelector.shootout.prizeLabel",{"amount":PokerCurrencyFormatter.numberToCurrency(_loc3_,false,0,false)});
         this.shootoutPrizeTextField.fitInWidth(280);
         var _loc4_:* = 232;
         this.shootoutPrizeTextField.x = (280 - this.shootoutPrizeTextField.textWidth * this.shootoutPrizeTextField.scaleX) / 2 - _loc4_;
         HtmlTextBox(this.mcLobby.buyin_btn.getChildByName("enterRoundButtonText")).updateText("Play Round " + param2.nRound,18);
         var _loc5_:Array = param2.sSkippedRounds.split(",");
         this.shootoutRoundOneButton.chipAmount = Number(param1.nBuyin);
         this.shootoutRoundTwoButton.goldAmount = Number(param1.skipRound1Price);
         this.shootoutRoundThreeButton.goldAmount = Number(param1.skipRound2Price);
         switch(param2.nRound)
         {
            case 1:
               this.shootoutRoundOneButton.status = LobbyShootoutRoundButton.STATUS_BUY_IN;
               this.shootoutRoundTwoButton.status = LobbyShootoutRoundButton.STATUS_SKIP;
               if(this.plModel.enableSponsorShootoutsButton)
               {
                  this.shootoutRoundTwoButton.changeToSponsoredShootoutButton(this.plModel.sponsorShootoutsTotal,this.plModel.sponsorShootoutsAccepted,this.plModel.sponsorShootoutsState);
                  this.shootoutRoundTwoButton.sponsoredButton.addEventListener(MouseEvent.CLICK,this.onShootoutSponsoredButtonClick,false,0,true);
               }
               this.shootoutRoundThreeButton.status = LobbyShootoutRoundButton.STATUS_SKIP;
               break;
            case 2:
               this.shootoutRoundOneButton.status = _loc5_[0] == "1"?LobbyShootoutRoundButton.STATUS_SKIPPED:LobbyShootoutRoundButton.STATUS_PLACED;
               this.shootoutRoundTwoButton.status = LobbyShootoutRoundButton.STATUS_ELIGIBLE;
               if(this.shootoutRoundTwoButton.sponsoredButton)
               {
                  this.shootoutRoundTwoButton.sponsoredButton.removeEventListener(MouseEvent.CLICK,this.onShootoutSponsoredButtonClick);
                  this.shootoutRoundTwoButton.restoreToNormalShootoutButton();
               }
               this.shootoutRoundThreeButton.status = LobbyShootoutRoundButton.STATUS_SKIP;
               break;
            case 3:
               this.shootoutRoundOneButton.status = _loc5_[0] == "1"?LobbyShootoutRoundButton.STATUS_SKIPPED:LobbyShootoutRoundButton.STATUS_PLACED;
               this.shootoutRoundTwoButton.status = _loc5_[0] == "2" || _loc5_[1] == "2"?LobbyShootoutRoundButton.STATUS_SKIPPED:LobbyShootoutRoundButton.STATUS_PLACED;
               this.shootoutRoundThreeButton.status = LobbyShootoutRoundButton.STATUS_ELIGIBLE;
               break;
         }
         
      }
      
      public function showPremiumLobby(param1:Array) : void {
         var _loc3_:PowerTournamentsHappyHourView = null;
         var _loc2_:* = 0;
         if(this.mcLobby.premium_mc.numChildren == 1)
         {
            _loc3_ = new PowerTournamentsHappyHourView(PokerClassProvider.getObject("PowerTournamentsHappyHourView"),this.mcLobby);
            _loc3_.name = "PowerTournamentsHappyHourView";
            _loc3_.x = this.enablePowerTourneyLobbyTab?5:7;
            _loc3_.y = this.enablePowerTourneyLobbyTab?7:28;
            _loc2_ = 0;
            while(_loc2_ < _loc3_.list.length)
            {
               if(_loc2_ < param1.length)
               {
                  _loc3_.updateConfigForIndex(_loc2_,param1[_loc2_]);
                  _loc3_.list[_loc2_]["cta"].addEventListener(MouseEvent.CLICK,this.onPremiumTournamentPlayNow,false,0,true);
               }
               else
               {
                  _loc3_.updateConfigForIndex(_loc2_,null);
               }
               _loc2_++;
            }
            _loc3_.helpCTA.addEventListener(MouseEvent.CLICK,this.onHowToPlayClick,false,0,true);
            _loc3_.showHappyHourFooter = this.isCurrentlyHappyHour;
            this.mcLobby.premium_mc.addChild(_loc3_);
         }
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PowerTourneyHappyHour:Tab:2012-10-09"));
      }
      
      private function onPremiumTournamentPlayNow(param1:MouseEvent) : void {
         var _loc2_:int = this.mcLobby.premium_mc.getChildByName("PowerTournamentsHappyHourView")["list"].indexOf(param1.currentTarget.parent) + 1;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:PowerTourneyHappyHour:EntranceButton:" + String(_loc2_) + ":2012-10-09"));
         this.dispatchEvent(new LVEvent(LVEvent.PREMIUM_CLICK,param1.currentTarget.parent.config));
      }
      
      public function showWeeklyLoading() : void {
         this.plModel.sLobbyMode = "weekly";
         this.setLobbyDisplay();
         var _loc1_:MovieClip = this.mcLobby.weekly_mc;
         _loc1_.visible = true;
         this.mcLobby.shootout_mc.visible = false;
         this.mcLobby.buyin_btn.visible = false;
         this.mcLobby.howToPlayButton.visible = false;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_.numChildren)
         {
            _loc1_.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
         _loc1_.bg.visible = true;
         _loc1_.logo.visible = true;
         if(!_loc1_.contains(this.weeklySpinner))
         {
            _loc1_.addChild(this.weeklySpinner);
            this.weeklySpinner.gotoAndPlay(0);
         }
      }
      
      public function updateWeeklyConfig(param1:Object) : void {
         var inData:Object = param1;
         this.plModel.sLobbyMode = "weekly";
         this.setLobbyDisplay();
         this.mcLobby.weekly_mc.visible = true;
         this.mcLobby.shootout_mc.visible = false;
         this.mcLobby.buyin_btn.visible = true;
         this.mcLobby.howToPlayButton.visible = true;
         var i:int = 0;
         while(i < this.mcLobby.weekly_mc.numChildren)
         {
            this.mcLobby.weekly_mc.getChildAt(i).visible = true;
            i++;
         }
         if(this.weekly.contains(this.weeklySpinner))
         {
            this.weeklySpinner.stop();
            this.weekly.removeChild(this.weeklySpinner);
         }
         if(parseInt(inData.tourneyState))
         {
            if(!parseInt(inData.tourneyPoints))
            {
               HtmlTextBox(this.mcLobby.buyin_btn.getChildByName("enterRoundButtonText")).updateText("Buy Back in for $3.00",16);
               this.setWeeklyViewState("buyin");
            }
            else
            {
               HtmlTextBox(this.mcLobby.buyin_btn.getChildByName("enterRoundButtonText")).updateText("Continue Weekly Tourney",12);
               this.setWeeklyViewState("normal");
            }
         }
         else
         {
            HtmlTextBox(this.mcLobby.buyin_btn.getChildByName("enterRoundButtonText")).updateText("Enter Tournament",18);
            this.setWeeklyViewState("normal");
         }
         (this.weekly.getChildByName("potSize") as HtmlTextBox).updateText(inData.tourneyPurse,18);
         var rankStr:String = inData.tourneyRank == 0?"Your Rank: *":"Your Rank: " + inData.tourneyRank;
         var topPercentageStr:String = inData.tourneyRank == 0?"":" Top " + Math.floor(parseInt(inData.tourneyRank) / parseInt(inData.playersLeft) * 100).toString() + "%";
         var rankTextData:Array = [
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":rankStr
            },
            {
               "font":"Main",
               "color":16763904,
               "size":14,
               "text":topPercentageStr
            }];
         (this.weekly.getChildByName("ranking") as HtmlTextBox).updateHtmlText(HtmlTextBox.getHtmlString(rankTextData));
         var tChipsData:Array = [
            {
               "font":"Main",
               "color":16777215,
               "size":14,
               "text":"Tourney Chips: "
            },
            {
               "font":"Main",
               "color":65331,
               "size":14,
               "text":LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(inData.tourneyPoints,false,0,false)})
            }];
         (this.weekly.getChildByName("tourneyChips") as HtmlTextBox).updateHtmlText(HtmlTextBox.getHtmlString(tChipsData));
         (this.weekly.getChildByName("friendsLeft") as HtmlTextBox).updateText(inData.friendsLeft + " of " + inData.friendsTotal + " Friends Left",14);
         if(!this.weekly.weeklyCheckBox.hasEventListener(MouseEvent.CLICK))
         {
            this.weekly.weeklyCheckBox.addEventListener(MouseEvent.CLICK,this.onWeeklyTellFriendsCheckBoxClick,false,0,true);
         }
         if(!this.weekly.clAll.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            this.weekly.clAll.addEventListener(MouseEvent.MOUSE_DOWN,this.onShowWeeklyChipLeaders,false,0,true);
         }
         if(!this.weekly.clFriends.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            this.weekly.clFriends.addEventListener(MouseEvent.MOUSE_DOWN,this.onShowWeeklyChipFriends,false,0,true);
         }
         if(!this.weekly.clAll.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.weekly.clAll.addEventListener(MouseEvent.MOUSE_OVER,function():void
            {
               weekly.clAll.gotoAndStop(2);
            },false,0,true);
         }
         if(!this.weekly.clFriends.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.weekly.clFriends.addEventListener(MouseEvent.MOUSE_OVER,function():void
            {
               weekly.clFriends.gotoAndStop(2);
            },false,0,true);
         }
         if(!this.weekly.clAll.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.weekly.clAll.addEventListener(MouseEvent.MOUSE_OUT,this.checkWeeklyLeadersButtonState,false,0,true);
         }
         if(!this.weekly.clFriends.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.weekly.clFriends.addEventListener(MouseEvent.MOUSE_OUT,this.checkWeeklyLeadersButtonState,false,0,true);
         }
         if(!this.weekly.clAll.hasEventListener(MouseEvent.MOUSE_UP))
         {
            this.weekly.clAll.addEventListener(MouseEvent.MOUSE_UP,this.checkWeeklyLeadersButtonState,false,0,true);
         }
         if(!this.weekly.clFriends.hasEventListener(MouseEvent.MOUSE_UP))
         {
            this.weekly.clFriends.addEventListener(MouseEvent.MOUSE_UP,this.checkWeeklyLeadersButtonState,false,0,true);
         }
         this.weekly.clAll.buttonMode = true;
         this.weekly.clFriends.buttonMode = true;
         if(this.plModel.oWeeklyData.friends != undefined)
         {
            this.onShowWeeklyChipFriends(null);
         }
         else
         {
            this.onShowWeeklyChipLeaders(null);
         }
      }
      
      public function checkWeeklyLeadersButtonState(param1:MouseEvent=null) : void {
         if(this.bIsShowingWeeklyLeaders)
         {
            this.weekly.clAll.gotoAndStop(2);
            this.weekly.clFriends.gotoAndStop(1);
         }
         else
         {
            this.weekly.clAll.gotoAndStop(1);
            this.weekly.clFriends.gotoAndStop(2);
         }
      }
      
      public function onWeeklyTellFriendsCheckBoxClick(param1:MouseEvent) : void {
         if(this.weekly.weeklyCheckBox.onState.visible)
         {
            this.weekly.weeklyCheckBox.onState.visible = false;
         }
         else
         {
            this.weekly.weeklyCheckBox.onState.visible = true;
         }
         dispatchEvent(new LVEvent(LVEvent.ON_TELL_FRIENDS_CHECK_BOX_CLICK,this.weekly.weeklyCheckBox.onState.visible));
      }
      
      public function onShowWeeklyChipLeaders(param1:MouseEvent) : void {
         var _loc2_:* = 0;
         while(true)
         {
            if(!(this.plModel.oWeeklyData.leaders == undefined) && (this.plModel.oWeeklyData.leaders[_loc2_]))
            {
               this.weekly.leaders.getChildByName(_loc2_.toString()).loadData(this.plModel.oWeeklyData.leaders[_loc2_].name,this.plModel.oWeeklyData.leaders[_loc2_].points,this.plModel.oWeeklyData.leaders[_loc2_].pic_url);
               this.weekly.leaders.getChildByName(_loc2_.toString()).y = _loc2_ * 42 + 4;
               this.weekly.leaders.getChildByName(_loc2_.toString()).x = 3;
               this.weekly.leaders.getChildByName(_loc2_.toString()).visible = true;
            }
            else
            {
               this.weekly.leaders.getChildByName(_loc2_.toString()).visible = false;
            }
            _loc2_++;
         }
         
      }
      
      public function onShowWeeklyChipFriends(param1:MouseEvent) : void {
         var _loc2_:* = 0;
         while(true)
         {
            if(!(this.plModel.oWeeklyData.friends == undefined) && (this.plModel.oWeeklyData.friends[_loc2_]))
            {
               this.weekly.leaders.getChildByName(_loc2_.toString()).loadData(this.plModel.oWeeklyData.friends[_loc2_].name,this.plModel.oWeeklyData.friends[_loc2_].points,this.plModel.oWeeklyData.friends[_loc2_].pic_url);
               this.weekly.leaders.getChildByName(_loc2_.toString()).y = _loc2_ * 42 + 4;
               this.weekly.leaders.getChildByName(_loc2_.toString()).x = 3;
               this.weekly.leaders.getChildByName(_loc2_.toString()).visible = true;
            }
            else
            {
               this.weekly.leaders.getChildByName(_loc2_.toString()).visible = false;
            }
            _loc2_++;
         }
         
      }
      
      public function setWeeklyViewState(param1:String="normal") : void {
         if(param1 == "normal")
         {
            this.weekly.getChildByName("potSizeLabel").visible = true;
            this.weekly.getChildByName("potSize").visible = true;
            this.weekly.getChildByName("ranking").visible = true;
            this.weekly.getChildByName("tourneyChips").visible = true;
            this.weekly.getChildByName("friendsLeft").visible = true;
            this.weekly.getChildByName("tellFriends").visible = true;
            this.weekly.weeklyCheckBox.visible = true;
            this.weekly.weeklyCheckBox.onState.visible = false;
            this.weekly.getChildByName("buyBackHead").visible = false;
            this.weekly.getChildByName("buyBackDisc").visible = false;
            this.weekly.creditCards.visible = false;
         }
         else
         {
            if(param1 == "buyin")
            {
               this.weekly.getChildByName("potSizeLabel").visible = false;
               this.weekly.getChildByName("potSize").visible = false;
               this.weekly.getChildByName("ranking").visible = false;
               this.weekly.getChildByName("tourneyChips").visible = false;
               this.weekly.getChildByName("friendsLeft").visible = false;
               this.weekly.getChildByName("tellFriends").visible = false;
               this.weekly.weeklyCheckBox.visible = false;
               this.weekly.getChildByName("buyBackHead").visible = true;
               this.weekly.getChildByName("buyBackDisc").visible = true;
               this.weekly.creditCards.visible = true;
            }
         }
         if(this.plModel.disableShareWithFriendsCheckboxes)
         {
            this.weekly.getChildByName("tellFriends").visible = false;
            this.weekly.weeklyCheckBox.visible = false;
         }
      }
      
      public function lockedCellFormatter(param1:Object) : String {
         return "";
      }
      
      public function playersCellFormatter(param1:Object) : String {
         var _loc2_:* = "sitPlayers";
         var _loc3_:* = "maxPlayers";
         return PokerGlobalData.instance.enableHyperJoin?PokerCurrencyFormatter.numberToCurrency(param1[_loc3_],true,0,false):PokerCurrencyFormatter.numberToCurrency(param1[_loc2_],true,0,false) + " / " + PokerCurrencyFormatter.numberToCurrency(param1[_loc3_],true,0,false);
      }
      
      public function stakesCellFormatter(param1:Object) : String {
         var _loc2_:* = "smallBlind";
         var _loc3_:* = "bigBlind";
         return PokerCurrencyFormatter.numberToCurrency(param1[_loc2_],true,0,false) + " / " + PokerCurrencyFormatter.numberToCurrency(param1[_loc3_],true,0,false);
      }
      
      public function minBuyInCellFormatter(param1:Object) : String {
         var _loc2_:* = "minBuyIn";
         var _loc3_:* = "maxBuyIn";
         return PokerCurrencyFormatter.numberToCurrency(param1[_loc2_],true,0,false) + " / " + PokerCurrencyFormatter.numberToCurrency(param1[_loc3_],true,0,false);
      }
      
      public function maxBuyInCellFormatter(param1:Object) : String {
         return PokerCurrencyFormatter.numberToCurrency(param1["maxBuyIn"],true,0,false);
      }
      
      public function feeCellFormatter(param1:Object) : String {
         return PokerCurrencyFormatter.numberToCurrency(param1["entryFee"],true,0,false) + " + " + PokerCurrencyFormatter.numberToCurrency(param1["hostFee"],true,0,false);
      }
      
      public function playerSpeedCellFormatter(param1:Object) : String {
         if(param1["playerSpeed"] == "-1")
         {
            return "-";
         }
         return param1["playerSpeed"] + " sec.";
      }
      
      public function get shootoutBadgeUrl() : String {
         return this._shootoutBadgeUrl;
      }
      
      public function set shootoutBadgeUrl(param1:String) : void {
         this._shootoutBadgeUrl = param1;
         if(this._shootoutBadgeUrl != "")
         {
            this.shootoutBadgeLoader = new SafeImageLoader();
            this.shootoutBadgeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onShootoutBadgeLoaderComplete,false,0,true);
            this.shootoutBadgeLoader.load(new URLRequest(this._shootoutBadgeUrl));
         }
      }
      
      private function onShootoutBadgeLoaderComplete(param1:Event) : void {
         this.shootoutBadgeLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onShootoutBadgeLoaderComplete);
         this.mcLobby.shootout_mc.badgeContainer.addChild(this.shootoutBadgeLoader);
         this.mcLobby.shootout_mc.badgeContainer.visible = true;
         this.mcLobby.shootout_mc.learnmore_btn.visible = true;
         this.mcLobby.shootout_mc.learnmore_btn.buttonMode = true;
         this.mcLobby.shootout_mc.learnmore_btn.useHandCursor = true;
         this.mcLobby.shootout_mc.learnmore_btn.addEventListener(MouseEvent.CLICK,this.onLearnMoreClick,false,0,true);
      }
      
      public function unlockLobbyGrid() : void {
         this.lobbyGrid.unlockLobbyGrid();
      }
      
      public function getTableRebalFTUE() : MovieClip {
         var _loc1_:Point = null;
         var _loc2_:EmbeddedFontTextField = null;
         if(!this._hasClosedTableRebalFTUE)
         {
            if(this._tableRebalFTUE == null)
            {
               _loc1_ = localToGlobal(new Point(this.roomSortDropDown.x,this.roomSortDropDown.y));
               this._tableRebalFTUE = PokerClassProvider.getObject("IncreaseTableStakesFTUE");
               this._tableRebalFTUE.closeButton.buttonMode = true;
               this._tableRebalFTUE.closeButton.useHandCursor = true;
               this._tableRebalFTUE.closeButton.addEventListener(MouseEvent.CLICK,this.onHideTableRebalFTUE,false,0,true);
               this._tableRebalFTUE.x = _loc1_.x + 30;
               this._tableRebalFTUE.y = _loc1_.y;
               _loc2_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.ftue.tablerebalance.msg"),"Main",12,2449333,"center",true);
               _loc2_.multiline = true;
               _loc2_.wordWrap = true;
               _loc2_.width = 135;
               _loc2_.autoSize = TextFieldAutoSize.CENTER;
               _loc2_.x = (75 - _loc2_.width) / 2;
               _loc2_.y = -this._tableRebalFTUE.height / 2 - _loc2_.height / 2 - 5;
               this._tableRebalFTUE.addChild(_loc2_);
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:TableRebalFTUE:2012-08-06"));
            }
         }
         return this._tableRebalFTUE;
      }
      
      private function onHideTableRebalFTUE(param1:MouseEvent) : void {
         if(this._tableRebalFTUE == null)
         {
            return;
         }
         this._tableRebalFTUE.closeButton.removeEventListener(MouseEvent.CLICK,this.onHideTableRebalFTUE);
         dispatchEvent(new LVEvent(LVEvent.HIDE_TABLE_REBAL_FTUE,this._tableRebalFTUE));
         this._hasClosedTableRebalFTUE = true;
         this._tableRebalFTUE = null;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:TableRebalFTUE:Close:2012-08-06"));
      }
      
      private function showTooltip(param1:String, param2:Number, param3:Number, param4:Number, param5:Number=0) : void {
         var _loc6_:Point = null;
         this.hideTooltip();
         if(stage != null)
         {
            this.tooltipParent = stage;
            this.tooltip = new Tooltip(param2,param1,"","",16777215,true,9,param5);
            _loc6_ = this.tooltipParent.globalToLocal(localToGlobal(new Point(param3,param4)));
            this.tooltip.x = _loc6_.x;
            this.tooltip.y = _loc6_.y;
            this.tooltipParent.addChild(this.tooltip);
         }
      }
      
      private function hideTooltip() : void {
         if(!(this.tooltip == null) && !(this.tooltipParent == null) && (this.tooltipParent.contains(this.tooltip)))
         {
            this.tooltip.visible = false;
            this.tooltipParent.removeChild(this.tooltip);
            this.tooltip = null;
         }
      }
      
      private function getLobbyStakesList(param1:DataProvider) : Array {
         var _loc2_:Array = null;
         var _loc3_:DataProvider = null;
         var _loc4_:Dictionary = null;
         var _loc5_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         _loc2_ = [];
         this.plModel.smallBlindLevels = [];
         _loc3_ = param1.clone();
         _loc3_.sortOn("minBuyIn",Array.DESCENDING | Array.NUMERIC);
         _loc4_ = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_.getItemAt(_loc5_);
            _loc7_ = this.stakesCellFormatter(_loc6_);
            if(_loc6_["type"] == this.plModel.filterTableType)
            {
               if(!_loc4_[_loc7_])
               {
                  _loc4_[_loc7_] = true;
                  this.plModel.smallBlindLevels.push(
                     {
                        "smallBlind":_loc6_.smallBlind,
                        "maxBuyIn":_loc6_.maxBuyIn,
                        "desc":_loc7_
                     });
                  _loc2_.push(
                     {
                        "label":_loc7_,
                        "value":_loc7_,
                        "icon":((_loc6_["chipLocked"]) || (_loc6_["levelLocked"])?PokerClassProvider.getObject("LockIconAlt"):null)
                     });
               }
            }
            _loc5_++;
         }
         if(this.plModel.xpLevel < 4)
         {
            _loc2_.reverse();
         }
         _loc2_.unshift(
            {
               "label":LocaleManager.localize("flash.lobby.minMaxFilterDropdown.defaultOption"),
               "value":"All"
            });
         return _loc2_;
      }
      
      public function displayRoomListEmptyLobbyLock() : void {
         this.unlockLobbyGrid();
         this.lobbyGrid.lockLobbyGrid(LocaleManager.localize("flash.lobby.lobbyLockRoomFilterEmpty"),16,false);
         dispatchEvent(new LVEvent(LVEvent.DISPLAY_ROOM_SORT_DROPDOWN_ARROW));
         PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyImpressionEmptyListLock",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Impression EmptyListLock o:LobbyUI:2010-07-01","",1,"",PokerStatHit.HITTYPE_FG));
      }
      
      private function onRoomSortDropDownClick(param1:Event) : void {
         this.userPreferencesContainer.setUserPreferenceSource("buyin");
         dispatchEvent(new LVEvent(LVEvent.MINMAX_FILTER_BUTTON_CLICK));
         PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyClickRoomFilterDropDown",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click RoomFilterDropDown o:LobbyUI:2010-07-01","",1,"",PokerStatHit.HITTYPE_FG));
      }
      
      private function onRmSrtDrpDwnScrlBrClick(param1:Event) : void {
         dispatchEvent(new LVEvent(LVEvent.MINMAX_FILTER_SCROLLBAR_CLICK));
         PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyClickRoomFilterScrollBar",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click RoomFilterScrollBar o:LobbyUI:2010-07-01","",1,"",PokerStatHit.HITTYPE_FG));
      }
      
      private function onMinMaxFilterKeySelected(param1:UIComponentEvent) : void {
         if(String(param1.params) != "default")
         {
            dispatchEvent(new LVEvent(LVEvent.MINMAX_FILTER_KEY_SELECTED,{"key":param1.params}));
            PokerStatsManager.DoHitForStat(new PokerStatHit("lobbyClickRoomFilterDropDownSelected",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click RoomFilterDropDownSelected o:LobbyUI:2010-07-01","",1,"",PokerStatHit.HITTYPE_FG));
         }
      }
      
      public function showLockOverlayOnLobbyGrid(param1:Number) : void {
         if(!this.lockOverlay)
         {
            this.lockOverlay = PokerClassProvider.getObject("LockOverlay");
            this.lockOverlay.x = 58;
            this.lockOverlay.y = 156;
            this.unlockAtLevelTF = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.grid.lockOverlay.unlockAtLevel"),"MainCondensed",36,4342338,"center");
            this.unlockAtLevelTF.x = 8;
            this.unlockAtLevelTF.y = 25;
            this.unlockAtLevelTF.width = 420;
            this.unlockAtLevelTF.height = 46;
            this.lockOverlay.addChild(this.unlockAtLevelTF);
            addChild(this.lockOverlay);
         }
         this.lockOverlay.visible = true;
         this.unlockAtLevelTF.text = LocaleManager.localize("flash.lobby.gameSelector.grid.lockOverlay.unlockAtLevel",{"xpLevel":param1});
      }
      
      public function hideLockOverlayOnLobbyGrid() : void {
         if(this.lockOverlay)
         {
            this.lockOverlay.visible = false;
         }
      }
      
      private function onLobbyGridPurchaseFastTablesClick(param1:LVEvent) : void {
         dispatchEvent(param1);
      }
      
      public function showHighLowArrow(param1:Boolean) : void {
         if((this._highLowArrowEnabled) && (param1) && this._highLowArrow == null)
         {
            this.initHighLowArrow();
         }
         if(this._highLowArrow != null)
         {
            this._highLowArrow.visible = param1;
         }
      }
      
      private function hideHighLowArrow(param1:MouseEvent) : void {
         this._highLowArrow.visible = false;
      }
      
      private function initHighLowArrow() : void {
         var _loc1_:EmbeddedFontTextField = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         this._highLowArrow = new MovieClip();
         _loc1_ = new EmbeddedFontTextField("","Main",13,16777215);
         _loc1_.autoSize = TextFieldAutoSize.RIGHT;
         _loc1_.multiline = true;
         _loc1_.wordWrap = true;
         _loc1_.height = 55;
         _loc1_.width = 90;
         _loc1_.x = -132;
         _loc1_.y = -22;
         _loc1_.text = LocaleManager.localize("flash.minigame.highlow.lobby.text");
         _loc1_.fontSize = LocaleManager.locale == "id"?11:Number(150 / Math.max(_loc1_.textWidth,150)) * 13;
         _loc2_ = PokerClassProvider.getObject("HighLowLogoNew");
         _loc2_.useHandCursor = false;
         _loc2_.buttonMode = false;
         _loc2_.scaleX = 0.25;
         _loc2_.scaleY = 0.25;
         _loc2_.x = -5;
         _loc2_.y = -5;
         _loc3_ = PokerClassProvider.getObject("HighLowCloseButton");
         _loc3_.x = 42;
         _loc3_.y = -15;
         _loc4_ = PokerClassProvider.getObject("HighLowArrowBase");
         _loc4_.useHandCursor = false;
         _loc4_.buttonMode = false;
         _loc4_.width = 195.5;
         _loc4_.height = 63;
         _loc4_.x = -19;
         _loc4_.y = -38;
         this._highLowArrow.addChild(_loc4_);
         this._highLowArrow.addChild(_loc2_);
         this._highLowArrow.addChild(_loc3_);
         this._highLowArrow.addChild(_loc1_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.hideHighLowArrow);
         if(this.mcLobby.joinRoom_btn)
         {
            this._highLowArrow.x = this.mcLobby.joinRoom_btn.x;
            this._highLowArrow.y = this.mcLobby.joinRoom_btn.y + 50;
            this.mcLobby.addChild(this._highLowArrow);
         }
      }
      
      private function hideMTT() : void {
         var _loc1_:DisplayObject = null;
         _loc1_ = getChildByName("MTTLobby");
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
            dispatchEvent(new MTTEvent(MTTEvent.MTT_DISABLE_REQUESTS));
         }
      }
      
      private function hideZPWC() : void {
         var _loc1_:DisplayObject = null;
         _loc1_ = getChildByName("ZPWCLobby");
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
            dispatchEvent(new MTTEvent(MTTEvent.ZPWC_DISABLE_REQUESTS));
         }
      }
      
      public function showMTT(param1:DisplayObject) : void {
         if(!param1)
         {
            return;
         }
         if(!contains(param1))
         {
            addChild(param1);
         }
         else
         {
            param1.visible = true;
         }
         dispatchEvent(new MTTEvent(MTTEvent.MTT_ENABLE_REQUESTS));
      }
      
      public function showZPWC(param1:DisplayObject) : void {
         if(!param1)
         {
            return;
         }
         if(!contains(param1))
         {
            addChild(param1);
         }
         else
         {
            param1.visible = true;
         }
         dispatchEvent(new MTTEvent(MTTEvent.ZPWC_ENABLE_REQUESTS));
      }
      
      public function set highLowArrowEnabled(param1:Boolean) : void {
         this._highLowArrowEnabled = param1;
      }
      
      private function onScratchersAdClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SCRATCHERS_AD_CLICK));
      }
      
      private function onBlackjackAdClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.BLACKJACK_AD_CLICK));
      }
      
      private function onPokerGeniusAdClick(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.POKER_GENIUS_AD_CLICK));
      }
      
      public function removePokerGeniusLobbyAd() : void {
         this.lobbyAdContainer.removeAdWithKey("Poker Genius");
         this.initLobbyAd();
      }
      
      public function get zpwcFTUE() : MovieClip {
         return this.zpwcLobbyArrow;
      }
      
      private function _showPlayNowFastRibbon() : void {
         if(this._fastRibbonLabel != null)
         {
            this._fastRibbonLabel.visible = true;
         }
         else
         {
            this._fastRibbonLabelDelayedVisible = true;
         }
      }
      
      private function _hidePlayNowFastRibbon() : void {
         if(this._fastRibbonLabel != null)
         {
            this._fastRibbonLabel.visible = false;
         }
         else
         {
            this._fastRibbonLabelDelayedVisible = false;
         }
      }
      
      private function _onPlayNowFastRibbonLoaded(param1:Event) : void {
         this._fastRibbonLabel = param1.currentTarget.content as DisplayObject;
         if(this.isLobbyRedesign)
         {
            this._fastRibbonLabel.x = this._fastRibbonLabel.x + (this.bigFindSeatButton.x + this.bigFindSeatButton.width - this._fastRibbonLabel.width);
            this._fastRibbonLabel.y = this._fastRibbonLabel.y + this.bigFindSeatButton.y;
            addChild(this._fastRibbonLabel);
         }
         else
         {
            this._fastRibbonLabel.x = 122;
            this.findSeatButton.addChild(this._fastRibbonLabel);
         }
         this._fastRibbonLabel.visible = this._fastRibbonLabelDelayedVisible;
      }
      
      private function initVideoPokerEntryPoint() : void {
         var _loc1_:EmbeddedFontTextField = null;
         if(this.isLobbyRedesign)
         {
            this._videoPokerButton = PokerClassProvider.getObject("largeSecondaryButton") as ZButton;
            this._videoPokerButton.x = this.bigFindSeatButton.x + this.bigFindSeatButton.width + 10;
            this._videoPokerButton.y = this.bigFindSeatButton.y;
            this._videoPokerButton.width = this.bigFindSeatButton.width;
            this._videoPokerButton.height = this.bigFindSeatButton.height;
            this._videoPokerButton.init();
            this._videoPokerButton.text = "";
            _loc1_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.videoPoker.playSimple"),"Main",20,16777215,"center",true);
            _loc1_.width = 170;
            _loc1_.height = 26;
            _loc1_.x = 0;
            _loc1_.y = 8;
            _loc1_.scaleX = 1.235;
            this._videoPokerButton.addChild(_loc1_);
         }
         else
         {
            this._videoPokerButton = PokerClassProvider.getObject("standardSecondaryButton") as ZButton;
            this._videoPokerButton.x = LOBBY_LEARNTOPLAY_BUTTON_X;
            this._videoPokerButton.y = LOBBY_LEARNTOPLAY_BUTTON_Y;
            this._videoPokerButton.width = LOBBY_LEARNTOPLAY_BUTTON_WIDTH;
            this._videoPokerButton.init();
            this._videoPokerButton.text = LocaleManager.localize("flash.lobby.videoPoker.play");
         }
         this._videoPokerButton.doLayout();
         addChild(this._videoPokerButton);
         this._videoPokerButton.addEventListener(ZButtonEvent.RELEASE,this.onVideoPokerStart,false,0,true);
         dispatchEvent(new LVEvent(LVEvent.VIDEO_POKER_IMPRESSION));
         this.learnToPlayButton.visible = false;
      }
      
      private function onVideoPokerStart(param1:ZButtonEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.SHOW_VIDEO_POKER));
      }
   }
}
