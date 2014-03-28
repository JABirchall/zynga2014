package com.zynga.poker.protocol
{
   public class RGetUserInfo extends Object
   {
      
      public function RGetUserInfo(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:int, param9:Number, param10:Number) {
         super();
         this.type = param1;
         if(!isNaN(param2))
         {
            this.xp = param2;
         }
         if(!isNaN(param3))
         {
            this.level = param3;
         }
         if(!isNaN(param4))
         {
            this.xpLevelEnd = param4;
         }
         if(!isNaN(param5))
         {
            this.casinoGold = param5;
         }
         if(!isNaN(param6))
         {
            this.nextGiftUnlock = param6;
         }
         if(!isNaN(param7))
         {
            this.nextAchievementUnlock = param7;
         }
         if(!isNaN(param8))
         {
            this.rakeEnabled = param8;
         }
         if(!isNaN(param9))
         {
            this.rakePercentage = param9;
         }
         if(!isNaN(param10))
         {
            this.rakeBlindMultiplier = param10;
         }
      }
      
      public var type:String;
      
      public var xp:Number;
      
      public var level:Number;
      
      public var xpLevelEnd:Number;
      
      public var casinoGold:Number;
      
      public var nextGiftUnlock:Number;
      
      public var nextAchievementUnlock:Number;
      
      public var rakeEnabled:int;
      
      public var rakePercentage:Number;
      
      public var rakeBlindMultiplier:Number;
   }
}
