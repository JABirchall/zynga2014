package com.zynga.poker.protocol
{
   import com.zynga.poker.challenges.ChallengeRequestType;
   
   public class SJoinChallenge extends Object
   {
      
      public function SJoinChallenge(param1:String, param2:String, param3:Boolean) {
         this.availableRequestTypes = [ChallengeRequestType.WILLING,ChallengeRequestType.UNWILLING];
         super();
         this.type = "SJoinChallenge";
         if(this.availableRequestTypes.indexOf(param1) > -1)
         {
            this.requestType = param1;
         }
         else
         {
            this.requestType = "UnWilling";
         }
         this.fromLobby = param3;
         this.requestType = param1;
         this.targetChallenge = param2;
      }
      
      public var requestType:String;
      
      public var targetChallenge:String;
      
      public var type:String;
      
      public var fromLobby:Boolean;
      
      private var availableRequestTypes:Array;
   }
}
