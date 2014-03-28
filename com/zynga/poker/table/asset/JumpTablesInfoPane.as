package com.zynga.poker.table.asset
{
   import flash.display.Sprite;
   import com.zynga.draw.ComplexBox;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.table.events.TVEvent;
   
   public class JumpTablesInfoPane extends Sprite
   {
      
      public function JumpTablesInfoPane() {
         super();
         this.setup();
      }
      
      private var _background:ComplexBox;
      
      private var _closeButton:MovieClip;
      
      private var _searchIndicator:MovieClip;
      
      private var _searchLabel:EmbeddedFontTextField;
      
      private var _searchUIContainer:Sprite;
      
      private var _backToLobbyContainer:Sprite;
      
      private var _backToLobbyLabel:EmbeddedFontTextField;
      
      private var _backToLobbyButton:PokerButton;
      
      private function setup() : void {
         this._background = new ComplexBox(240,64,0,
            {
               "type":"roundrect",
               "corners":6
            },false,
            {
               "size":1,
               "color":7105644
            });
         this._closeButton = PokerClassProvider.getObject("LobbyFeedCloseButton");
         this._closeButton.x = this._background.width - (this._closeButton.width + 2);
         this._closeButton.y = 2;
         this._closeButton.buttonMode = true;
         this._closeButton.addEventListener(MouseEvent.MOUSE_OVER,this.onCloseButtonOver,false,0,true);
         this._closeButton.addEventListener(MouseEvent.MOUSE_OUT,this.onCloseButtonOut,false,0,true);
         this._closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
         this._background.addChild(this._closeButton);
         addChild(this._background);
      }
      
      public function showSearchingDialog() : void {
         if(!this._background)
         {
            return;
         }
         if((this._backToLobbyContainer) && (contains(this._backToLobbyContainer)))
         {
            removeChild(this._backToLobbyContainer);
         }
         if(!this._searchUIContainer)
         {
            this._searchUIContainer = new Sprite();
            if(!this._searchIndicator)
            {
               this._searchIndicator = PokerClassProvider.getObject("LoadAnim_Circle1");
               this._searchIndicator.scaleX = this._searchIndicator.scaleY = 0.75;
               this._searchIndicator.x = this._searchIndicator.width / 2;
               this._searchIndicator.y = this._searchIndicator.height / 2;
            }
            if(!this._searchUIContainer.contains(this._searchIndicator))
            {
               this._searchUIContainer.addChild(this._searchIndicator);
            }
            if(!this._searchLabel)
            {
               this._searchLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.message.jumpTablesSearching"),"Main",11,16777215,TextFormatAlign.LEFT);
               this._searchLabel.autoSize = TextFieldAutoSize.LEFT;
               this._searchLabel.x = this._searchIndicator.width + 4;
               this._searchLabel.y = (this._searchUIContainer.height - this._searchLabel.height) / 2;
            }
            if(!this._searchUIContainer.contains(this._searchLabel))
            {
               this._searchUIContainer.addChild(this._searchLabel);
            }
            this._searchUIContainer.x = (this._background.width - this._searchUIContainer.width) / 2;
            this._searchUIContainer.y = (this._background.height - this._searchUIContainer.height) / 2;
         }
         if(!contains(this._searchUIContainer))
         {
            addChild(this._searchUIContainer);
         }
      }
      
      public function showBackToLobbyDialog() : void {
         if(!this._background)
         {
            return;
         }
         if((this._searchUIContainer) && (contains(this._searchUIContainer)))
         {
            removeChild(this._searchUIContainer);
         }
         if(!this._backToLobbyContainer)
         {
            this._backToLobbyContainer = new Sprite();
            if(!this._backToLobbyLabel)
            {
               this._backToLobbyLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.message.jumpTablesError"),"Main",11,16777215,TextFormatAlign.LEFT);
               this._backToLobbyLabel.multiline = true;
               this._backToLobbyLabel.wordWrap = true;
               this._backToLobbyLabel.autoSize = TextFieldAutoSize.LEFT;
               this._backToLobbyLabel.width = this._background.width - this._background.width * 0.2;
               this._backToLobbyLabel.height = this._backToLobbyLabel.textHeight;
            }
            if(!this._backToLobbyContainer.contains(this._backToLobbyLabel))
            {
               this._backToLobbyContainer.addChild(this._backToLobbyLabel);
            }
            if(!this._backToLobbyButton)
            {
               this._backToLobbyButton = new PokerButton(null,"large",LocaleManager.localize("flash.table.jumpTablesButtonBackToLobbyLabel"));
               this._backToLobbyButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
               this._backToLobbyButton.x = (this._backToLobbyLabel.width - this._backToLobbyButton.width) / 2;
               this._backToLobbyButton.y = this._backToLobbyLabel.height;
            }
            if(!this._backToLobbyContainer.contains(this._backToLobbyButton))
            {
               this._backToLobbyContainer.addChild(this._backToLobbyButton);
            }
            this._backToLobbyContainer.x = (this._background.width - this._backToLobbyContainer.width) / 2;
            this._backToLobbyContainer.y = (this._background.height - this._backToLobbyContainer.height) / 2;
         }
         if(!contains(this._backToLobbyContainer))
         {
            addChild(this._backToLobbyContainer);
         }
      }
      
      private function onCloseButtonOver(param1:MouseEvent) : void {
         this._closeButton.gotoAndStop(2);
      }
      
      private function onCloseButtonOut(param1:MouseEvent) : void {
         this._closeButton.gotoAndStop(1);
      }
      
      private function onCloseButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_CANCEL_JUMP_TABLE_SEARCH,{"willJumpToLobby":(param1.currentTarget == this._backToLobbyButton?true:false)}));
      }
      
      public function destroy() : void {
      }
   }
}
