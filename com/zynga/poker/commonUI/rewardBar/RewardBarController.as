package com.zynga.poker.commonUI.rewardBar
{
   import com.zynga.poker.commonUI.rewardBar.views.IRewardBarView;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarZPWCView;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarChipsView;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarInviteView;
   import com.zynga.poker.commonUI.rewardBar.views.RewardBarBaseView;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.events.Event;
   import com.zynga.io.ExternalCall;
   import flash.display.DisplayObjectContainer;
   
   public class RewardBarController extends Object
   {
      
      public function RewardBarController(param1:Object) {
         this.VIEW_TYPE_CHIPS = RewardBarChipsView.VIEW_TYPE;
         this.VIEW_TYPE_ZPWC = RewardBarZPWCView.VIEW_TYPE;
         this.VIEW_TYPE_INVITE = RewardBarInviteView.VIEW_TYPE;
         super();
         this._chipLotto = param1.chipLotto as int;
         this._numChevrons = param1.numChevrons;
         this._increment = int(Math.ceil((param1.claimThreshold as int) / this._numChevrons));
         this._numAccepts = param1.numAccepts as int;
         this._viewType = param1.viewType as int;
         this._claimFunction = param1.claimFunction as String;
         this._ticketPrize = param1.ticketPrize as int;
         this._ticketTotal = param1.ticketTotal as int;
      }
      
      private const VIEW_TYPE_CHIPS:int;
      
      private const VIEW_TYPE_ZPWC:int;
      
      private const VIEW_TYPE_INVITE:int;
      
      private var _rewardBarView:IRewardBarView;
      
      private var _chipLotto:int;
      
      private var _ticketPrize:int;
      
      private var _ticketTotal:int;
      
      private var _increment:int;
      
      private var _numChevrons:int;
      
      private var _numAccepts:int;
      
      private var _viewType:int;
      
      private var _claimFunction:String;
      
      public function createRewardBarView(param1:Number, param2:Number) : void {
         switch(this._viewType)
         {
            case this.VIEW_TYPE_ZPWC:
               this._rewardBarView = new RewardBarZPWCView(param1,42,this._numChevrons,this._increment);
               this._rewardBarView.createPrizeText(this._ticketTotal);
               break;
            case this.VIEW_TYPE_CHIPS:
            case this.VIEW_TYPE_INVITE:
               this._rewardBarView = new RewardBarChipsView(param1,param2,this._numChevrons,this._increment);
               this._rewardBarView.createPrizeText(this._chipLotto);
               break;
            default:
               this._rewardBarView = new RewardBarInviteView(param1,param2,this._numChevrons,this._increment);
               this._rewardBarView.createPrizeText(this._chipLotto);
         }
         
         this._rewardBarView.addEventListener(RewardBarBaseView.CLAIM_REWARD,this.onClaimRewardClick,false,0,true);
         this._rewardBarView.addEventListener(RewardBarBaseView.ASSETS_LOADED,this.onAssetsLoaded,false,0,true);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:ChipGiftRewardBar:Type_" + this._viewType + ":2012-05-17"));
      }
      
      private function onClaimRewardClick(param1:Event) : void {
         this._rewardBarView.removeEventListener(RewardBarBaseView.CLAIM_REWARD,this.onClaimRewardClick);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Click o:ChipGiftRewardBar_Claim:Type_" + this._viewType + ":2012-05-17"));
         ExternalCall.getInstance().call(this._claimFunction);
      }
      
      public function onClaimedReward(param1:int) : void {
         this._rewardBarView.showClaimedBonus(param1,this._ticketPrize);
      }
      
      private function onAssetsLoaded(param1:Event) : void {
         this._rewardBarView.removeEventListener(RewardBarBaseView.ASSETS_LOADED,this.onAssetsLoaded);
         this.determineGoldChevrons();
      }
      
      public function get rewardBarView() : DisplayObjectContainer {
         return this._rewardBarView as DisplayObjectContainer;
      }
      
      public function destroy() : void {
         this._chipLotto = 0;
         this._increment = 0;
         this._numChevrons = 0;
         this._numAccepts = 0;
         this._rewardBarView.destroy();
         this._rewardBarView = null;
      }
      
      private function determineGoldChevrons() : void {
         var _loc1_:* = 0;
         if(this._numAccepts >= this._numChevrons * this._increment)
         {
            this._rewardBarView.goldifyChevrons(this._numChevrons);
         }
         else
         {
            if(this._numAccepts >= this._increment)
            {
               _loc1_ = int(Math.floor(this._numAccepts / this._increment));
               this._rewardBarView.goldifyChevrons(_loc1_);
            }
         }
      }
   }
}
