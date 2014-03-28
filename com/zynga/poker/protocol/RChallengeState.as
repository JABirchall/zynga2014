package com.zynga.poker.protocol
{
   public class RChallengeState extends Object
   {
      
      public function RChallengeState(param1:String, param2:Array, param3:Array, param4:Number=1.0) {
         super();
         this.type = param1;
         this.userChallenges = param2;
         this.assistedChallenges = param3;
         this.xpMultiplier = param4;
      }
      
      public var type:String;
      
      public var userChallenges:Array;
      
      public var assistedChallenges:Array;
      
      public var xpMultiplier:Number;
   }
}
