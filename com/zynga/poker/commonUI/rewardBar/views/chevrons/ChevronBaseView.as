package com.zynga.poker.commonUI.rewardBar.views.chevrons
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.display.BitmapData;
   
   public class ChevronBaseView extends Sprite implements IChevronView
   {
      
      public function ChevronBaseView(param1:Number=60, param2:Number=30) {
         super();
         this._isGold = false;
         this._chevronWidth = param1;
         this._chevronHeight = param2;
      }
      
      public static const GOLD_TWEEN_COMPLETE:String = "goldTweenComplete";
      
      public static const CHEVRON_ASSETS_COMPLETE:String = "assetsComplete";
      
      private var _isGold:Boolean;
      
      protected var _chevronWidth:Number;
      
      protected var _chevronHeight:Number;
      
      public function initAssetLoading() : void {
         this.assetLoadingComplete();
      }
      
      protected function assetLoadingComplete() : void {
         dispatchEvent(new Event(CHEVRON_ASSETS_COMPLETE));
      }
      
      public function createChevronFromDomain(param1:ApplicationDomain, param2:int) : void {
      }
      
      public function createChevronBackground(param1:BitmapData=null) : void {
      }
      
      public function createChevronForeground(param1:int, param2:BitmapData=null) : void {
      }
      
      public function get isGold() : Boolean {
         return this._isGold;
      }
      
      public function set isGold(param1:Boolean) : void {
         this._isGold = param1;
      }
      
      public function goldify() : void {
      }
      
      protected function goldifyComplete() : void {
         this._isGold = true;
         dispatchEvent(new Event(GOLD_TWEEN_COMPLETE));
      }
      
      public function destroy() : void {
      }
   }
}
