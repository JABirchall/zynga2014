package com.zynga.poker.popups.modules.PreSelectPopUp
{
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   
   public class PreSelectPopUpViewWithLotto extends PreSelectPopUpView
   {
      
      public function PreSelectPopUpViewWithLotto() {
         super();
      }
      
      private var _youWonTF:EmbeddedFontTextField = null;
      
      private var _mainLottoTF:EmbeddedFontTextField = null;
      
      private var _subLottoTF:EmbeddedFontTextField = null;
      
      private var _getMoreTF:EmbeddedFontTextField = null;
      
      private var _lottoImageLoader:SafeImageLoader;
      
      override protected function initPopUpContainer() : void {
         var _loc1_:Object = null;
         super.initPopUpContainer();
         if(popupData.extra_params)
         {
            _loc1_ = popupData.extra_params;
            if(_loc1_.badge == "gold")
            {
               preSelectPopUpContainer.goldBadge.visible = true;
               preSelectPopUpContainer.blueBadge.visible = false;
            }
            if(_loc1_.badge == "blue")
            {
               preSelectPopUpContainer.goldBadge.visible = false;
               preSelectPopUpContainer.blueBadge.visible = true;
            }
            this._lottoImageLoader = new SafeImageLoader();
            this._lottoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLottoImageLoadComplete,false,0,true);
            this._lottoImageLoader.load(new URLRequest(_loc1_.topLeftImage));
            this._youWonTF = new EmbeddedFontTextField(_loc1_.preheader,"MainSemi",15,16777215,"center");
            this._youWonTF.x = -47.25;
            this._youWonTF.y = -466.85;
            this._youWonTF.width = 129.7;
            this._youWonTF.height = 18.85;
            preSelectPopUpContainer.addChild(this._youWonTF);
            this._mainLottoTF = new EmbeddedFontTextField(_loc1_.lott_amt,"MainSemi",50,0,"center");
            this._mainLottoTF.multiline = true;
            this._mainLottoTF.wordWrap = true;
            this._mainLottoTF.x = _loc1_.badge == "blue"?-191:-234;
            this._mainLottoTF.y = -439;
            this._mainLottoTF.width = 500;
            preSelectPopUpContainer.addChild(this._mainLottoTF);
            this._subLottoTF = new EmbeddedFontTextField(_loc1_.header,"MainSemi",12,0,"center");
            this._subLottoTF.x = -175;
            this._subLottoTF.y = -381;
            this._subLottoTF.width = 387;
            this._subLottoTF.height = 18;
            preSelectPopUpContainer.addChild(this._subLottoTF);
            if(_loc1_.topRightButtonText)
            {
               this._getMoreTF = new EmbeddedFontTextField(_loc1_.topRightButtonText,"MainSemi",12,0,"center");
               this._getMoreTF.x = 0;
               this._getMoreTF.y = -2;
               this._getMoreTF.wordWrap = true;
               this._getMoreTF.fitInWidth(150);
               this._getMoreTF.width = 150;
               this._getMoreTF.autoSize = TextFieldAutoSize.CENTER;
               if(this._getMoreTF.height <= PreSelectPopUpView.TOP_RIGHT_BUTTON_LINE_HEIGHT)
               {
                  this._getMoreTF.y = 3;
               }
               preSelectPopUpContainer.lottoButton.addChild(this._getMoreTF);
               preSelectPopUpContainer.lottoButton.addEventListener(MouseEvent.CLICK,this.onLottoButtonClicked,false,0,true);
               preSelectPopUpContainer.lottoButton.buttonMode = true;
               preSelectPopUpContainer.lottoButton.visible = true;
            }
            else
            {
               preSelectPopUpContainer.lottoButton.visible = false;
            }
         }
      }
      
      private function onLottoImageLoadComplete(param1:Event) : void {
         this._lottoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLottoImageLoadComplete);
         this._lottoImageLoader.x = 0.0;
         this._lottoImageLoader.y = 0.0;
         preSelectPopUpContainer.lottoBadge.addChild(this._lottoImageLoader);
      }
      
      private function onLottoButtonClicked(param1:MouseEvent) : void {
         if(popupData.extra_params == null)
         {
            return;
         }
         externalInterface.call(popupData.extra_params.topRightButtonCB);
      }
      
      override protected function setup() : void {
         super.setup();
      }
      
      override public function freezeScreen(param1:Boolean) : void {
         super.freezeScreen(param1);
         preSelectPopUpContainer.lottoButton.mouseEnabled = !param1;
      }
   }
}
