package com.zynga.poker.protocol
{
   public class STipTheDealer extends Object
   {
      
      public function STipTheDealer(param1:String, param2:Number, param3:int) {
         super();
         this.type = param1;
         this.amount = param2;
         this.sit = param3;
      }
      
      public var amount:Number;
      
      public var sit:int;
      
      public var type:String;
   }
}
