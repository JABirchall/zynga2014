package com.zynga.poker.protocol
{
   public class SGetGiftPrices extends Object
   {
      
      public function SGetGiftPrices(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.giftType = param2;
      }
      
      public var type:String;
      
      public var giftType:Number;
   }
}
