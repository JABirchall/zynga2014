package com.zynga.poker.mfs.bigMFS.view
{
   import com.zynga.poker.mfs.view.MFSView;
   import com.zynga.poker.commonUI.rewardBar.RewardBarController;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.Sprite;
   import com.zynga.display.SafeImageLoader;
   import flash.utils.Dictionary;
   import flash.text.TextField;
   import com.zynga.ui.scroller.ScrollSystem;
   import fl.controls.CheckBox;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldType;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarZPWCView;
   import flash.filters.DropShadowFilter;
   import flash.filters.BevelFilter;
   import com.zynga.poker.PokerGlobalData;
   import flash.display.Bitmap;
   import com.zynga.poker.mfs.bigMFS.events.BigMFSPopUpEvent;
   import com.zynga.poker.popups.modules.events.BigMFSPopUpChicletEvent;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.mfs.model.MFSModel;
   
   public class BigMFSView extends MFSView
   {
      
      public function BigMFSView(param1:MFSModel) {
         this._friendsContainer = new MovieClip();
         this.selectedUsersMap = new Dictionary(false);
         this.currentlyProcessingUserMap = new Dictionary(false);
         this._zyngaPreSelectMap = new Dictionary(false);
         super(param1,MFSModel.TYPE_BIG_MFS);
      }
      
      protected static const DEFAULT_HEADER_WIDTHS:Number = 680;
      
      public static var NUM_COLUMNS:Number = 5;
      
      public static var NUM_ROWS:Number = 10;
      
      public static var DEFAULT_TOTAL_COUNT:Number = NUM_COLUMNS * NUM_ROWS;
      
      public static var CHICLET_WIDTH:Number = 132;
      
      public static var CHICLET_HEIGHT:Number = 24;
      
      public static var MAX_NUM_PER_SEND:Number = 50;
      
      private const YELLOW_FONT_TOKEN:String = "::YELLOW::";
      
      private const kAmountToAutoSelect:int = 50;
      
      private var _rewardBarController:RewardBarController;
      
      private var _base:MovieClip = null;
      
      protected var _btnSend:MovieClip = null;
      
      private var _page:MovieClip = null;
      
      private var _progressMeter:MovieClip = null;
      
      private var _statusBG:MovieClip = null;
      
      private var _statusMask:MovieClip = null;
      
      private var _headerBG:MovieClip = null;
      
      protected var _header:EmbeddedFontTextField = null;
      
      protected var _subHeader:EmbeddedFontTextField = null;
      
      protected var _iconHeader:EmbeddedFontTextField = null;
      
      protected var _progressString:EmbeddedFontTextField = null;
      
      protected var _closeTF:EmbeddedFontTextField = null;
      
      private var _toWallTF:EmbeddedFontTextField = null;
      
      protected var _closeSprite:Sprite = null;
      
      private var _toWallSprite:Sprite = null;
      
      private var _sendTF:EmbeddedFontTextField = null;
      
      private var _spinner:MovieClip = null;
      
      private var _friendsContainer:MovieClip;
      
      private var _numUsersThatCanBeSentTo:int = 0;
      
      private var _numSelectedUsers:int = 0;
      
      private var _originalScrollY:Number;
      
      protected var _closeButton:MovieClip = null;
      
      private var _headerImageLoader:SafeImageLoader;
      
      private var _burstImageLoader:SafeImageLoader;
      
      private var _limit:Number = -1;
      
      private var _limitReachedContainer:Sprite;
      
      public var selectedUsersMap:Dictionary;
      
      public var currentlyProcessingUserMap:Dictionary;
      
      public var numRequestsSent:int = 0;
      
      public var searchNameInput:TextField = null;
      
      public var defaultSearchText:String = "";
      
      public var scrollContainer:ScrollSystem;
      
      public var selectAll:CheckBox = null;
      
      public var isSelectAllActivated:Boolean = false;
      
      public var shouldAutoSelectOnLaunch:Boolean = false;
      
      public var shouldAutoCloseOnSend:Boolean = false;
      
      private var _sendAllButton:PokerUIButton;
      
      private var _remainingToAutoSelect:int = 50;
      
      private var _zyngaPreSelectMap:Dictionary;
      
      override public function init() : void {
         if(mfsModel.popupData.hasOwnProperty("sendLimit"))
         {
            this._limit = mfsModel.popupData.sendLimit;
         }
         if(mfsModel.popupData.hasOwnProperty("preSelectAll"))
         {
            this.shouldAutoSelectOnLaunch = mfsModel.popupData.preSelectAll;
         }
         super.init();
      }
      
      override protected function initPopUpContainer() : void {
         this.x = 380;
         this.y = 300;
         this.initBaseElements();
         this.initHeaderText();
         this.initButtons();
         this.initTextFields();
      }
      
      protected function initButtons() : void {
         this._btnSend = PokerClassProvider.getObject("BMFS_send") as MovieClip;
         addChild(this._btnSend as DisplayObject);
         this._btnSend.x = -220;
         this._btnSend.y = 220;
         this._btnSend.addEventListener(MouseEvent.CLICK,this.onSendButtonClicked,false,0,true);
         this._btnSend.buttonMode = true;
         if(mfsModel.popupData.showCloseButton)
         {
            this._closeButton = PokerClassProvider.getObject("bigMFSCloseButton") as MovieClip;
            this._closeButton.x = 330;
            this._closeButton.y = -245;
            this._closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClicked,false,0,true);
            this._closeButton.useHandCursor = true;
            this._closeButton.mouseEnabled = true;
            this._closeButton.buttonMode = true;
            addChild(this._closeButton as DisplayObject);
         }
         if(mfsModel.popupData.showCancelLink)
         {
            this._closeSprite = new Sprite();
            this._closeSprite.graphics.beginFill(16711680,0.0);
            this._closeSprite.graphics.drawRect(295,233,50,18);
            this._closeSprite.graphics.endFill();
            addChild(this._closeSprite);
            this._closeSprite.buttonMode = true;
            this._closeSprite.addEventListener(MouseEvent.CLICK,this.onCloseButtonClicked,false,0,true);
            this._closeTF = new EmbeddedFontTextField(mfsModel.popupData.cancel,"MainSemi",14,10066329,"center");
            this._closeTF.x = 245;
            this._closeTF.y = 233;
            this._closeTF.width = 150;
            this._closeTF.height = 18;
            addChild(this._closeTF);
         }
         if(mfsModel.popupData.showPostToWall)
         {
            this._toWallSprite = new Sprite();
            this._toWallSprite.graphics.beginFill(16711680,0.0);
            this._toWallSprite.graphics.drawRect(-105,220,120,18);
            this._toWallSprite.graphics.endFill();
            addChild(this._toWallSprite);
            this._toWallSprite.buttonMode = true;
            this._toWallSprite.addEventListener(MouseEvent.CLICK,this.onPostToWallClicked,false,0,true);
            this._toWallTF = new EmbeddedFontTextField(mfsModel.popupData.postToWallText,"MainSemi",14,255,"center");
            this._toWallTF.x = -110;
            this._toWallTF.y = 220;
            this._toWallTF.width = 150;
            this._toWallTF.height = 18;
            addChild(this._toWallTF);
         }
         this.selectAll = new CheckBox();
         this.selectAll.textField.autoSize = TextFieldAutoSize.LEFT;
         this.selectAll.setStyle("textFormat",new TextFormat("_sans",16,39423));
         this.selectAll.x = -330;
         this.selectAll.y = -92;
         this.selectAll.label = mfsModel.popupData.selectAll;
         this.selectAll.labelPlacement = "right";
         this.selectAll.selected = false;
         var _loc1_:* = true;
         if(mfsModel.popupData.hasOwnProperty("showSelectAll"))
         {
            _loc1_ = mfsModel.popupData["showSelectAll"];
         }
         if(_loc1_)
         {
            addChild(this.selectAll);
         }
      }
      
      protected function initBaseElements() : void {
         this._base = PokerClassProvider.getObject("BMFS_base") as MovieClip;
         addChild(this._base as DisplayObject);
         this._page = PokerClassProvider.getObject("BMFS_page") as MovieClip;
         addChild(this._page as DisplayObject);
         this._page.x = 0;
         this._page.y = 40;
         this._statusMask = PokerClassProvider.getObject("BMFS_statusMask") as MovieClip;
         addChild(this._statusMask as DisplayObject);
         this._statusMask.x = 230 - 12;
         this._statusMask.y = 202;
         this._statusBG = PokerClassProvider.getObject("BMFS_statusBG") as MovieClip;
         addChild(this._statusBG as DisplayObject);
         this._statusBG.x = 230 - 12;
         this._statusBG.y = 202;
         this._progressMeter = PokerClassProvider.getObject("BMFS_prog") as MovieClip;
         addChild(this._progressMeter as DisplayObject);
         this._progressMeter.x = -125 + 230 - 12;
         this._progressMeter.y = 202;
         this._progressMeter.mask = this._statusMask;
         var _loc1_:String = mfsModel.popupData.hasOwnProperty("headerBG")?mfsModel.popupData["headerBG"]:"BMFS_bg_blue";
         this._headerBG = PokerClassProvider.getObject(_loc1_) as MovieClip;
         this._headerBG.x = -this._headerBG.width / 2;
         this._headerBG.y = -245;
         addChild(this._headerBG as DisplayObject);
         if(mfsModel.popupData.image)
         {
            this._headerImageLoader = new SafeImageLoader();
            this._headerImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onHeaderImageLoadComplete,false,0,true);
            this._headerImageLoader.load(new URLRequest(mfsModel.popupData.image));
         }
      }
      
      protected function initHeaderText() : void {
         var _loc1_:Number = mfsModel.popupData.image != null?120:10;
         this._header = new EmbeddedFontTextField(mfsModel.popupData.header,"MainSemi",48,16777215,"center");
         this._header.multiline = true;
         this._header.autoSize = TextFieldAutoSize.CENTER;
         this._header.fitInWidth(DEFAULT_HEADER_WIDTHS - _loc1_);
         if(this._header.height > 70)
         {
            this._header.fitInHeight(70);
         }
         this._header.x = (_loc1_ - this._header.width) / 2;
         this._header.y = -185 - this._header.height / 2;
         addChild(this._header);
         this._subHeader = new EmbeddedFontTextField(mfsModel.popupData.subHeader,"MainSemi",20,16777215,"center");
         this._subHeader.multiline = true;
         this._subHeader.autoSize = TextFieldAutoSize.CENTER;
         this._subHeader.fitInWidth(this._header.width < 300?300:this._header.width);
         if(this._subHeader.height > 50)
         {
            this._subHeader.fitInHeight(50);
         }
         this._subHeader.x = (_loc1_ - this._subHeader.width) / 2;
         this._header.y = -185 - this._header.height / 2 - this._subHeader.height / 2;
         this._subHeader.y = this._header.y + this._header.height;
         addChild(this._subHeader);
         this._iconHeader = new EmbeddedFontTextField(mfsModel.popupData.iconHeader,"MainSemi",12,16777215,"center");
         this._iconHeader.x = -365;
         this._iconHeader.y = -140;
         this._iconHeader.fitInWidth(160);
         this._iconHeader.width = 160;
         this._iconHeader.autoSize = TextFieldAutoSize.CENTER;
         addChild(this._iconHeader);
         this._progressString = new EmbeddedFontTextField("","MainSemi",14,39423,"right");
         this._progressString.x = 0;
         this._progressString.y = 215;
         this._progressString.width = 343;
         this._progressString.height = 30;
         addChild(this._progressString);
      }
      
      protected function initTextFields() : void {
         this._sendTF = new EmbeddedFontTextField(mfsModel.popupData.sendButtonText,"MainSemi",20,16777215,"center");
         this._sendTF.x = -305;
         this._sendTF.y = 207;
         this._sendTF.fitInWidth(180);
         this._sendTF.width = 180;
         this._sendTF.autoSize = TextFieldAutoSize.CENTER;
         addChild(this._sendTF);
         this.defaultSearchText = mfsModel.popupData.search;
         this.searchNameInput = new TextField();
         this.searchNameInput.defaultTextFormat = new TextFormat("_sans",16,4473924,true,null,null,null,null,TextFormatAlign.LEFT);
         this.searchNameInput.width = 150;
         this.searchNameInput.height = 24;
         this.searchNameInput.x = 10 + 165 - 3;
         this.searchNameInput.y = -42 - 55 + 4;
         this.searchNameInput.type = TextFieldType.INPUT;
         this.searchNameInput.multiline = false;
         this.searchNameInput.wordWrap = false;
         this.searchNameInput.maxChars = 30;
         this.searchNameInput.text = this.defaultSearchText;
         addChild(this.searchNameInput);
         this.searchNameInput.addEventListener(FocusEvent.FOCUS_OUT,this.onsearchNameInputOutOfFocus,false,0,true);
         this.searchNameInput.addEventListener(FocusEvent.FOCUS_IN,this.onsearchNameInputInFocus,false,0,true);
         this.searchNameInput.addEventListener(KeyboardEvent.KEY_UP,this.onInputEntered,false,0,true);
      }
      
      override protected function setup() : void {
         super.setup();
         if(this.selectAll)
         {
            if(this._numUsersThatCanBeSentTo)
            {
               this.selectAll.addEventListener(MouseEvent.CLICK,this.onSelectAllClicked,false,0,true);
            }
            else
            {
               this.selectAll.enabled = false;
            }
         }
         this.updateProgressMeter();
         this.disableSendButton();
         if(this.shouldAutoSelectOnLaunch)
         {
            if(this._numSelectedUsers)
            {
               this.enableSendButton();
            }
         }
      }
      
      override protected function initRewardBar() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:TextFormat = null;
         var _loc5_:TextFormat = null;
         var _loc6_:TextFormat = null;
         if(mfsModel.popupData.hasOwnProperty("rewardBar"))
         {
            this._rewardBarController = new RewardBarController(mfsModel.popupData.rewardBar);
            this._rewardBarController.createRewardBarView(this._headerBG.width,35);
            this._rewardBarController.rewardBarView.x = -335;
            this._rewardBarController.rewardBarView.y = this._headerBG.y + this._headerBG.height / 2;
            addChild(this._rewardBarController.rewardBarView);
            if(this._header)
            {
               this._header.scaleX = this._header.scaleY = 1;
               _loc1_ = this._header.text.indexOf(this.YELLOW_FONT_TOKEN);
               _loc2_ = -1;
               if(_loc1_ > -1)
               {
                  this._header.text = this._header.text.substring(0,_loc1_) + this._header.text.substring(_loc1_ + this.YELLOW_FONT_TOKEN.length);
                  _loc2_ = this._header.text.indexOf(this.YELLOW_FONT_TOKEN);
                  if(_loc2_ > -1)
                  {
                     this._header.text = this._header.text.substring(0,_loc2_) + this._header.text.substring(_loc2_ + this.YELLOW_FONT_TOKEN.length);
                  }
                  else
                  {
                     _loc2_ = this._header.text.length;
                  }
               }
               _loc3_ = new TextFormat("Main",20,16777215,true);
               this._header.setTextFormat(_loc3_);
               if(_loc1_ > -1)
               {
                  _loc4_ = new TextFormat("Main",20,16757248,true);
                  this._header.setTextFormat(_loc4_,_loc1_,_loc2_);
               }
               this._header.width = this._header.parent.width;
               this._header.x = this._rewardBarController.rewardBarView.x;
               this._header.y = -235;
            }
            if(this._subHeader)
            {
               _loc5_ = new TextFormat("MainSemi",16,16777215);
               this._subHeader.setTextFormat(_loc5_);
               this._subHeader.width = this._header.width * 1.1;
               this._subHeader.x = this._header.x;
               this._subHeader.y = this._header.y + 23;
            }
            if(this._rewardBarController.rewardBarView is RewardBarZPWCView)
            {
               if(this._header)
               {
                  _loc6_ = this._header.getTextFormat();
                  _loc6_.color = 13214515;
                  this._header.filters = [new DropShadowFilter(),new BevelFilter(5,90,16777215,1,11382189,1,26,26)];
                  this._header.setTextFormat(_loc6_);
                  this._header.x = this._headerBG.x + 10;
               }
               if(this._subHeader)
               {
                  this._subHeader.filters = [new DropShadowFilter()];
                  this._subHeader.autoSize = TextFieldAutoSize.LEFT;
                  this._subHeader.x = this._header.x;
               }
               this._rewardBarController.rewardBarView.x = -274;
               this._rewardBarController.rewardBarView.y = this._rewardBarController.rewardBarView.y + 2;
            }
            else
            {
               this._burstImageLoader = new SafeImageLoader();
               this._burstImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onRewardBarBurstImageLoaded,false,0,true);
               this._burstImageLoader.load(new URLRequest(PokerGlobalData.instance.staticUrlPrefix + mfsModel.popupData.rewardBar.prizeImage));
            }
         }
      }
      
      override public function onRewardBarClaimed(param1:Object) : void {
         this._rewardBarController.onClaimedReward(param1.bonus as int);
      }
      
      private function onRewardBarBurstImageLoaded(param1:Event) : void {
         this._burstImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onHeaderImageLoadComplete);
         var _loc2_:Bitmap = this._burstImageLoader.content as Bitmap;
         _loc2_.smoothing = true;
         var _loc3_:Number = this._headerBG.height / _loc2_.height;
         _loc2_.height = this._headerBG.height;
         _loc2_.width = _loc2_.width * _loc3_;
         _loc2_.x = this._headerBG.width - _loc2_.width;
         this._headerBG.addChild(_loc2_);
      }
      
      override protected function close() : void {
         if(this._rewardBarController)
         {
            if(contains(this._rewardBarController.rewardBarView))
            {
               removeChild(this._rewardBarController.rewardBarView);
            }
            this._rewardBarController.destroy();
            this._rewardBarController = null;
         }
         if((parent) && (parent.contains(this)))
         {
            parent.removeChild(this);
         }
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_CLOSE_STATS_CLICKED));
         super.close();
      }
      
      private function onHeaderImageLoadComplete(param1:Event) : void {
         this._headerImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onHeaderImageLoadComplete);
         var _loc2_:Bitmap = this._headerImageLoader.content as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.y = -200 - 35;
         _loc2_.scaleX = mfsModel.popupData.imageScale?mfsModel.popupData.imageScale * 0.9:0.66;
         _loc2_.scaleY = mfsModel.popupData.imageScale?mfsModel.popupData.imageScale * 0.9:0.66;
         _loc2_.x = this._iconHeader.x + (this._iconHeader.width - this._headerImageLoader.contentLoaderInfo.width * _loc2_.scaleX) / 2;
         addChild(_loc2_);
      }
      
      override protected function initSpinner() : void {
         this._spinner = PokerClassProvider.getObject("status_spinner");
         this._spinner.x = 0;
         this._spinner.y = 50;
         this._spinner.visible = false;
         addChild(this._spinner);
      }
      
      override protected function initChicletArray() : void {
         this.initFriendList();
         this.updatechicletArrayPositions();
         this.initScrollSystem();
      }
      
      private function initFriendList() : void {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:BigMFSPopUpChiclet = null;
         for (_loc1_ in mfsModel.popupData.recipients)
         {
            _loc2_ = mfsModel.popupData.recipients[_loc1_];
            if((_loc2_.zid) && (_loc2_.first_name) && (_loc2_.last_name))
            {
               _loc3_ = new BigMFSPopUpChiclet(_loc2_);
               _loc3_.addEventListener(BigMFSPopUpChicletEvent.TYPE_CLICKED,this.onChickletClicked,false,0,true);
               mfsModel.chicletArray.push(_loc3_);
            }
         }
         if(this._limit >= 0)
         {
            this._numUsersThatCanBeSentTo = Math.min(this._limit,mfsModel.chicletArray.length);
         }
         else
         {
            this._numUsersThatCanBeSentTo = mfsModel.chicletArray.length;
         }
         if(mfsModel.popupData.hasOwnProperty("oneClickSend"))
         {
            this._remainingToAutoSelect = mfsModel.chicletArray.length;
         }
         this.autoSelectChiclets();
      }
      
      private function autoSelectChiclets() : void {
         var _loc1_:* = 0;
         var _loc2_:BigMFSPopUpChiclet = null;
         if(this.shouldAutoSelectOnLaunch)
         {
            if(this._remainingToAutoSelect >= mfsModel.chicletArray.length)
            {
               this.selectAll.selected = true;
               this.isSelectAllActivated = true;
            }
            _loc1_ = 0;
            while(_loc1_ < mfsModel.chicletArray.length)
            {
               if(--this._remainingToAutoSelect >= 0)
               {
                  _loc2_ = mfsModel.chicletArray[_loc1_] as BigMFSPopUpChiclet;
                  _loc2_.selected = true;
                  this._numSelectedUsers++;
                  this.selectedUsersMap[_loc2_.zid] = true;
                  this._zyngaPreSelectMap[_loc2_.zid] = true;
               }
               _loc1_++;
            }
            this._remainingToAutoSelect = 0;
         }
      }
      
      private function onChickletClicked(param1:BigMFSPopUpChicletEvent) : void {
         var _loc2_:BigMFSPopUpChiclet = param1.target as BigMFSPopUpChiclet;
         if(this._limit >= 0 && (_loc2_.selected) && this._numSelectedUsers == this._limit)
         {
            this.setupLimitReachedContainer();
            _loc2_.selected = false;
            return;
         }
         if(_loc2_.selected)
         {
            this._numSelectedUsers++;
            this.selectedUsersMap[_loc2_.zid] = true;
         }
         else
         {
            this._numSelectedUsers--;
            delete this.selectedUsersMap[[_loc2_.zid]];
         }
         this.checkSendButtonState();
      }
      
      private function setupLimitReachedContainer() : void {
         var _loc5_:EmbeddedFontTextField = null;
         if(!(this._limitReachedContainer == null) && (this.contains(this._limitReachedContainer)))
         {
            return;
         }
         this._limitReachedContainer = new Sprite();
         this._limitReachedContainer.x = -200;
         this._limitReachedContainer.y = -300;
         addChild(this._limitReachedContainer);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRoundRect(100,250,235,142,10,10);
         _loc1_.graphics.endFill();
         this._limitReachedContainer.addChildAt(_loc1_,0);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(-200,48,this.width + 10,this.height);
         _loc2_.graphics.endFill();
         _loc2_.alpha = 0.5;
         this._limitReachedContainer.addChildAt(_loc2_,0);
         var _loc3_:MovieClip = PokerClassProvider.getObject("bigMFSCloseButton");
         _loc3_.x = 307;
         _loc3_.y = 254;
         _loc3_.buttonMode = true;
         _loc3_.addEventListener(MouseEvent.CLICK,this.onLimitReachedCloseButtonClicked,false,0,true);
         this._limitReachedContainer.addChild(_loc3_);
         var _loc4_:ShinyButton = new ShinyButton(mfsModel.popupData.sendButtonText,175,35,16,16777215,ShinyButton.COLOR_LIGHT_GREEN);
         _loc4_.addEventListener(MouseEvent.CLICK,this.onLimitReachedSendButtonClicked,false,0,true);
         _loc4_.x = 100 + (235 - 175) / 2;
         _loc4_.y = 345;
         this._limitReachedContainer.addChild(_loc4_);
         if(this._limit == 1)
         {
            _loc5_ = new EmbeddedFontTextField(mfsModel.popupData.sendLimitReachedTextSingular.replace(new RegExp("{numFriends}","g"),this._limit),"MainSemi",14,16777215,"center");
         }
         else
         {
            _loc5_ = new EmbeddedFontTextField(mfsModel.popupData.sendLimitReachedTextPlural.replace(new RegExp("{numFriends}","g"),this._limit),"MainSemi",14,16777215,"center");
         }
         _loc5_.x = 110;
         _loc5_.y = 278;
         _loc5_.width = 212;
         _loc5_.height = 60;
         _loc5_.wordWrap = true;
         this._limitReachedContainer.addChild(_loc5_);
      }
      
      public function closeLimitReachedContainer() : void {
         removeChild(this._limitReachedContainer);
         this._limitReachedContainer = null;
      }
      
      public function onLimitReachedCloseButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_LIMIT_CLOSE_CLICKED));
      }
      
      public function onLimitReachedSendButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_LIMIT_SEND_CLICKED));
      }
      
      private function checkSendButtonState() : void {
         if(this._numSelectedUsers < mfsModel.chicletArray.length)
         {
            if(this._numSelectedUsers == 0)
            {
               this.disableSendButton();
            }
            else
            {
               this.enableSendButton();
            }
            if((this.selectAll) && (this.selectAll.selected))
            {
               this.toggleSelectAll(false);
            }
         }
         else
         {
            this.enableSendButton();
            if((this.selectAll) && !this.selectAll.selected)
            {
               this.toggleSelectAll(false);
            }
         }
      }
      
      public function toggleSelectAll(param1:Boolean=true) : void {
         this.isSelectAllActivated = !this.isSelectAllActivated;
         this.selectAll.selected = this.isSelectAllActivated;
         if(!param1)
         {
            return;
         }
         var _loc2_:* = 0;
         while(_loc2_ < mfsModel.chicletArray.length)
         {
            mfsModel.chicletArray[_loc2_].selected = this.isSelectAllActivated;
            if(this.isSelectAllActivated)
            {
               this.selectedUsersMap[mfsModel.chicletArray[_loc2_].zid] = true;
            }
            _loc2_++;
         }
         if(this.isSelectAllActivated)
         {
            this._numSelectedUsers = mfsModel.chicletArray.length;
            this.enableSendButton();
         }
         else
         {
            this.selectedUsersMap = new Dictionary(false);
            this._numSelectedUsers = 0;
            this.disableSendButton();
         }
      }
      
      private function disableSendButton() : void {
         if(this._btnSend.hasEventListener(MouseEvent.CLICK))
         {
            this._btnSend.removeEventListener(MouseEvent.CLICK,this.onSendButtonClicked);
         }
         this._btnSend.enabled = false;
         this._btnSend.alpha = 0.5;
      }
      
      private function enableSendButton() : void {
         if(this._numUsersThatCanBeSentTo == 0)
         {
            return;
         }
         if(!this._btnSend.hasEventListener(MouseEvent.CLICK))
         {
            this._btnSend.addEventListener(MouseEvent.CLICK,this.onSendButtonClicked,false,0,true);
         }
         this._btnSend.enabled = true;
         this._btnSend.alpha = 1;
      }
      
      public function updatechicletArrayPositions() : void {
         var _loc3_:BigMFSPopUpChiclet = null;
         var _loc1_:* = 0;
         while(this._friendsContainer.numChildren)
         {
            this._friendsContainer.removeChildAt(0);
         }
         var _loc2_:* = 0;
         while(_loc2_ < mfsModel.chicletArray.length)
         {
            _loc3_ = mfsModel.chicletArray[_loc2_] as BigMFSPopUpChiclet;
            if(this.searchNameInput.text == "" || this.searchNameInput.text == this.defaultSearchText || _loc3_.full_name.toLowerCase().indexOf(this.searchNameInput.text.toLowerCase()) >= 0)
            {
               this.setUpChicletPosition(this._friendsContainer,mfsModel.chicletArray[_loc2_],_loc1_,_loc2_);
               _loc1_++;
            }
            _loc2_++;
         }
         this.updateScrollBarVisibility();
      }
      
      private function initScrollSystem() : void {
         var _loc1_:Object = new Object();
         _loc1_.arrowUp = PokerClassProvider.getObject("ChatArrowUp");
         _loc1_.trackV = PokerClassProvider.getObject("ChatTrackV");
         _loc1_.arrowDown = PokerClassProvider.getObject("ChatArrowDown");
         _loc1_.handleV = PokerClassProvider.getObject("ChatHandleV");
         this.scrollContainer = new ScrollSystem(this,this._friendsContainer,669,240,_loc1_,9,0,true,false,CHICLET_HEIGHT);
         this.scrollContainer.x = -343;
         this.scrollContainer.y = -58;
         addChild(this.scrollContainer);
         this._originalScrollY = this.scrollContainer.barV.handle.y;
         this.updateScrollBarVisibility();
      }
      
      private function updateScrollBarVisibility() : void {
         if(this.scrollContainer)
         {
            if(mfsModel.chicletArray.length <= 50)
            {
               this.scrollContainer.barV.visible = false;
            }
            else
            {
               this.scrollContainer.barV.visible = true;
            }
         }
      }
      
      private function updateProgressMeter() : void {
         if(this._numUsersThatCanBeSentTo == 0)
         {
            this._progressMeter.width = 0;
         }
         else
         {
            this._progressMeter.width = Number(this.numRequestsSent) / Number(this._numUsersThatCanBeSentTo) * 500;
         }
         var _loc1_:String = (mfsModel.popupData) && (mfsModel.popupData.progressMeterText)?mfsModel.popupData.progressMeterText:"{send} / {totalNumber}";
         _loc1_ = _loc1_.replace(new RegExp("{totalNumber}"),this._numUsersThatCanBeSentTo);
         _loc1_ = _loc1_.replace(new RegExp("{send}"),this.numRequestsSent);
         if((mfsModel.popupData) && (mfsModel.popupData.progressMeterText.indexOf("requestsSent") >= 0) && mfsModel.popupData.progressMeterText.indexOf("totalRequestsPossible") >= 0)
         {
            _loc1_ = (mfsModel.popupData) && (mfsModel.popupData.progressMeterText)?mfsModel.popupData.progressMeterText:"{requestsSent} / {totalRequestsPossible}";
            _loc1_ = _loc1_.replace(new RegExp("{totalRequestsPossible}"),this._numUsersThatCanBeSentTo);
            _loc1_ = _loc1_.replace(new RegExp("{requestsSent}"),this.numRequestsSent);
         }
         this._progressString.text = _loc1_;
      }
      
      private function setUpChicletPosition(param1:MovieClip, param2:BigMFSPopUpChiclet, param3:int, param4:int) : void {
         param1.addChild(param2);
         var _loc5_:int = int(param3 % NUM_COLUMNS);
         var _loc6_:* = 40;
         param2.x = _loc5_ * CHICLET_WIDTH;
         param2.y = int(param3 / NUM_COLUMNS) * CHICLET_HEIGHT;
         param2.index = param4;
      }
      
      override public function onFBCallBackReceived(param1:int) : void {
         var _loc4_:* = 0;
         var _loc5_:BigMFSPopUpChiclet = null;
         if(param1 == 0)
         {
            this.toggleBigMFSScreenFreeze(true);
            return;
         }
         this.numRequestsSent = this.numRequestsSent + param1;
         this._numSelectedUsers = this._numSelectedUsers - param1;
         this.updateProgressMeter();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         if(mfsModel.chicletArray.length > 0)
         {
            _loc4_ = mfsModel.chicletArray.length-1;
            while(_loc4_ >= 0)
            {
               _loc5_ = BigMFSPopUpChiclet(mfsModel.chicletArray[_loc4_]);
               if(this.currentlyProcessingUserMap[_loc5_.zid])
               {
                  if(this._friendsContainer.contains(_loc5_))
                  {
                     this._friendsContainer.removeChild(_loc5_);
                  }
                  delete this.selectedUsersMap[[_loc5_.zid]];
                  mfsModel.chicletArray.splice(_loc4_,1);
               }
               else
               {
                  if((this.selectedUsersMap[_loc5_.zid]) || !this.selectedUsersMap[_loc5_.zid] && !this._zyngaPreSelectMap[_loc5_.zid])
                  {
                     _loc2_.push(_loc5_);
                  }
                  else
                  {
                     _loc3_.push(_loc5_);
                  }
               }
               _loc4_--;
            }
            mfsModel.chicletArray = _loc2_;
            if(!mfsModel.popupData.removeUnselectedUsers)
            {
               mfsModel.chicletArray = mfsModel.chicletArray.concat(_loc3_);
            }
            this.updatechicletArrayPositions();
         }
         if(mfsModel.chicletArray.length == 0 || this._limit >= 0 && this.numRequestsSent == this._limit || (this.shouldAutoCloseOnSend))
         {
            this.close();
         }
         else
         {
            if((mfsModel.popupData.hasOwnProperty("oneClickSend")) && (mfsModel.popupData["oneClickSend"]))
            {
               this._remainingToAutoSelect = mfsModel.chicletArray.length;
            }
            else
            {
               this._remainingToAutoSelect = this.kAmountToAutoSelect;
            }
            this.autoSelectChiclets();
         }
         this.checkSendButtonState();
         this.toggleBigMFSScreenFreeze(true);
         if((mfsModel.popupData.hasOwnProperty("oneClickSend")) && (mfsModel.popupData["oneClickSend"]))
         {
            this.onAutoSendTriggered();
         }
      }
      
      public function toggleBigMFSScreenFreeze(param1:Boolean) : void {
         if(this._btnSend)
         {
            this._btnSend.mouseEnabled = param1;
         }
         if(this._sendAllButton)
         {
            this._sendAllButton.mouseEnabled = param1;
         }
         if(this.searchNameInput)
         {
            this.searchNameInput.mouseEnabled = param1;
         }
         if(this.selectAll)
         {
            this.selectAll.mouseEnabled = param1;
         }
         if(this._btnSend)
         {
            this._btnSend.mouseChildren = param1;
         }
         if(this.scrollContainer)
         {
            this.scrollContainer.mouseChildren = param1;
         }
         if(this._spinner)
         {
            this._spinner.visible = !param1;
         }
      }
      
      private function onPostToWallClicked(param1:MouseEvent=null) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_POST_WALL_CLICKED));
      }
      
      protected function onCloseButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_CLOSE_BUTTON_CLICKED));
      }
      
      private function onAutoSendTriggered(param1:MouseEvent=null) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_AUTO_SEND_TRIGGERED));
      }
      
      protected function onSendButtonClicked(param1:MouseEvent=null) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_SEND_CLICKED));
      }
      
      private function onSendAllButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_SEND_ALL_CLICKED));
      }
      
      private function onSelectAllClicked(param1:MouseEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_SELECT_ALL_CLICKED));
      }
      
      private function onInputEntered(param1:KeyboardEvent) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_ENTERED));
      }
      
      private function onsearchNameInputInFocus(param1:Event) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_IN_FOCUS));
      }
      
      private function onsearchNameInputOutOfFocus(param1:Event) : void {
         dispatchEvent(new BigMFSPopUpEvent(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_OUT_OF_FOCUS));
      }
      
      public function closeBigMFSView() : void {
         this.close();
      }
   }
}
