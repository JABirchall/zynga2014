package com.zynga.poker.protocol
{
   public class RGiftShown2 extends Object
   {
      
      public function RGiftShown2(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.giftId = param3;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var giftId:Number;
   }
}
