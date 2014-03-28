package com.zynga.poker.protocol
{
   public class SSkipShootRound extends Object
   {
      
      public function SSkipShootRound(param1:String, param2:int) {
         super();
         this.type = param1;
         this.targetRound = param2;
      }
      
      public var type:String;
      
      public var targetRound:int;
   }
}
