package com.zynga.poker.protocol
{
   public class RCreateChallengeSuccess extends Object
   {
      
      public function RCreateChallengeSuccess(param1:String, param2:String) {
         super();
         this.type = param1;
         this.challengeID = param2;
      }
      
      public var type:String;
      
      public var challengeID:String;
   }
}
