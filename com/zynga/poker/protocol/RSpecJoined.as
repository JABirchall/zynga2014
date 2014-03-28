package com.zynga.poker.protocol
{
   import com.zynga.poker.UserProfile;
   
   public class RSpecJoined extends Object
   {
      
      public function RSpecJoined(param1:String, param2:UserProfile) {
         super();
         this.type = param1;
         this.userProfile = param2;
      }
      
      public var type:String;
      
      public var userProfile:UserProfile;
   }
}
