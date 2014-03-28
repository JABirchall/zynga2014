package com.zynga.poker.protocol
{
   public class SCreateChallenge extends Object
   {
      
      public function SCreateChallenge(param1:String, param2:int, param3:String, param4:Boolean) {
         super();
         this.type = param1;
         this.fromLobby = param4;
         this.challengeTypeId = param2;
         this.friendList = param3;
      }
      
      public var type:String;
      
      public var fromLobby:Boolean;
      
      public var challengeTypeId:int;
      
      public var friendList:String;
   }
}
