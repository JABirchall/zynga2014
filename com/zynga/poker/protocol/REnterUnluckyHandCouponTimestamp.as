package com.zynga.poker.protocol
{
   public class REnterUnluckyHandCouponTimestamp extends Object
   {
      
      public function REnterUnluckyHandCouponTimestamp(param1:String, param2:int) {
         super();
         this.type = param1;
         this.timestamp = param2;
      }
      
      public var type:String;
      
      public var timestamp:int;
   }
}
