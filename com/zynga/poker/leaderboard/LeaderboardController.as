package com.zynga.poker.leaderboard
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.ConfigModel;
   import flash.utils.Timer;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.LeaderboardCommand;
   import flash.events.TimerEvent;
   import flash.display.DisplayObject;
   
   public class LeaderboardController extends EventDispatcher
   {
      
      public function LeaderboardController(param1:DisplayObjectContainer, param2:Number, param3:PokerController, param4:PokerGlobalData) {
         super();
         this._displayContainer = param1;
         this._timestamp = param2;
         this._pControl = param3;
         this._pgData = param4;
      }
      
      private var _displayContainer:DisplayObjectContainer;
      
      public function get displayContainer() : DisplayObjectContainer {
         return this._displayContainer;
      }
      
      private var _leaderboard:Object;
      
      private var _timestamp:Number;
      
      private var _pControl:PokerController;
      
      private var _pgData:PokerGlobalData;
      
      public var externalInterface:IExternalCall;
      
      private var _configModel:ConfigModel;
      
      public function set configModel(param1:ConfigModel) : void {
         this._configModel = param1;
      }
      
      private var _smallBlind:int;
      
      private var _tableType:String;
      
      private var _stakesDesc:String;
      
      public function get smallBlind() : int {
         return this._smallBlind;
      }
      
      public function get tableType() : String {
         return this._tableType;
      }
      
      public function get stakesDesc() : String {
         return this._stakesDesc;
      }
      
      private var _loadingTimer:Timer;
      
      public function setPlayNowPrefs(param1:int, param2:String, param3:String) : void {
         this._smallBlind = param1;
         this._tableType = param2;
         this._stakesDesc = param3;
         if(this._leaderboard)
         {
            this._leaderboard.setPlayNowPrefs(this._smallBlind,this._tableType,this._stakesDesc);
         }
      }
      
      public function showLeaderboard(param1:Object, param2:Boolean=false) : void {
         var _loc4_:Popup = null;
         var _loc5_:Class = null;
         if(this._leaderboard == null)
         {
            _loc4_ = this._pControl.getPopupConfigByID("Leaderboard");
            _loc5_ = PokerClassProvider.getClass(_loc4_.moduleClassName);
            this._leaderboard = new _loc5_();
            this._leaderboard.configModel = this._configModel;
            this._leaderboard.externalInterface = this.externalInterface;
            this._leaderboard.commandDispatcher = PokerCommandDispatcher.getInstance();
            this._leaderboard.commandDispatcher.addDispatcherForType(LeaderboardCommand,this._leaderboard);
         }
         if(this._pgData.xpLevel < this._configModel.getIntForFeatureConfig("leaderboard","levelRequirement"))
         {
            this._leaderboard.init(this._displayContainer,null,param2);
            this._leaderboard.locked = true;
            return;
         }
         this._leaderboard.locked = false;
         this._leaderboard.timestamp = this._timestamp;
         var _loc3_:Object = this._configModel.getFeatureConfig("leaderboard");
         this._leaderboard.trophyConfig = !(_loc3_ == null) && (_loc3_)?_loc3_.trophyConfig:this._pgData.leaderboardData.trophyConfig;
         this._leaderboard.init(this._displayContainer,param1.leaderBoard,param2);
         this._leaderboard.setPlayNowPrefs(this._smallBlind,this._tableType,this._stakesDesc);
         if(!param1.leaderBoard)
         {
            this._loadingTimer = new Timer(10 * 1000,1);
            this._loadingTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLoadingTimerComplete,false,0,true);
            this._loadingTimer.start();
         }
      }
      
      public function set visible(param1:Boolean) : void {
         if(this._leaderboard)
         {
            (this._leaderboard as DisplayObject).visible = param1;
         }
      }
      
      private function onLoadingTimerComplete(param1:TimerEvent) : void {
         this._loadingTimer.reset();
         this._loadingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onLoadingTimerComplete);
         if(!this._pgData.leaderboardData.hasOwnProperty("leaderBoard") || !this._pgData.leaderboardData.leaderBoard.hasOwnProperty("trophies"))
         {
            this.externalInterface.call("zc.feature.leaderboard.retrieveLeaderboardData");
         }
      }
   }
}
