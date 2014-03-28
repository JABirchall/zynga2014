package com.zynga.poker.commonUI.rewardBar.views
{
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import com.zynga.poker.commonUI.rewardBar.views.chevrons.IChevronView;
   import com.zynga.draw.ShinyButton;
   import caurina.transitions.Tweener;
   import com.zynga.poker.commonUI.rewardBar.views.chevrons.ChevronBaseView;
   import flash.events.Event;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   
   public class RewardBarBaseView extends Sprite implements IRewardBarView
   {
      
      public function RewardBarBaseView(param1:int, param2:Number, param3:Number, param4:Number, param5:int=5, param6:int=5) {
         super();
         this._totalHeight = param4;
         this._totalWidth = param2;
         this._prizeWidth = param3;
         this._chevronIncrement = param6;
         this.createChevrons(param5);
         addChild(this._chevronContainer);
         this.initAssetLoading();
      }
      
      public static const ASSETS_LOADED:String = "assetsLoaded";
      
      public static const CLAIM_REWARD:String = "claim";
      
      protected var _totalWidth:Number;
      
      protected var _totalHeight:Number;
      
      protected var _prizeWidth:Number;
      
      private var _goldifyToIndex:int;
      
      private var _currentlyGolding:int;
      
      protected var _chevronIncrement:int;
      
      protected var _chevrons:Vector.<IChevronView>;
      
      protected var _chevronContainer:Sprite;
      
      protected var _claimButton:ShinyButton;
      
      protected function createChevrons(param1:int) : void {
         this._chevrons = new Vector.<IChevronView>(param1,true);
         this._chevronContainer = new Sprite();
      }
      
      protected function initAssetLoading() : void {
         this.assetsLoaded();
      }
      
      public function showClaimedBonus(param1:int, param2:int=0) : void {
         Tweener.addTween(this._chevronContainer,
            {
               "alpha":0,
               "time":1,
               "onComplete":this.displayClaimText,
               "onCompleteParams":[param1,param2]
            });
      }
      
      protected function displayClaimText(param1:int, param2:int) : void {
      }
      
      public function goldifyChevrons(param1:int) : void {
         this._goldifyToIndex = param1-1;
         this._currentlyGolding = 0;
         this.startNextGoldTween();
      }
      
      private function startNextGoldTween() : void {
         this._chevrons[this._currentlyGolding].addEventListener(ChevronBaseView.GOLD_TWEEN_COMPLETE,this.onChevronGoldTweenComplete,false,0,true);
         if(!this._chevrons[this._currentlyGolding].isGold)
         {
            this._chevrons[this._currentlyGolding].goldify();
         }
      }
      
      private function onChevronGoldTweenComplete(param1:Event) : void {
         if(this._chevrons == null)
         {
            return;
         }
         this._chevrons[this._currentlyGolding].removeEventListener(ChevronBaseView.GOLD_TWEEN_COMPLETE,this.onChevronGoldTweenComplete);
         if(this._currentlyGolding < this._goldifyToIndex)
         {
            this._currentlyGolding++;
            this.startNextGoldTween();
         }
         else
         {
            if(this._currentlyGolding == this._chevrons.length-1)
            {
               this.onAllChevronsGold();
            }
         }
      }
      
      protected function onAllChevronsGold() : void {
         this.createClaimButton();
      }
      
      protected function createClaimButton(param1:Number=100, param2:Number=31, param3:int=16, param4:String="") : void {
         if(!param4)
         {
            param4 = LocaleManager.localize("flash.mfs.rewardBar.claim");
         }
         this._claimButton = new ShinyButton(param4,param1,param2,param3);
         this._claimButton.y = this._chevronContainer.y + (this._chevronContainer.height - this._claimButton.height) / 2;
         this._claimButton.x = this._chevronContainer.width + 15;
         this._claimButton.addEventListener(MouseEvent.CLICK,this.onClaimClick,false,0,true);
         addChild(this._claimButton);
      }
      
      protected function onClaimClick(param1:MouseEvent) : void {
         this._claimButton.removeEventListener(MouseEvent.CLICK,this.onClaimClick);
         removeChild(this._claimButton);
         this._claimButton = null;
         dispatchEvent(new Event(CLAIM_REWARD));
      }
      
      public function createPrizeText(param1:int) : void {
      }
      
      protected function assetsLoaded() : void {
         dispatchEvent(new Event(ASSETS_LOADED));
      }
      
      public function destroy() : void {
         var _loc1_:IChevronView = null;
         if((this.parent) && (this.parent.contains(this)))
         {
            this.parent.removeChild(this);
         }
         for each (_loc1_ in this._chevrons)
         {
            _loc1_.destroy();
            _loc1_ = null;
         }
         this._chevrons = null;
         this._chevronContainer = null;
      }
   }
}
