package com.zynga.poker.table.asset
{
   public class Pot extends Object
   {
      
      public function Pot(param1:int, param2:Number) {
         super();
         this.nPotId = param1;
         this.nAmt = param2;
      }
      
      public var nPotId:int;
      
      public var nAmt:Number;
   }
}
