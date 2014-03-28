package com.zynga.poker.nav.topnav
{
   import com.zynga.poker.feature.FeatureModel;
   
   public class XPBoostWithPurchaseModel extends FeatureModel
   {
      
      public function XPBoostWithPurchaseModel() {
         super();
         this._multiplier = 0;
         this._timeRemaining = 0;
         this._endTimestamp = 0;
         this._openBuyPageOnXPBarClick = false;
         this._isHappyHour = false;
      }
      
      public static const MILESTONE_ARRAY:Array = new Array(21600,7200,3600,1800,600);
      
      public static function getHoursMinutes(param1:int) : Array {
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:int = int(param1 / 3600);
         var _loc4_:int = int((param1 - _loc3_ * 3600) / 60);
         var _loc5_:Array = new Array();
         if(_loc3_ < 10)
         {
            _loc5_[0] = "0";
            _loc5_[1] = _loc3_;
         }
         else
         {
            _loc6_ = String(_loc3_);
            _loc5_[0] = _loc6_.charAt(0);
            _loc5_[1] = _loc6_.charAt(1);
         }
         if(_loc4_ < 10)
         {
            _loc5_[2] = "0";
            _loc5_[3] = _loc4_;
         }
         else
         {
            _loc7_ = String(_loc4_);
            _loc5_[2] = _loc7_.charAt(0);
            _loc5_[3] = _loc7_.charAt(1);
         }
         return _loc5_;
      }
      
      private var _multiplier:int;
      
      private var _timeRemaining:int;
      
      private var _endTimestamp:int;
      
      private var _openBuyPageOnXPBarClick:Boolean;
      
      private var _isHappyHour:Boolean;
      
      override public function init() : void {
         this._multiplier = configModel.getNumberForFeatureConfig("xPBoostWithPurchase","XPMultiplier") * 100;
         this._timeRemaining = configModel.getIntForFeatureConfig("xPBoostWithPurchase","timeRemaining");
         this._endTimestamp = this._timeRemaining + new Date().time / 1000;
         this._openBuyPageOnXPBarClick = configModel.getBooleanForFeatureConfig("xPBoostWithPurchase","openBuyPageOnXPBarClick");
         this._isHappyHour = configModel.getBooleanForFeatureConfig("happyHour","shouldShowXpBoost");
      }
      
      public function updateModel(param1:Object) : void {
         var _loc3_:Object = null;
         this._multiplier = (param1.hasOwnProperty("XPMultiplier")?param1["XPMultiplier"]:0) * 100;
         this._timeRemaining = param1.hasOwnProperty("timeRemaining")?param1["timeRemaining"]:0;
         this._endTimestamp = this._timeRemaining + new Date().time / 1000;
         this._isHappyHour = param1.hasOwnProperty("isHappyHour")?param1["isHappyHour"]:false;
         var _loc2_:Object = configModel.getFeatureConfig("xPBoostWithPurchase");
         if(!(_loc2_ === null) && this._isHappyHour === false)
         {
            _loc2_.XPMultiplier = this._multiplier / 100;
         }
         if(this._isHappyHour === true)
         {
            _loc3_ = configModel.getFeatureConfig("happyHour");
            if(!(_loc3_ === null) && _loc3_.isSendingXPToasterCommand === true)
            {
               _loc3_.isSendingXPToasterCommand = false;
            }
         }
      }
      
      public function set openBuyPageOnXPBarClick(param1:Boolean) : void {
         this._openBuyPageOnXPBarClick = param1;
      }
      
      public function get openBuyPageOnXPBarClick() : Boolean {
         return this._openBuyPageOnXPBarClick;
      }
      
      public function set XPMultiplier(param1:int) : void {
         this._multiplier = param1;
      }
      
      public function get XPMultiplier() : int {
         return this._multiplier;
      }
      
      public function set timeRemaining(param1:int) : void {
         this._timeRemaining = param1;
      }
      
      public function get timeRemaining() : int {
         return this._timeRemaining;
      }
      
      public function get endTimestamp() : int {
         return this._endTimestamp;
      }
      
      public function get isHappyHour() : Boolean {
         return this._isHappyHour;
      }
      
      public function get formattedTimeRemaining() : Array {
         if(this._timeRemaining > 0)
         {
            return getHoursMinutes(this._timeRemaining);
         }
         return new Array("0","0","0","0");
      }
   }
}
