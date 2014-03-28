package com.zynga.poker.pokerscore.interfaces
{
   public interface IPokerScoreService
   {
      
      function init() : void;
      
      function registerDataListener(param1:Function) : Boolean;
      
      function unregisterDataListener(param1:Function) : Boolean;
      
      function requestData() : void;
      
      function updateHandsPlayedCount(param1:uint=1) : void;
   }
}
