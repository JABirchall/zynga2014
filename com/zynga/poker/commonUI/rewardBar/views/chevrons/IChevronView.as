package com.zynga.poker.commonUI.rewardBar.views.chevrons
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.display.BitmapData;
   
   public interface IChevronView extends IEventDispatcher
   {
      
      function get isGold() : Boolean;
      
      function set isGold(param1:Boolean) : void;
      
      function goldify() : void;
      
      function createChevronFromDomain(param1:ApplicationDomain, param2:int) : void;
      
      function createChevronBackground(param1:BitmapData=null) : void;
      
      function createChevronForeground(param1:int, param2:BitmapData=null) : void;
      
      function initAssetLoading() : void;
      
      function destroy() : void;
   }
}
