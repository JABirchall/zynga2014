package com.zynga.poker.table.shouts
{
   import flash.events.Event;
   
   public class ShoutControllerEvent extends Event
   {
      
      public function ShoutControllerEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const EVENT_ASSETS_LOADED:String = "assetsLoaded";
      
      public static const EVENT_USER_CLOSED:String = "userClosed";
      
      public static const EVENT_SHOUT_OFFSCREEN:String = "shoutOffscreen";
      
      public static const EVENT_SHOW_ACHIEVEMENTS_PROFILE:String = "showAchievements";
   }
}
