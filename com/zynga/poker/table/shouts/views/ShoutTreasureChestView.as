package com.zynga.poker.table.shouts.views
{
   import flash.utils.Timer;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import caurina.transitions.*;
   import flash.display.MovieClip;
   import com.zynga.format.PokerCurrencyFormatter;
   
   public class ShoutTreasureChestView extends ShoutBasicView
   {
      
      public function ShoutTreasureChestView(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean=false) {
         super("TreasureChest1",null,SHOUT_TYPE,Math.min(param6?SHOUT_CLOSE_TIMEOUT_IN_SECONDS_CONGRAULATORY:SHOUT_CLOSE_TIMEOUT_IN_SECONDS_MILESTONE,param4));
         this._handsPlayed = param1;
         this._targetHands = param2;
         this._chipsCurrentEarned = param3;
         this._timeLeft = param4;
         this._isCongratShout = param6;
         this._multiplier = param5;
      }
      
      public static const SHOUT_TYPE:int = 7;
      
      public static const SHOUT_CLOSE_TIMEOUT_IN_SECONDS_MILESTONE:int = 20;
      
      public static const SHOUT_CLOSE_TIMEOUT_IN_SECONDS_CONGRAULATORY:int = 40;
      
      private var _handsPlayed:int;
      
      private var _targetHands:int;
      
      private var _chipsCurrentEarned:int;
      
      private var _timeLeft:int;
      
      private var _isCongratShout:Boolean;
      
      private var _timer:Timer;
      
      private var _multiplier:int;
      
      override protected function onCloseClick(param1:MouseEvent) : void {
         super.onCloseClick(param1);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"TreasureChest Other Click o:TreasureChestShout" + this._handsPlayed + "ManualClose:2013-10-23"));
      }
      
      override protected function assetsComplete() : void {
         var _loc1_:* = 0;
         super.assetsComplete();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"TreasureChest Other Click o:TreasureChestShout" + this._handsPlayed + "ShoutOpen:2013-10-23"));
         var _loc2_:Array = [0,1,5,10,20,30,35];
         var _loc3_:int = _loc2_.indexOf(this._handsPlayed);
         _loc1_ = _loc3_ > 0?_loc2_[_loc3_-1]:35;
         var _loc4_:int = this._chipsCurrentEarned * this._multiplier;
         if(!(_swfContentName == null) && !(shoutContainer.getChildByName(_swfContentName) == null))
         {
            (shoutContainer.getChildByName(_swfContentName) as MovieClip).showChipEarnScreen(_loc1_,this._handsPlayed,this._targetHands,PokerCurrencyFormatter.numberToCurrency(this._chipsCurrentEarned,false,2,false),PokerCurrencyFormatter.numberToCurrency(_loc4_,false,2,false),this._multiplier,this._timeLeft);
         }
      }
      
      public function get handsPlayed() : int {
         return this._handsPlayed;
      }
   }
}
