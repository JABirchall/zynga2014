package com.zynga.poker.challenges
{
   public class UserChallenge extends Object
   {
      
      public function UserChallenge(param1:String, param2:Challenge, param3:String, param4:Number, param5:Array, param6:Number=0, param7:Number=0) {
         super();
         this.id = param1;
         this.challenge = param2;
         this.taskStatus = param3;
         this.timeRemaining = param4;
         this.helpers = param5;
         this.bestTime = param6;
         this.lastTime = param7;
      }
      
      public var id:String;
      
      public var challenge:Challenge;
      
      public var taskStatus:String;
      
      public var timeRemaining:Number;
      
      public var bestTime:Number;
      
      public var lastTime:Number;
      
      public var helpers:Array;
   }
}
