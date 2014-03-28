package com.zynga.poker
{
   public interface IPokerLoader
   {
      
      function get debugMode() : Boolean;
      
      function get bLobbyAssetsLoaded() : Boolean;
      
      function set bLobbyAssetsLoaded(param1:Boolean) : void;
      
      function get bLobbyJoinComplete() : Boolean;
      
      function set bLobbyJoinComplete(param1:Boolean) : void;
      
      function connectionFailed() : void;
      
      function loadBalanceError(param1:String) : void;
      
      function loginFailed() : void;
      
      function loginSFFailed(param1:String="") : void;
      
      function setConnectionText(param1:String) : void;
      
      function startPokerController() : void;
   }
}
