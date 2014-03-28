package com.zynga.poker.pokerscore
{
   public class PokerScoreSubscription extends Object
   {
      
      public function PokerScoreSubscription() {
         super();
      }
      
      public static const STATUS_TRIAL_UNUSED:int = -1;
      
      public static const STATUS_TRIAL_USED:int = 0;
      
      public static const STATUS_TRIAL_ACTIVE:int = 1;
      
      private var _subscriptionType:int;
      
      private var _secsRemaining:int;
      
      private var _trialStatus:int;
      
      public function init(param1:int, param2:int, param3:int) : void {
         this._subscriptionType = param1;
         this._secsRemaining = param2;
         this._trialStatus = param3;
      }
      
      public function get subscriptionType() : int {
         return this._subscriptionType;
      }
      
      public function get secsRemaining() : int {
         return this._secsRemaining;
      }
      
      public function get trialStatus() : int {
         return this._trialStatus;
      }
   }
}
