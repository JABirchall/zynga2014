package com.zynga.poker.protocol
{
   public class SCreateRoom extends Object
   {
      
      public function SCreateRoom(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number) {
         super();
         this.type = param1;
         this.sName = param2;
         this.sPass = param3;
         this.nSmallBlind = param4;
         this.nBigBlind = param5;
         this.nMaxPlayers = param6;
         this.nMaxBuyIn = this.nSmallBlind * 40;
      }
      
      public var type:String;
      
      public var sName:String;
      
      public var sPass:String;
      
      public var nSmallBlind:Number;
      
      public var nBigBlind:Number;
      
      public var nMaxPlayers:Number;
      
      public var nMaxBuyIn:Number;
   }
}
