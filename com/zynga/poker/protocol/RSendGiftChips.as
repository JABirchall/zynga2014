package com.zynga.poker.protocol
{
   public class RSendGiftChips extends Object
   {
      
      public function RSendGiftChips(param1:String, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) {
         super();
         this.type = param1;
         this.amount = param2;
         this.fromSit = param3;
         this.fromChips = param4;
         this.toSit = param5;
         this.toChips = param6;
      }
      
      public var type:String;
      
      public var amount:int;
      
      public var fromSit:Number;
      
      public var fromChips:Number;
      
      public var toSit:Number;
      
      public var toChips:Number;
   }
}
