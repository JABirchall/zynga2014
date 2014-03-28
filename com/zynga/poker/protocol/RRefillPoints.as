package com.zynga.poker.protocol
{
   public class RRefillPoints extends Object
   {
      
      public function RRefillPoints(param1:String, param2:int, param3:int) {
         super();
         this.type = param1;
         this.refillPoints = param2;
         this.remaining = param3;
      }
      
      public var type:String;
      
      public var refillPoints:int;
      
      public var remaining:int;
   }
}
