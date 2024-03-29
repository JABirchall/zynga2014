package com.zynga.poker.nav.assets
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   
   public class ScratchersPostLuckyBonusAd extends MovieClip
   {
      
      public function ScratchersPostLuckyBonusAd() {
         super();
         this.setup();
      }
      
      private var _base:MovieClip;
      
      private var _closeButton:MovieClip;
      
      private var _labelField:EmbeddedFontTextField;
      
      private function setup() : void {
         var _loc1_:* = NaN;
         this._base = PokerClassProvider.getObject("ScratchersPostLuckyBonusAd");
         this._closeButton = PokerClassProvider.getObject("FTUEArrowCloseButton");
         this._labelField = new EmbeddedFontTextField(LocaleManager.localize("flash.nav.scratchersPostLuckyBonusAdCopy",{"amount":PokerCurrencyFormatter.numberToCurrency(175000000,false,1,true)}) + " ","Main",11,2449333,TextFormatAlign.CENTER);
         _loc1_ = 25;
         this._labelField.autoSize = TextFieldAutoSize.CENTER;
         this._labelField.x = _loc1_;
         this._labelField.y = (this._base.height - this._labelField.height) / 2;
         this._base.width = this._labelField.width + _loc1_ * 2;
         this._closeButton.x = this._base.width - (this._closeButton.width + 4);
         this._closeButton.y = 4;
         this._closeButton.buttonMode = true;
         addChild(this._base);
         addChild(this._labelField);
         addChild(this._closeButton);
      }
      
      public function get base() : MovieClip {
         return this._base;
      }
      
      public function get closeButton() : MovieClip {
         return this._closeButton;
      }
   }
}
