package com.zynga.poker.protocol
{
   public class RBuyIn extends Object
   {
      
      public function RBuyIn(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.points = param3;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var points:Number;
   }
}
