package com.zynga.poker.protocol
{
   public class RChallengeError extends Object
   {
      
      public function RChallengeError(param1:int) {
         super();
         this.type = "RChallengeError";
         this.errorCode = param1;
      }
      
      public var type:String;
      
      public var errorCode:int;
   }
}
