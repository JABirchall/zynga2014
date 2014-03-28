package com.zynga.poker.pokerscore
{
   public class PokerScoreSignificantHand extends Object
   {
      
      public function PokerScoreSignificantHand(param1:String, param2:Boolean, param3:int) {
         super();
         this._handId = param1;
         this._didScoreIncrease = param2;
         this._secondsAgo = param3;
      }
      
      private var _handId:String;
      
      private var _didScoreIncrease:Boolean;
      
      private var _secondsAgo:int;
      
      public function get handId() : String {
         return this._handId;
      }
      
      public function get didScoreIncrease() : Boolean {
         return this._didScoreIncrease;
      }
      
      public function get secondsAgo() : int {
         return this._secondsAgo;
      }
   }
}
