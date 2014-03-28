package com.zynga.poker.table.betting.hsm
{
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.locale.LocaleManager;
   
   public class HSMModel extends FeatureModel
   {
      
      public function HSMModel() {
         super();
      }
      
      public var turnedOn:Boolean = false;
      
      public var currentTooltip:String = "";
      
      private var _currentLevel:int = -1;
      
      public function get currentLevel() : int {
         return this._currentLevel;
      }
      
      public function set currentLevel(param1:int) : void {
         this._currentLevel = param1;
      }
      
      public function get hsmEnabled() : Boolean {
         return configModel.isFeatureEnabled("hsm");
      }
      
      private var _rakePercentage:Number;
      
      public function get rakePercentage() : Number {
         return this._rakePercentage;
      }
      
      public function set rakePercentage(param1:Number) : void {
         this._rakePercentage = param1;
      }
      
      private var _rakeBlindMultiplier:Number;
      
      public function get rakeBlindMultiplier() : Number {
         return this._rakeBlindMultiplier;
      }
      
      private var _hsmRakeShoutName:String = "hsmRakeShout";
      
      public function get isHSMFreeUsageOn() : Boolean {
         return (this.freeUsageObj) && this.freeUsageObj.on == 1?true:false;
      }
      
      public var lastHandText:String = "";
      
      private var _handListText:Array;
      
      public var tableBigBlind:int = 1;
      
      public var freeUsageObj:Object;
      
      public function get handListText() : Array {
         return this._handListText;
      }
      
      override public function init() : void {
         this._rakeBlindMultiplier = pgData.rakeBlindMultiplier;
         this._rakePercentage = pgData.rakePercentage;
         this._handListText = [LocaleManager.localize("flash.table.hand.highCard"),LocaleManager.localize("flash.table.hand.onePair"),LocaleManager.localize("flash.table.hand.twoPair"),LocaleManager.localize("flash.table.hand.threeOfAKind"),LocaleManager.localize("flash.table.hand.straight"),LocaleManager.localize("flash.table.hand.flush"),LocaleManager.localize("flash.table.hand.fullHouse"),LocaleManager.localize("flash.table.hand.fourOfAKind"),LocaleManager.localize("flash.table.hand.straightFlush"),LocaleManager.localize("flash.table.hand.royalFlush")];
      }
   }
}
