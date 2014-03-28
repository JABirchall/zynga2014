package com.zynga.poker.mfs.bigMFS.view
{
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import flash.display.Sprite;
   import fl.controls.CheckBox;
   import flash.text.TextFormat;
   import com.zynga.poker.mfs.model.MFSModel;
   
   public class BigMFSAppEntryView extends BigMFSView
   {
      
      public function BigMFSAppEntryView(param1:MFSModel) {
         super(param1);
      }
      
      private var _preHeader:EmbeddedFontTextField;
      
      override protected function initHeaderText() : void {
         var _loc1_:* = NaN;
         _loc1_ = mfsModel.popupData.image != null?90:10;
         _header = new EmbeddedFontTextField(mfsModel.popupData.header,"MainSemi",48,16777215,"center");
         _header.multiline = true;
         _header.autoSize = TextFieldAutoSize.CENTER;
         _header.fitInWidth(DEFAULT_HEADER_WIDTHS - _loc1_);
         if(_header.height > 70)
         {
            _header.fitInHeight(70);
         }
         _header.x = (_loc1_ - _header.width) / 2;
         addChild(_header);
         _subHeader = new EmbeddedFontTextField(mfsModel.popupData.subHeader,"MainSemi",22,16777215,"center");
         _subHeader.multiline = true;
         _subHeader.autoSize = TextFieldAutoSize.CENTER;
         _subHeader.fitInWidth(DEFAULT_HEADER_WIDTHS - _loc1_ < 300?300:_header.width);
         if(_subHeader.height > 50)
         {
            _subHeader.fitInHeight(50);
         }
         _subHeader.x = (_loc1_ - _subHeader.width) / 2;
         addChild(_subHeader);
         this._preHeader = new EmbeddedFontTextField(mfsModel.popupData.preHeader,"MainSemi",22,16777215,"center");
         this._preHeader.multiline = true;
         this._preHeader.autoSize = TextFieldAutoSize.CENTER;
         this._preHeader.fitInWidth(DEFAULT_HEADER_WIDTHS - _loc1_ < 300?300:_header.width);
         if(this._preHeader.height > 50)
         {
            this._preHeader.fitInHeight(50);
         }
         this._preHeader.x = (_loc1_ - this._preHeader.width) / 2;
         addChild(this._preHeader);
         _header.y = -170 - _header.height / 2 - _subHeader.height / 2;
         _subHeader.y = _header.y + _header.height;
         this._preHeader.y = _header.y - _header.height / 2;
         _iconHeader = new EmbeddedFontTextField(mfsModel.popupData.iconHeader,"MainSemi",12,16777215,"center");
         _iconHeader.x = -365;
         _iconHeader.y = -140;
         _iconHeader.fitInWidth(160);
         _iconHeader.width = 160;
         _iconHeader.autoSize = TextFieldAutoSize.CENTER;
         addChild(_iconHeader);
         _progressString = new EmbeddedFontTextField("","MainSemi",14,39423,"right");
         _progressString.x = 0;
         _progressString.y = 215;
         _progressString.width = 343;
         _progressString.height = 30;
         addChild(_progressString);
      }
      
      override protected function initButtons() : void {
         _btnSend = PokerClassProvider.getObject("largePrimaryButton");
         _btnSend.text = "";
         _btnSend.width = 140;
         _btnSend.doLayout();
         addChild(_btnSend);
         _btnSend.x = -285;
         _btnSend.y = 199;
         _btnSend.mouseChildren = false;
         _btnSend.addEventListener(MouseEvent.CLICK,onSendButtonClicked,false,0,true);
         if(mfsModel.popupData.showCloseButton)
         {
            _closeButton = PokerClassProvider.getObject("smallBlueCloseButton");
            _closeButton.x = 340;
            _closeButton.y = -232;
            _closeButton.addEventListener(MouseEvent.CLICK,onCloseButtonClicked,false,0,true);
            _closeButton.useHandCursor = true;
            _closeButton.mouseEnabled = true;
            _closeButton.buttonMode = true;
            addChild(_closeButton);
         }
         if(mfsModel.popupData.showCancelLink)
         {
            _closeSprite = new Sprite();
            _closeSprite.graphics.beginFill(16711680,0.0);
            _closeSprite.graphics.drawRect(295,233,50,18);
            _closeSprite.graphics.endFill();
            addChild(_closeSprite);
            _closeSprite.buttonMode = true;
            _closeSprite.addEventListener(MouseEvent.CLICK,onCloseButtonClicked,false,0,true);
            _closeTF = new EmbeddedFontTextField(mfsModel.popupData.cancel,"MainSemi",14,10066329,"center");
            _closeTF.x = 245;
            _closeTF.y = 233;
            _closeTF.width = 150;
            _closeTF.height = 18;
            addChild(_closeTF);
         }
         selectAll = new CheckBox();
         selectAll.textField.autoSize = TextFieldAutoSize.LEFT;
         selectAll.setStyle("textFormat",new TextFormat("_sans",16,39423));
         selectAll.x = -330;
         selectAll.y = -92;
         selectAll.label = mfsModel.popupData.selectAll;
         selectAll.labelPlacement = "right";
         selectAll.selected = false;
         var _loc1_:* = true;
         if(mfsModel.popupData.hasOwnProperty("showSelectAll"))
         {
            _loc1_ = mfsModel.popupData["showSelectAll"];
         }
         if(_loc1_)
         {
            addChild(selectAll);
         }
      }
   }
}
