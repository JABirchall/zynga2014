package com.zynga.poker.protocol
{
   public class RBoughtGift extends Object
   {
      
      public function RBoughtGift(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) {
         super();
         this.type = param1;
         this.senderSit = param2;
         this.giftType = param3;
         this.giftNo = param4;
         this.fromChips = param5;
         this.toSit = param6;
      }
      
      public var type:String;
      
      public var senderSit:Number;
      
      public var giftType:Number;
      
      public var giftNo:Number;
      
      public var fromChips:Number;
      
      public var toSit:Number;
   }
}
