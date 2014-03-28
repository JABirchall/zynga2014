package com.zynga.poker.zoom.handlers
{
   import com.zynga.poker.zoom.ZshimEvent;
   
   public interface IZoomMessageHandler
   {
      
      function onZoomShout(param1:ZshimEvent) : void;
      
      function onZoomUpdate(param1:ZshimEvent) : void;
      
      function onZoomAddFriend(param1:ZshimEvent) : void;
      
      function onZoomRemoveFriend(param1:ZshimEvent) : void;
      
      function onZoomTableInvitation(param1:ZshimEvent) : void;
      
      function onZoomToolbarJoin(param1:ZshimEvent) : void;
      
      function onZoomSocketClose(param1:ZshimEvent) : void;
      
      function onLeaderboardGetUpdate(param1:ZshimEvent) : void;
   }
}
