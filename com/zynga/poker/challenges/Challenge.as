package com.zynga.poker.challenges
{
   import com.zynga.poker.SSLMigration;
   
   public class Challenge extends Object
   {
      
      public function Challenge(param1:int, param2:String, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:String, param10:String, param11:String, param12:Boolean, param13:Number, param14:int=0, param15:int=0) {
         super();
         this.typeID = param1;
         this.name = param2;
         this.category = param3;
         this.description = param4;
         this.buddiesRequired = param5;
         this.chipsRewarded = param6;
         this.xpRewarded = param7;
         this.secondsDuration = param8;
         this.smallIcon = SSLMigration.getSecureURL(param10);
         this.largeIcon = SSLMigration.getSecureURL(param11);
         this.challengeStatus = param9;
         this.available = param12;
         this.nextAvailable = param13;
         this.ordering = param14;
         this.xpRewardedBonus = param15;
      }
      
      public var typeID:int;
      
      public var name:String;
      
      public var category:int;
      
      public var description:String;
      
      public var buddiesRequired:int;
      
      public var chipsRewarded:int;
      
      public var xpRewarded:int;
      
      public var secondsDuration:int;
      
      public var smallIcon:String;
      
      public var largeIcon:String;
      
      public var challengeStatus:String;
      
      public var available:Boolean;
      
      public var nextAvailable:Number;
      
      public var ordering:int;
      
      public var xpRewardedBonus:int;
      
      public function clone() : Challenge {
         return new Challenge(this.typeID,this.name,this.category,this.description,this.buddiesRequired,this.chipsRewarded,this.xpRewarded,this.secondsDuration,this.challengeStatus,this.smallIcon,this.largeIcon,this.available,this.nextAvailable,this.ordering,this.xpRewardedBonus);
      }
   }
}
