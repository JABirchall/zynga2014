package com.zynga.poker.friends.interfaces
{
   public interface INotifHandler
   {
      
      function showOnlineNotif(param1:String) : Boolean;
      
      function showOfflineNotif(param1:String) : Boolean;
      
      function showInviteNotif(param1:String) : Boolean;
      
      function showJoinNotif(param1:String) : Boolean;
      
      function showJoinedNotif(param1:Object) : Boolean;
   }
}
