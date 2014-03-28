package com.zynga.poker.mfs.miniMFS.view
{
   import com.zynga.poker.mfs.view.MFSView;
   import com.zynga.locale.LocaleManager;
   import flash.display.MovieClip;
   import com.zynga.ui.scroller.ScrollSystem;
   import com.zynga.display.SafeImageLoader;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextField;
   import fl.controls.CheckBox;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldType;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import com.zynga.poker.mfs.miniMFS.events.MiniMFSPopUpChicletEvent;
   import flash.display.DisplayObject;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.mfs.miniMFS.events.MiniMFSPopUpEvent;
   import com.zynga.poker.mfs.model.MFSModel;
   
   public class MiniMFSView extends MFSView
   {
      
      public function MiniMFSView(param1:MFSModel) {
         this.chicletContainer = new MovieClip();
         this.chicletContainerChecked = new MovieClip();
         this.chicletArrayChecked = new Array();
         super(param1,MFSModel.TYPE_MINI_MFS);
      }
      
      public static const HEADER_LINE_HEIGHT:Number = 24;
      
      public static const DEFAULT_CHIC_HEIGHT:Number = 20;
      
      public static const DEFAULT_CHIC_HEIGHT_PADDING:Number = 1;
      
      public static const MAX_NUM_FRDS_ON_ONE_SEND:Number = 50;
      
      public static const SEARCH_NAME:String = LocaleManager.localize("flash.mfs.search.name");
      
      public static const SELECT_FRIENDS:String = LocaleManager.localize("flash.mfs.search.friends");
      
      public var miniMFSPopUpContainer:MovieClip = null;
      
      public var miniMFSScroll:ScrollSystem = null;
      
      public var miniMFSScrollChecked:ScrollSystem = null;
      
      public var chicletContainer:MovieClip;
      
      public var chicletContainerChecked:MovieClip;
      
      public var chicletArrayChecked:Array;
      
      public var maxGiftsContainer:MovieClip = null;
      
      private var _headerImageLoader:SafeImageLoader;
      
      private var _headerImageContainer:Sprite;
      
      private var _selectTF:EmbeddedFontTextField = null;
      
      private var _headerTF:EmbeddedFontTextField = null;
      
      private var _subheaderTF:EmbeddedFontTextField = null;
      
      private var _sendTF:EmbeddedFontTextField = null;
      
      private var _spinner:MovieClip = null;
      
      public var numberOfRequestsSent:int = 0;
      
      public var searchNameInput:TextField;
      
      public var chkSelectAll:CheckBox = null;
      
      private var _selectAllMode:Boolean = false;
      
      override protected function initPopUpContainer() : void {
         this.miniMFSPopUpContainer = PokerClassProvider.getObject("MiniMFS") as MovieClip;
         this.miniMFSPopUpContainer.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClicked,false,0,true);
         this.miniMFSPopUpContainer.sendButton.addEventListener(MouseEvent.CLICK,this.onSendButtonClicked,false,0,true);
         this.miniMFSPopUpContainer.closeButton.buttonMode = true;
         this.miniMFSPopUpContainer.sendButton.buttonMode = true;
         this.miniMFSPopUpContainer.x = 26;
         this.miniMFSPopUpContainer.y = 375;
         addChild(this.miniMFSPopUpContainer);
         this._selectTF = new EmbeddedFontTextField(SELECT_FRIENDS,"MainSemi",10,0,"center");
         this._selectTF.x = -4.8;
         this._selectTF.y = 110.4;
         this._selectTF.width = 169.35;
         this._selectTF.height = 17.95;
         this._selectTF.visible = false;
         this.miniMFSPopUpContainer.addChild(this._selectTF);
         this.initHeader();
         if(mfsModel.popupData.selectAll != null)
         {
            this._selectAllMode = mfsModel.popupData.selectAll;
         }
         if(this._selectAllMode)
         {
            this._selectTF.y = this._selectTF.y + 20;
         }
         this._sendTF = new EmbeddedFontTextField(mfsModel.popupData.btnSendText,"MainSemi",16,16777215,"center");
         this._sendTF.x = -55;
         this._sendTF.y = -13;
         this._sendTF.wordWrap = true;
         this._sendTF.fitInWidth(110);
         this._sendTF.width = 110;
         this._sendTF.autoSize = TextFieldAutoSize.CENTER;
         if(this._sendTF.height > 30)
         {
            this._sendTF.y = this._sendTF.y - 7;
         }
         this.miniMFSPopUpContainer.sendButton.addChild(this._sendTF);
         if(this._selectAllMode)
         {
            this.chkSelectAll = new CheckBox();
            this.chkSelectAll.textField.autoSize = TextFieldAutoSize.LEFT;
            this.chkSelectAll.setStyle("textFormat",new TextFormat("_sans",11,6710886));
            this._headerTF.y = -144;
            this.chkSelectAll.label = mfsModel.popupData.selectAllText;
            this.chkSelectAll.selected = true;
            this.chkSelectAll.x = -4;
            this.chkSelectAll.y = -42;
            this.chkSelectAll.addEventListener(MouseEvent.CLICK,this.onSelectAllClicked,false,0,true);
            this.miniMFSPopUpContainer.addChild(this.chkSelectAll);
         }
         this.initSearchNameInput();
      }
      
      override protected function initSpinner() : void {
         this._spinner = PokerClassProvider.getObject("status_spinner");
         this._spinner.x = 100;
         this._spinner.y = 0;
         this._spinner.visible = false;
         this.miniMFSPopUpContainer.addChild(this._spinner);
      }
      
      protected function initHeader() : void {
         var _loc1_:* = !(mfsModel.popupData.subHeader == null);
         var _loc2_:Number = 32.45;
         var _loc3_:Number = 160.55;
         if(_loc1_)
         {
            this._headerTF = new EmbeddedFontTextField(mfsModel.popupData.header,"MainSemi",16,16505088,"left");
            this._headerTF.wordWrap = true;
            this._headerTF.y = -136;
            this._headerTF.fitInWidth(_loc3_);
            this._headerTF.x = _loc2_;
            this._headerTF.width = _loc3_;
            this._headerTF.autoSize = TextFieldAutoSize.LEFT;
            if(this._headerTF.height > HEADER_LINE_HEIGHT)
            {
               this._headerTF.y = this._headerTF.y - 15;
            }
         }
         else
         {
            this._headerTF = new EmbeddedFontTextField(mfsModel.popupData.header,"MainSemi",17,16505088,"center");
            this._headerTF.wordWrap = true;
            this._headerTF.y = -133;
            this._headerTF.x = _loc2_;
            this._headerTF.width = _loc3_;
            this._headerTF.autoSize = TextFieldAutoSize.LEFT;
            this._headerTF.y = this._headerTF.y + (5 - Math.floor(this._headerTF.height / HEADER_LINE_HEIGHT) * 10);
         }
         this.miniMFSPopUpContainer.addChild(this._headerTF);
         if(_loc1_)
         {
            this._subheaderTF = new EmbeddedFontTextField(mfsModel.popupData.subHeader,"MainSemi",12,16777215,"left");
            this._subheaderTF.x = 33.45;
            this._subheaderTF.y = -110;
            this._subheaderTF.width = 160.55;
            this._subheaderTF.height = 51.3;
            this._subheaderTF.wordWrap = true;
            this.miniMFSPopUpContainer.addChild(this._subheaderTF);
         }
         if(mfsModel.popupData.image)
         {
            this._headerImageContainer = new Sprite();
            this._headerImageContainer.x = -10;
            this._headerImageContainer.y = -135;
            this.miniMFSPopUpContainer.addChild(this._headerImageContainer);
            this._headerImageLoader = new SafeImageLoader();
            this._headerImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onHeaderImageLoadComplete,false,0,true);
            this._headerImageLoader.load(new URLRequest(mfsModel.popupData.image));
         }
      }
      
      private function initSearchNameInput() : void {
         this.searchNameInput = new TextField();
         this.searchNameInput.defaultTextFormat = new TextFormat("_sans",12,4473924,true,null,null,null,null,TextFormatAlign.LEFT);
         this.searchNameInput.width = 190;
         this.searchNameInput.height = 20;
         this.searchNameInput.x = -95;
         this.searchNameInput.y = -109;
         this.searchNameInput.type = TextFieldType.INPUT;
         this.searchNameInput.multiline = false;
         this.searchNameInput.wordWrap = false;
         this.searchNameInput.maxChars = 30;
         this.searchNameInput.border = true;
         this.searchNameInput.borderColor = 13421772;
         this.searchNameInput.text = SEARCH_NAME;
         this.searchNameInput.addEventListener(FocusEvent.FOCUS_OUT,this.onSearchNameInputOutOfFocus,false,0,true);
         this.searchNameInput.addEventListener(FocusEvent.FOCUS_IN,this.onSearchNameInputInFocus,false,0,true);
         this.searchNameInput.addEventListener(MouseEvent.CLICK,this.onSearchNameInputInFocus,false,0,true);
         this.searchNameInput.addEventListener(KeyboardEvent.KEY_UP,this.onInputEntered,false,0,true);
         this.miniMFSPopUpContainer.scrollContainer.addChild(this.searchNameInput);
      }
      
      private function scrollMC(param1:MouseEvent) : void {
         this.updateScrolls();
      }
      
      public function updateScrolls() : void {
         this.miniMFSScroll.moveRequestV(0);
         this.miniMFSScroll.updater(false,false);
         if(this.miniMFSScrollChecked)
         {
            this.miniMFSScrollChecked.moveRequestV(0);
            this.miniMFSScrollChecked.updater(false,false);
         }
      }
      
      override protected function initChicletArray() : void {
         if(mfsModel.popupData)
         {
            this.initAllFrdsDataUnchecked();
         }
         this.updateUncheckedchicletArrayPositions();
         var _loc1_:Object = new Object();
         _loc1_.arrowUp = PokerClassProvider.getObject("ChatArrowUp");
         _loc1_.arrowDown = PokerClassProvider.getObject("ChatArrowDown");
         _loc1_.handleV = PokerClassProvider.getObject("ChatHandleV");
         _loc1_.trackV = PokerClassProvider.getObject("ChatTrackV");
         var _loc2_:Number = -101;
         var _loc3_:Number = -78;
         var _loc4_:Number = 183;
         var _loc5_:Number = 115;
         if(this._selectAllMode)
         {
            _loc5_ = _loc5_ + 29;
         }
         this.miniMFSScroll = new ScrollSystem(this.miniMFSPopUpContainer,this.chicletContainer,_loc4_,_loc5_,_loc1_,9,0,true,false);
         this.miniMFSScroll.x = _loc2_;
         this.miniMFSScroll.y = _loc3_;
         this.miniMFSPopUpContainer.scrollContainer.addChild(this.miniMFSScroll);
         this.chicletContainer.addEventListener(MouseEvent.CLICK,this.scrollMC);
         var _loc6_:Object = new Object();
         _loc6_.arrowUp = PokerClassProvider.getObject("ChatArrowUp");
         _loc6_.arrowDown = PokerClassProvider.getObject("ChatArrowDown");
         _loc6_.handleV = PokerClassProvider.getObject("ChatHandleV");
         _loc6_.trackV = PokerClassProvider.getObject("ChatTrackV");
         var _loc7_:Number = 43;
         var _loc8_:Number = 183;
         var _loc9_:Number = 63;
         var _loc10_:Sprite = new Sprite();
         _loc10_.graphics.beginFill(13421772);
         _loc10_.graphics.drawRect(0,0,_loc8_,_loc9_);
         _loc10_.graphics.endFill();
         _loc10_.x = _loc2_;
         _loc10_.y = _loc7_;
         this.miniMFSPopUpContainer.scrollContainer.addChild(_loc10_);
         this.miniMFSScrollChecked = new ScrollSystem(this.miniMFSPopUpContainer,this.chicletContainerChecked,_loc8_,_loc9_,_loc6_,9,0,true,false);
         this.miniMFSScrollChecked.x = _loc2_;
         this.miniMFSScrollChecked.y = _loc7_;
         this.miniMFSPopUpContainer.scrollContainer.addChild(this.miniMFSScrollChecked);
         this.chicletContainerChecked.addEventListener(MouseEvent.CLICK,this.scrollMC);
         var _loc11_:Sprite = new Sprite();
         _loc11_.graphics.lineStyle(2,13421772);
         _loc11_.graphics.moveTo(_loc2_,-82);
         _loc11_.graphics.lineTo(101,-82);
         this.miniMFSPopUpContainer.scrollContainer.addChild(_loc11_);
         if(this._selectAllMode)
         {
            this.miniMFSScroll.y = this.miniMFSScroll.y + 20;
            _loc10_.visible = false;
            this.miniMFSScrollChecked.visible = false;
            this.selectAll();
         }
      }
      
      private function initAllFrdsDataUnchecked() : void {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:MiniMFSPopUpChiclet = null;
         for (_loc1_ in mfsModel.popupData.recipients)
         {
            _loc2_ = mfsModel.popupData.recipients[_loc1_];
            if((_loc2_.zid) && (_loc2_.first_name) && (_loc2_.last_name))
            {
               _loc3_ = new MiniMFSPopUpChiclet(_loc2_);
               _loc3_.addEventListener(MiniMFSPopUpChicletEvent.TYPE_CLICKED,this.onChickletClicked,false,0,true);
               mfsModel.chicletArray.push(_loc3_);
            }
         }
         mfsModel.chicletArray.sortOn("playerName");
      }
      
      public function updateUncheckedchicletArrayPositions() : void {
         var _loc6_:MiniMFSPopUpChiclet = null;
         var _loc1_:String = SEARCH_NAME;
         var _loc2_:MovieClip = this.chicletContainer;
         var _loc3_:Array = mfsModel.chicletArray;
         var _loc4_:* = 0;
         while(_loc2_.numChildren)
         {
            _loc2_.removeChildAt(0);
         }
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_] as MiniMFSPopUpChiclet;
            if(this.searchNameInput.text == _loc1_ || this.searchNameInput.text == "" || _loc6_.playerName.toLowerCase().indexOf(this.searchNameInput.text.toLowerCase()) >= 0)
            {
               this.setUpChicletPosition(_loc2_,_loc3_[_loc5_],_loc4_,_loc5_);
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      private function updateCheckedchicletArrayPositions() : void {
         var _loc1_:MovieClip = this.chicletContainerChecked;
         var _loc2_:Array = this.chicletArrayChecked;
         var _loc3_:* = 0;
         while(_loc1_.numChildren)
         {
            _loc1_.removeChildAt(0);
         }
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_.length)
         {
            this.setUpChicletPosition(_loc1_,_loc2_[_loc4_],_loc3_,_loc4_);
            _loc3_++;
            _loc4_++;
         }
         if(_loc2_.length)
         {
            this._selectTF.visible = false;
         }
      }
      
      private function setUpChicletPosition(param1:MovieClip, param2:MiniMFSPopUpChiclet, param3:int, param4:int) : void {
         param1.addChild(param2);
         param2.y = param3 * (DEFAULT_CHIC_HEIGHT + DEFAULT_CHIC_HEIGHT_PADDING) + DEFAULT_CHIC_HEIGHT_PADDING;
         param2.arrayIndex = param4;
      }
      
      public function setupMaxGiftsContainer() : void {
         if(!(this.maxGiftsContainer == null) && (this.contains(this.maxGiftsContainer)))
         {
            return;
         }
         this.maxGiftsContainer = new MovieClip();
         addChild(this.maxGiftsContainer as DisplayObject);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRoundRect(0,475,235,92,10,10);
         _loc1_.graphics.endFill();
         this.maxGiftsContainer.addChildAt(_loc1_,0);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,260,235,315);
         _loc2_.graphics.endFill();
         _loc2_.alpha = 0.5;
         this.maxGiftsContainer.addChildAt(_loc2_,0);
         var _loc3_:MovieClip = PokerClassProvider.getObject("miniMFSCloseButton");
         _loc3_.x = 211;
         _loc3_.y = 475 + 1;
         _loc3_.buttonMode = true;
         _loc3_.addEventListener(MouseEvent.CLICK,this.onMaxGiftsCloseButtonClicked,false,0,true);
         this.maxGiftsContainer.addChild(_loc3_);
         var _loc4_:ShinyButton = new ShinyButton(mfsModel.popupData.btnSendAndContinueText,175,35,16,16777215,ShinyButton.COLOR_LIGHT_GREEN);
         _loc4_.addEventListener(MouseEvent.CLICK,this.onMaxGiftsSendButtonClicked,false,0,true);
         _loc4_.x = 30;
         _loc4_.y = 475 + 55;
         this.maxGiftsContainer.addChild(_loc4_);
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(mfsModel.popupData.sendLimitReachedText.replace(new RegExp("{numFriends}"),MAX_NUM_FRDS_ON_ONE_SEND),"MainSemi",14,16777215,"center");
         _loc5_.x = 30;
         _loc5_.y = 490;
         _loc5_.width = 175;
         _loc5_.height = 40;
         _loc5_.wordWrap = true;
         this.maxGiftsContainer.addChild(_loc5_);
         this.maxGiftsContainer.addEventListener(MouseEvent.CLICK,this.scrollMC);
      }
      
      public function removeMaxGiftsContainer() : void {
         removeChild(this.maxGiftsContainer);
         this.maxGiftsContainer = null;
      }
      
      public function onMaxGiftsCloseButtonClicked(param1:MouseEvent) : void {
         this.removeMaxGiftsContainer();
      }
      
      private function onChickletClicked(param1:MiniMFSPopUpChicletEvent) : void {
         var _loc2_:MiniMFSPopUpChiclet = param1.target as MiniMFSPopUpChiclet;
         if(!this._selectAllMode && !_loc2_.selected && this.chicletArrayChecked.length >= MAX_NUM_FRDS_ON_ONE_SEND)
         {
            this.setupMaxGiftsContainer();
            _loc2_.selected = false;
            return;
         }
         _loc2_.selected = !_loc2_.selected;
         if((_loc2_.selected) && (this._selectTF.visible))
         {
            this._selectTF.visible = false;
         }
         if((this._selectAllMode) && (this.chkSelectAll) && (this.chkSelectAll.selected))
         {
            this.chkSelectAll.selected = false;
         }
         if(!this._selectAllMode)
         {
            this.updateOnChicletClicked(_loc2_);
         }
      }
      
      private function updateOnChicletClicked(param1:MiniMFSPopUpChiclet) : void {
         var _loc2_:Boolean = param1.selected;
         if(_loc2_)
         {
            mfsModel.chicletArray.splice(param1.arrayIndex,1);
            this.chicletArrayChecked.push(param1);
            this.chicletArrayChecked.sortOn("playerName");
         }
         else
         {
            this.chicletArrayChecked.splice(param1.arrayIndex,1);
            mfsModel.chicletArray.push(param1);
            mfsModel.chicletArray.sortOn("playerName");
         }
         this.updateCheckedchicletArrayPositions();
         this.updateUncheckedchicletArrayPositions();
      }
      
      public function onMaxGiftsSendButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_SEND_ALL));
      }
      
      override public function onFBCallBackReceived(param1:int) : void {
         this.freezeScreen(false);
         this.numberOfRequestsSent = this.numberOfRequestsSent + param1;
         if(!this.isAlive())
         {
            dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_POST_SEND,{"requestsSent":this.numberOfRequestsSent}));
         }
      }
      
      public function freezeScreen(param1:Boolean) : void {
         if(!this.isAlive())
         {
            return;
         }
         this.chicletContainer.mouseChildren = !param1;
         this.chicletContainerChecked.mouseChildren = !param1;
         this.miniMFSPopUpContainer.sendButton.mouseEnabled = !param1;
         this.searchNameInput.mouseEnabled = !param1;
         this._spinner.visible = param1;
      }
      
      private function onHeaderImageLoadComplete(param1:Event) : void {
         this._headerImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onHeaderImageLoadComplete);
         this._headerImageLoader.scaleX = 0.66;
         this._headerImageLoader.scaleY = 0.66;
         this._headerImageContainer.addChild(this._headerImageLoader);
      }
      
      private function onSelectAllClicked(param1:MouseEvent) : void {
         if(this.chkSelectAll.selected)
         {
            this.selectAll();
         }
         else
         {
            this.unselectAll();
         }
      }
      
      private function selectAll() : void {
         var _loc1_:int = mfsModel.chicletArray.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            (mfsModel.chicletArray[_loc2_] as MiniMFSPopUpChiclet).selected = true;
            _loc2_++;
         }
      }
      
      private function unselectAll() : void {
         var _loc1_:int = mfsModel.chicletArray.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            (mfsModel.chicletArray[_loc2_] as MiniMFSPopUpChiclet).selected = false;
            _loc2_++;
         }
      }
      
      public function isAlive() : Boolean {
         if(this.miniMFSPopUpContainer)
         {
            return true;
         }
         return false;
      }
      
      public function setSelectTFVisible(param1:Boolean) : void {
         this._selectTF.visible = param1;
      }
      
      private function onCloseButtonClicked(param1:MouseEvent) : void {
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_CLOSE_BUTTON_CLICKED));
      }
      
      private function onSendButtonClicked(param1:MouseEvent) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:MiniMFSPopUpChiclet = null;
         var _loc5_:* = 0;
         if(this._selectAllMode)
         {
            _loc2_ = 0;
            _loc3_ = mfsModel.chicletArray.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = mfsModel.chicletArray[_loc5_];
               if(_loc4_.selected)
               {
                  if(_loc2_ == MAX_NUM_FRDS_ON_ONE_SEND)
                  {
                     break;
                  }
                  this.chicletArrayChecked.push(_loc4_);
                  _loc2_++;
               }
               _loc5_++;
            }
         }
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_SEND_BUTTON_CLICKED));
      }
      
      private function onSearchNameInputOutOfFocus(param1:Event) : void {
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_OUT_OF_FOCUS));
      }
      
      private function onSearchNameInputInFocus(param1:Event) : void {
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_IN_FOCUS));
      }
      
      private function onInputEntered(param1:KeyboardEvent) : void {
         dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_ENTERED));
      }
   }
}
