package com.zynga.poker.protocol
{
   public class SGetGiftInfo3 extends Object
   {
      
      public function SGetGiftInfo3(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.giftId = param2;
      }
      
      public var type:String;
      
      public var giftId:Number;
   }
}
