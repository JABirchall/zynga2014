package com.zynga.poker.popups.modules.PreSelectPopUp
{
   import com.zynga.poker.popups.MFSPopUpView;
   import flash.text.TextFormat;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import fl.controls.CheckBox;
   import flash.utils.Dictionary;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import com.zynga.poker.commonUI.rewardBar.RewardBarController;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.display.DisplayObject;
   import flash.text.TextFieldAutoSize;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonRequest2MFSActionStyle;
   import com.zynga.geom.Size;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarZPWCView;
   import flash.filters.DropShadowFilter;
   import flash.filters.BevelFilter;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.popups.modules.events.PreSelectPopUpChicletEvent;
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.popups.modules.events.MFSPopUpEvent;
   
   public class PreSelectPopUpView extends MFSPopUpView
   {
      
      public function PreSelectPopUpView(param1:Boolean=true) {
         this.preSelectPopUpContainerBGMask = new Sprite();
         this.chicletContainer = new MovieClip();
         this.chicletContainerMask = new Sprite();
         this._selectedUsersMap = new Dictionary(false);
         this._currentlyProcessingUserMap = new Dictionary(false);
         super(TYPE_PRESELECT_MFS);
         this._resize = param1;
      }
      
      private static const TYPE_PRESELECT_MFS:String = "Preselect";
      
      protected static const DEFAULT_CHIC_HEIGHT:Number = 33.3;
      
      protected static const DEFAULT_CHIC_HEIGHT_PADDING:Number = 2.66;
      
      protected static const DEFAULT_CHIC_WIDTH:Number = 163.5;
      
      protected static const DEFAULT_CHIC_WIDTH_PADDING:Number = 30;
      
      protected static const DEFAULT_PAGE_SIZE:Number = (DEFAULT_CHIC_WIDTH + DEFAULT_CHIC_WIDTH_PADDING) * 3;
      
      protected static const DEFAULT_ROW_COUNT:Number = 8;
      
      protected static const DEFAULT_COL_COUNT:Number = 3;
      
      protected static const DEFAULT_TOTAL_COUNT:Number = DEFAULT_ROW_COUNT * DEFAULT_COL_COUNT;
      
      protected static const DEFAULT_CHICLET_X:Number = -278;
      
      protected static const DEFAULT_CHICLET_Y:Number = -255;
      
      public static const MAX_NUM_PER_SEND:Number = 50;
      
      protected static const TOP_RIGHT_BUTTON_LINE_HEIGHT:Number = 18;
      
      private var _rowCount:Number = 8;
      
      private var _colCount:Number = 3;
      
      private var _totalCount:Number = 24.0;
      
      private var _chicletX:Number = -278;
      
      private var _chicletY:Number = -255;
      
      private var _labelTextFormat:TextFormat;
      
      private const kPageCountToAutoSelect:int = 2;
      
      protected var preSelectPopUpContainer:MovieClip = null;
      
      protected var preSelectPopUpContainerBGMask:Sprite;
      
      protected var chicletContainer:MovieClip;
      
      protected var chicletContainerMask:Sprite;
      
      protected var playerTextTF:EmbeddedFontTextField = null;
      
      protected var playerSubTextTF:EmbeddedFontTextField = null;
      
      protected var progressTF:EmbeddedFontTextField = null;
      
      protected var sendTF:EmbeddedFontTextField = null;
      
      private var _iconHeader:EmbeddedFontTextField = null;
      
      protected var prevBtn:MovieClip;
      
      protected var nextBtn:MovieClip;
      
      private var featherImageLoader:SafeImageLoader;
      
      private var _currentPage:int = 0;
      
      protected var selectAll:CheckBox = null;
      
      protected var sendRequest:CheckBox = null;
      
      private var _isSelectAllActivated:Boolean = false;
      
      private var _lastPageDisplacement:Number = 0;
      
      private var _numPages:Number = 0;
      
      private var _numUsersThatCanBeSentTo:int = 0;
      
      private var _numSelectedUsers:int = 0;
      
      private var _numSelectedUsersOnPage:int = 0;
      
      private var _selectedUsersMap:Dictionary;
      
      private var _currentlyProcessingUserMap:Dictionary;
      
      private var _numRequestsSent:int = 0;
      
      private var _usersOnPage:Array;
      
      protected var spinner:MovieClip;
      
      private var _spinnerContainer:Sprite;
      
      private var _resize:Boolean = true;
      
      public var sn_id:int;
      
      public var showOptimizedLayout:Boolean = false;
      
      public var shouldAutoSelectChicletsPerPage:Boolean = false;
      
      public var sendAllShouldSendToMaxUsers:Boolean = false;
      
      protected var _sendAllButton:PokerUIButton;
      
      protected var _sendSelectedButton:PokerUIButton;
      
      protected var _sendMainButton:PokerUIButton;
      
      private var _pagesRemainingToAutoSelect:int = 2;
      
      private var _rewardBarController:RewardBarController = null;
      
      private var _headerBG:MovieClip = null;
      
      override public function init(param1:Object) : void {
         super.init(param1);
         this.realignNavButtonsAndSpinner();
      }
      
      override protected function setup() : void {
         super.setup();
         this.prepareCurrentPageChicletArray();
         if(popupData.preSelectAll == null || (popupData.preSelectAll))
         {
            this.toggleSelectAll(true);
         }
      }
      
      private function getPopupTextProperties() : Object {
         var _loc1_:* = "MainSemi";
         var _loc2_:* = false;
         var _loc3_:* = 22;
         var _loc4_:* = 14;
         var _loc5_:* = 16;
         var _loc6_:* = 20;
         var _loc7_:* = 12;
         var _loc8_:* = 14;
         return 
            {
               "font":_loc1_,
               "fontBold":_loc2_,
               "headerFontSize":_loc3_,
               "subHeaderFontSize":_loc4_,
               "selectAllFontSize":_loc5_,
               "sendButtonFontSize":_loc6_,
               "progressMeterFontSize":_loc7_,
               "imageLabelFontSize":_loc8_
            };
      }
      
      override protected function initPopUpContainer() : void {
         this.preSelectPopUpContainer = PokerClassProvider.getObject("com.zynga.poker.popups.modules.PreSelectPopUp") as MovieClip;
         this.preSelectPopUpContainer.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClicked,false,0,true);
         this.featherImageLoader = new SafeImageLoader();
         this.featherImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFeatherImageLoadComplete,false,0,true);
         this.featherImageLoader.load(new URLRequest(popupData.image));
         var _loc1_:Object = this.getPopupTextProperties();
         var _loc2_:String = _loc1_.font as String;
         if(popupData.headerBG)
         {
            this._headerBG = PokerClassProvider.getObject(popupData.headerBG);
            this.preSelectPopUpContainer.addChild(this._headerBG as DisplayObject);
            this._headerBG.x = this.preSelectPopUpContainer.whiteBG.x;
            this._headerBG.width = this.preSelectPopUpContainer.whiteBG.width;
            this._headerBG.y = -450;
         }
         this.playerTextTF = new EmbeddedFontTextField(popupData.header,_loc2_,_loc1_.headerFontSize,0,"center",_loc1_.fontBold);
         this.playerTextTF.x = -91;
         this.playerTextTF.y = -337;
         this.playerTextTF.wordWrap = true;
         this.playerTextTF.fitInWidth(351);
         this.playerTextTF.width = 351;
         this.playerTextTF.autoSize = TextFieldAutoSize.CENTER;
         this.playerTextTF.height = this.playerTextTF.height + 5;
         this.preSelectPopUpContainer.addChild(this.playerTextTF);
         if(popupData.subHeader != null)
         {
            this.playerSubTextTF = new EmbeddedFontTextField(popupData.subHeader,_loc2_,_loc1_.subHeaderFontSize,0,"center",_loc1_.fontBold);
            this.playerSubTextTF.x = -91 - 30;
            this.playerSubTextTF.y = -290;
            this.playerSubTextTF.width = 351 + 60;
            this.playerSubTextTF.height = 60;
            this.playerSubTextTF.wordWrap = true;
            this.playerTextTF.y = this.playerTextTF.y - 10;
            this.preSelectPopUpContainer.addChild(this.playerSubTextTF);
         }
         this.selectAll = new CheckBox();
         this.selectAll.textField.autoSize = TextFieldAutoSize.LEFT;
         this.selectAll.setStyle("textFormat",new TextFormat(_loc2_,_loc1_.selectAllFontSize,39423,_loc1_.fontBold));
         this.selectAll.x = -245;
         this.selectAll.y = this.preSelectPopUpContainer.progressMeter.y;
         this.selectAll.label = popupData.selectAllText;
         this.selectAll.selected = false;
         this.selectAll.labelPlacement = "right";
         if(popupData.sendRequestCheckbox != null)
         {
            this.sendRequest = new CheckBox();
            this.sendRequest.textField.autoSize = TextFieldAutoSize.LEFT;
            this.sendRequest.setStyle("textFormat",new TextFormat("_sans",10.5,8947848,_loc1_.fontBold));
            if(popupData.sendRequestCheckbox == 1)
            {
               this.sendRequest.x = -245;
               this.sendRequest.y = this.preSelectPopUpContainer.progressMeter.y + 18;
            }
            if(popupData.sendRequestCheckbox == 2)
            {
               this.sendRequest.x = this.playerTextTF.x + (this.playerTextTF.width - this.sendRequest.width) / 2;
               this.sendRequest.y = this.playerTextTF.y + 50;
               this.playerSubTextTF.y = this.playerSubTextTF.y - 28;
            }
            this.sendRequest.label = popupData.sendRequestText;
            this.sendRequest.selected = true;
            this.preSelectPopUpContainer.addChild(this.sendRequest);
         }
         if(popupData.showSelectAll == null || popupData.showSelectAll == true)
         {
            if(!this.showOptimizedLayout)
            {
               this.preSelectPopUpContainer.addChild(this.selectAll);
            }
         }
         this.preSelectPopUpContainer.addChild(this.chicletContainer);
         this.chicletContainer.x = this._chicletX;
         this.chicletContainer.y = this._chicletY;
         this.prevBtn = new PreSelectPopUpArrowButton(PreSelectPopUpArrowButton.ORIENTATION_LEFT);
         this.prevBtn.x = -303;
         this.prevBtn.y = -220 + 3;
         this.prevBtn.addEventListener(MouseEvent.CLICK,this.moveToPrevPage,false,0,true);
         this.preSelectPopUpContainer.addChild(this.prevBtn);
         this.nextBtn = new PreSelectPopUpArrowButton(PreSelectPopUpArrowButton.ORIENTATION_RIGHT);
         this.nextBtn.x = 303;
         this.nextBtn.y = -220 + 3;
         this.nextBtn.addEventListener(MouseEvent.CLICK,this.moveToNextPage,false,0,true);
         this.preSelectPopUpContainer.addChild(this.nextBtn);
         this.progressTF = new EmbeddedFontTextField("",_loc2_,_loc1_.progressMeterFontSize,0,"center",_loc1_.fontBold);
         this.progressTF.x = this.preSelectPopUpContainer.progressMeter.x - 11;
         this.progressTF.y = this.preSelectPopUpContainer.progressMeter.y + 15;
         this.progressTF.width = 156;
         this.progressTF.autoSize = TextFieldAutoSize.CENTER;
         this.progressTF.height = 20;
         this.preSelectPopUpContainer.addChild(this.progressTF);
         this._sendMainButton = new PokerUIButton();
         this._sendMainButton.style = PokerUIButton.BUTTONSTYLE_REQUEST_TWO_MFS_ACTION;
         this._sendMainButton.colorSet = PokerUIButtonRequest2MFSActionStyle.COLOR_GREEN;
         this._sendMainButton.buttonSize = new Size(139.9,33.25);
         this._sendMainButton.alignToPoint(new Point(-52.55,40.4));
         this.preSelectPopUpContainer.addChild(this._sendMainButton);
         this.sendTF = new EmbeddedFontTextField(popupData.sendButtonText,"MainSemi",_loc1_.sendButtonFontSize,16777215,"center");
         this.sendTF.x = -60;
         this.sendTF.y = this.preSelectPopUpContainer.progressMeter.y + 2;
         this.sendTF.width = 150;
         this.sendTF.height = 24;
         this.sendTF.mouseEnabled = false;
         if(!this.showOptimizedLayout)
         {
            this.preSelectPopUpContainer.addChild(this.sendTF);
         }
         if(this.showOptimizedLayout)
         {
            this._sendAllButton = new PokerUIButton();
            this._sendAllButton.style = PokerUIButton.BUTTONSTYLE_REQUEST_TWO_MFS_ACTION;
            this._sendAllButton.buttonSize = new Size(146,36);
            this._sendAllButton.labelTextFormat = new TextFormat("MainSemi",14,16777215,false,false,false,null,null,TextFormatAlign.CENTER,null,null,null,-5);
            this._sendAllButton.label = LocaleManager.localize("flash.mfs.button.sendAll");
            this._sendAllButton.addEventListener(MouseEvent.CLICK,this.onSendAllClicked,false,0,true);
            this.preSelectPopUpContainer.addChild(this._sendAllButton);
            if(popupData.type != 1)
            {
               this._sendAllButton.alignToPoint(new Point(-246,-62));
            }
            else
            {
               this._sendAllButton.alignToPoint(new Point(-246,38));
            }
            this._sendSelectedButton = new PokerUIButton();
            this._sendSelectedButton.style = PokerUIButton.BUTTONSTYLE_REQUEST_TWO_MFS_ACTION;
            this._sendSelectedButton.colorSet = PokerUIButtonRequest2MFSActionStyle.COLOR_GRAY;
            this._sendSelectedButton.buttonSize = this._sendAllButton.buttonSize;
            this._sendSelectedButton.labelTextFormat = this._sendAllButton.labelTextFormat;
            this._sendSelectedButton.label = LocaleManager.localize("flash.mfs.button.sendSelected");
            this._sendSelectedButton.alignToPoint(new Point(this._sendAllButton.getBounds(this).right + 12,this._sendAllButton.y));
            this.preSelectPopUpContainer.addChild(this._sendSelectedButton);
            this._sendMainButton.visible = false;
         }
         var _loc3_:MovieClip = this.preSelectPopUpContainer.closeButton;
         this.preSelectPopUpContainer.addChild(_loc3_);
         addChild(this.preSelectPopUpContainer);
         this.preSelectPopUpContainer.x = 365;
         this.preSelectPopUpContainer.y = 475;
      }
      
      override protected function initSpinner() : void {
         this.spinner = PokerClassProvider.getObject("status_spinner");
         this.spinner.x = 20;
         this.spinner.y = -200;
         this.spinner.visible = false;
         this.preSelectPopUpContainer.addChild(this.spinner);
      }
      
      override protected function initRewardBar() : void {
         var _loc1_:MovieClip = null;
         var _loc2_:TextFormat = null;
         var _loc3_:TextFormat = null;
         var _loc4_:TextFormat = null;
         if(popupData.hasOwnProperty("rewardBar"))
         {
            this._rewardBarController = new RewardBarController(popupData.rewardBar);
            this._rewardBarController.createRewardBarView(this._headerBG.width,35);
            this._rewardBarController.rewardBarView.x = -255;
            this._rewardBarController.rewardBarView.y = this._headerBG.y + this._headerBG.height * 0.5;
            this.preSelectPopUpContainer.addChild(this._rewardBarController.rewardBarView);
            if(this.playerTextTF)
            {
               this.playerTextTF.scaleX = this.playerTextTF.scaleY = 1;
               _loc2_ = new TextFormat("Main",20,16777215,true);
               _loc2_.align = "left";
               this.playerTextTF.setTextFormat(_loc2_);
               this.playerTextTF.multiline = false;
               this.playerTextTF.width = this._headerBG.width;
               this.playerTextTF.x = this._headerBG.x + 30;
               this.playerTextTF.y = -335;
            }
            if(this.playerSubTextTF)
            {
               _loc3_ = new TextFormat("MainSemi",16,16777215);
               if(LocaleManager.locale == "fr")
               {
                  _loc3_.size = 14;
               }
               _loc3_.align = "left";
               this.playerSubTextTF.setTextFormat(_loc3_);
               this.playerSubTextTF.multiline = false;
               this.playerSubTextTF.width = this.playerTextTF.width;
               this.playerSubTextTF.x = this.playerTextTF.x;
               this.playerSubTextTF.y = this.playerTextTF.y + 23;
            }
            if(this._rewardBarController.rewardBarView is RewardBarZPWCView)
            {
               if(this.playerTextTF)
               {
                  _loc4_ = this.playerTextTF.getTextFormat();
                  _loc4_.color = 13214515;
                  this.playerTextTF.filters = [new DropShadowFilter(),new BevelFilter(5,90,16777215,1,11382189,1,26,26)];
                  this.playerTextTF.setTextFormat(_loc4_);
                  this.playerTextTF.x = this._headerBG.x + 10;
               }
               if(this.playerSubTextTF)
               {
                  this.playerSubTextTF.filters = [new DropShadowFilter()];
                  this.playerSubTextTF.autoSize = TextFieldAutoSize.LEFT;
                  this.playerSubTextTF.x = this.playerTextTF.x;
               }
            }
            this._rowCount = 7;
            this._totalCount = this._rowCount * this._colCount;
            this.chicletContainer.y = this._chicletY = -220;
            _loc1_ = this.preSelectPopUpContainer.closeButton;
            this.preSelectPopUpContainer.addChild(_loc1_);
         }
      }
      
      override public function onRewardBarClaimed(param1:Object) : void {
         this._rewardBarController.onClaimedReward(param1.bonus as int);
      }
      
      private function onSendAllClicked(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:PreSelectMFSSendAll:2012-01-26"));
         if(!this.selectAll.selected)
         {
            this.onSelectAllClicked(null);
         }
         this.onSendButtonClicked(null);
      }
      
      private function onSelectAllClicked(param1:MouseEvent) : void {
         if(this._isSelectAllActivated)
         {
            doHitForStat(popupData.trackString,STAT_UNSELECT_ALL);
         }
         else
         {
            doHitForStat(popupData.trackString,STAT_SELECT_ALL);
         }
         this.toggleSelectAll(true);
      }
      
      private function toggleSelectAll(param1:Boolean=true) : void {
         this._isSelectAllActivated = !this._isSelectAllActivated;
         this.selectAll.selected = this._isSelectAllActivated;
         if(!param1)
         {
            return;
         }
         var _loc2_:* = 0;
         while(_loc2_ < chicletArray.length)
         {
            chicletArray[_loc2_].selected = this._isSelectAllActivated;
            if(this._isSelectAllActivated)
            {
               this._selectedUsersMap[chicletArray[_loc2_].UID] = true;
            }
            _loc2_++;
         }
         if(this._isSelectAllActivated)
         {
            this._numSelectedUsers = chicletArray.length;
            this._numSelectedUsersOnPage = this._usersOnPage.length;
            this.enableSendButton();
         }
         else
         {
            this._selectedUsersMap = new Dictionary(false);
            this._numSelectedUsers = 0;
            this._numSelectedUsersOnPage = 0;
            this.disableSendButton();
         }
      }
      
      private function disableSendButton() : void {
         if(this.showOptimizedLayout)
         {
            if(this._sendSelectedButton.hasEventListener(MouseEvent.CLICK))
            {
               this._sendSelectedButton.removeEventListener(MouseEvent.CLICK,this.onSendButtonClicked);
            }
            this._sendSelectedButton.enabled = false;
         }
         else
         {
            if(this._sendMainButton.hasEventListener(MouseEvent.CLICK))
            {
               this._sendMainButton.removeEventListener(MouseEvent.CLICK,this.onSendButtonClicked);
            }
            this._sendMainButton.enabled = false;
         }
      }
      
      private function enableSendButton() : void {
         if(this._numUsersThatCanBeSentTo == 0)
         {
            return;
         }
         if(this.showOptimizedLayout)
         {
            if(!this._sendSelectedButton.hasEventListener(MouseEvent.CLICK))
            {
               this._sendSelectedButton.addEventListener(MouseEvent.CLICK,this.onSendButtonClicked,false,0,true);
               this._sendSelectedButton.enabled = true;
            }
         }
         else
         {
            if(!this._sendMainButton.hasEventListener(MouseEvent.CLICK))
            {
               this._sendMainButton.addEventListener(MouseEvent.CLICK,this.onSendButtonClicked,false,0,true);
               this._sendMainButton.enabled = true;
            }
         }
      }
      
      override protected function initChicletArray() : void {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:PreSelectPopUpChiclet = null;
         this.preSelectPopUpContainerBGMask.graphics.beginFill(0,1);
         this.preSelectPopUpContainerBGMask.graphics.drawRect(-410,-485,815,595);
         this.preSelectPopUpContainerBGMask.graphics.endFill();
         this.preSelectPopUpContainerBGMask.alpha = 0.4;
         this.preSelectPopUpContainer.addChildAt(this.preSelectPopUpContainerBGMask,0);
         this.chicletContainerMask.graphics.beginFill(65280,1);
         this.chicletContainerMask.graphics.drawRect(this._chicletX,this._chicletY,560,300);
         this.chicletContainerMask.graphics.endFill();
         this.preSelectPopUpContainer.addChild(this.chicletContainerMask);
         this.chicletContainer.mask = this.chicletContainerMask;
         for (_loc1_ in popupData.recipients)
         {
            _loc2_ = popupData.recipients[_loc1_];
            if((_loc2_.zid) && (_loc2_.first_name) && (_loc2_.last_name) && (_loc2_.pic_small))
            {
               _loc3_ = new PreSelectPopUpChiclet(_loc2_);
               _loc3_.sn_id = this.sn_id;
               _loc3_.addEventListener(PreSelectPopUpChicletEvent.TYPE_CLICKED,this.onChicletClicked,false,0,true);
               if(popupData.preSelectAll == null || (popupData.preSelectAll))
               {
                  _loc3_.selected = true;
               }
               chicletArray.push(_loc3_);
            }
         }
         chicletArray.sortOn("playerName");
         this._numUsersThatCanBeSentTo = chicletArray.length;
         this.repositionChiclets();
         if(this._numUsersThatCanBeSentTo)
         {
            this.selectAll.addEventListener(MouseEvent.CLICK,this.onSelectAllClicked,false,0,true);
         }
         else
         {
            this.selectAll.enabled = false;
         }
         this.updateProgressMeterText();
         this.preSelectPopUpContainer.progressMeter.greenPart.width = 0;
      }
      
      private function repositionChiclets() : void {
         var _loc1_:* = 0;
         while(_loc1_ < chicletArray.length)
         {
            this.setUpChicletPosition(chicletArray[_loc1_],_loc1_);
            _loc1_++;
         }
      }
      
      private function onChicletClicked(param1:PreSelectPopUpChicletEvent) : void {
         var _loc2_:PreSelectPopUpChiclet = param1.target as PreSelectPopUpChiclet;
         _loc2_.selected = !_loc2_.selected;
         if(_loc2_.selected)
         {
            this._numSelectedUsers++;
            this._numSelectedUsersOnPage++;
            this._selectedUsersMap[_loc2_.UID] = true;
            this.enableSendButton();
         }
         else
         {
            this._numSelectedUsers--;
            if(--this._numSelectedUsersOnPage == 0)
            {
               this.disableSendButton();
            }
            delete this._selectedUsersMap[[_loc2_.UID]];
         }
         if(this._numSelectedUsers < chicletArray.length)
         {
            if(this.selectAll.selected)
            {
               this.toggleSelectAll(false);
            }
         }
         else
         {
            if(this._numSelectedUsers == chicletArray.length)
            {
               if(!this.selectAll.selected)
               {
                  this.toggleSelectAll(false);
               }
            }
         }
      }
      
      public function prepareCurrentPageChicletArray() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      protected function realignNavButtonsAndSpinner() : void {
         var _loc1_:Number = this.preSelectPopUpContainer.whiteBG.y + (this.preSelectPopUpContainer.whiteBG.height - this.prevBtn.height) / 2;
         this.prevBtn.y = _loc1_;
         this.nextBtn.y = _loc1_;
         var _loc2_:Number = _loc1_;
         this.spinner.y = _loc2_;
      }
      
      protected function setUpChicletPosition(param1:PreSelectPopUpChiclet, param2:int) : void {
         this.chicletContainer.addChild(param1);
         var _loc3_:int = param2 / this._totalCount;
         var _loc4_:int = param2 % this._totalCount / this._colCount;
         var _loc5_:int = param2 % this._totalCount % this._colCount;
         param1.x = 30 + _loc3_ * DEFAULT_PAGE_SIZE + _loc5_ * (DEFAULT_CHIC_WIDTH + DEFAULT_CHIC_WIDTH_PADDING);
         param1.y = _loc4_ * (DEFAULT_CHIC_HEIGHT + DEFAULT_CHIC_HEIGHT_PADDING);
      }
      
      public function cleanUpAfterSendRequests() : void {
         var _loc1_:* = NaN;
         if(!this.isAlive())
         {
            this.displayPostSendPopUp(this._numRequestsSent);
         }
         else
         {
            if(chicletArray.length == 0)
            {
               if(popupData.openZSCAfterClose == 1)
               {
                  externalInterface.call("ZY.App.flashDailyPopup.openZSC");
               }
               else
               {
                  if(popupData.openZSCAfterClose == 2)
                  {
                     externalInterface.call("ZY.App.flash2ndAppEntryPopup.openZSC");
                  }
               }
               this.removePreSelectPopUpContainer();
               this.displayPostSendPopUp(this._numRequestsSent);
            }
            else
            {
               this.updateProgressMeterText();
               this.preSelectPopUpContainer.progressMeter.greenPart.width = 136.3 * Number(this._numRequestsSent) / Number(this._numUsersThatCanBeSentTo);
               _loc1_ = this._chicletX - this._currentPage * DEFAULT_PAGE_SIZE;
               Tweener.addTween(this.chicletContainer,
                  {
                     "x":_loc1_,
                     "time":0.2,
                     "transition":"easeOutSine"
                  });
               this.repositionChiclets();
               this.prepareCurrentPageChicletArray();
            }
         }
      }
      
      private function updateProgressMeterText() : void {
         var _loc1_:String = (popupData) && (popupData.progressMeterText)?popupData.progressMeterText:"{requestsSent} / {totalRequestsPossible}";
         _loc1_ = _loc1_.replace(new RegExp("{requestsSent}"),this._numRequestsSent);
         _loc1_ = _loc1_.replace(new RegExp("{totalRequestsPossible}"),this._numUsersThatCanBeSentTo);
         this.progressTF.text = _loc1_;
         this.progressTF.fitInWidth(this.progressTF.width);
      }
      
      protected function moveToNextPage(param1:MouseEvent) : void {
         if(this._currentPage + 1 >= this._numPages)
         {
            this._currentPage = 0;
         }
         else
         {
            this._currentPage++;
         }
         var _loc2_:Number = this._chicletX - this._currentPage * DEFAULT_PAGE_SIZE;
         this.chicletContainer.visible = false;
         Tweener.addTween(this.chicletContainer,
            {
               "x":_loc2_,
               "time":0.2,
               "transition":"easeOutSine",
               "onComplete":this.onPageTransitionComplete
            });
         this.prepareCurrentPageChicletArray();
      }
      
      private function updateNavButtonStates() : void {
         if(this._numPages == 1)
         {
            this.nextBtn.visible = false;
            this.prevBtn.visible = false;
            return;
         }
         if(this._currentPage + 1 >= this._numPages)
         {
            if(this.nextBtn.hasEventListener(MouseEvent.CLICK))
            {
               this.nextBtn.removeEventListener(MouseEvent.CLICK,this.moveToNextPage);
            }
            this.nextBtn.visible = false;
         }
         else
         {
            if(!this.nextBtn.hasEventListener(MouseEvent.CLICK))
            {
               this.nextBtn.addEventListener(MouseEvent.CLICK,this.moveToNextPage,false,0,true);
            }
            this.nextBtn.visible = true;
         }
         if(this._currentPage-1 < 0)
         {
            if(this.prevBtn.hasEventListener(MouseEvent.CLICK))
            {
               this.prevBtn.removeEventListener(MouseEvent.CLICK,this.moveToPrevPage);
            }
            this.prevBtn.visible = false;
         }
         else
         {
            if(!this.prevBtn.hasEventListener(MouseEvent.CLICK))
            {
               this.prevBtn.addEventListener(MouseEvent.CLICK,this.moveToPrevPage,false,0,true);
            }
            this.prevBtn.visible = true;
         }
      }
      
      protected function moveToPrevPage(param1:MouseEvent) : void {
         if(this._currentPage-1 < 0)
         {
            this._currentPage = this._numPages-1;
         }
         else
         {
            this._currentPage--;
         }
         var _loc2_:Number = this._chicletX - this._currentPage * DEFAULT_PAGE_SIZE;
         this.chicletContainer.visible = false;
         Tweener.addTween(this.chicletContainer,
            {
               "x":_loc2_,
               "time":0.2,
               "transition":"easeOutSine",
               "onComplete":this.onPageTransitionComplete
            });
         this.prepareCurrentPageChicletArray();
      }
      
      private function onPageTransitionComplete() : void {
         this.chicletContainer.visible = true;
      }
      
      private function adjustPagePositioning(param1:Number) : void {
         if(this._sendAllButton)
         {
            this._sendAllButton.y = this._sendAllButton.y + param1;
         }
         if(this._sendSelectedButton)
         {
            this._sendSelectedButton.y = this._sendSelectedButton.y + param1;
         }
         if(this._sendMainButton)
         {
            this._sendMainButton.y = this._sendMainButton.y + param1;
         }
         this.preSelectPopUpContainer.blackBG.height = this.preSelectPopUpContainer.blackBG.height + param1;
         this.preSelectPopUpContainer.whiteBG.height = this.preSelectPopUpContainer.whiteBG.height + param1;
         this.preSelectPopUpContainer.progressMeter.y = this.preSelectPopUpContainer.progressMeter.y + param1;
         this.progressTF.y = this.progressTF.y + param1;
         this.selectAll.y = this.selectAll.y + param1;
         if((this.sendRequest) && popupData.sendRequestCheckbox == 1)
         {
            this.sendRequest.y = this.sendRequest.y + param1;
         }
         this.sendTF.y = this.sendTF.y + param1;
         this.adjustPopUpWindowPosition(param1);
      }
      
      protected function adjustPopUpWindowPosition(param1:Number) : void {
         this.preSelectPopUpContainer.y = this.preSelectPopUpContainer.y - param1 / 2;
         this.preSelectPopUpContainerBGMask.y = this.preSelectPopUpContainerBGMask.y + param1 / 2;
      }
      
      public function removePreSelectPopUpContainer() : void {
         this.removeChiclets();
         removeChild(this.preSelectPopUpContainer);
         this.preSelectPopUpContainer = null;
      }
      
      private function removeChiclets() : void {
         var _loc1_:Number = chicletArray.length;
         var _loc2_:int = _loc1_-1;
         while(_loc2_ >= 0)
         {
            chicletArray[_loc2_].dispose();
            if(this.chicletContainer.contains(chicletArray[_loc2_]))
            {
               this.chicletContainer.removeChild(chicletArray[_loc2_]);
            }
            chicletArray[_loc2_] = null;
            _loc2_--;
         }
      }
      
      private function onFeatherImageLoadComplete(param1:Event) : void {
         var _loc3_:Object = null;
         var _loc4_:* = NaN;
         this.featherImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onFeatherImageLoadComplete);
         if(this.preSelectPopUpContainer == null)
         {
            return;
         }
         var _loc2_:Bitmap = this.featherImageLoader.content as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.y = 0;
         _loc2_.scaleX = 0.4;
         _loc2_.scaleY = 0.4;
         _loc2_.x = 48;
         this.preSelectPopUpContainer.featherBadge.addChild(_loc2_);
         if(popupData.imageText)
         {
            _loc3_ = this.getPopupTextProperties();
            this._iconHeader = new EmbeddedFontTextField(popupData.imageText,_loc3_.font,_loc3_.imageLabelFontSize,0,"center",_loc3_.fontBold);
            this._iconHeader.fitInWidth(160);
            this._iconHeader.autoSize = TextFieldAutoSize.LEFT;
            _loc4_ = this._iconHeader.width;
            if(_loc2_.width < _loc4_)
            {
               this._iconHeader.x = _loc2_.x + (_loc2_.width - this._iconHeader.width) / 2;
            }
            else
            {
               this._iconHeader.x = _loc2_.x + _loc2_.width / 2;
            }
            this._iconHeader.y = _loc2_.height + 5;
            this.preSelectPopUpContainer.featherBadge.addChild(this._iconHeader);
         }
      }
      
      public function onCloseButtonClicked(param1:MouseEvent) : void {
         this.removePreSelectPopUpContainer();
         this.displayPostSendPopUp(this._numRequestsSent);
         if(popupData.openZSCAfterClose == 1)
         {
            externalInterface.call("ZY.App.flashDailyPopup.openZSC");
         }
         else
         {
            if(popupData.openZSCAfterClose == 2)
            {
               externalInterface.call("ZY.App.flash2ndAppEntryPopup.openZSC");
            }
         }
         if(popupData.postSendCB)
         {
            externalInterface.call(popupData.postSendCB);
         }
         doHitForStat(popupData.trackString,STAT_CLOSE);
      }
      
      public function onSendButtonClicked(param1:MouseEvent) : void {
         PokerStageManager.hideFullScreenMode();
         if(this.showOptimizedLayout)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:PreSelectMFSSendSelected:2012-01-26"));
         }
         this.sendRequests();
      }
      
      private function sendRequests() : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc1_:Array = new Array();
         this._currentlyProcessingUserMap = new Dictionary(false);
         if(!this.sendAllShouldSendToMaxUsers)
         {
            _loc2_ = this._usersOnPage.length-1;
            while(_loc2_ >= 0)
            {
               if(this._selectedUsersMap[this._usersOnPage[_loc2_].UID])
               {
                  _loc1_.push(Number(this._usersOnPage[_loc2_].UID));
                  this._currentlyProcessingUserMap[this._usersOnPage[_loc2_].UID] = true;
               }
               _loc2_--;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < MAX_NUM_PER_SEND)
            {
               if(chicletArray[_loc3_])
               {
                  if(this._selectedUsersMap[chicletArray[_loc3_].UID])
                  {
                     _loc1_.push(Number(chicletArray[_loc3_].UID));
                     this._currentlyProcessingUserMap[chicletArray[_loc3_].UID] = true;
                  }
               }
               _loc3_++;
            }
         }
         this.freezeScreen(true);
         externalInterface.call(popupData.sendCB,_loc1_,this.sendRequest?int(this.sendRequest.selected):1);
         doHitForStat(popupData.trackString,STAT_CLICKED);
      }
      
      override public function onFBCallBackReceived(param1:int) : void {
         this.freezeScreen(false);
         if(param1 == 0)
         {
            return;
         }
         this._numRequestsSent = this._numRequestsSent + param1;
         var _loc2_:int = chicletArray.length-1;
         while(_loc2_ >= 0)
         {
            if(this._currentlyProcessingUserMap[chicletArray[_loc2_].UID])
            {
               if(this.chicletContainer.contains(chicletArray[_loc2_]))
               {
                  this.chicletContainer.removeChild(chicletArray[_loc2_]);
               }
               chicletArray.splice(_loc2_,1);
            }
            _loc2_--;
         }
         if(this._currentPage == 0 && (this._pagesRemainingToAutoSelect))
         {
            this._pagesRemainingToAutoSelect--;
         }
         this._currentPage = 0;
         this.cleanUpAfterSendRequests();
      }
      
      private function displayPostSendPopUp(param1:int) : void {
         var _loc2_:Object = 
            {
               "counter":param1,
               "url":popupData.image,
               "scale":0.33
            };
         if(param1 == 1)
         {
            _loc2_.message = popupData.postSendTextSingular;
         }
         else
         {
            _loc2_.message = popupData.postSendTextPlural;
         }
         dispatchEvent(new MFSPopUpEvent(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,_loc2_));
         doHitForStat(popupData.trackString,"Preselect_" + getStatClusterForCount(param1) + "_Sends");
      }
      
      public function freezeScreen(param1:Boolean) : void {
         if(!this.isAlive())
         {
            return;
         }
         if(this._sendAllButton)
         {
            this._sendAllButton.mouseEnabled = !param1;
         }
         if(this._sendSelectedButton)
         {
            this._sendSelectedButton.mouseEnabled = !param1;
         }
         if(this._sendMainButton)
         {
            this._sendMainButton.mouseEnabled = !param1;
         }
         this.chicletContainer.mouseEnabled = !param1;
         this.chicletContainer.mouseChildren = !param1;
         this.preSelectPopUpContainer.closeButton.mouseEnabled = true;
         this.spinner.visible = param1;
      }
      
      public function isAlive() : Boolean {
         if(this.preSelectPopUpContainer)
         {
            return true;
         }
         return false;
      }
   }
}
