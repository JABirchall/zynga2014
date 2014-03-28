package com.zynga.poker.challenges
{
   public class ChallengeHelper extends Object
   {
      
      public function ChallengeHelper(param1:String, param2:String) {
         super();
         this.zid = param1;
         this.taskStatus = param2;
      }
      
      public var zid:String;
      
      public var taskStatus:String;
      
      public var firstName:String = "";
      
      public var picURL:String = "";
   }
}
