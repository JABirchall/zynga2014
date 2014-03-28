package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.table.asset.PokerButton;
   import flash.display.MovieClip;
   import com.zynga.poker.table.asset.MuteIcon;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.asset.TableInfo;
   import com.zynga.draw.Box;
   import com.zynga.text.HtmlTextBox;
   import com.zynga.draw.ShineButton;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.display.SafeImageLoader;
   import flash.display.Sprite;
   import com.zynga.poker.table.asset.Poll;
   import com.zynga.poker.table.asset.JumpTablesInfoPane;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.events.ErrorEvent;
   import flash.net.URLRequest;
   import flash.events.Event;
   import __AS3__.vec.Vector;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.table.todo.TAListEvent;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.table.events.controller.TableAdControllerEvent;
   import flash.geom.Point;
   import com.zynga.draw.AutoTriangle;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.PokerClassProvider;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import com.zynga.utils.timers.PokerTimer;
   import caurina.transitions.Tweener;
   import com.zynga.poker.table.events.view.TVEMuteSound;
   import com.zynga.poker.table.events.view.TVEGiftPressed;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.table.events.view.TVEJoinUserPressed;
   import com.zynga.poker.table.tableads.validators.TableAdValidator;
   import com.zynga.poker.table.tableads.validators.HSMRevPromoValidator;
   import com.zynga.poker.table.events.view.TVEPollEvent;
   import flash.display.DisplayObject;
   import com.zynga.poker.constants.ExternalAsset;
   import com.zynga.utils.ExternalAssetManager;
   
   public class TableView extends FeatureView
   {
      
      public function TableView() {
         this._playersClubChairs = {};
         this._pendingChairs = {};
         this._playersClubAssets = {};
         super();
         this.bgCont = PokerClassProvider.getObject("BlankContainer");
         this.bgCont.x = 0;
         this.bgCont.y = 0;
         addChild(this.bgCont);
         this.dummyCards = PokerClassProvider.getObject("BlankContainer");
         this.dummyCards.x = 0;
         this.dummyCards.y = 0;
         addChild(this.dummyCards);
         this._giftCont = new Sprite();
         this._giftCont.x = 0;
         this._giftCont.y = 0;
         addChild(this._giftCont);
         this._scoreCont = new Sprite();
         this._scoreCont.x = 0;
         this._scoreCont.y = 0;
         addChild(this._scoreCont);
         this.chipCont = PokerClassProvider.getObject("BlankContainer");
         this.chipCont.x = 0;
         this.chipCont.y = 0;
         addChild(this.chipCont);
         this._invCont = new Sprite();
         this._invCont.x = 0;
         this._invCont.y = 0;
         addChild(this._invCont);
         this._chatCont = new Sprite();
         this._chatCont.x = 0;
         this._chatCont.y = 0;
         addChild(this._chatCont);
         this._statCont = PokerClassProvider.getObject("BlankContainer");
         this._statCont.x = 0;
         this._statCont.y = 0;
         addChild(this._statCont);
         this.mcPopupNextHand = PokerClassProvider.getObject("PleaseWaitAssets");
         this.mcPopupNextHand.x = 248;
         this.mcPopupNextHand.y = 372;
         addChild(this.mcPopupNextHand);
         this.btnCont = PokerClassProvider.getObject("BlankContainer");
         this.btnCont.x = 0;
         this.btnCont.y = 0;
         addChild(this.btnCont);
         this._bettingPanelContainer = new Sprite();
         addChild(this._bettingPanelContainer);
         this._tAdController = new TableAdController();
         addChild(this._tAdController.adContainer);
      }
      
      private static const TABLE_BACKGROUND_NAME:String = "TableBackground";
      
      private static const PLAYERS_CLUB_NONE:String = "nn";
      
      private static const PLAYERS_CLUB_SILVER:String = "sv";
      
      private static const PLAYERS_CLUB_GOLD:String = "gd";
      
      private static const PLAYERS_CLUB_BLACK:String = "bk";
      
      private static const PLAYERS_CLUB_RED:String = "rd";
      
      private static const KEY_TIER:String = "tier";
      
      private static const KEY_CURR_CHAIR:String = "currChair";
      
      private static const KEY_PREV_CHAIR:String = "prevChair";
      
      public var ptModel:TableModel;
      
      public var leaveButton:PokerButton;
      
      public var jumpTablesButton:PokerButton;
      
      public var muterButton;
      
      public var slotsButton:MovieClip;
      
      private var muter:MuteIcon;
      
      public var joinButton:PokerButton;
      
      public var handButton:PokerButton;
      
      private var _standButton:PokerButton;
      
      public function get standButton() : PokerButton {
         return this._standButton;
      }
      
      private var _chatCont:DisplayObjectContainer;
      
      public function get chatCont() : DisplayObjectContainer {
         return this._chatCont;
      }
      
      private var _invCont:DisplayObjectContainer;
      
      public function get invCont() : DisplayObjectContainer {
         return this._invCont;
      }
      
      public function removeTableAcePopup(param1:int) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.ptModel.tableAcePopups.length)
         {
            if(this.ptModel.tableAcePopups[_loc2_].seat == param1)
            {
               removeChild(this.ptModel.tableAcePopups[_loc2_].textBox);
               this.ptModel.tableAcePopups.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function clearTableAcePopups() : void {
         var _loc1_:Object = null;
         for each (_loc1_ in this.ptModel.tableAcePopups)
         {
            removeChild(_loc1_.textBox);
         }
         this.ptModel.tableAcePopups.length = 0;
      }
      
      private var _giftCont:DisplayObjectContainer;
      
      public function get giftCont() : DisplayObjectContainer {
         return this._giftCont;
      }
      
      private var _scoreCont:DisplayObjectContainer;
      
      public var chipCont:MovieClip;
      
      private var _statCont:MovieClip;
      
      public function get statCont() : MovieClip {
         return this._statCont;
      }
      
      private var bgCont:MovieClip;
      
      public var dummyCards:MovieClip;
      
      public var btnCont:MovieClip;
      
      public var viewer_points:uint = 8786177;
      
      public var viewer_weekly:uint = 8786177;
      
      public var tableInfo:TableInfo;
      
      public var winningHand:Box;
      
      public var winningHandText:HtmlTextBox;
      
      public var mcPopupNextHand:MovieClip;
      
      public var mcPopupNextHandBuyChipsButton:ShineButton;
      
      public var tableMessageTextField:EmbeddedFontTextField;
      
      public var legalReminderTextField:EmbeddedFontTextField;
      
      public var _bgLoad:SafeAssetLoader;
      
      public var bgWidth:Number;
      
      public var bgHeight:Number;
      
      public var logoWidth:Number;
      
      private var _bgLogoLoad:SafeImageLoader;
      
      public var logoCont:MovieClip;
      
      private var tcontents:Sprite;
      
      public var bgStarHeight:Number;
      
      public var bgStarWidth:Number;
      
      public var bgAttempts:int = 0;
      
      public const BG_MAX_ATTEMPTS:int = 3;
      
      public var poll:Poll = null;
      
      private var tableOverlay:TableOverlay;
      
      public var friendInvites:Array;
      
      public var hsmFreeUsagePromoShow:Boolean = false;
      
      private var _tAdController:TableAdController;
      
      public function get tAdController() : TableAdController {
         return this._tAdController;
      }
      
      public var jumpTablesInfoPane:JumpTablesInfoPane;
      
      public var fullScreenModeManager:FullScreenModeManager;
      
      private var _bettingPanelContainer:Sprite;
      
      private var _helpingHandsCont:Sprite;
      
      public function get bettingPanelContainer() : Sprite {
         return this._bettingPanelContainer;
      }
      
      private var showHiLoTestOnFirstFold:Boolean = true;
      
      private var _helpingHandsButton:MovieClip;
      
      private var _helpingHandsButtonAnim:MovieClip;
      
      private var _isTimerSet:Boolean;
      
      private var _helpingHandsConfig:Object;
      
      private var _playersClubChairs:Object;
      
      private var _pendingChairs:Object;
      
      private var _playersClubAssets:Object;
      
      private var _topRightLeaderboardButton:MovieClip;
      
      private var _topRightLeaderboardCont:Sprite;
      
      override protected function _init() : void {
         this.bgAttempts = 0;
         this.setBG();
         this.initButtons();
         this.initBetAds();
         this.onSoundMutePressed();
         this.setTableInfo();
         this.jumpTablesInfoPane = new JumpTablesInfoPane();
         this.jumpTablesInfoPane.x = 760 - (this.jumpTablesInfoPane.width + 4);
         this.jumpTablesInfoPane.y = 4;
         this.jumpTablesInfoPane.visible = false;
         addChild(this.jumpTablesInfoPane);
         this.initUIListeners();
      }
      
      public function initViewMTT() : void {
         this.setBG();
         this.initButtons();
         this.initMTTUIListeners();
         if(this.mcPopupNextHand)
         {
            this.mcPopupNextHand.visible = false;
         }
         if(this._tAdController)
         {
            this._tAdController.adContainer.visible = false;
         }
      }
      
      public function setJoinButtonSelected(param1:Boolean) : void {
         if(this.joinButton != null)
         {
            this.joinButton.setSelectZyngaLive(!param1);
         }
         if(param1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:JoinBuddiesOpen:2011-03-25"));
         }
         else
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:JoinBuddiesClose:2011-03-25"));
         }
      }
      
      public function setBG(param1:ErrorEvent=null) : void {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         this.bgAttempts++;
         if(this.bgAttempts < this.BG_MAX_ATTEMPTS)
         {
            _loc2_ = this.ptModel.tableBackground.sTableBackgroundUrl;
            _loc3_ = new URLRequest(_loc2_);
            this._bgLoad = new SafeAssetLoader();
            this._bgLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,this.addBG,false,0,true);
            this._bgLoad.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this.setBG,false,0,true);
            this._bgLoad.load(_loc3_);
         }
      }
      
      public function setLogo() : void {
         var _loc1_:String = this.ptModel.tableBackground.sLogoUrl;
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this._bgLogoLoad = new SafeImageLoader();
         this._bgLogoLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,this.addBGLogo,false,0,true);
         this._bgLogoLoad.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this.setBG,false,0,true);
         this._bgLogoLoad.load(_loc2_);
      }
      
      public function addBG(param1:Event) : void {
         var _loc3_:* = 0;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:uint = 0;
         var _loc6_:PokerUser = null;
         this.bgWidth = param1.target.width;
         this.bgHeight = param1.target.height;
         this.bgCont.addChild(this._bgLoad);
         var _loc2_:Boolean = this.ptModel.useNewTablesWithPlayersClub();
         if(_loc2_)
         {
            this._bgLoad.name = TABLE_BACKGROUND_NAME;
            this._bgLoad.y = this._bgLoad.y - 40;
            _loc3_ = this.ptModel.room.maxPlayers-1;
            while(_loc3_ >= 0)
            {
               _loc6_ = this.ptModel.getUserBySit(_loc3_);
               if(_loc6_)
               {
                  this.fadeOutBackgroundChair(_loc3_);
               }
               _loc3_--;
            }
            _loc4_ = this.ptModel.playerPosModel.unusedPositions;
            for each (_loc5_ in _loc4_)
            {
               this.hideBackgroundChair(_loc5_);
            }
         }
         if(this.ptModel.tableBackground.bHasLogo)
         {
            this.setLogo();
         }
      }
      
      public function addBGLogo(param1:Event) : void {
         this._bgLogoLoad.x = (this.bgWidth - param1.target.width) / 2;
         this._bgLogoLoad.y = this.ptModel.tableBackground.iLogoY;
         this.bgCont.addChild(this._bgLogoLoad);
         if(this.ptModel.tableBackground.bHasText)
         {
            this.addLogoText();
         }
      }
      
      public function addLogoText(param1:ErrorEvent=null) : void {
         this.tcontents = new Sprite();
         this.tcontents.mouseChildren = false;
         this.tcontents.mouseEnabled = false;
         this.ptModel.tableBackground.sLogoText.x = (this.bgWidth - this.ptModel.tableBackground.sLogoText.textWidth) / 2 - 2;
         this.ptModel.tableBackground.sLogoText.y = (this.bgHeight - this._bgLogoLoad.y - this._bgLogoLoad.height) / 2 + this.ptModel.tableBackground.sLogoText.textHeight - this.ptModel.tableBackground.nMyYOffset;
         this.tcontents.addEventListener(ErrorEvent.ERROR,this.addLogoText,false,0,true);
         this.tcontents.addChild(this.ptModel.tableBackground.sLogoText);
         this.bgCont.addChild(this.tcontents);
         if(this.ptModel.tableBackground.bHasStars)
         {
            this.addStars();
         }
      }
      
      public function addStars(param1:ErrorEvent=null) : void {
         var _loc6_:String = null;
         var _loc7_:URLRequest = null;
         this.bgStarHeight = 12;
         this.bgStarWidth = 12;
         var _loc2_:* = false;
         var _loc3_:Number = 0;
         var _loc4_:Array = new Array(this.ptModel.tableBackground.iStarCount);
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc4_[_loc5_] = new SafeImageLoader();
            _loc6_ = this.ptModel.tableBackground.sStarUrl;
            _loc7_ = new URLRequest(_loc6_);
            _loc4_[_loc5_].contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this.addStars,false,0,true);
            if(_loc2_)
            {
               _loc4_[_loc5_].x = this.ptModel.tableBackground.sLogoText.x + 5 + this.ptModel.tableBackground.sLogoText.width + _loc3_;
               _loc3_ = _loc3_ + (this.bgStarWidth + 1);
            }
            else
            {
               _loc4_[_loc5_].x = this.ptModel.tableBackground.sLogoText.x - 5 - this.bgStarWidth + _loc3_ * -1;
            }
            _loc2_ = !_loc2_;
            _loc4_[_loc5_].y = this.ptModel.tableBackground.sLogoText.y + this.bgStarHeight / 2;
            _loc4_[_loc5_].load(_loc7_);
            this.bgCont.addChild(_loc4_[_loc5_]);
            _loc5_++;
         }
      }
      
      public function clearBG() : void {
         var _loc2_:SafeAssetLoader = null;
         var _loc3_:Sprite = null;
         var _loc1_:* = 0;
         while(this.bgCont.numChildren > 0)
         {
            _loc2_ = this.bgCont.getChildAt(0) as SafeAssetLoader;
            if(_loc2_ != null)
            {
               this.bgCont.removeChildAt(0);
            }
            else
            {
               _loc3_ = this.bgCont.getChildAt(0) as Sprite;
               if(_loc3_ != null)
               {
                  this.bgCont.removeChildAt(0);
               }
            }
            _loc1_++;
         }
      }
      
      private function onTableActionListItemClick(param1:TAListEvent) : void {
         this.onCancelJumpTableSearch(null);
         dispatchEvent(param1);
      }
      
      private function initBetAds() : void {
         var _loc1_:Object = null;
         if((this.ptModel.enableBetControlAds()) && !this.tAdController.initialized)
         {
            _loc1_ = this.ptModel.betAdConfig;
            this._tAdController.setAds(_loc1_.betAdData,_loc1_.betAdFrequency,_loc1_.spectatorAdFrequency);
            this._tAdController.addEventListener(TVEvent.ON_TABLE_AD_BUTTON_CLICK,this.onTableAdButtonClick,false,0,true);
            this._tAdController.addEventListener(TableAdControllerEvent.GET_AD_TOOLTIP,this.onGetTableAdTooltip,false,0,true);
            this._tAdController.addEventListener(TableAdControllerEvent.GET_AD_VALIDATOR,this.onGetTableAdValidator,false,0,true);
         }
      }
      
      private function initButtons() : void {
         var _loc9_:Point = null;
         var _loc10_:Sprite = null;
         var _loc11_:Object = null;
         var _loc1_:Object = new Object();
         _loc1_.gfx = AutoTriangle.make(1118481);
         _loc1_.theX = 59;
         _loc1_.theY = 5;
         var _loc2_:Object = new Object();
         _loc2_.gfx = AutoTriangle.make(1118481);
         _loc2_.gfx.rotation = -90;
         _loc2_.theX = 59;
         _loc2_.theY = 11;
         var _loc3_:Number = 3;
         var _loc4_:Number = 682;
         if((this.ptModel.tableConfig) && (this.ptModel.tableConfig.leaveButtonsTopLeft))
         {
            _loc1_.gfx.rotation = -180;
            _loc1_.theX = 9;
            _loc1_.theY = 11;
            _loc2_.theX = 4;
            _loc3_ = 12;
            _loc4_ = 6;
         }
         if(this.ptModel.pgData.mttZone)
         {
            this.leaveButton = new PokerButton(null,"medium",LocaleManager.localize("flash.popup.MTT.dialog.withdraw"),_loc1_,70,_loc3_);
         }
         else
         {
            this.leaveButton = new PokerButton(null,"medium",LocaleManager.localize("flash.table.controls.toLobbyButton"),_loc1_,70,_loc3_);
         }
         this.leaveButton.name = "btnTableControlsToLobby";
         this.btnCont.addChild(this.leaveButton);
         this.leaveButton.x = _loc4_;
         this.leaveButton.y = 5;
         this._standButton = new PokerButton(null,"medium",LocaleManager.localize("flash.table.controls.standUpButton"),_loc2_,70,_loc3_);
         this._standButton.name = "btnTableControlsStandUp";
         this.btnCont.addChild(this._standButton);
         this._standButton.visible = false;
         this._standButton.x = _loc4_;
         this._standButton.y = 30;
         var _loc5_:Object = new Object();
         _loc5_.gfx = AutoTriangle.make(1118481);
         _loc5_.gfx.rotation = 0.0;
         _loc5_.theX = 59;
         _loc5_.theY = 13;
         this.jumpTablesButton = new PokerButton(null,"medium",LocaleManager.localize("flash.table.jumpTablesButtonLabel"),_loc5_,70,12);
         this.jumpTablesButton.size = new Point(this.jumpTablesButton.width,32);
         if(this.ptModel.pgData.jumpTablesEnabled)
         {
            if(this.ptModel.room.gameType.toLowerCase() != "challenge")
            {
               this.jumpTablesButton.visible = false;
            }
            this.btnCont.addChild(this.jumpTablesButton);
         }
         this.jumpTablesButton.x = 682;
         this.jumpTablesButton.y = 30;
         if(this.ptModel.redesignConfig.bettingUI)
         {
            _loc9_ = this.btnCont.globalToLocal(this.muterButton.localToGlobal(new Point(0,0)));
            this.muterButton.x = _loc9_.x;
            this.muterButton.y = _loc9_.y;
         }
         else
         {
            this.muter = new MuteIcon();
            _loc10_ = new Sprite();
            _loc10_.addChild(this.muter);
            _loc11_ = new Object();
            _loc11_.gfx = _loc10_;
            _loc11_.theX = 7;
            _loc11_.theY = 5;
            this.muterButton = new PokerButton(null,"large","",_loc11_,30);
            this.muterButton.x = 250;
            this.muterButton.y = 500;
         }
         this.btnCont.addChild(this.muterButton);
         if((this.ptModel.pgData.freeFullScreenMode) || (this.ptModel.pgData.rakeFullScreenMode))
         {
            this.fullScreenModeManager = new FullScreenModeManager(this,this.ptModel.pgData.freeFullScreenMode);
            this.fullScreenModeManager.init();
         }
         var _loc6_:MovieClip = PokerClassProvider.getObject("ZLStatus");
         _loc6_.stop();
         var _loc7_:Object = new Object();
         _loc7_.gfx = _loc6_;
         _loc7_.theX = 2;
         _loc7_.theY = 6;
         this.joinButton = new PokerButton(null,"large",LocaleManager.localize("flash.table.controls.pokerBuddiesButton",{"count":this.ptModel.nZoomFriends}),_loc7_,150,13,-1,-1);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:PokerBuddiesOnline:2011-04-21","",this.ptModel.nZoomFriends));
         this.joinButton.x = 354;
         this.joinButton.y = 500;
         this.joinButton.setZLStatus(this.ptModel.nZoomFriends);
         this.btnCont.addChild(this.joinButton);
         if((this.ptModel.pgData.mttZone) || (this.ptModel.redesignConfig.bettingUI))
         {
            this.joinButton.visible = false;
         }
         if(!this.tableMessageTextField)
         {
            this.tableMessageTextField = new EmbeddedFontTextField("","Main",14,16777215,"center");
            this.tableMessageTextField.autoSize = TextFieldAutoSize.LEFT;
            this.tableMessageTextField.height = 40;
            this.tableMessageTextField.y = 8;
            this.tableMessageTextField.mouseEnabled = false;
            this.tableMessageTextField.selectable = false;
            this.mcPopupNextHand.NormalBackground.addChild(this.tableMessageTextField);
         }
         if(!this.legalReminderTextField)
         {
            this.legalReminderTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.message.legalReminder"),"Main",12,16777215,"center");
            this.legalReminderTextField.width = 290;
            this.legalReminderTextField.height = 40;
            this.legalReminderTextField.x = -12;
            this.legalReminderTextField.y = 90;
            this.legalReminderTextField.mouseEnabled = false;
            this.legalReminderTextField.multiline = true;
            this.legalReminderTextField.selectable = false;
            this.legalReminderTextField.wordWrap = true;
            this.mcPopupNextHand.addChild(this.legalReminderTextField);
         }
         var _loc8_:TextFormat = new TextFormat("Myriad Pro",12,16777215);
         this.mcPopupNextHand.postToPlayRadioOne.setStyle("textFormat",_loc8_);
         this.mcPopupNextHand.postToPlayRadioTwo.setStyle("textFormat",_loc8_);
         if(!this.ptModel.configModel.getBooleanForFeatureConfig("core","disableGetChipsAndGold"))
         {
            this.mcPopupNextHandBuyChipsButton = new ShineButton(120,26,LocaleManager.localize("flash.table.message.getChipsAndGoldButton"),13,"gold",true);
            this.mcPopupNextHandBuyChipsButton.x = 168;
            this.mcPopupNextHandBuyChipsButton.y = 64;
            this.mcPopupNextHand.addChild(this.mcPopupNextHandBuyChipsButton);
         }
      }
      
      public function initTopRightLeaderboardButton() : void {
         this._topRightLeaderboardButton = PokerClassProvider.getObject("topRightLeaderboardButton");
         this._topRightLeaderboardButton.mouseChildren = false;
         this._topRightLeaderboardButton.buttonMode = true;
         this._topRightLeaderboardButton.x = 705;
         this._topRightLeaderboardButton.y = 20;
         this._topRightLeaderboardCont = new Sprite();
         addChild(this._topRightLeaderboardCont);
         this._topRightLeaderboardCont.addChild(this._topRightLeaderboardButton);
         this._topRightLeaderboardButton.mouseEnabled = true;
         this._topRightLeaderboardButton.addEventListener(MouseEvent.CLICK,this.onTopRightLeaderboardPressed,false,0,true);
      }
      
      private function onTopRightLeaderboardPressed(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.SHOW_LEADERBOARD));
      }
      
      public function initHelpingHandsButton() : void {
         this._helpingHandsButtonAnim = PokerClassProvider.getObject("helpingHandsButtonAnim");
         this._helpingHandsButtonAnim.mouseChildren = false;
         this._helpingHandsButtonAnim.buttonMode = true;
         this._helpingHandsButtonAnim.x = 700;
         this._helpingHandsButtonAnim.y = 5;
         this._helpingHandsCont = new Sprite();
         addChild(this._helpingHandsCont);
         this._helpingHandsCont.addChild(this._helpingHandsButtonAnim);
         this._helpingHandsButtonAnim.mouseEnabled = true;
         this._helpingHandsConfig = this.ptModel.configModel.getFeatureConfig("helpingHands");
         if(this._helpingHandsConfig.rakeData.rakeEnabled)
         {
            this._helpingHandsButtonAnim.offDot.visible = false;
            this._helpingHandsButtonAnim.onDot.visible = true;
         }
         else
         {
            this._helpingHandsButtonAnim.onDot.visible = false;
            this._helpingHandsButtonAnim.offDot.visible = true;
         }
         this._helpingHandsButtonAnim.addEventListener(MouseEvent.CLICK,this.onHelpingHandsPressed,false,0,true);
         this._helpingHandsButtonAnim.addEventListener(MouseEvent.MOUSE_OVER,this.onHelpingHandsMouseOver,false,0,true);
         this._helpingHandsButtonAnim.addEventListener(MouseEvent.ROLL_OUT,this.onHelpingHandsMouseOut,false,0,true);
      }
      
      public function toggleHelpingHandsRake() : void {
         this._helpingHandsButtonAnim.onDot.visible = !this._helpingHandsButtonAnim.onDot.visible;
         this._helpingHandsButtonAnim.offDot.visible = !this._helpingHandsButtonAnim.offDot.visible;
      }
      
      public function animateHHButton() : void {
         PokerTimer.instance.addAnchor(this._helpingHandsConfig.rakeData.animationDuration,this.onHHTimerComplete);
         this._isTimerSet = true;
      }
      
      public function stopHHButtonAnimation() : void {
         this._helpingHandsButtonAnim.gotoAndStop(1);
         this._isTimerSet = false;
      }
      
      public function onHHTimerComplete() : void {
         PokerTimer.instance.removeAnchor(this.onHHTimerComplete);
         this._helpingHandsButtonAnim.gotoAndStop(1);
         this._isTimerSet = false;
      }
      
      public function initMTTButtons() : void {
         if(this.leaveButton)
         {
            this.leaveButton.theText.tf.text = LocaleManager.localize("flash.popup.MTT.dialog.withdraw");
         }
         if(this._standButton)
         {
            this._standButton.visible = false;
         }
      }
      
      public function clearButtons() : void {
         if(!(this.leaveButton == null) && (this.btnCont.contains(this.leaveButton)))
         {
            this.btnCont.removeChild(this.leaveButton);
            this.leaveButton = null;
         }
         if(!(this.standButton == null) && (this.btnCont.contains(this.standButton)))
         {
            this.btnCont.removeChild(this._standButton);
            this._standButton = null;
         }
         if(!(this.jumpTablesButton == null) && (this.btnCont.contains(this.jumpTablesButton)))
         {
            this.btnCont.removeChild(this.jumpTablesButton);
            this.jumpTablesButton = null;
         }
         if(!(this.muterButton == null) && (this.btnCont.contains(this.muterButton)))
         {
            this.btnCont.removeChild(this.muterButton);
            this.muterButton = null;
         }
         if(!(this.joinButton == null) && (this.btnCont.contains(this.joinButton)))
         {
            this.btnCont.removeChild(this.joinButton);
            this.joinButton = null;
         }
      }
      
      private function initUIListeners() : void {
         this.leaveButton.addEventListener(MouseEvent.CLICK,this.onLeaveTablePressed,false,0,true);
         this.leaveButton.addEventListener(MouseEvent.MOUSE_OVER,this.onBoundaryUIMouseOver,false,0,true);
         this.leaveButton.addEventListener(MouseEvent.MOUSE_OUT,this.onBoundaryUIMouseOut,false,0,true);
         this._standButton.addEventListener(MouseEvent.CLICK,this.onStandPressed,false,0,true);
         this._standButton.addEventListener(MouseEvent.MOUSE_OVER,this.onBoundaryUIMouseOver,false,0,true);
         this._standButton.addEventListener(MouseEvent.MOUSE_OUT,this.onBoundaryUIMouseOut,false,0,true);
         this.jumpTablesButton.addEventListener(MouseEvent.CLICK,this.onJumpTablesButtonClick,false,0,true);
         this.jumpTablesInfoPane.addEventListener(TVEvent.ON_CANCEL_JUMP_TABLE_SEARCH,this.onCancelJumpTableSearch,false,0,true);
         this.muterButton.addEventListener(MouseEvent.CLICK,this.onSoundMutePressed,false,0,true);
         this.joinButton.addEventListener(MouseEvent.CLICK,this.onJoinPressed,false,0,true);
         this.mcPopupNextHand.postToPlayRadioOne.addEventListener(MouseEvent.CLICK,this.onPostToPlayChange,false,0,true);
         this.mcPopupNextHand.postToPlayRadioTwo.addEventListener(MouseEvent.CLICK,this.onPostToPlayChange,false,0,true);
         if(this.mcPopupNextHandBuyChipsButton)
         {
            this.mcPopupNextHandBuyChipsButton.addEventListener(MouseEvent.CLICK,this.onBuyChipsClick,false,0,true);
         }
         addEventListener(MouseEvent.CLICK,this.onTablePressed,false,0,true);
      }
      
      private function onTablePressed(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.TABLE_PRESSED));
      }
      
      private function initMTTUIListeners() : void {
         this.leaveButton.addEventListener(MouseEvent.CLICK,this.onLeaveTablePressed,false,0,true);
         this.leaveButton.addEventListener(MouseEvent.MOUSE_OVER,this.onBoundaryUIMouseOver,false,0,true);
         this.leaveButton.addEventListener(MouseEvent.MOUSE_OUT,this.onBoundaryUIMouseOut,false,0,true);
         this._standButton.addEventListener(MouseEvent.CLICK,this.onStandPressed,false,0,true);
         this._standButton.addEventListener(MouseEvent.MOUSE_OVER,this.onBoundaryUIMouseOver,false,0,true);
         this._standButton.addEventListener(MouseEvent.MOUSE_OUT,this.onBoundaryUIMouseOut,false,0,true);
         this.jumpTablesButton.addEventListener(MouseEvent.CLICK,this.onJumpTablesButtonClick,false,0,true);
         this.muterButton.addEventListener(MouseEvent.CLICK,this.onSoundMutePressed,false,0,true);
         this.joinButton.addEventListener(MouseEvent.CLICK,this.onJoinPressed,false,0,true);
         this.joinButton.visible = false;
      }
      
      public function getSeatNum(param1:String) : Number {
         var _loc5_:* = undefined;
         var _loc2_:Number = -1;
         var _loc3_:PokerUser = this.ptModel.getUserByZid(param1);
         var _loc4_:Array = this.ptModel.aUsers;
         for (_loc5_ in _loc4_)
         {
            if(param1 == _loc4_[_loc5_].zId)
            {
               _loc2_ = _loc4_[_loc5_].nSit;
            }
         }
         return _loc2_;
      }
      
      public function cleanupTable() : void {
         this.clearBG();
         this.clearButtons();
         this.onUnloadOverlay(new Event(Event.UNLOAD));
         this.hideWinningHandOnTable();
         if(this._tAdController.initialized)
         {
            this._tAdController.stopAds();
         }
         this.dismissJumpTablesInfoPane(false);
      }
      
      public function cleanupTableMTT() : void {
         this.clearBG();
         this.clearButtons();
      }
      
      private function onLeaveTablePressed(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
      }
      
      public function onLeaveTourney() : void {
         dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
      }
      
      public function onLeaveShootout() : void {
         dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
      }
      
      private function onStandPressed(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.STAND_UP));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:Table:StandUp:2011-05-03"));
      }
      
      private function onHelpingHandsPressed(param1:MouseEvent) : void {
         this._helpingHandsButtonAnim.gotoAndStop(1);
         if(this._isTimerSet)
         {
            PokerTimer.instance.removeAnchor(this.onHHTimerComplete);
         }
         dispatchEvent(new TVEvent(TVEvent.ON_HELPING_HANDS_CLICK));
      }
      
      private function onHelpingHandsMouseOver(param1:MouseEvent) : void {
         this._helpingHandsButtonAnim.gotoAndStop(1);
         if(this._isTimerSet)
         {
            PokerTimer.instance.removeAnchor(this.onHHTimerComplete);
         }
         dispatchEvent(new TVEvent(TVEvent.ON_HELPING_HANDS_HOVER));
      }
      
      private function onHelpingHandsMouseOut(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_HELPING_HANDS_MOUSE_OUT));
      }
      
      private function onJumpTablesButtonClick(param1:MouseEvent) : void {
         if(Tweener.isTweening(this.jumpTablesInfoPane))
         {
            Tweener.removeTweens(this.jumpTablesInfoPane);
         }
         this.jumpTablesInfoPane.showSearchingDialog();
         this.jumpTablesInfoPane.y = -this.jumpTablesInfoPane.height;
         this.jumpTablesInfoPane.visible = true;
         Tweener.addTween(this.jumpTablesInfoPane,
            {
               "y":2,
               "time":0.25,
               "transition":"easeOutQuint"
            });
         dispatchEvent(new TVEvent(TVEvent.ON_START_JUMP_TABLE_SEARCH));
      }
      
      public function onSoundMutePressed(param1:MouseEvent=null) : void {
         if(!this.ptModel.redesignConfig.bettingUI)
         {
            this.muter.toggler(this.ptModel.bTableSoundMute);
         }
         if(param1)
         {
            dispatchEvent(new TVEMuteSound(TVEvent.TOGGLE_MUTE_SOUND,this.ptModel.bTableSoundMute));
         }
      }
      
      public function onJoinPressed(param1:MouseEvent) : void {
         this.onCancelJumpTableSearch(null);
         dispatchEvent(new TVEvent(TVEvent.FRIEND_NET_PRESSED));
      }
      
      public function playerSat() : void {
         if(this.ptModel.nTourneyId > -1 || this.ptModel.room.gameType == "Tournament")
         {
            this._standButton.visible = false;
         }
         else
         {
            if(!this.ptModel.pgData.mttZone)
            {
               this._standButton.visible = true;
            }
         }
         this.updateJumpTablesButtonVisibility();
      }
      
      public function updateAfterBuyIn() : void {
         var _loc1_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         if(_loc1_)
         {
            this.updateAfterSitdown();
         }
      }
      
      public function showSpotlightOverlay(param1:String="") : void {
         var _loc2_:PokerUser = this.ptModel.getUserByZid(this.ptModel.viewer.zid);
         var _loc3_:Array = this.ptModel.tableLayout.getChickletLayout();
         var _loc4_:uint = this.ptModel.playerPosModel.getMappedPosition(_loc2_.nSit);
         var _loc5_:Point = _loc3_[_loc4_].clone();
         if(featureModel.configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc5_.x = _loc5_.x + 7;
            this.tableOverlay = new RedesignTableOverlay(this,TableOverlay.SPOTLIGHT,_loc5_,_loc2_.sUserName,_loc2_.sGender,param1);
         }
         else
         {
            this.tableOverlay = new TableOverlay(this,TableOverlay.SPOTLIGHT,_loc5_,_loc2_.sUserName,_loc2_.sGender,param1);
         }
         this.tableOverlay.addEventListener(Event.UNLOAD,this.onUnloadOverlay,false,0,true);
         addChild(this.tableOverlay);
         if(featureModel.configModel.isFeatureEnabled("skipTables"))
         {
            dispatchEvent(new TVEvent(TVEvent.SKIP_TABLE_OVERLAY));
         }
      }
      
      public function onReasonToClear() : void {
         if(this.tableOverlay)
         {
            this.tableOverlay.onReasonToClear();
            dispatchEvent(new TVEvent(TVEvent.SKIP_TABLE_CLEAR_OVERLAY));
         }
      }
      
      public function updateAfterSitdown() : void {
         var _loc2_:Sprite = null;
         var _loc1_:Boolean = this.ptModel.pgData.showingLevelUpAnimation;
         if(!this.ptModel.isTournament && !_loc1_)
         {
            this.onUnloadOverlay(new Event(Event.UNLOAD));
            this.showSpotlightOverlay();
            _loc2_ = new Sprite();
            if(this.mcPopupNextHand.P2PBackground.numChildren > 0)
            {
               _loc2_.addChild(this.mcPopupNextHand.P2PBackground.getChildAt(0));
            }
            _loc2_.name = "girlOverlay";
            if((this.mcPopupNextHand) && !this.mcPopupNextHand.contains(_loc2_))
            {
               this.mcPopupNextHand.addChildAt(_loc2_,this.mcPopupNextHand.numChildren - 2);
            }
            this.tableMessageTextField.visible = false;
            this.ptModel.pgData.tableOverlayAnimating = true;
         }
      }
      
      public function onUnloadOverlay(param1:Event) : void {
         if(this.tableOverlay)
         {
            removeChild(this.tableOverlay);
            this.tableOverlay = null;
            dispatchEvent(new TVEvent(TVEvent.SKIP_TABLE_CLEAR_OVERLAY));
         }
         this.ptModel.pgData.tableOverlayAnimating = false;
      }
      
      public function clearTable() : void {
         this.hideWinningHandOnTable();
      }
      
      private function onBoundaryUIMouseOver(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.BOUNDARYUI_FADE_IN));
      }
      
      private function onBoundaryUIMouseOut(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.BOUNDARYUI_FADE_OUT));
      }
      
      public function showWinningHandOnTable(param1:String) : void {
         var param1:String = param1.toUpperCase();
         if(this.winningHand == null)
         {
            this.winningHandText = new HtmlTextBox("Main",param1,11,16777215,"center");
            this.winningHandText.x = 49;
            this.winningHandText.y = 10;
            this.winningHand = new Box(100,18,0,false,true,20);
            this.winningHand.x = 328;
            this.winningHand.y = 100;
            this.winningHand.alpha = 0.8;
            this.winningHand.addChild(this.winningHandText);
            addChild(this.winningHand);
         }
         this.winningHand.visible = true;
         this.winningHandText.updateText(param1);
      }
      
      public function hideWinningHandOnTable() : void {
         if(this.winningHand == null)
         {
            return;
         }
         this.winningHand.visible = false;
      }
      
      public function getPendingInviteCount() : int {
         return this.ptModel.aBuddyInvites.length;
      }
      
      public function onInvitePressed() : void {
         dispatchEvent(new TVEvent(TVEvent.INVITE_PRESSED));
      }
      
      public function giftClick(param1:int) : void {
         dispatchEvent(new TVEGiftPressed(TVEvent.GIFT_PRESSED,param1));
      }
      
      public function setTableInfo() : void {
         if(!this.tableInfo)
         {
            this.tableInfo = new TableInfo();
            this.tableInfo.x = 755;
            this.tableInfo.y = 338;
            addChild(this.tableInfo);
         }
         setChildIndex(this.tableInfo,getChildIndex(this.bgCont) + 1);
         var _loc1_:String = this.ptModel.room.gameType == "Tournament" && this.ptModel.nTourneyId == -1?"":PokerCurrencyFormatter.numberToCurrency(this.ptModel.room.smallBlind,true,0) + " / " + PokerCurrencyFormatter.numberToCurrency(this.ptModel.room.bigBlind,true,0);
         var _loc2_:PokerGlobalData = PokerGlobalData.instance;
         var _loc3_:String = (_loc2_.enableHyperJoin) && !(_loc2_.roomNameDisplay == null)?_loc2_.roomNameDisplay:this.ptModel.room.roomName;
         if(_loc2_.flashCookie != null)
         {
            _loc2_.flashCookie.SetValue("sRoomName",_loc3_);
         }
         this.tableInfo.blinds = "";
         this.tableInfo.serverAndTable = LocaleManager.localize("flash.table.info.tableAndBlinds",
            {
               "table":_loc3_,
               "blinds":_loc1_
            });
         if((this.ptModel.pgData.hideTableInfoAtTable) && !this.ptModel.pgData.mttZone)
         {
            this.tableInfo.serverAndTable = "";
         }
      }
      
      public function updateBlinds() : void {
         var _loc1_:String = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(this.ptModel.room.smallBlind,true,2,false)}) + " / " + LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(this.ptModel.room.bigBlind,true,2,false)});
         var _loc2_:PokerGlobalData = PokerGlobalData.instance;
         var _loc3_:String = (_loc2_.enableHyperJoin) && !(_loc2_.roomNameDisplay == null)?_loc2_.roomNameDisplay:this.ptModel.room.roomName;
         this.tableInfo.serverAndTable = LocaleManager.localize("flash.table.info.tableAndBlinds",
            {
               "table":_loc3_,
               "blinds":_loc1_
            });
      }
      
      public function refreshJoinUser(param1:String) : void {
         if(!this.joinButton)
         {
            return;
         }
         var _loc2_:Number = this.ptModel.aJoinFriends.length;
         if(param1 == "friends")
         {
            this.joinButton.theText.updateText(LocaleManager.localize("flash.table.controls.pokerBuddiesButton",{"count":_loc2_}));
         }
         this.joinButton.setZLStatus(this.ptModel.aJoinFriends.length);
      }
      
      public function updatezLiveButtonText(param1:Number) : void {
         var _loc2_:String = null;
         if(param1 != 0)
         {
            _loc2_ = String(this.ptModel.aJoinFriends.length - param1) + " + " + String(param1);
            if(this.joinButton)
            {
               this.joinButton.theText.updateText(LocaleManager.localize("flash.table.controls.pokerBuddiesButton",{"count":_loc2_}));
            }
         }
      }
      
      public function glowButton() : void {
         if(this.joinButton != null)
         {
            this.joinButton.glowZLive();
         }
      }
      
      public function requestJoinUser(param1:String, param2:Number, param3:Number) : void {
         dispatchEvent(new TVEJoinUserPressed(TVEvent.JOIN_USER_PRESSED,param1,param2,param3));
      }
      
      public function betSliderPressed() : void {
         dispatchEvent(new TVEvent(TVEvent.BET_SLIDER_PRESSED));
      }
      
      public function betPlusPressed() : void {
         dispatchEvent(new TVEvent(TVEvent.BET_PLUS_PRESSED));
      }
      
      public function betMinusPressed() : void {
         dispatchEvent(new TVEvent(TVEvent.BET_MINUS_PRESSED));
      }
      
      public function betInputPressed() : void {
         dispatchEvent(new TVEvent(TVEvent.BET_INPUT_PRESSED));
      }
      
      public function updatePopupNextHand(param1:Boolean=false, param2:String="", param3:Boolean=false) : void {
         if(this.ptModel.pgData.disableChipsAndGold)
         {
            param1 = false;
         }
         if(this.ptModel.enableBetControlAds())
         {
            this._tAdController.showAd(this.ptModel.getUserByZid(this.ptModel.viewer.zid) == null);
            this._tAdController.adContainer.visible = param1;
            param1 = false;
         }
         if(this.ptModel.pgData.dispMode == "tournament" || this.ptModel.pgData.dispMode == "shootout" || this.ptModel.pgData.dispMode == "premium" || this.ptModel.aUsers.length == 1)
         {
            this.mcPopupNextHand.visible = param1;
         }
         if(this.ptModel.pgData.dispMode != "weekly")
         {
            this.mcPopupNextHand.visible = false;
         }
         this.updatePostToPlayVisibility(param3);
         this.tableMessageTextField.text = param2;
         this.tableMessageTextField.fitInWidth(126);
         this.tableMessageTextField.x = 103 + (126 - this.tableMessageTextField.textWidth * this.tableMessageTextField.scaleX) / 2;
      }
      
      private function onTableAdButtonClick(param1:TVEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_TABLE_AD_BUTTON_CLICK,param1.params));
      }
      
      private function onGetTableAdTooltip(param1:TableAdControllerEvent) : void {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:String = null;
         var _loc2_:Object = param1.params == null?{}:param1.params;
         _loc2_["resolvedText"] = "";
         var _loc3_:String = _loc2_.text == null?"":_loc2_.text as String;
         if(_loc3_.length > 0)
         {
            _loc4_ = _loc2_.params;
            if(_loc4_)
            {
               for (_loc5_ in _loc4_)
               {
                  _loc6_ = String(_loc4_[_loc5_]);
                  if(_loc6_.indexOf(".") > 0)
                  {
                     _loc7_ = _loc6_.split(".");
                  }
                  else
                  {
                     _loc7_ = [_loc6_ as String];
                  }
                  _loc8_ = this;
                  _loc9_ = _loc7_.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc7_[_loc10_] as String;
                     if(_loc8_ == null)
                     {
                        _loc8_ = "";
                        break;
                     }
                     _loc8_ = _loc8_[_loc11_];
                     _loc10_++;
                  }
                  _loc3_ = _loc3_.replace("{" + _loc5_ + "}",_loc8_);
               }
            }
         }
         _loc2_["resolvedText"] = _loc3_;
         this._tAdController.dispatchEvent(new TableAdControllerEvent(TableAdControllerEvent.GET_AD_TOOLTIP_COMPLETE,_loc2_));
      }
      
      private function onGetTableAdValidator(param1:TableAdControllerEvent) : void {
         var _loc2_:String = param1.params == null?"":String(param1.params);
         var _loc3_:TableAdValidator = null;
         if(_loc2_.length > 0)
         {
            switch(_loc2_)
            {
               case TableAdController.VALIDATOR_TYPE_HSM_REV_PROMO:
                  _loc3_ = new HSMRevPromoValidator(this.ptModel.pgData.rakeEnabled);
                  break;
            }
            
         }
         this.tAdController.dispatchEvent(new TableAdControllerEvent(TableAdControllerEvent.GET_AD_VALIDATOR_COMPLETE,_loc3_));
      }
      
      private function updatePostToPlayVisibility(param1:Boolean) : void {
         if(param1)
         {
            this.tableMessageTextField.visible = false;
            this.mcPopupNextHand.NormalBackground.visible = false;
            this.mcPopupNextHand.P2PHeaderText.visible = true;
            this.mcPopupNextHand.postToPlayRadioOne.visible = true;
            this.mcPopupNextHand.postToPlayRadioTwo.visible = true;
            this.mcPopupNextHand.P2PBackground.visible = true;
         }
         else
         {
            this.tableMessageTextField.visible = true;
            this.mcPopupNextHand.NormalBackground.visible = true;
            this.mcPopupNextHand.P2PHeaderText.visible = false;
            this.mcPopupNextHand.postToPlayRadioOne.visible = false;
            this.mcPopupNextHand.postToPlayRadioTwo.visible = false;
            this.mcPopupNextHand.P2PBackground.visible = false;
         }
      }
      
      public function get postToPlayFlag() : int {
         if(this.mcPopupNextHand.postToPlayRadioOne.selected)
         {
            return 1;
         }
         return 0;
      }
      
      private function onPostToPlayChange(param1:Event) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_POST_TO_PLAY_CHANGE));
      }
      
      public function showPoll(param1:String, param2:String) : void {
         if(this.poll == null)
         {
            this.poll = new Poll(param1,param2);
            this.poll.alpha = 0;
            this.poll.x = 587;
            this.poll.y = 280;
            addChildAt(this.poll,getChildIndex(this.tableInfo) + 1);
            this.poll.addEventListener(TVEPollEvent.POLL_CLOSE,this.onPollClose,false,0,true);
            this.poll.addEventListener(TVEPollEvent.POLL_YES,this.onPollYes,false,0,true);
            this.poll.addEventListener(TVEPollEvent.POLL_NO,this.onPollNo,false,0,true);
         }
         else
         {
            this.poll.alpha = 0;
            this.poll.id = param1;
            this.poll.question = param2;
         }
         Tweener.addTween(this.poll,
            {
               "alpha":1,
               "time":1,
               "transition":"easeInSine"
            });
      }
      
      public function hidePoll() : void {
         if(this.poll != null)
         {
            this.poll.removeEventListener(TVEPollEvent.POLL_CLOSE,this.onPollClose);
            this.poll.removeEventListener(TVEPollEvent.POLL_YES,this.onPollYes);
            this.poll.removeEventListener(TVEPollEvent.POLL_NO,this.onPollNo);
            removeChild(this.poll);
            this.poll = null;
         }
      }
      
      private function onPollClose(param1:TVEPollEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.POLL_CLOSE));
      }
      
      private function onPollYes(param1:TVEPollEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.POLL_YES));
      }
      
      private function onPollNo(param1:TVEPollEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.POLL_NO));
      }
      
      private function onBuyChipsClick(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_BUY_CHIPS_CLICK));
      }
      
      private function onCancelJumpTableSearch(param1:TVEvent) : void {
         this.dismissJumpTablesInfoPane();
         var _loc2_:* = false;
         if((param1) && param1.params.willJumpToLobby == true)
         {
            _loc2_ = true;
            this.hideJumpTablesButton();
            this.prepareTableViewForJump();
         }
         dispatchEvent(new TVEvent(TVEvent.ON_CANCEL_JUMP_TABLE_SEARCH,{"willJumpToLobby":_loc2_}));
      }
      
      public function updateJumpTablesButtonVisibility() : void {
         if(this.ptModel.pgData.jumpTablesEnabled)
         {
            if(this.ptModel.room.gameType.toLowerCase() == "challenge" && this.ptModel.pgData.dispMode.toLowerCase() == "challenge" && !this._standButton.visible)
            {
               this.showJumpTablesButton();
               return;
            }
         }
         this.hideJumpTablesButton();
         this.onCancelJumpTableSearch(null);
      }
      
      public function showJumpTablesButton() : void {
         if((this.jumpTablesButton) && !this.jumpTablesButton.visible)
         {
            this.jumpTablesButton.visible = true;
            dispatchEvent(new TVEvent(TVEvent.ON_JUMP_TABLE_BUTTON_SHOWN));
         }
      }
      
      public function hideJumpTablesButton() : void {
         if((this.jumpTablesButton) && (this.jumpTablesButton.visible))
         {
            this.jumpTablesButton.visible = false;
         }
      }
      
      public function dismissJumpTablesInfoPane(param1:Boolean=true) : void {
         var inAnimated:Boolean = param1;
         if((this.jumpTablesInfoPane) && (contains(this.jumpTablesInfoPane)))
         {
            if(Tweener.isTweening(this.jumpTablesInfoPane))
            {
               Tweener.removeTweens(this.jumpTablesInfoPane);
            }
            if(inAnimated)
            {
               Tweener.addTween(this.jumpTablesInfoPane,
                  {
                     "y":-this.jumpTablesInfoPane.height,
                     "time":0.25,
                     "transition":"easeInQuint",
                     "onComplete":function():void
                     {
                        jumpTablesInfoPane.visible = false;
                     }
                  });
            }
            else
            {
               this.jumpTablesInfoPane.visible = false;
               this.jumpTablesInfoPane.y = -this.jumpTablesInfoPane.height;
            }
         }
      }
      
      public function prepareTableViewForJump() : void {
         this.dismissJumpTablesInfoPane(false);
         dispatchEvent(new TVEvent(TVEvent.ON_TABLE_CLEANUP));
      }
      
      private function isViewerInHand() : Boolean {
         var _loc3_:* = undefined;
         var _loc1_:Array = this.ptModel.aUsers;
         var _loc2_:* = false;
         for (_loc3_ in _loc1_)
         {
            if(this.ptModel.viewer.zid == _loc1_[_loc3_].zid)
            {
               if(_loc1_[_loc3_].sStatusText == "waiting" || _loc1_[_loc3_].sStatusText == "satout" || _loc1_[_loc3_].sStatusText == "fold")
               {
                  return false;
               }
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void {
         super.dispose();
         this.clearPlayersClubChairs();
         while(this._bettingPanelContainer.numChildren > 0)
         {
            this._bettingPanelContainer.removeChildAt(0);
         }
         removeChild(this._bettingPanelContainer);
         this._bettingPanelContainer = null;
         this.ptModel = null;
         this.leaveButton = null;
         this.jumpTablesButton = null;
         this.slotsButton = null;
         this.muter = null;
         this.joinButton = null;
         this.handButton = null;
         this._standButton = null;
         this._chatCont = null;
         this._invCont = null;
         this._giftCont = null;
         this._scoreCont = null;
         this.chipCont = null;
         this._statCont = null;
         this.bgCont = null;
         this.dummyCards = null;
         this.btnCont = null;
         this.tableInfo = null;
         this.winningHand = null;
         this.winningHandText = null;
         this.mcPopupNextHand = null;
         this.mcPopupNextHandBuyChipsButton = null;
         this.tableMessageTextField = null;
         this.legalReminderTextField = null;
      }
      
      public function fadeOutBackgroundChair(param1:int) : void {
         var _loc2_:DisplayObject = null;
         if(featureModel.configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc2_ = this.getMappedBackgroundChairBySeat(param1);
            if(_loc2_)
            {
               _loc2_.alpha = 0.3;
            }
         }
      }
      
      public function fadeInBackgroundChair(param1:int) : void {
         var _loc2_:DisplayObject = null;
         if(featureModel.configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc2_ = this.getMappedBackgroundChairBySeat(param1);
            if(_loc2_)
            {
               _loc2_.alpha = 1;
            }
         }
      }
      
      private function hideBackgroundChair(param1:int) : void {
         var _loc2_:DisplayObject = null;
         if(featureModel.configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc2_ = this.getBackgroundChairBySeat(param1);
            if(_loc2_ !== null)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function getMappedBackgroundChairBySeat(param1:int) : DisplayObject {
         var _loc2_:uint = this.ptModel.playerPosModel.getMappedPosition(param1);
         return this.getBackgroundChairBySeat(_loc2_);
      }
      
      private function getBackgroundChairBySeat(param1:int) : DisplayObject {
         var _loc3_:MovieClip = null;
         var _loc2_:DisplayObject = null;
         if((this._bgLoad) && (this._bgLoad.content))
         {
            _loc3_ = this._bgLoad.content as MovieClip;
            _loc2_ = _loc3_.getChildByName("chair_" + param1);
         }
         return _loc2_;
      }
      
      public function changeSeatByTier(param1:int, param2:String) : void {
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc3_:Boolean = (featureModel.configModel.isFeatureEnabled("playersClub")) && (featureModel.configModel.getBooleanForFeatureConfig("playersClub","usePlayersClubChairs"));
         if(_loc3_)
         {
            if(this.loadPlayersClubSeats(param2))
            {
               this._pendingChairs[param1] = param2;
            }
            else
            {
               this.removePlayersClubChair(param1);
               if(param2 != PLAYERS_CLUB_NONE)
               {
                  _loc4_ = this.getMappedChairAssetBySeat(param1,PLAYERS_CLUB_NONE);
                  _loc5_ = this.getMappedChairAssetBySeat(param1,param2);
                  if(!(_loc4_ == null) && !(_loc5_ == null))
                  {
                     _loc6_ = _loc4_.parent.getChildIndex(_loc4_);
                     _loc4_.visible = false;
                     _loc4_.parent.addChildAt(_loc5_,_loc6_);
                     _loc5_.visible = true;
                     _loc7_ = {};
                     _loc7_[KEY_TIER] = param2;
                     _loc7_[KEY_CURR_CHAIR] = _loc5_;
                     _loc7_[KEY_PREV_CHAIR] = _loc4_;
                     this._playersClubChairs[param1] = _loc7_;
                  }
               }
            }
         }
      }
      
      private function loadPlayersClubSeats(param1:String) : Boolean {
         var _loc3_:SafeAssetLoader = null;
         var _loc4_:String = null;
         var _loc5_:Function = null;
         var _loc2_:* = false;
         if(param1 != PLAYERS_CLUB_NONE)
         {
            if(this._playersClubAssets[param1] == null)
            {
               this._playersClubAssets[param1] = new SafeAssetLoader();
               _loc3_ = this._playersClubAssets[param1];
               switch(param1)
               {
                  case PLAYERS_CLUB_SILVER:
                     _loc4_ = ExternalAsset.PLAYERS_CLUB_SILVER_SEATS;
                     _loc5_ = this.onSilverSeatsLoaded;
                     break;
                  case PLAYERS_CLUB_GOLD:
                     _loc4_ = ExternalAsset.PLAYERS_CLUB_GOLD_SEATS;
                     _loc5_ = this.onGoldSeatsLoaded;
                     break;
                  case PLAYERS_CLUB_BLACK:
                     _loc4_ = ExternalAsset.PLAYERS_CLUB_BLACK_SEATS;
                     _loc5_ = this.onBlackSeatsLoaded;
                     break;
                  case PLAYERS_CLUB_RED:
                     _loc4_ = ExternalAsset.PLAYERS_CLUB_RED_SEATS;
                     _loc5_ = this.onRedSeatsLoaded;
                     break;
               }
               
            }
            else
            {
               if((this._playersClubAssets[param1] as SafeAssetLoader).content == null)
               {
                  _loc2_ = true;
               }
            }
            if(_loc3_ != null)
            {
               _loc2_ = true;
               _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,_loc5_,false,0,true);
               _loc3_.load(new URLRequest(ExternalAssetManager.getUrl(_loc4_)));
            }
         }
         return _loc2_;
      }
      
      private function onSilverSeatsLoaded(param1:Event) : void {
         this.loadPendingSeats(PLAYERS_CLUB_SILVER);
      }
      
      private function onGoldSeatsLoaded(param1:Event) : void {
         this.loadPendingSeats(PLAYERS_CLUB_GOLD);
      }
      
      private function onBlackSeatsLoaded(param1:Event) : void {
         this.loadPendingSeats(PLAYERS_CLUB_BLACK);
      }
      
      private function onRedSeatsLoaded(param1:Event) : void {
         this.loadPendingSeats(PLAYERS_CLUB_RED);
      }
      
      private function loadPendingSeats(param1:String) : void {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:String = null;
         for (_loc2_ in this._pendingChairs)
         {
            _loc3_ = int(_loc2_);
            _loc4_ = this._pendingChairs[_loc2_];
            if(param1 == _loc4_)
            {
               this.changeSeatByTier(_loc3_,param1);
               delete this._pendingChairs[[_loc2_]];
            }
         }
      }
      
      private function getMappedChairAssetBySeat(param1:int, param2:String) : DisplayObject {
         var _loc3_:uint = this.ptModel.playerPosModel.getMappedPosition(param1);
         return this.getChairAssetBySeat(_loc3_,param2);
      }
      
      private function getChairAssetBySeat(param1:int, param2:String) : DisplayObject {
         var _loc6_:MovieClip = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:SafeAssetLoader = null;
         var _loc5_:* = param2 + "_";
         if(param2 == PLAYERS_CLUB_NONE)
         {
            _loc4_ = this._bgLoad;
            _loc5_ = "";
         }
         else
         {
            _loc4_ = this._playersClubAssets[param2];
         }
         if(!(_loc4_ == null) && !(_loc4_.content == null))
         {
            _loc6_ = _loc4_.content as MovieClip;
            if(_loc6_ != null)
            {
               _loc3_ = _loc6_.getChildByName(_loc5_ + "chair_" + param1);
            }
         }
         return _loc3_;
      }
      
      public function clearPlayersClubChairs() : void {
         var _loc1_:String = null;
         for (_loc1_ in this._playersClubChairs)
         {
            this.removePlayersClubChair(int(_loc1_));
         }
      }
      
      public function updatePlayersClubChairs() : void {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for (_loc2_ in this._playersClubChairs)
         {
            _loc1_[_loc2_] = this._playersClubChairs[_loc2_][KEY_TIER];
         }
         this.clearPlayersClubChairs();
         for (_loc2_ in _loc1_)
         {
            this.changeSeatByTier(int(_loc2_),_loc1_[_loc2_]);
         }
      }
      
      public function removePlayersClubChair(param1:int) : void {
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:String = null;
         var _loc5_:SafeAssetLoader = null;
         var _loc6_:MovieClip = null;
         if(this._playersClubChairs.hasOwnProperty(param1))
         {
            _loc2_ = this._playersClubChairs[param1][KEY_CURR_CHAIR];
            _loc3_ = this._playersClubChairs[param1][KEY_PREV_CHAIR];
            _loc4_ = this._playersClubChairs[param1][KEY_TIER];
            _loc5_ = this._playersClubAssets[_loc4_];
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.content as MovieClip;
               if(_loc6_ != null)
               {
                  _loc6_.addChild(_loc2_);
               }
            }
            _loc3_.visible = true;
            delete this._playersClubChairs[[param1]];
         }
      }
      
      public function bubbleContainer(param1:DisplayObject) : void {
         if(contains(param1))
         {
            removeChild(param1);
            addChild(param1);
         }
      }
   }
}
