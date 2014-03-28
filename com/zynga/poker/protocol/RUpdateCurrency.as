package com.zynga.poker.protocol
{
   public class RUpdateCurrency extends Object
   {
      
      public function RUpdateCurrency(param1:String, param2:String, param3:int) {
         super();
         this.type = param1;
         this.currencyType = param2;
         this.amt = param3;
      }
      
      public var type:String;
      
      public var currencyType:String;
      
      public var amt:Number;
   }
}
