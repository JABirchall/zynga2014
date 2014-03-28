package com.zynga.poker.protocol
{
   public class RAchieved extends Object
   {
      
      public function RAchieved(param1:String, param2:Object) {
         super();
         this.type = param1;
         this.nSit = int(param2.sit);
         this.sAchievmentName = param2.achievementName;
         this.nRewardBonus = Number(param2.rewardBonus);
         this.sPicUrl = param2.picUrl;
         this.nPoints = Number(param2.nPoints);
         this.sPlayerText = param2.playerText;
         this.sIconUrl = param2.iconUrl;
         this.sZid = param2.zid;
         this.nAchievmentId = int(param2.achievementId);
         this.feedPoints = int(param2.feedPoints);
         this.feedAmountWon = int(param2.feedAmountWon);
         this.feedHandLetters = String(param2.feedHandLetters);
      }
      
      public var type:String;
      
      public var nSit:int;
      
      public var nAchievmentId:Number;
      
      public var sAchievmentName:String;
      
      public var nRewardBonus:Number;
      
      public var sPicUrl:String;
      
      public var nPoints:Number;
      
      public var sPlayerText:String;
      
      public var sIconUrl:String;
      
      public var sZid:String;
      
      public var feedPoints:Number;
      
      public var feedAmountWon:Number;
      
      public var feedHandLetters:String;
   }
}
