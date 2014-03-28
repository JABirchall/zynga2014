package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   
   public class LobbyPlayerInfo extends MovieClip
   {
      
      public function LobbyPlayerInfo(param1:Boolean=false) {
         var _loc4_:* = NaN;
         var _loc5_:String = null;
         super();
         var _loc2_:* = "LobbyPlayerInfoAssets";
         var _loc3_:Number = 0;
         _loc4_ = 0;
         this.assets = PokerClassProvider.getObject(_loc2_);
         _loc5_ = TextFieldAutoSize.LEFT;
         addChild(this.assets);
         this.assets.x = 415.9 + _loc3_;
         this.assets.y = 19;
         this.welcome = new EmbeddedFontTextField("","Calibri",14,16777215);
         this.welcome.autoSize = _loc5_;
         this.welcome.x = 42;
         this.welcome.x = this.welcome.x + _loc4_;
         this.welcome.y = 6;
         this.assets.addChild(this.welcome);
         this.chipsLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.playerInfo.chipsLabel"),"Calibri",10,10066329);
         this.chipsLabel.autoSize = _loc5_;
         this.chipsLabel.x = 42;
         this.chipsLabel.x = this.chipsLabel.x + _loc4_;
         this.chipsLabel.y = 27;
         this.assets.addChild(this.chipsLabel);
         this.points = new EmbeddedFontTextField("","CalibriBold",14,16777215);
         this.points.autoSize = _loc5_;
         this.points.x = 42;
         this.points.x = this.points.x + _loc4_;
         this.points.y = 40;
         this.assets.addChild(this.points);
         this._casinoLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.playerInfo.casinoLabel"),"Calibri",9,10066329);
         this._casinoLabel.autoSize = _loc5_;
         this._casinoLabel.x = 224;
         this._casinoLabel.y = 6;
         this.assets.addChild(this._casinoLabel);
         this._server = new EmbeddedFontTextField("","CalibriBold",11,16777215);
         this._server.autoSize = _loc5_;
         this._server.x = 224;
         this._server.y = 19;
         this.assets.addChild(this._server);
         var _loc6_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.playerInfo.changeCasinoButton"),"Calibri",11,10066329,"center");
         _loc6_.autoSize = TextFieldAutoSize.CENTER;
         _loc6_.fitInWidth(70);
         _loc6_.width = 80;
         _loc6_.x = Math.round((this.assets.changeCasinoButton.width - _loc6_.width) / 2);
         _loc6_.y = Math.round((this.assets.changeCasinoButton.height - _loc6_.height) / 2);
         this.assets.changeCasinoButton.addChild(_loc6_);
         if(param1)
         {
            this.assets.changeCasinoButton.visible = false;
         }
         else
         {
            this.assets.changeCasinoButton.buttonMode = true;
            this.assets.changeCasinoButton.mouseEnabled = true;
         }
         this.assets.changeCasinoButton.mouseChildren = false;
      }
      
      public var assets:MovieClip;
      
      public var welcome:EmbeddedFontTextField;
      
      public var chipsLabel:EmbeddedFontTextField;
      
      public var points:EmbeddedFontTextField;
      
      private var _casinoLabel:EmbeddedFontTextField;
      
      private var _server:EmbeddedFontTextField;
      
      public function set serverText(param1:String) : void {
         this._server.text = param1;
      }
   }
}
