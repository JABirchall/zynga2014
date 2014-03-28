package com.zynga.poker.protocol
{
   public class RMarkTurn extends Object
   {
      
      public function RMarkTurn(param1:String, param2:int, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.elapsed = param3;
         this.time = param4;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var elapsed:Number;
      
      public var time:Number;
   }
}
