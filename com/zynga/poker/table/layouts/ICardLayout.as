package com.zynga.poker.table.layouts
{
   public interface ICardLayout
   {
      
      function getCardDimensions() : Array;
      
      function getCommunityCardLayout() : Array;
      
      function getHoleCardLayout() : Array;
      
      function getDummyCardLayout() : Array;
   }
}
