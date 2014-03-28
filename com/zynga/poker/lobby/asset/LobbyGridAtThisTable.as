package com.zynga.poker.lobby.asset
{
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.filters.DropShadowFilter;
   
   public class LobbyGridAtThisTable extends Sprite
   {
      
      public function LobbyGridAtThisTable(param1:String, param2:String, param3:Array) {
         super();
         this.tableName = param1;
         this.tableStakes = param2;
         this.players = param3;
         mouseEnabled = false;
         this.filters = [new DropShadowFilter()];
      }
      
      private var tableNameTextField:EmbeddedFontTextField = null;
      
      private var tableStakesTextField:EmbeddedFontTextField = null;
      
      private var playerItems:Array;
      
      private var _tableName:String = "";
      
      private var _tableStakes:String = "";
      
      private var _players:Array;
      
      public function get tableName() : String {
         return this._tableName;
      }
      
      public function set tableName(param1:String) : void {
         if(this._tableName != param1)
         {
            this._tableName = param1;
            if(this.tableNameTextField == null)
            {
               this.tableNameTextField = new EmbeddedFontTextField(this._tableName,"Main",16,16777215);
               this.tableNameTextField.autoSize = TextFieldAutoSize.LEFT;
               this.tableNameTextField.x = 10;
               this.tableNameTextField.y = 8;
               addChild(this.tableNameTextField);
            }
            else
            {
               this.tableNameTextField.text = this._tableName;
            }
         }
      }
      
      public function get tableStakes() : String {
         return this._tableStakes;
      }
      
      public function set tableStakes(param1:String) : void {
         if(this._tableStakes != param1)
         {
            this._tableStakes = param1;
            if(this.tableStakesTextField == null)
            {
               this.tableStakesTextField = new EmbeddedFontTextField(this._tableStakes,"Main",13,3368601);
               this.tableStakesTextField.autoSize = TextFieldAutoSize.LEFT;
               this.tableStakesTextField.x = 10;
               this.tableStakesTextField.y = 28;
               addChild(this.tableStakesTextField);
            }
            else
            {
               this.tableStakesTextField.text = this._tableStakes;
            }
         }
      }
      
      public function get players() : Array {
         return this._players;
      }
      
      public function set players(param1:Array) : void {
         this._players = param1;
         this.refresh();
      }
      
      private function refresh() : void {
         var _loc1_:LobbyGridAtThisTableItem = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(this.playerItems)
         {
            for each (_loc1_ in this.playerItems)
            {
               removeChild(_loc1_);
            }
         }
         this.playerItems = new Array();
         if(this._players)
         {
            _loc6_ = 0;
            for each (_loc7_ in this._players)
            {
               _loc8_ = _loc7_["fullName"].length > 16?_loc7_["fullName"].slice(0,16) + "...":_loc7_["fullName"];
               _loc9_ = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(_loc7_["chips"],false,0,false)});
               _loc1_ = new LobbyGridAtThisTableItem(_loc7_["pic_url"],_loc8_,_loc9_);
               _loc1_.x = 10 + _loc6_ % 3 * 80;
               _loc1_.y = 50 + Math.floor(_loc6_ / 3) * 100;
               addChild(_loc1_);
               this.playerItems.push(_loc1_);
               _loc6_++;
            }
         }
         var _loc2_:Number = 260;
         var _loc3_:Number = 54 + Math.ceil(_loc6_ / 3) * 100;
         var _loc4_:Number = 30;
         var _loc5_:Number = 30;
         graphics.clear();
         graphics.lineStyle(1,10066329,1,true);
         graphics.beginFill(0);
         graphics.moveTo(0,0);
         graphics.lineTo(0,(_loc3_ - _loc5_) / 2);
         graphics.lineTo(-_loc4_,(_loc3_ - _loc5_) / 2 + _loc5_ / 2);
         graphics.lineTo(0,(_loc3_ - _loc5_) / 2 + _loc5_);
         graphics.lineTo(0,_loc3_);
         graphics.lineTo(_loc2_,_loc3_);
         graphics.lineTo(_loc2_,0);
         graphics.moveTo(0,0);
         graphics.endFill();
         graphics.moveTo(10,50);
         graphics.lineTo(250,50);
      }
   }
}
