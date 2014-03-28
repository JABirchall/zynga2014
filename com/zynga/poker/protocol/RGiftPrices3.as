package com.zynga.poker.protocol
{
   public class RGiftPrices3 extends Object
   {
      
      public function RGiftPrices3(param1:String, param2:Number, param3:Array, param4:Array) {
         super();
         this.type = param1;
         this.giftType = param2;
         this.giftArray = param3;
         this.catArray = param4;
      }
      
      public var type:String;
      
      public var giftType:Number;
      
      public var giftArray:Array;
      
      public var catArray:Array;
   }
}
