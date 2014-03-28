package com.zynga.poker.protocol
{
   public class RPokerScoreUpdate extends Object
   {
      
      public function RPokerScoreUpdate(param1:String, param2:Number, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.score = param2;
         this.scoreRangeLow = param3;
         this.scoreRangeHigh = param4;
      }
      
      public var type:String;
      
      public var score:Number;
      
      public var scoreRangeLow:Number;
      
      public var scoreRangeHigh:Number;
   }
}
