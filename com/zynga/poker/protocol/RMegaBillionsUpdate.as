package com.zynga.poker.protocol
{
   public class RMegaBillionsUpdate extends Object
   {
      
      public function RMegaBillionsUpdate(param1:String, param2:String, param3:Number, param4:String, param5:Number, param6:String, param7:Number, param8:String, param9:Number) {
         super();
         this.type = param1;
         this.isJackpotWin = param2;
         this.updatedChipAmount = param3;
         this.firstWinnerName = param4;
         this.firstWinnerAmount = param5;
         this.secondWinnerName = param6;
         this.secondWinnerAmount = param7;
         this.thirdWinnerName = param8;
         this.thirdWinnerAmount = param9;
      }
      
      public var type:String;
      
      public var isJackpotWin:String;
      
      public var updatedChipAmount:Number;
      
      public var firstWinnerName:String;
      
      public var firstWinnerAmount:Number;
      
      public var secondWinnerName:String;
      
      public var secondWinnerAmount:Number;
      
      public var thirdWinnerName:String;
      
      public var thirdWinnerAmount:Number;
   }
}
