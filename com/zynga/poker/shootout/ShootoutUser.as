package com.zynga.poker.shootout
{
   public class ShootoutUser extends Object
   {
      
      public function ShootoutUser() {
         super();
      }
      
      public var bPlaying:Boolean = false;
      
      public var sLastPlayed:String = "";
      
      public var nRound:Number = 1;
      
      public var nWonCount:Number = 0;
      
      public var nShootoutId:Number = 0;
      
      public var nBuyin:Number = 0;
      
      public var sSkippedRounds:String;
      
      public function updateUser(param1:Boolean, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:String) : void {
         this.bPlaying = param1;
         this.sLastPlayed = param2;
         this.nRound = param3;
         this.nWonCount = param4;
         this.nShootoutId = param5;
         this.nBuyin = param6;
         this.sSkippedRounds = param7;
      }
   }
}
