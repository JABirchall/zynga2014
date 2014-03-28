package com.zynga.poker.protocol
{
   public class RDealHoles extends Object
   {
      
      public function RDealHoles(param1:String, param2:int, param3:String, param4:Number, param5:String, param6:Number, param7:int) {
         super();
         this.type = param1;
         this.sit = param2;
         this.card1 = param3;
         this.tip1 = param4;
         this.card2 = param5;
         this.tip2 = param6;
         this.small = param7;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var card1:String;
      
      public var tip1:Number;
      
      public var card2:String;
      
      public var tip2:Number;
      
      public var small:int;
   }
}
