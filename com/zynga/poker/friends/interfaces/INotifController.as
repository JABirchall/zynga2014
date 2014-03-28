package com.zynga.poker.friends.interfaces
{
   public interface INotifController
   {
      
      function showOnlineNotif(param1:String) : void;
      
      function showOfflineNotif(param1:String) : void;
      
      function showInviteNotif(param1:String) : void;
      
      function showJoinNotif(param1:String) : void;
      
      function showJoinedNotif(param1:Object) : void;
      
      function set notifHandler(param1:INotifHandler) : void;
      
      function get notifHandler() : INotifHandler;
   }
}
