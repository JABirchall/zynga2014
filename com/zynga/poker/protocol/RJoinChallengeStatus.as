package com.zynga.poker.protocol
{
   public class RJoinChallengeStatus extends Object
   {
      
      public function RJoinChallengeStatus(param1:Array, param2:Array) {
         super();
         this.type = "RJoinChallengeStatus";
         this.success = param1;
         this.failure = param2;
      }
      
      public var type:String;
      
      public var success:Array;
      
      public var failure:Array;
   }
}
