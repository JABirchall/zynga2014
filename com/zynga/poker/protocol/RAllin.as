package com.zynga.poker.protocol
{
   public class RAllin extends Object
   {
      
      public function RAllin(param1:String, param2:int, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.bet = param3;
         this.chips = param4;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var bet:Number;
      
      public var chips:Number;
   }
}
