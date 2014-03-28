package com.zynga.poker.table.interfaces
{
   import com.zynga.poker.table.layouts.ICardLayout;
   
   public interface ICardController
   {
      
      function initCards(param1:ICardLayout) : void;
      
      function cleanupCards() : void;
      
      function clearCards() : void;
      
      function repositionCards() : void;
      
      function resetModel() : void;
      
      function showPlayerCards(param1:int) : void;
      
      function clearPlayerCards(param1:int) : void;
      
      function clearCommunityCard(param1:int) : void;
      
      function dealCard(param1:int, param2:Boolean) : void;
      
      function replayDeal(param1:int) : void;
      
      function dealFlop(param1:Boolean) : void;
      
      function dealCommunityCard(param1:int, param2:Boolean=false) : void;
      
      function showWinningCards(param1:Object) : void;
      
      function dealDummyCard(param1:int, param2:Boolean) : void;
      
      function showAllHoles(param1:int) : void;
      
      function showWinningHand(param1:int) : void;
      
      function checkDealCount() : Boolean;
      
      function resetDealCount() : void;
      
      function checkOnePassDone() : Boolean;
      
      function setupNewHand(param1:Object) : void;
      
      function dealHoleCards(param1:int) : void;
      
      function setFlopCards(param1:Array) : void;
      
      function setStreetCard(param1:Object) : void;
      
      function setRiverCard(param1:Object) : void;
      
      function clearHoleCards() : void;
      
      function runPossibleHands() : void;
      
      function foldDummyCards(param1:int) : void;
      
      function foldPlayerCards(param1:int) : void;
      
      function setFourColorDeck(param1:Boolean) : void;
      
      function dimPlayerCards(param1:int) : void;
      
      function setHoleCards(param1:Object) : void;
   }
}
