package com.zynga.poker
{
   import com.zynga.User;
   
   public class UserProfile extends User
   {
      
      public function UserProfile(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Number, param8:int, param9:int=0, param10:int=0, param11:String="masc", param12:Boolean=false) {
         super(param1);
         this.username = param2;
         this.network = param3;
         if(param4)
         {
            this.smallPictureURL = param4;
         }
         if(param5)
         {
            this.largePictureURL = param5;
         }
         if(param6)
         {
            this.profileURL = param6;
         }
         this.chips = param7;
         this.rank = param8;
         this.xpLevel = param9;
         this.xp = param10;
         this.gender = param11;
         this.isMod = param12;
      }
      
      public var username:String;
      
      public var network:String = "";
      
      public var smallPictureURL:String = "";
      
      public var largePictureURL:String = "";
      
      public var profileURL:String = "";
      
      public var chips:Number;
      
      public var rank:int;
      
      public var gender:String;
      
      public var isMod:Boolean;
      
      public var xpLevel:int = 0;
      
      public var xp:int = 0;
   }
}
