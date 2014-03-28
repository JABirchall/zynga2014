package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   
   public class LobbyCasinoSelector extends MovieClip
   {
      
      public function LobbyCasinoSelector() {
         super();
         this.assets = PokerClassProvider.getObject("LobbyCasinoSelectorAssets");
         addChild(this.assets);
         this.assets.x = 280.7;
         this.assets.y = 218.05;
         this.heading = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.casinoSelector.heading"),"Main",26,16777215,"center");
         this.heading.autoSize = TextFieldAutoSize.CENTER;
         this.heading.fitInWidth(200);
         this.heading.x = (this.width - this.heading.width) / 2;
         this.heading.y = -50;
         this.assets.addChild(this.heading);
         this.playersOnline = new EmbeddedFontTextField("","Main",12,16777215,"center");
         this.playersOnline.width = 200;
         this.playersOnline.height = 18;
         this.playersOnline.y = -18;
         this.assets.addChild(this.playersOnline);
         this.tip = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.casinoSelector.tip"),"Main",14,16777215,"center");
         this.tip.width = 400;
         this.tip.height = 40;
         this.tip.x = -100;
         this.tip.y = 130;
         this.assets.addChild(this.tip);
      }
      
      public var assets:MovieClip;
      
      public var heading:EmbeddedFontTextField;
      
      public var playersOnline:EmbeddedFontTextField;
      
      public var tip:EmbeddedFontTextField;
   }
}
