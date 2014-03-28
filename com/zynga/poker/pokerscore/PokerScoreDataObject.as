package com.zynga.poker.pokerscore
{
   import com.zynga.poker.protocol.RPokerScoreUpdate;
   import __AS3__.vec.*;
   
   public class PokerScoreDataObject extends Object
   {
      
      public function PokerScoreDataObject() {
         this._subscriptions = new PokerScoreSubscriptions();
         new Vector.<Number>(10)[0] = 50;
         new Vector.<Number>(10)[1] = 55;
         new Vector.<Number>(10)[2] = 59;
         new Vector.<Number>(10)[3] = 57;
         new Vector.<Number>(10)[4] = 63;
         new Vector.<Number>(10)[5] = 66;
         new Vector.<Number>(10)[6] = 70;
         new Vector.<Number>(10)[7] = 74;
         new Vector.<Number>(10)[8] = 77;
         new Vector.<Number>(10)[9] = 82;
         this._scoreHistoryDefaultData = new Vector.<Number>(10);
         this._scoreHistory = this._scoreHistoryDefaultData;
         new Vector.<PokerScoreSignificantHand>(3)[0] = new PokerScoreSignificantHand("",true,5000);
         new Vector.<PokerScoreSignificantHand>(3)[1] = new PokerScoreSignificantHand("",true,500);
         new Vector.<PokerScoreSignificantHand>(3)[2] = new PokerScoreSignificantHand("",true,5);
         this._significantHandsDefaultData = new Vector.<PokerScoreSignificantHand>(3);
         this._significantHands = this._significantHandsDefaultData;
         super();
      }
      
      public static const KEY_SCORE_CARD_DATA:String = "scoreCardData";
      
      public static const KEY_TIP_DATA:String = "improveTip";
      
      public static const KEY_SCORE:String = "score";
      
      public static const KEY_SCORE_RANGE:String = "scoreRange";
      
      public static const KEY_HIGH:String = "high";
      
      public static const KEY_LOW:String = "low";
      
      public static const KEY_SUBSCRIPTIONS:String = "subs";
      
      public static const KEY_PREMIUM:String = "prem";
      
      public static const KEY_PRO:String = "pro";
      
      public static const KEY_TRIAL:String = "trial";
      
      public static const KEY_SECS_REMAINING:String = "secsRemaining";
      
      public static const KEY_SCORE_HISTORY:String = "scoreHistory";
      
      public static const KEY_SIGNIFICANT_HANDS:String = "sigHands";
      
      public static const KEY_HAND_ID:String = "handId";
      
      public static const KEY_DID_SCORE_INCREASE:String = "didScoreIncrease";
      
      public static const KEY_TIME_DELTA:String = "timeDelta";
      
      public static const KEY_CURRENT_BUCKET_COUNT:String = "currBucketCount";
      
      public static const KEY_HANDS_PLAYED_COUNTER:String = "handsPlayedCounter";
      
      public static const PAYER_LESS_THAN_BUCKET:int = 0;
      
      public static const PAYER_FREE:int = 1;
      
      public static const PAYER_PREMIUM:int = 2;
      
      public static const PAYER_PRO:int = 3;
      
      private var _score:int = -1;
      
      private var _hasScore:Boolean = false;
      
      private var _scoreRangeLow:int = -1;
      
      private var _scoreRangeHigh:int = -1;
      
      private var _hasScoreRange:Boolean = false;
      
      private var _subscriptions:PokerScoreSubscriptions;
      
      private var _hasSubscriptions:Boolean = false;
      
      private var _currentBucketCount:int = 0;
      
      private var _hasCurrentBucketCount:Boolean = false;
      
      private var _handsPlayedUnsaved:int = 0;
      
      private var _handsPlayedSaved:int = 0;
      
      private var _hasHandsPlayedCounter:Boolean = false;
      
      private var _scoreHistoryDefaultData:Vector.<Number>;
      
      private var _scoreHistory:Vector.<Number>;
      
      private var _hasScoreHistory:Boolean = false;
      
      private var _significantHandsDefaultData:Vector.<PokerScoreSignificantHand>;
      
      private var _significantHands:Vector.<PokerScoreSignificantHand>;
      
      private var _hasSignificantHands:Boolean = false;
      
      private var _tipKey:String = "popups.pokerScore.aboutScore.tips.1.description";
      
      private var _hasTipKey:Boolean = false;
      
      public function checkAndUpdatePokerScoreData(param1:RPokerScoreUpdate) : Boolean {
         var _loc2_:Boolean = this.isScoreFieldValid(param1.score);
         var _loc3_:Boolean = this.areScoreRangeFieldsValid(param1.scoreRangeLow,param1.scoreRangeHigh);
         var _loc4_:* = true;
         this._hasScore = _loc2_;
         this._hasScoreRange = _loc3_;
         this.updateScoreFromField(param1.score);
         this.updateScoreRangeFromFields(param1.scoreRangeLow,param1.scoreRangeHigh);
         return _loc4_;
      }
      
      public function checkAndUpdateScoreCardData(param1:Object) : Boolean {
         var _loc3_:Object = null;
         var _loc2_:Boolean = this.isTipKeyObjectValid(param1);
         if(_loc2_)
         {
            this._hasTipKey = _loc2_;
            this.updateTipKeyFromObject(param1);
         }
         if(this.isFieldValid(param1,KEY_SCORE_CARD_DATA,Object))
         {
            _loc3_ = param1[KEY_SCORE_CARD_DATA];
            _loc4_ = this.isScoreObjectValid(_loc3_);
            _loc5_ = this.isScoreRangeObjectValid(_loc3_);
            _loc6_ = this.isCurrentBucketCountObjectValid(_loc3_);
            _loc7_ = this.isHandsPlayedCounterObjectValid(_loc3_);
            _loc8_ = this.isScoreHistoryObjectValid(_loc3_);
            _loc9_ = this.isSignificantHandsObjectValid(_loc3_);
            _loc10_ = this.isSubscriptionObjectValid(_loc3_);
            _loc11_ = _loc4_;
            _loc12_ = true;
            if(!_loc6_ || !_loc7_)
            {
               _loc12_ = false;
            }
            if(_loc4_)
            {
               if(!_loc8_ || !_loc9_)
               {
                  _loc12_ = false;
               }
            }
            if(_loc11_)
            {
               if(!_loc10_)
               {
                  _loc12_ = false;
               }
            }
            if(_loc12_)
            {
               this._hasScore = _loc4_;
               this._hasScoreRange = _loc5_;
               this._hasCurrentBucketCount = _loc6_;
               this._hasHandsPlayedCounter = _loc7_;
               this._hasScoreHistory = _loc8_;
               this._hasSignificantHands = _loc9_;
               this._hasSubscriptions = _loc10_;
               this.updateScoreFromObject(_loc3_);
               this.updateScoreRangeFromObject(_loc3_);
               this.updateCurrentBucketCount(_loc3_);
               this.updateHandsPlayedCounter(_loc3_);
               this.updateScoreHistory(_loc3_);
               this.updateSignificantHands(_loc3_);
               this.updateSubscriptions(_loc3_);
            }
            return _loc12_;
         }
         return false;
      }
      
      private function isScoreObjectValid(param1:Object) : Boolean {
         return (this.isFieldValid(param1,KEY_SCORE,int)) && (this.isScoreFieldValid(param1[KEY_SCORE]));
      }
      
      private function isScoreFieldValid(param1:int) : Boolean {
         return this.isScoreWithinBounds(param1);
      }
      
      private function updateScoreFromObject(param1:Object) : void {
         if(this._hasScore)
         {
            this._score = param1[KEY_SCORE];
         }
         else
         {
            this._score = -1;
         }
      }
      
      private function updateScoreFromField(param1:int) : void {
         if(this._hasScore)
         {
            this._score = param1;
         }
         else
         {
            this._score = -1;
         }
      }
      
      private function isScoreRangeObjectValid(param1:Object) : Boolean {
         var _loc2_:Object = null;
         if(this.isFieldValid(param1,KEY_SCORE_RANGE,Object))
         {
            _loc2_ = param1[KEY_SCORE_RANGE];
            if((this.isFieldValid(_loc2_,KEY_HIGH,int)) && (this.isFieldValid(_loc2_,KEY_LOW,int)) && (this.areScoreRangeFieldsValid(param1[KEY_SCORE_RANGE][KEY_LOW],param1[KEY_SCORE_RANGE][KEY_HIGH])))
            {
               return true;
            }
         }
         return false;
      }
      
      private function areScoreRangeFieldsValid(param1:int, param2:int) : Boolean {
         return (this.isScoreWithinBounds(param1)) && (this.isScoreWithinBounds(param2)) && param1 < param2;
      }
      
      private function updateScoreRangeFromFields(param1:int, param2:int) : void {
         if(this._hasScoreRange)
         {
            this._scoreRangeLow = param1;
            this._scoreRangeHigh = param2;
         }
         else
         {
            this._scoreRangeLow = -1;
            this._scoreRangeHigh = -1;
         }
      }
      
      private function updateScoreRangeFromObject(param1:Object) : void {
         if(this._hasScoreRange)
         {
            this._scoreRangeHigh = param1[KEY_SCORE_RANGE][KEY_HIGH];
            this._scoreRangeLow = param1[KEY_SCORE_RANGE][KEY_LOW];
         }
         else
         {
            this._scoreRangeHigh = -1;
            this._scoreRangeLow = -1;
         }
      }
      
      private function isCurrentBucketCountObjectValid(param1:Object) : Boolean {
         return this.isFieldValid(param1,KEY_CURRENT_BUCKET_COUNT,int);
      }
      
      private function updateCurrentBucketCount(param1:Object) : void {
         if(this._hasCurrentBucketCount)
         {
            this._currentBucketCount = param1[KEY_CURRENT_BUCKET_COUNT];
         }
         else
         {
            this._currentBucketCount = 0;
         }
      }
      
      private function isHandsPlayedCounterObjectValid(param1:Object) : Boolean {
         return this.isFieldValid(param1,KEY_HANDS_PLAYED_COUNTER,int);
      }
      
      private function updateHandsPlayedCounter(param1:Object) : void {
         var _loc2_:* = 0;
         if(this._hasHandsPlayedCounter)
         {
            if(param1[KEY_HANDS_PLAYED_COUNTER] > this._handsPlayedSaved)
            {
               _loc2_ = param1[KEY_HANDS_PLAYED_COUNTER] - this._handsPlayedSaved;
               this._handsPlayedUnsaved = this._handsPlayedUnsaved - _loc2_;
               if(this._handsPlayedUnsaved < 0)
               {
                  this._handsPlayedUnsaved = 0;
               }
            }
            else
            {
               if(param1[KEY_HANDS_PLAYED_COUNTER] < this._handsPlayedSaved)
               {
                  this._handsPlayedUnsaved = 0;
               }
            }
            this._handsPlayedSaved = param1[KEY_HANDS_PLAYED_COUNTER];
         }
         else
         {
            this._handsPlayedSaved = 0;
         }
         if(this._currentBucketCount > this.handsPlayedCount)
         {
            this._handsPlayedUnsaved = this._currentBucketCount;
         }
      }
      
      private function isScoreHistoryObjectValid(param1:Object) : Boolean {
         var _loc2_:Object = null;
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         if(this.isFieldValid(param1,KEY_SCORE_HISTORY,Object))
         {
            _loc2_ = param1[KEY_SCORE_HISTORY];
            _loc3_ = 0;
            for each (_loc4_ in _loc2_)
            {
               _loc3_++;
               if(!(_loc4_ is Number))
               {
                  return false;
               }
            }
            if(_loc3_ == 0)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function updateScoreHistory(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:* = NaN;
         this._scoreHistory = new Vector.<Number>();
         if(this._hasScoreHistory)
         {
            _loc2_ = param1[KEY_SCORE_HISTORY];
            for each (_loc3_ in _loc2_)
            {
               this._scoreHistory.push(_loc3_);
            }
         }
      }
      
      private function isSignificantHandsObjectValid(param1:Object) : Boolean {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(this.isFieldValid(param1,KEY_SIGNIFICANT_HANDS,Object))
         {
            _loc2_ = param1[KEY_SIGNIFICANT_HANDS];
            for each (_loc3_ in _loc2_)
            {
               if(!this.isFieldValid(_loc3_,KEY_HAND_ID,String) || !this.isFieldValid(_loc3_,KEY_DID_SCORE_INCREASE,Boolean) || !this.isFieldValid(_loc3_,KEY_TIME_DELTA,int))
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      private function updateSignificantHands(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:PokerScoreSignificantHand = null;
         this._significantHands = new Vector.<PokerScoreSignificantHand>();
         if(this._hasSignificantHands)
         {
            _loc2_ = param1[KEY_SIGNIFICANT_HANDS];
            for each (_loc3_ in _loc2_)
            {
               _loc4_ = new PokerScoreSignificantHand(_loc3_[KEY_HAND_ID],_loc3_[KEY_DID_SCORE_INCREASE],_loc3_[KEY_TIME_DELTA]);
               this._significantHands.push(_loc4_);
            }
         }
      }
      
      private function isSubscriptionObjectValid(param1:Object) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(this.isFieldValid(param1,KEY_SUBSCRIPTIONS,Object))
         {
            _loc2_ = 0;
            for (_loc3_ in param1[KEY_SUBSCRIPTIONS])
            {
               if(!(PokerScoreDataMappings.PAYER_KEYS_TO_SUBSCRIPTION_TYPES[_loc3_] == null) && (this.isFieldValid(param1[KEY_SUBSCRIPTIONS],_loc3_,Object)))
               {
                  _loc4_ = param1[KEY_SUBSCRIPTIONS][_loc3_];
                  if((this.isFieldValid(_loc4_,KEY_SECS_REMAINING,int)) && (this.isFieldValid(_loc4_,KEY_TRIAL,int)))
                  {
                     _loc2_++;
                  }
               }
            }
            if(_loc2_ == 0)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function updateSubscriptions(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:PokerScoreSubscription = null;
         this._subscriptions.clear();
         if(this._hasSubscriptions)
         {
            for (_loc2_ in param1[KEY_SUBSCRIPTIONS])
            {
               if(!(PokerScoreDataMappings.PAYER_KEYS_TO_SUBSCRIPTION_TYPES[_loc2_] == null) && (this.isFieldValid(param1[KEY_SUBSCRIPTIONS],_loc2_,Object)))
               {
                  _loc3_ = new PokerScoreSubscription();
                  _loc3_.init(PokerScoreDataMappings.PAYER_KEYS_TO_SUBSCRIPTION_TYPES[_loc2_],param1[KEY_SUBSCRIPTIONS][_loc2_][KEY_SECS_REMAINING],param1[KEY_SUBSCRIPTIONS][_loc2_][KEY_TRIAL]);
                  this._subscriptions.push(_loc3_);
               }
            }
         }
      }
      
      private function isTipKeyObjectValid(param1:Object) : Boolean {
         return this.isFieldValid(param1,KEY_TIP_DATA,String);
      }
      
      private function updateTipKeyFromObject(param1:Object) : void {
         if(this._hasTipKey)
         {
            this._tipKey = param1[KEY_TIP_DATA];
         }
      }
      
      private function isFieldValid(param1:Object, param2:String, param3:Class) : Boolean {
         return (param1.hasOwnProperty(param2)) && !(param1[param2] == null) && param1[param2] is param3;
      }
      
      private function isScoreWithinBounds(param1:int) : Boolean {
         return param1 >= 0 && param1 <= 100;
      }
      
      public function get score() : int {
         return this._score;
      }
      
      public function get scoreRangeHigh() : int {
         return this._scoreRangeHigh;
      }
      
      public function get scoreRangeLow() : int {
         return this._scoreRangeLow;
      }
      
      public function get subscriptions() : PokerScoreSubscriptions {
         return this._subscriptions;
      }
      
      public function get handsPlayedCount() : int {
         return this._handsPlayedUnsaved + this._handsPlayedSaved;
      }
      
      public function get handsPlayedCountUnsaved() : int {
         return this._handsPlayedUnsaved;
      }
      
      public function set handsPlayedCountUnsaved(param1:int) : void {
         this._handsPlayedUnsaved = param1;
      }
      
      public function get scoreHistory() : Vector.<Number> {
         if(!this.hasPaid)
         {
            return this._scoreHistoryDefaultData;
         }
         return this._scoreHistory;
      }
      
      public function get significantHands() : Vector.<PokerScoreSignificantHand> {
         if(!this.hasPaid)
         {
            return this._significantHandsDefaultData;
         }
         return this._significantHands;
      }
      
      public function get tipKey() : String {
         return this._tipKey;
      }
      
      public function get hasScore() : Boolean {
         return this._hasScore;
      }
      
      public function get hasScoreRange() : Boolean {
         return this._hasScoreRange;
      }
      
      public function get payerStatus() : int {
         if(this._hasScore)
         {
            return this._subscriptions.getActivePayerType();
         }
         if(this._hasScoreRange)
         {
            return PAYER_FREE;
         }
         return PAYER_LESS_THAN_BUCKET;
      }
      
      public function saveHandsPlayedCount() : void {
         this._handsPlayedSaved = this._handsPlayedSaved + this._handsPlayedUnsaved;
         this._handsPlayedUnsaved = 0;
      }
      
      public function get hasPaid() : Boolean {
         return this._hasScore;
      }
   }
}
