package com.zynga.poker.protocol
{
   public class RWinners extends Object
   {
      
      public function RWinners(param1:String, param2:Number, param3:String, param4:Array) {
         super();
         this.type = param1;
         this.pot = param2;
         this.winningHand = param3;
         this.winningHands = param4;
      }
      
      public var type:String;
      
      public var pot:Number;
      
      public var winningHand:String;
      
      public var winningHands:Array;
   }
}
