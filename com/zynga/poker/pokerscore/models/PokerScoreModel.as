package com.zynga.poker.pokerscore.models
{
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.pokerscore.PokerScoreDataObject;
   import com.zynga.poker.pokerscore.PokerScoreSubscriptions;
   import __AS3__.vec.Vector;
   import com.zynga.poker.pokerscore.PokerScoreSignificantHand;
   
   public class PokerScoreModel extends FeatureModel
   {
      
      public function PokerScoreModel() {
         super();
      }
      
      protected var _pokerScoreData:PokerScoreDataObject;
      
      private var _scoreHasChanged:Boolean = false;
      
      private var _previousScore:int = -1;
      
      public function updateData(param1:PokerScoreDataObject) : void {
         this._scoreHasChanged = !(this._previousScore == -1) && !(this._previousScore == param1.score);
         this._pokerScoreData = param1;
         this._previousScore = param1.score;
      }
      
      protected function get pokerScoreData() : PokerScoreDataObject {
         if(this._pokerScoreData == null)
         {
            this._pokerScoreData = new PokerScoreDataObject();
         }
         return this._pokerScoreData;
      }
      
      public function get score() : int {
         return this.pokerScoreData.score;
      }
      
      public function get scoreRangeHigh() : int {
         return this.pokerScoreData.scoreRangeHigh;
      }
      
      public function get scoreRangeLow() : int {
         return this.pokerScoreData.scoreRangeLow;
      }
      
      public function get subscriptions() : PokerScoreSubscriptions {
         return this.pokerScoreData.subscriptions;
      }
      
      public function get handsPlayedCount() : int {
         return this.pokerScoreData.handsPlayedCount;
      }
      
      public function get scoreHistory() : Vector.<Number> {
         return this.pokerScoreData.scoreHistory;
      }
      
      public function get significantHands() : Vector.<PokerScoreSignificantHand> {
         return this.pokerScoreData.significantHands;
      }
      
      public function get hasScore() : Boolean {
         return this.pokerScoreData.hasScore;
      }
      
      public function get hasScoreRange() : Boolean {
         return this.pokerScoreData.hasScoreRange;
      }
      
      public function get payerStatus() : int {
         return this.pokerScoreData.payerStatus;
      }
      
      public function get scoreHasChanged() : Boolean {
         return this._scoreHasChanged;
      }
      
      override public function dispose() : void {
         super.dispose();
      }
   }
}
