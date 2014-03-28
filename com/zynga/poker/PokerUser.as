package com.zynga.poker
{
   import com.zynga.User;
   import com.zynga.poker.table.asset.CardData;
   
   public class PokerUser extends User
   {
      
      public function PokerUser(param1:int, param2:String, param3:Number, param4:String, param5:String, param6:Number, param7:int, param8:String, param9:String, param10:String, param11:int, param12:String, param13:String, param14:int, param15:String, param16:Number, param17:int, param18:int, param19:int, param20:String, param21:int=0, param22:int=0, param23:int=0, param24:int=1, param25:int=0, param26:int=0, param27:int=0, param28:String="masc", param29:int=0) {
         super(param5);
         this.bIsTableAce = false;
         this.nTableAceWinningsAmount = 0;
         this.nSit = param1;
         this.sUserName = param2;
         this.nChips = param3;
         this.nTotalPoints = param6;
         this.nRank = param7;
         this.sNetwork = param8;
         this.sTourneyState = param9;
         if(param4 != null)
         {
            this.sPicURL = SSLMigration.getAppropriateProfileImageUrl(param4);
         }
         if(param10 != null)
         {
            this.sPicLrgURL = SSLMigration.getAppropriateProfileImageUrl(param10);
         }
         this.nAchievementRank = param11;
         this.sProfileURL = SSLMigration.getAppropriateProfileImageUrl(param13);
         this.nGiftId = param14;
         this.sStatusText = param15;
         this.nCurBet = param16;
         this.emailSubscribed = param27 == 1?true:false;
         this.nPlayLevel = param17;
         this.nProtoVersion = param18;
         this.nCapabilities = param19;
         this.sClientType = param20;
         this.nFirstTime = param21;
         this.nHideGifts = param22;
         this.nPostToPlay = param24;
         this.xpLevel = param25;
         this.xp = param26;
         this.sGender = param28;
         this.nHandsWon = param23;
         this.nHandsPlayed = param29;
      }
      
      public static const DEFAULT_PIC_URL:String = "http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png";
      
      public var nSit:int;
      
      public var sUserName:String;
      
      public var nChips:Number;
      
      public var nOldChips:Number;
      
      public var nStartHandChips:Number;
      
      public var sPicURL:String = "";
      
      public var nTotalPoints:Number;
      
      public var nRank:int;
      
      public var sNetwork:String;
      
      public var sTourneyState:String;
      
      public var sPicLrgURL:String = "";
      
      public var nAchievementRank:int;
      
      public var sProfileURL:String;
      
      public var gender:String = "masc";
      
      public var xpLevel:int = 0;
      
      public var xp:int = 0;
      
      public var emailSubscribed:Boolean = false;
      
      public var nGiftId:int;
      
      public var sStatusText:String;
      
      public var sWinningHand:String;
      
      public var nCurBet:Number;
      
      public var nPlayLevel:int;
      
      public var nProtoVersion:int;
      
      public var nCapabilities:int;
      
      public var sClientType:String;
      
      public var nFirstTime:int;
      
      public var nBlind:Number;
      
      public var holecard1:CardData;
      
      public var holecard2:CardData;
      
      public var aPotsWon:Array;
      
      public var aHandString:Array;
      
      public var nHideGifts:int;
      
      public var nPostToPlay:int;
      
      public var sGender:String;
      
      public var nHandsWon:int;
      
      public var nHandsPlayed:int;
      
      public var bIsTableAce:Boolean;
      
      public var nTableAceWinningsAmount:Number;
   }
}
