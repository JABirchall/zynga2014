package com.zynga.poker.protocol
{
   public class RBoughtGift2 extends Object
   {
      
      public function RBoughtGift2(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) {
         super();
         this.type = param1;
         this.senderSit = param2;
         this.giftId = param3;
         this.fromChips = param4;
         this.toSit = param5;
      }
      
      public var type:String;
      
      public var senderSit:Number;
      
      public var giftType:Number;
      
      public var giftId:Number;
      
      public var fromChips:Number;
      
      public var toSit:Number;
   }
}
