package com.zynga.poker.protocol
{
   public class RUserLevelledUp extends Object
   {
      
      public function RUserLevelledUp(param1:String, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int) {
         super();
         this.type = param1;
         this.sit = param2;
         this.zid = param3;
         this.xpLevel = param4;
         this.xp = param5;
         this.nextGiftUnlock = param6;
         this.nextAchievementUnlock = param7;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var zid:String;
      
      public var xpLevel:int;
      
      public var xp:int;
      
      public var nextGiftUnlock:int;
      
      public var nextAchievementUnlock:int;
   }
}
