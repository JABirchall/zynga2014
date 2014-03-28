package com.zynga.poker.challenges
{
   public class AssistedChallenge extends Object
   {
      
      public function AssistedChallenge(param1:String, param2:String, param3:Challenge, param4:String, param5:String, param6:Number, param7:String, param8:Number=0, param9:String="", param10:String="") {
         super();
         this.id = param1;
         this.initiator = param2;
         this.challenge = param3;
         this.disposition = param4;
         this.taskStatus = param5;
         this.timeRemaining = param6;
         this.userTaskStatus = param7;
         this.picURL = param10;
         this.firstName = param9;
         this.timeInitiated = param8;
      }
      
      public var initiator:String;
      
      public var id:String;
      
      public var challenge:Challenge;
      
      public var disposition:String;
      
      public var taskStatus:String;
      
      public var timeRemaining:Number;
      
      public var userTaskStatus:String;
      
      public var firstName:String;
      
      public var picURL:String;
      
      public var timeInitiated:Number;
   }
}
