package com.zynga.poker.protocol
{
   public class RShootoutBuyinChanged extends Object
   {
      
      public function RShootoutBuyinChanged(param1:String, param2:Number, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.nRefund = param2;
         this.nNewBuyIn = param3;
         this.nOldBuyIn = param4;
      }
      
      public var type:String;
      
      public var nRefund:Number;
      
      public var nNewBuyIn:Number;
      
      public var nOldBuyIn:Number;
   }
}
