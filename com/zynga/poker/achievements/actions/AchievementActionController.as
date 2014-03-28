package com.zynga.poker.achievements.actions
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.achievements.actions.fun.*;
   import com.zynga.poker.achievements.actions.social.*;
   import com.zynga.poker.achievements.actions.game.*;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.utils.getQualifiedClassName;
   
   public class AchievementActionController extends EventDispatcher
   {
      
      public function AchievementActionController() {
         var _loc1_:AchievementActionHiLoPro = null;
         var _loc2_:AchievementActionGiftGetter = null;
         var _loc3_:AchievementActionBlingMaster = null;
         var _loc4_:AchievementActionFreeMoneyFiveWay = null;
         var _loc5_:AchievementActionLuckyCharmer = null;
         var _loc6_:AchievementActionTheDiceManCometh = null;
         var _loc7_:AchievementActionYouAreAGoodFriend = null;
         var _loc8_:AchievementActionItTakesMoreThanOne = null;
         var _loc9_:AchievementActionPowerPlayer = null;
         var _loc10_:AchievementActionShootoutChampion = null;
         var _loc11_:AchievementActionHabitForming = null;
         var _loc12_:AchievementActionSitAndGo = null;
         var _loc13_:AchievementActionTakeASpin = null;
         var _loc14_:AchievementActionYouAreABadFriend = null;
         var _loc15_:AchievementActionPotHauler = null;
         var _loc16_:AchievementActionMovingOnUpBronze = null;
         var _loc17_:AchievementActionMovingOnUpSilver = null;
         var _loc18_:AchievementActionMovingOnUpGold = null;
         var _loc19_:AchievementActionMovingOnUpPlatinum = null;
         var _loc20_:AchievementActionStrengthInNumbers = null;
         var _loc21_:AchievementActionMovingOnUpPewter = null;
         var _loc22_:AchievementActionMovingOnUpCopper = null;
         var _loc23_:AchievementActionMovingOnUpBronzeLoosened = null;
         var _loc24_:AchievementActionMovingOnUpSilverLoosened = null;
         var _loc25_:AchievementActionMovingOnUpGoldLoosened = null;
         super();
         this._packageRoot = getQualifiedClassName(this).split("::").shift();
         addEventListener(CommandEvent.TYPE_ACHIEVEMENT_ACTION,this.onAchievementActionClicked);
      }
      
      private var _packageRoot:String;
      
      private var _lastActionID:String;
      
      private const ACHIEVEMENT_ACTION_PREFIX:String = "AchievementAction";
      
      public function onAchievementActionClicked(param1:CommandEvent) : void {
         this._lastActionID = param1.params.achievementId;
         var _loc2_:Array = String(this.lastAction).split("_");
         var _loc3_:String = this._packageRoot + "." + _loc2_[0].toLowerCase() + "." + this.ACHIEVEMENT_ACTION_PREFIX + _loc2_[1];
         var _loc4_:Class = PokerClassProvider.getClass(_loc3_);
         if(_loc4_)
         {
            this.completeAction(_loc4_);
         }
      }
      
      private function completeAction(param1:Class) : void {
         var _loc3_:String = null;
         var _loc2_:IAchievementAction = new param1() as IAchievementAction;
         if(PokerGlobalData.instance.inLobbyRoom)
         {
            _loc2_.executeFromLobby();
            _loc3_ = "Lobby";
         }
         else
         {
            _loc2_.executeFromTable();
            _loc3_ = "Table";
         }
         this.fireActionStat(_loc3_);
      }
      
      private function fireActionStat(param1:String) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,param1 + " Other Click o:AchievementAction_" + this.lastAction + ":2012-05-31"));
      }
      
      public function get lastAction() : String {
         return this._lastActionID;
      }
   }
}
