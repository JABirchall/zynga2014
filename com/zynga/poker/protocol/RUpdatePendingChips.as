package com.zynga.poker.protocol
{
   public class RUpdatePendingChips extends Object
   {
      
      public function RUpdatePendingChips(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.amount = param2;
         this.sum = param3;
      }
      
      public var type:String;
      
      public var amount:Number;
      
      public var sum:Number;
   }
}
