package com.zynga.poker.pokerscore
{
   import __AS3__.vec.Vector;
   
   public class PokerScoreSubscriptions extends Object
   {
      
      public function PokerScoreSubscriptions() {
         this._subscriptions = new Vector.<PokerScoreSubscription>();
         super();
      }
      
      public static const SUBSCRIPTION_NULL:int = -1;
      
      public static const SUBSCRIPTION_PREMIUM:int = 0;
      
      public static const SUBSCRIPTION_PRO:int = 1;
      
      private var _subscriptions:Vector.<PokerScoreSubscription>;
      
      public function clear() : void {
         this._subscriptions = new Vector.<PokerScoreSubscription>();
      }
      
      public function push(param1:PokerScoreSubscription) : void {
         this._subscriptions.push(param1);
      }
      
      public function getActiveSubscription() : PokerScoreSubscription {
         var _loc2_:PokerScoreSubscription = null;
         var _loc1_:PokerScoreSubscription = null;
         for each (_loc2_ in this._subscriptions)
         {
            if(_loc1_ == null || _loc2_.subscriptionType > _loc1_.subscriptionType && _loc2_.secsRemaining > 0)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      public function getActivePayerType() : int {
         var _loc1_:PokerScoreSubscription = this.getActiveSubscription();
         if(!(_loc1_ == null) && !(PokerScoreDataMappings.SUBSCRIPTION_TYPES_TO_PAYER_TYPES[_loc1_.subscriptionType] == null))
         {
            return PokerScoreDataMappings.SUBSCRIPTION_TYPES_TO_PAYER_TYPES[_loc1_.subscriptionType];
         }
         return PokerScoreDataObject.PAYER_LESS_THAN_BUCKET;
      }
      
      public function canUseTrial(param1:int) : Boolean {
         var _loc2_:PokerScoreSubscription = null;
         for each (_loc2_ in this._subscriptions)
         {
            if(_loc2_.subscriptionType == param1 && !(_loc2_.trialStatus == PokerScoreSubscription.STATUS_TRIAL_UNUSED))
            {
               return false;
            }
         }
         return true;
      }
      
      public function mapSubscriptionTypesToItemCode(param1:int) : int {
         return PokerScoreDataMappings.SUBSCRIPTION_TYPES_TO_ITEM_CODES[param1];
      }
   }
}
