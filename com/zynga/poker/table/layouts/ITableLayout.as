package com.zynga.poker.table.layouts
{
   public interface ITableLayout
   {
      
      function getSeatLayout() : Array;
      
      function getChickletLayout() : Array;
      
      function getGiftLayout() : Array;
      
      function getDealerPuckLayout() : Array;
      
      function getChipLayout() : IChipLayout;
      
      function getCardLayout() : ICardLayout;
      
      function getMaxPlayers() : int;
   }
}
