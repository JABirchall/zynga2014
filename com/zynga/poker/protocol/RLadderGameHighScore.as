package com.zynga.poker.protocol
{
   public class RLadderGameHighScore extends Object
   {
      
      public function RLadderGameHighScore(param1:String, param2:int, param3:int) {
         super();
         this.type = param1;
         this.currentWeek = param2;
         this.currentScore = param3;
      }
      
      public var type:String;
      
      public var currentWeek:int;
      
      public var currentScore:int;
   }
}
