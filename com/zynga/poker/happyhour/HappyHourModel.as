package com.zynga.poker.happyhour
{
   import com.zynga.poker.feature.FeatureModel;
   
   public class HappyHourModel extends FeatureModel
   {
      
      public function HappyHourModel() {
         super();
      }
      
      public static const TYPE_LUCKY_BONUS:String = "hh_lucky_bonus";
      
      public static const TYPE_DOUBLE_XP:String = "hh_double_xp";
      
      public static const NOT_HAPPY_HOUR_STATE:String = "not_hh";
      
      public static const PRE_HAPPY_HOUR_STATE:String = "pre_hh";
      
      public static const IN_HAPPY_HOUR_STATE:String = "in_hh";
      
      public static const XP_BOOST_CAP:int = 4;
      
      private var _type:String;
      
      private var _marketingStartTime:int;
      
      private var _happyHourStartTime:int;
      
      private var _happyHourEndTime:int;
      
      private var _happyHourLuckyBonusAlreadySpun:Boolean;
      
      private var _hasAlreadySeenFlyout:Boolean;
      
      private var _numFlyoutsSeen:int;
      
      private var _maxFlyoutsCount:int;
      
      private var _utcOffset:int;
      
      private var _xpBoostMultiplier:int;
      
      private var _isFirstTimeLoad:Boolean = true;
      
      private const TYPE_KEY:String = "happyHourType";
      
      private const MARKETING_START_TIME_KEY:String = "marketingStartTime";
      
      private const HAPPY_HOUR_START_TIME_KEY:String = "hhStart";
      
      private const HAPPY_HOUR_END_TIME_KEY:String = "hhEnd";
      
      private const HAPPY_HOUR_LUCKY_BONUS_ALREADY_SPUN_KEY:String = "happyHourLuckyBonusAlreadySpun";
      
      private const HAS_ALREADY_SEEN_FLYOUT_KEY:String = "hasAlreadySeenFlyout";
      
      private const NUM_FLYOUTS_SEEN_KEY:String = "numFlyoutsSeen";
      
      private const MAX_FLYOUTS_COUNT_KEY:String = "maxFlyoutsCount";
      
      private const UTC_OFFSET_KEY:String = "utcOffset";
      
      private const XP_BOOST_CAP_KEY:String = "xpBoostCap";
      
      private const XP_BOOST_MULTIPLIER_KEY:String = "xpBoostMultiplier";
      
      override public function init() : void {
         this._type = configModel.getStringForFeatureConfig("happyHour",this.TYPE_KEY);
         this._marketingStartTime = configModel.getIntForFeatureConfig("happyHour",this.MARKETING_START_TIME_KEY);
         this._happyHourStartTime = configModel.getIntForFeatureConfig("happyHour",this.HAPPY_HOUR_START_TIME_KEY);
         this._happyHourEndTime = configModel.getIntForFeatureConfig("happyHour",this.HAPPY_HOUR_END_TIME_KEY);
         this._happyHourLuckyBonusAlreadySpun = configModel.getBooleanForFeatureConfig("happyHour",this.HAPPY_HOUR_LUCKY_BONUS_ALREADY_SPUN_KEY);
         this._utcOffset = configModel.getIntForFeatureConfig("happyHour",this.UTC_OFFSET_KEY);
         this._xpBoostMultiplier = configModel.getIntForFeatureConfig("happyHour",this.XP_BOOST_MULTIPLIER_KEY);
         this._hasAlreadySeenFlyout = configModel.getBooleanForFeatureConfig("happyHour",this.HAS_ALREADY_SEEN_FLYOUT_KEY);
         this._numFlyoutsSeen = configModel.getIntForFeatureConfig("happyHour",this.NUM_FLYOUTS_SEEN_KEY);
         this._maxFlyoutsCount = configModel.getIntForFeatureConfig("happyHour",this.MAX_FLYOUTS_COUNT_KEY);
      }
      
      public function get type() : String {
         return this._type;
      }
      
      public function get marketingStartTime() : int {
         return this._marketingStartTime;
      }
      
      public function get happyHourStartTime() : int {
         return this._happyHourStartTime;
      }
      
      public function get happyHourEndTime() : int {
         return this._happyHourEndTime;
      }
      
      public function get happyHourLuckyBonusAlreadySpun() : Boolean {
         return this._happyHourLuckyBonusAlreadySpun;
      }
      
      public function get hasAlreadySeenFlyout() : Boolean {
         return this._hasAlreadySeenFlyout;
      }
      
      public function get numFlyoutsSeen() : int {
         return this._numFlyoutsSeen;
      }
      
      public function set numFlyoutsSeen(param1:int) : void {
         var _loc2_:Object = configModel.getFeatureConfig("happyHour");
         if(_loc2_ !== null)
         {
            _loc2_[this.NUM_FLYOUTS_SEEN_KEY] = param1;
         }
         this._numFlyoutsSeen = param1;
      }
      
      public function get maxFlyoutsCount() : int {
         return this._maxFlyoutsCount;
      }
      
      public function get utcOffset() : int {
         return this._utcOffset;
      }
      
      public function get xpBoostMultiplier() : int {
         return this._xpBoostMultiplier;
      }
      
      public function get isFirstTimeLoad() : Boolean {
         return this._isFirstTimeLoad;
      }
      
      public function set isFirstTimeLoad(param1:Boolean) : void {
         this._isFirstTimeLoad = param1;
      }
   }
}
