package com.zynga.poker.shootout
{
   public class ShootoutConfig extends Object
   {
      
      public function ShootoutConfig() {
         this.aWinnersCount = new Array();
         this.aPayouts = new Array();
         super();
      }
      
      public var nId:Number = 0;
      
      public var nIdVersion:Number = 0;
      
      public var sLastModified:String = "";
      
      public var nBuyin:Number = 500;
      
      public var nRounds:Number = 3;
      
      public var nPlayers:Number = 9;
      
      public var aWinnersCount:Array;
      
      public var aPayouts:Array;
      
      public var skipRound1Price:Number;
      
      public var skipRound2Price:Number;
      
      public function updateConfig(param1:Number, param2:Number, param3:String, param4:Number, param5:Number, param6:Number, param7:Array, param8:Array, param9:Number, param10:Number) : void {
         this.nId = param1;
         this.nIdVersion = param2;
         this.sLastModified = param3;
         this.nBuyin = param4;
         this.nRounds = param5;
         this.nPlayers = param6;
         this.aWinnersCount = param7;
         this.aPayouts = param8;
         this.skipRound1Price = param9;
         this.skipRound2Price = param10;
      }
   }
}
