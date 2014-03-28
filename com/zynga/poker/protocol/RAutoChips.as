package com.zynga.poker.protocol
{
   public class RAutoChips extends Object
   {
      
      public function RAutoChips(param1:String, param2:String, param3:Number, param4:String, param5:Number) {
         super();
         this.type = param1;
         this.messageType = param2;
         this.sit = param3;
         this.zid = param4;
         this.amount = param5;
      }
      
      public var type:String;
      
      public var messageType:String;
      
      public var sit:Number;
      
      public var zid:String;
      
      public var amount:Number;
   }
}
