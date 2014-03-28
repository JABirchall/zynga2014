package com.zynga.poker.table.chicklet.rollover.assets
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.BlendMode;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   
   public class PlayerRollover extends MovieClip
   {
      
      public function PlayerRollover() {
         super();
         this.assets = PokerClassProvider.getObject("PlayerRolloverAssets");
         addChild(this.assets);
         this.bg = this.assets.bg;
         this.playerImg = this.assets.playerImg;
         blendMode = BlendMode.LAYER;
         this.nameTF = new EmbeddedFontTextField("","Main",16,16777215);
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         this.nameTF.blendMode = BlendMode.LAYER;
         this.nameTF.x = 7;
         this.nameTF.y = 5;
         addChild(this.nameTF);
         this.levelTF = new EmbeddedFontTextField("","Main",12,0,"right");
         this.levelTF.width = 80;
         this.levelTF.height = 20;
         this.levelTF.x = 115;
         this.levelTF.y = 31;
         addChild(this.levelTF);
         this.titleTF = new EmbeddedFontTextField("","Main",12);
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.x = 200;
         this.titleTF.y = 31;
         addChild(this.titleTF);
         this.chipsLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chicklet.rollover.chipsLabel"),"MainLight",12,0,"right");
         this.chipsLabel.autoSize = TextFieldAutoSize.LEFT;
         this.chipsLabel.fitInWidth(80);
         this.chipsLabel.height = 20;
         this.chipsLabel.x = 115;
         this.chipsLabel.y = 55;
         addChild(this.chipsLabel);
         this.chipsTF = new EmbeddedFontTextField("","Main",12);
         this.chipsTF.autoSize = TextFieldAutoSize.LEFT;
         this.chipsTF.x = 200;
         this.chipsTF.y = 55;
         addChild(this.chipsTF);
         this.rankLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chicklet.rollover.rankLabel"),"MainLight",12,0,"right");
         this.rankLabel.autoSize = TextFieldAutoSize.LEFT;
         this.rankLabel.fitInWidth(120);
         this.rankLabel.height = 20;
         this.rankLabel.x = 115;
         this.rankLabel.y = 78;
         addChild(this.rankLabel);
         this.rankTF = new EmbeddedFontTextField("","Main",12);
         this.rankTF.autoSize = TextFieldAutoSize.LEFT;
         this.rankTF.x = 240;
         this.rankTF.y = 78;
         addChild(this.rankTF);
         this.networkLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chicklet.rollover.networkLabel"),"MainLight",12,0,"right");
         this.networkLabel.width = 80;
         this.networkLabel.height = 20;
         this.networkLabel.x = 115;
         this.networkLabel.y = 101;
         addChild(this.networkLabel);
         this.networkTF = new EmbeddedFontTextField("","Main",12);
         this.networkTF.autoSize = TextFieldAutoSize.LEFT;
         this.networkTF.x = 200;
         this.networkTF.y = 101;
         addChild(this.networkTF);
         this.tourneyLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chicklet.rollover.tourneyLabel"),"MainLight",12,0,"right");
         this.tourneyLabel.width = 80;
         this.tourneyLabel.height = 20;
         this.tourneyLabel.x = 115;
         this.tourneyLabel.y = 126;
         addChild(this.tourneyLabel);
         this.tourneyTF = new EmbeddedFontTextField("","Main",12);
         this.tourneyTF.multiline = true;
         this.tourneyTF.wordWrap = true;
         this.tourneyTF.width = 146;
         this.tourneyTF.height = 50;
         this.tourneyTF.x = 200;
         this.tourneyTF.y = 126;
         addChild(this.tourneyTF);
      }
      
      public var bg:MovieClip;
      
      public var playerImg:MovieClip;
      
      public var nameTF:EmbeddedFontTextField;
      
      public var levelTF:EmbeddedFontTextField;
      
      public var titleTF:EmbeddedFontTextField;
      
      public var chipsLabel:EmbeddedFontTextField;
      
      public var chipsTF:EmbeddedFontTextField;
      
      public var rankLabel:EmbeddedFontTextField;
      
      public var rankTF:EmbeddedFontTextField;
      
      public var networkLabel:EmbeddedFontTextField;
      
      public var networkTF:EmbeddedFontTextField;
      
      public var tourneyLabel:EmbeddedFontTextField;
      
      public var tourneyTF:EmbeddedFontTextField;
      
      private var assets:MovieClip;
   }
}
