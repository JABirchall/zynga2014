package com.zynga.poker.protocol
{
   public class RRakeInsufficientFunds extends Object
   {
      
      public function RRakeInsufficientFunds(param1:String, param2:String) {
         super();
         this.type = param1;
         this.event = param2;
      }
      
      public var type:String;
      
      public var event:String;
   }
}
