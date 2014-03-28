package com.zynga.poker.commonUI.rewardBar.views
{
   import flash.events.IEventDispatcher;
   
   public interface IRewardBarView extends IEventDispatcher
   {
      
      function showClaimedBonus(param1:int, param2:int=0) : void;
      
      function goldifyChevrons(param1:int) : void;
      
      function createPrizeText(param1:int) : void;
      
      function destroy() : void;
   }
}
