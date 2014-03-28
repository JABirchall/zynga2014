package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextField;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.poker.PokerGlobalData;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.PokerClassProvider;
   import flash.text.TextFormat;
   
   public class LobbyGameSelector extends MovieClip
   {
      
      public function LobbyGameSelector(param1:Boolean=false) {
         var _loc3_:String = null;
         var _loc5_:EmbeddedFontTextField = null;
         var _loc21_:* = NaN;
         var _loc22_:* = NaN;
         var _loc23_:* = NaN;
         var _loc24_:* = NaN;
         super();
         var _loc2_:String = param1?"LobbyGameSelectorAssets":"LobbyGameSelectorAssets_smallTourney";
         _loc3_ = TextFieldAutoSize.LEFT;
         this.assets = PokerClassProvider.getObject(_loc2_);
         addChild(this.assets);
         this.assets.removeChild(this.assets.lobbyBackground);
         this.assets.x = 57;
         this.assets.y = 106;
         var _loc4_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.tabs.pointsTab"),"CalibriBold",12,0,"center");
         _loc4_.autoSize = _loc3_;
         _loc4_.x = Math.round((this.assets.mcPointsTabOn.width - _loc4_.width) / 2);
         _loc4_.y = Math.round((this.assets.mcPointsTabOn.height - _loc4_.height) / 2);
         this.assets.mcPointsTabOn.addChild(_loc4_);
         _loc5_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.tabs.pointsTab"),"CalibriBold",12,16777215,"center");
         _loc5_.autoSize = _loc3_;
         _loc5_.x = Math.round((this.assets.mcPointsTabOff.width - _loc5_.width) / 2);
         _loc5_.y = Math.round((this.assets.mcPointsTabOff.height - _loc5_.height) / 2);
         this.assets.mcPointsTabOff.addChild(_loc5_);
         var _loc6_:* = "";
         if(PokerGlobalData.instance.configModel.getFeatureConfig("tournamentImprovements") !== null)
         {
            _loc6_ = LocaleManager.localize("flash.lobby.gameSelector.subTabs.shootoutSubTab");
         }
         else
         {
            _loc6_ = LocaleManager.localize("flash.lobby.gameSelector.tabs.tourneyTab");
         }
         var _loc7_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize(_loc6_),"CalibriBold",12,0,"center");
         _loc7_.autoSize = _loc3_;
         _loc7_.x = Math.round((this.assets.mcTournTabOn.width - _loc7_.width) / 2);
         _loc7_.y = Math.round((this.assets.mcTournTabOn.height - _loc7_.height) / 2);
         this.assets.mcTournTabOn.addChild(_loc7_);
         var _loc8_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize(_loc6_),"CalibriBold",12,16777215,"center");
         _loc8_.autoSize = _loc3_;
         _loc8_.x = Math.round((this.assets.mcTournTabOn.width - _loc8_.width) / 2);
         _loc8_.y = Math.round((this.assets.mcTournTabOn.height - _loc8_.height) / 2);
         this.assets.mcTournTabOff.addChild(_loc8_);
         var _loc9_:* = "";
         if(PokerGlobalData.instance.configModel.getFeatureConfig("tournamentImprovements") !== null)
         {
            _loc9_ = LocaleManager.localize("flash.lobby.gameSelector.subTabs.sitngoSubTab");
         }
         else
         {
            if(PokerGlobalData.instance.enableZPWC)
            {
               _loc9_ = LocaleManager.localize("flash.lobby.gameSelector.tabs.zpwcTab");
            }
            else
            {
               _loc9_ = LocaleManager.localize("flash.lobby.gameSelector.tabs.privateTab");
            }
         }
         var _loc10_:EmbeddedFontTextField = new EmbeddedFontTextField(_loc9_,"CalibriBold",12,0,"center");
         _loc10_.autoSize = _loc3_;
         _loc10_.x = Math.round((this.assets.mcPrivateTabOn.width - _loc10_.width) / 2);
         _loc10_.y = Math.round((this.assets.mcPrivateTabOn.height - _loc10_.height) / 2);
         this.assets.mcPrivateTabOn.addChild(_loc10_);
         var _loc11_:EmbeddedFontTextField = new EmbeddedFontTextField(_loc9_,"CalibriBold",12,16777215,"center");
         _loc11_.autoSize = _loc3_;
         _loc11_.x = Math.round((this.assets.mcPrivateTabOff.width - _loc11_.width) / 2);
         _loc11_.y = Math.round((this.assets.mcPrivateTabOff.height - _loc11_.height) / 2);
         this.assets.mcPrivateTabOff.addChild(_loc11_);
         this.assets.mcPremiumTabOn.x = 327;
         this.assets.mcPremiumTabOn.y = this.assets.mcPointsTabOn.y;
         this.assets.mcPremiumTabOff.x = 327;
         this.assets.mcPremiumTabOff.y = this.assets.mcPointsTabOff.y;
         var _loc12_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.tabs.premiumTab"),"CalibriBold",12,0,"center");
         _loc12_.autoSize = _loc3_;
         _loc12_.x = Math.round((this.assets.mcPremiumTabOn.width - _loc12_.width) / 2);
         _loc12_.y = Math.round((this.assets.mcPremiumTabOn.height - _loc12_.height) / 2);
         this.assets.mcPremiumTabOn.addChild(_loc12_);
         var _loc13_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.tabs.premiumTab"),"CalibriBold",12,16777215,"center");
         _loc13_.autoSize = _loc3_;
         _loc13_.x = Math.round((this.assets.mcPremiumTabOn.width - _loc13_.width) / 2);
         _loc13_.y = Math.round((this.assets.mcPremiumTabOn.height - _loc13_.height) / 2);
         this.assets.mcPremiumTabOff.addChild(_loc13_);
         var _loc14_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.powerSubTab"),"CalibriBold",12,0,"center");
         _loc14_.name = "label";
         _loc14_.autoSize = _loc3_;
         _loc14_.x = Math.round((this.assets.powerSubTab.width - _loc14_.width) / 2);
         _loc14_.y = Math.round((this.assets.powerSubTab.height - _loc14_.height) / 2);
         this.assets.powerSubTab.addChild(_loc14_);
         var _loc15_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.shootoutSubTab"),"CalibriBold",12,0,"center");
         _loc15_.name = "label";
         _loc15_.autoSize = _loc3_;
         _loc15_.x = Math.round((this.assets.shootoutSubTab.width - _loc15_.width) / 2);
         _loc15_.y = Math.round((this.assets.shootoutSubTab.height - _loc15_.height) / 2);
         this.assets.shootoutSubTab.addChild(_loc15_);
         var _loc16_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.sitngoSubTab"),"CalibriBold",12,0,"center");
         _loc16_.name = "label";
         _loc16_.autoSize = _loc3_;
         _loc16_.x = Math.round((this.assets.sitngoSubTab.width - _loc16_.width) / 2);
         _loc16_.y = Math.round((this.assets.sitngoSubTab.height - _loc16_.height) / 2);
         this.assets.sitngoSubTab.addChild(_loc16_);
         var _loc17_:EmbeddedFontTextField = null;
         if(PokerGlobalData.instance.enableMTT)
         {
            _loc17_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.subTabs.mttSubTab"),"CalibriBold",12,0,"center");
         }
         else
         {
            _loc17_ = new EmbeddedFontTextField(LocaleManager.localize(param1?"flash.lobby.gameSelector.subTabs.weeklySubTab":"flash.lobby.gameSelector.subTabs.weeklySubTabSmall"),"CalibriBold",12,0,"center");
         }
         _loc17_.name = "label";
         _loc17_.autoSize = _loc3_;
         _loc17_.x = Math.round((this.assets.weeklySubTab.width - _loc17_.width) / 2);
         _loc17_.y = Math.round((this.assets.weeklySubTab.height - _loc17_.height) / 2);
         this.assets.weeklySubTab.addChild(_loc17_);
         if(PokerGlobalData.instance.enableMTT)
         {
            _loc21_ = this.assets.powerSubTab.x;
            _loc22_ = this.assets.shootoutSubTab.x;
            _loc23_ = this.assets.sitngoSubTab.x;
            _loc24_ = this.assets.weeklySubTab.x;
            this.assets.weeklySubTab.x = _loc21_;
            this.assets.powerSubTab.x = _loc22_;
            this.assets.shootoutSubTab.x = _loc23_;
            this.assets.sitngoSubTab.x = _loc24_;
         }
         this._playersOnline = new EmbeddedFontTextField("","_sans",11,0,"left");
         this._playersOnline.defaultTextFormat = new TextFormat("_sans",11);
         this._playersOnline.name = "playersOnlineNew";
         this._playersOnline.width = 200;
         this._playersOnline.x = 5;
         this.adjustPlayersOnlineLocation();
         this._playersOnline.selectable = false;
         this._playersOnline.visible = false;
         this.assets.addChild(this._playersOnline);
         var _loc18_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.createTableButton"),"CalibriBold",12,0,"center");
         _loc18_.autoSize = _loc3_;
         _loc18_.fitInWidth(this.assets.createRoom_btn.width);
         _loc18_.x = Math.round((this.assets.createRoom_btn.width - _loc18_.width) / 2) - 50;
         _loc18_.y = Math.round((this.assets.createRoom_btn.height - _loc18_.height) / 2) - 11;
         this.assets.createRoom_btn.addChild(_loc18_);
         var _loc19_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.refreshListButton"),"CalibriBold",12,0,"center");
         _loc19_.autoSize = _loc3_;
         _loc19_.fitInWidth(this.assets.refresh_btn.width);
         _loc19_.x = Math.round((this.assets.refresh_btn.width - _loc19_.width) / 2) - 50;
         _loc19_.y = Math.round((this.assets.refresh_btn.height - _loc19_.height) / 2) - 11;
         this.assets.refresh_btn.addChild(_loc19_);
         this.joinTableButtonLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.joinTableButton"),"CalibriBold",12,0,"center");
         this.joinTableButtonLabel.autoSize = _loc3_;
         this.joinTableButtonLabel.fitInWidth(this.assets.joinRoom_btn.width);
         this.joinTableButtonLabel.x = Math.round((this.assets.joinRoom_btn.width - this.joinTableButtonLabel.width) / 2) - 50;
         this.joinTableButtonLabel.y = Math.round((this.assets.joinRoom_btn.height - this.joinTableButtonLabel.height) / 2) - 11;
         this.assets.joinRoom_btn.addChild(this.joinTableButtonLabel);
         var _loc20_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.howToPlayButton"),"Main",16,0,"center");
         _loc20_.autoSize = _loc3_;
         _loc20_.fitInWidth(this.assets.howToPlayButton.width - 5);
         _loc20_.x = Math.round((this.assets.howToPlayButton.width - _loc20_.width) / 2);
         _loc20_.y = Math.round((this.assets.howToPlayButton.height - _loc20_.height) / 2);
         this.assets.howToPlayButton.addChild(_loc20_);
         this.assets.howToPlayButton.buttonMode = true;
      }
      
      private static const PLAYERS_ONLINE_Y_BUTTONS:Number = 260;
      
      private static const PLAYERS_ONLINE_Y_NO_BUTTONS:Number = 239;
      
      public var assets:MovieClip;
      
      public var joinTableButtonLabel:EmbeddedFontTextField;
      
      private var _playersOnline:TextField;
      
      public function addNewTableSelectorAssetsToPage() : void {
         this._playersOnline.visible = true;
      }
      
      public function setOnlinePlayers(param1:Number) : void {
         this._playersOnline.text = LocaleManager.localize("flash.lobby.playersOnline",
            {
               "players":PokerCurrencyFormatter.numberToCurrency(param1,false,0,false),
               "player":
                  {
                     "type":"tk",
                     "key":"player",
                     "attributes":"",
                     "count":int(param1)
                  }
            });
      }
      
      public function adjustPlayersOnlineLocation() : void {
         this._playersOnline.y = PokerGlobalData.instance.enableRoomTypeOnly?PLAYERS_ONLINE_Y_NO_BUTTONS:PLAYERS_ONLINE_Y_BUTTONS;
      }
      
      public function adjustPlayersOnlineForTournamentImprovements() : void {
         this._playersOnline.y = 243;
      }
   }
}
