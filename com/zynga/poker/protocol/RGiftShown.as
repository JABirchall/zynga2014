package com.zynga.poker.protocol
{
   public class RGiftShown extends Object
   {
      
      public function RGiftShown(param1:String, param2:Number, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.giftType = param3;
         this.giftNo = param4;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var giftType:Number;
      
      public var giftNo:Number;
   }
}
