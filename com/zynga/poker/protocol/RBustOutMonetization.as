package com.zynga.poker.protocol
{
   public class RBustOutMonetization extends Object
   {
      
      public function RBustOutMonetization(param1:int, param2:int) {
         super();
         this.points = param1;
         this.sit = param2;
      }
      
      public const type:String = "RBustOutMonetization";
      
      public var points:int;
      
      public var sit:int;
   }
}
