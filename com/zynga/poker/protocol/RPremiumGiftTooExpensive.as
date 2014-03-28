package com.zynga.poker.protocol
{
   public class RPremiumGiftTooExpensive extends Object
   {
      
      public function RPremiumGiftTooExpensive(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.uCostOfGift = param2;
         this.uMyCurrentChipTotal = param3;
      }
      
      public var type:String;
      
      public var uCostOfGift:Number = -1;
      
      public var uMyCurrentChipTotal:Number = -1;
   }
}
