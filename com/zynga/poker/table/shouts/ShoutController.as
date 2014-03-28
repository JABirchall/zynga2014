package com.zynga.poker.table.shouts
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import __AS3__.vec.Vector;
   import com.zynga.poker.table.shouts.views.common.IShoutView;
   import flash.utils.Timer;
   import com.zynga.poker.minigame.MinigameController;
   import com.zynga.poker.table.shouts.views.ShoutTreasureChestView;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.events.TimerEvent;
   import com.zynga.poker.table.shouts.views.ZPWCEligibleTournamentShout;
   import com.zynga.poker.table.shouts.views.ShoutRetroView;
   import com.zynga.poker.table.shouts.views.ShoutMasteryAchievementView;
   import flash.events.Event;
   import com.zynga.poker.table.shouts.views.ShoutTicketView;
   import com.zynga.poker.table.shouts.views.common.ShoutBaseView;
   import com.zynga.io.ExternalCall;
   import com.zynga.poker.table.shouts.views.ShoutPowerTourneyHappyHourView;
   import com.zynga.poker.table.shouts.views.ShoutBasicView;
   
   public class ShoutController extends EventDispatcher
   {
      
      public function ShoutController(param1:MinigameController) {
         this.SHOUT_TYPE_MASTERY_ACHIEVEMENT = ShoutMasteryAchievementView.SHOUT_TYPE;
         this.SHOUT_TYPE_RETRO = ShoutRetroView.SHOUT_TYPE;
         this.SHOUT_TYPE_TICKET_DROP = ShoutTicketView.SHOUT_TYPE;
         this.SHOUT_TYPE_BASIC = ShoutBasicView.SHOUT_TYPE;
         this.SHOUT_TYPE_HAPPY_HOUR = ShoutPowerTourneyHappyHourView.SHOUT_TYPE;
         this.SHOUT_TYPE_ZPWC_ELIGIBLE = ZPWCEligibleTournamentShout.SHOUT_TYPE;
         this.SHOUT_TYPE_TREASURE_CHEST = ShoutTreasureChestView.SHOUT_TYPE;
         super();
         this._minigameController = param1;
         this._shoutQueue = new Vector.<IShoutView>();
         this.isShowingShout = false;
      }
      
      private const SHOUT_TYPE_MASTERY_ACHIEVEMENT:int;
      
      private const SHOUT_TYPE_RETRO:int;
      
      private const SHOUT_TYPE_TICKET_DROP:int;
      
      private const SHOUT_TYPE_BASIC:int;
      
      private const SHOUT_TYPE_HAPPY_HOUR:int;
      
      private const ZPWC_GRANT_LOCATION:String = "shout";
      
      private const SHOUT_TYPE_ZPWC_ELIGIBLE:int;
      
      private const SHOUT_TYPE_TREASURE_CHEST:int;
      
      private var _shoutContainer:DisplayObjectContainer;
      
      private var _currentShoutIndex:int;
      
      private var _shoutQueue:Vector.<IShoutView>;
      
      private var _allowedToShout:Boolean;
      
      private var _currentShoutTimer:Timer;
      
      private var _minigameController:MinigameController;
      
      private var _firstSessionTicketClaim:Boolean = true;
      
      public function fireShouts() : void {
         var _loc1_:* = false;
         var _loc2_:* = 0;
         var _loc3_:IShoutView = null;
         var _loc4_:ShoutTreasureChestView = null;
         if(((this.allowedToShout && !this.isShowingShout) && (this._shoutQueue.length)) && (this._shoutContainer) && (this._shoutContainer.stage))
         {
            _loc1_ = false;
            _loc2_ = 0;
            while(_loc2_ < this._shoutQueue.length)
            {
               if(this._shoutQueue[_loc2_].ready)
               {
                  _loc1_ = true;
                  break;
               }
               _loc2_++;
            }
            if(_loc1_)
            {
               _loc3_ = this._shoutQueue[_loc2_];
               this._shoutContainer.addChild(_loc3_ as DisplayObjectContainer);
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:FlashShout_Type_" + _loc3_.type + ":2012-05-31"));
               this._minigameController.hideGame(true);
               _loc3_.open();
               if(_loc3_.timeout)
               {
                  this._currentShoutTimer = new Timer(1000,_loc3_.timeout);
                  _loc4_ = _loc3_ as ShoutTreasureChestView;
                  if(_loc4_ != null)
                  {
                     this._currentShoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCloseTreasureChestShout,false,0,true);
                  }
                  else
                  {
                     this._currentShoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCloseShout,false,0,true);
                  }
                  this._currentShoutTimer.start();
               }
               this._currentShoutIndex = _loc2_;
            }
         }
      }
      
      public function queueShout(param1:Object) : void {
         var _loc3_:IShoutView = null;
         var _loc4_:* = false;
         var _loc5_:IShoutView = null;
         var _loc2_:int = param1.type;
         if(_loc2_)
         {
            switch(_loc2_)
            {
               case this.SHOUT_TYPE_MASTERY_ACHIEVEMENT:
                  _loc3_ = this.createMasteryAchievementShout(param1);
                  if(!this.isShowingShout)
                  {
                     this.removeShoutsByType(this.SHOUT_TYPE_MASTERY_ACHIEVEMENT);
                  }
                  break;
               case this.SHOUT_TYPE_RETRO:
                  _loc3_ = this.createRetroShout(param1);
                  break;
               case this.SHOUT_TYPE_TICKET_DROP:
                  _loc3_ = this.createTicketShout(param1);
                  break;
               case this.SHOUT_TYPE_HAPPY_HOUR:
                  _loc3_ = this.createPowerTourneyHappyHourShout(param1);
                  break;
               case this.SHOUT_TYPE_ZPWC_ELIGIBLE:
                  _loc4_ = false;
                  for each (_loc5_ in this._shoutQueue)
                  {
                     if(_loc5_ is ZPWCEligibleTournamentShout)
                     {
                        _loc4_ = true;
                        break;
                     }
                  }
                  if(!_loc4_)
                  {
                     _loc3_ = this.createZPWCEligibleTournamentShout(param1);
                  }
                  break;
               case this.SHOUT_TYPE_TREASURE_CHEST:
                  _loc3_ = this.createTreasureChestShout(param1);
                  if(!(_loc3_ == null) && !this.isShowingShout)
                  {
                     this.removeShoutsByType(this.SHOUT_TYPE_TREASURE_CHEST);
                  }
                  break;
               default:
                  _loc3_ = null;
            }
            
            if(_loc3_ != null)
            {
               _loc3_.addEventListener(ShoutControllerEvent.EVENT_ASSETS_LOADED,this.onShoutAssetsLoaded,false,0,true);
               _loc3_.addEventListener(ShoutControllerEvent.EVENT_USER_CLOSED,this.onUserClosedShout,false,0,true);
               _loc3_.addEventListener(ShoutControllerEvent.EVENT_SHOUT_OFFSCREEN,this.destroyShout,false,0,true);
               _loc3_.init();
               if(_loc2_ == this.SHOUT_TYPE_TREASURE_CHEST)
               {
                  this._shoutQueue.unshift(_loc3_);
               }
               else
               {
                  this._shoutQueue.push(_loc3_);
               }
            }
         }
      }
      
      private function createRetroShout(param1:Object) : IShoutView {
         if((param1.retroSubType) && (param1.title) && (param1.picurl) && (param1.btntext))
         {
            return new ShoutRetroView(param1.retroSubType,param1.title,param1.picurl,param1.btntext);
         }
         return null;
      }
      
      private function createMasteryAchievementShout(param1:Object) : IShoutView {
         var _loc2_:Vector.<String> = null;
         var _loc3_:IShoutView = null;
         if(param1.achievementIds)
         {
            _loc2_ = Vector.<String>(param1.achievementIds);
            _loc3_ = new ShoutMasteryAchievementView(_loc2_,param1.chips);
            _loc3_.addEventListener(ShoutMasteryAchievementView.EVENT_CLAIM_REWARDS,this.onMasteryAchievementClaim,false,0,true);
            return _loc3_;
         }
         return null;
      }
      
      private function onMasteryAchievementClaim(param1:Event) : void {
         var _loc2_:IShoutView = param1.target as IShoutView;
         _loc2_.removeEventListener(ShoutMasteryAchievementView.EVENT_CLAIM_REWARDS,this.onMasteryAchievementClaim);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:FlashShout_Type_" + _loc2_.type + "_Claim:2012-05-31"));
         dispatchEvent(new ShoutControllerEvent(ShoutControllerEvent.EVENT_SHOW_ACHIEVEMENTS_PROFILE));
      }
      
      private function createTicketShout(param1:Object) : IShoutView {
         var _loc2_:IShoutView = null;
         if(param1.ttdName)
         {
            _loc2_ = new ShoutTicketView(param1.ttdName);
            _loc2_.addEventListener(ShoutTicketView.EVENT_CLAIM_REWARDS,this.onTableTicketClaim,false,0,true);
            _loc2_.addEventListener(ShoutTicketView.EVENT_SHARE_REWARDS,this.onTableTicketShare,false,0,true);
            return _loc2_;
         }
         return null;
      }
      
      private function createTreasureChestShout(param1:Object) : IShoutView {
         var _loc2_:* = false;
         var _loc3_:ShoutBaseView = null;
         if(!(param1 == null) && !(param1.handsPlayed == null) && !(param1.targetHands == null) && !(param1.chipsCurrentEarned == null) && !(param1.timeLeft == null) && !(param1.multiplier == null))
         {
            _loc2_ = param1.handsPlayed >= param1.targetHands;
            _loc3_ = new ShoutTreasureChestView(param1.handsPlayed,param1.targetHands,param1.chipsCurrentEarned,param1.timeLeft,param1.multiplier,_loc2_);
            return _loc3_;
         }
         return null;
      }
      
      private function onTableTicketClaim(param1:Event) : void {
         var _loc2_:IShoutView = param1.target as IShoutView;
         _loc2_.removeEventListener(ShoutTicketView.EVENT_CLAIM_REWARDS,this.onTableTicketClaim);
         ExternalCall.getInstance().call("zc.feature.zpwc.claimTicket","shout");
         if(this._firstSessionTicketClaim)
         {
            this._firstSessionTicketClaim = false;
            ExternalCall.getInstance().call("ZY.App.ZPWC.showTodo","shout");
         }
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:FlashShout_Type_" + _loc2_.type + "_Claim:2012-07-25"));
      }
      
      private function onTableTicketShare(param1:Event) : void {
         var _loc2_:IShoutView = param1.target as IShoutView;
         _loc2_.removeEventListener(ShoutTicketView.EVENT_SHARE_REWARDS,this.onTableTicketClaim);
         ExternalCall.getInstance().call("zc.feature.zpwc.publishFeed",1,{});
      }
      
      private function createPowerTourneyHappyHourShout(param1:Object) : IShoutView {
         return new ShoutPowerTourneyHappyHourView(param1.swfVars);
      }
      
      private function createZPWCEligibleTournamentShout(param1:Object) : IShoutView {
         var _loc2_:IShoutView = new ZPWCEligibleTournamentShout(param1.swfVars);
         return _loc2_;
      }
      
      private function onShoutAssetsLoaded(param1:ShoutControllerEvent) : void {
         var _loc2_:IShoutView = param1.target as IShoutView;
         _loc2_.removeEventListener(ShoutControllerEvent.EVENT_ASSETS_LOADED,this.onShoutAssetsLoaded);
         _loc2_.ready = true;
         this.fireShouts();
      }
      
      private function onUserClosedShout(param1:ShoutControllerEvent) : void {
         var _loc2_:IShoutView = param1.target as IShoutView;
         _loc2_.removeEventListener(ShoutControllerEvent.EVENT_USER_CLOSED,this.onUserClosedShout);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Close o:FlashShout_Type_" + _loc2_.type + ":2012-05-31"));
      }
      
      public function onCloseShout(param1:TimerEvent=null) : void {
         var _loc2_:IShoutView = null;
         if(this.isShowingShout)
         {
            _loc2_ = this._shoutQueue[this._currentShoutIndex];
            _loc2_.close();
         }
      }
      
      public function onCloseTreasureChestShout(param1:TimerEvent=null) : void {
         var _loc2_:IShoutView = null;
         var _loc3_:ShoutTreasureChestView = null;
         if(this.isShowingShout)
         {
            _loc2_ = this._shoutQueue[this._currentShoutIndex];
            _loc3_ = _loc2_ as ShoutTreasureChestView;
            if(_loc3_ != null)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"TreasureChest Other Click o:TreasureChestShout" + _loc3_.handsPlayed + "AutoClose:2013-10-23"));
            }
            _loc2_.close();
         }
      }
      
      private function destroyTimer() : void {
         if(this._currentShoutTimer)
         {
            this._currentShoutTimer.stop();
            this._currentShoutTimer = null;
         }
      }
      
      private function removeShoutsByType(param1:int) : void {
         var _loc2_:int = this._shoutQueue.length;
         var _loc3_:int = _loc2_-1;
         while(_loc3_ >= 0)
         {
            if(this._shoutQueue[_loc3_].type == param1)
            {
               this._shoutQueue.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      private function destroyShout(param1:ShoutControllerEvent=null) : void {
         this.destroyTimer();
         this._minigameController.showGame(true);
         var _loc2_:IShoutView = this._shoutQueue.splice(this._currentShoutIndex,1).pop();
         _loc2_.removeEventListener(ShoutControllerEvent.EVENT_SHOUT_OFFSCREEN,this.destroyShout);
         if(this._shoutContainer.contains(_loc2_ as DisplayObjectContainer))
         {
            this._shoutContainer.removeChild(_loc2_ as DisplayObjectContainer);
         }
         _loc2_.destroy();
         _loc2_ = null;
         this.isShowingShout = false;
         this.fireShouts();
      }
      
      private function get isShowingShout() : Boolean {
         if(this._currentShoutIndex >= 0)
         {
            return true;
         }
         return false;
      }
      
      private function set isShowingShout(param1:Boolean) : void {
         if(param1 == false)
         {
            this._currentShoutIndex = -1;
         }
      }
      
      public function set allowedToShout(param1:Boolean) : void {
         this._allowedToShout = param1;
         if(this._allowedToShout)
         {
            this.fireShouts();
         }
      }
      
      public function set shoutParentView(param1:DisplayObjectContainer) : void {
         this._shoutContainer = param1;
      }
      
      public function get allowedToShout() : Boolean {
         return this._allowedToShout;
      }
   }
}
