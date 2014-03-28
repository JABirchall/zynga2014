package com.zynga.poker.minigame
{
   import flash.display.MovieClip;
   import com.zynga.poker.ICommandDispatcher;
   import com.zynga.poker.IUserModel;
   import com.zynga.poker.ConfigModel;
   import com.zynga.io.IExternalCall;
   import com.greensock.events.LoaderEvent;
   import caurina.transitions.Tweener;
   
   public class MinigameViewController extends MovieClip
   {
      
      public function MinigameViewController() {
         super();
         this._showEnabled = true;
      }
      
      private var _commandDispatcher:ICommandDispatcher;
      
      private var _userModel:IUserModel;
      
      private var _mainDisp:MovieClip;
      
      private var _showEnabled:Boolean;
      
      private var _view:MinigameView;
      
      protected var _configModel:ConfigModel;
      
      public var externalInterface:IExternalCall;
      
      public function load(param1:MovieClip, param2:IUserModel, param3:ICommandDispatcher, param4:LoaderEvent=null) : void {
         this._mainDisp = param1;
         this._userModel = param2;
         this._commandDispatcher = param3;
      }
      
      public function onGameMessage(param1:Object) : void {
      }
      
      public function showGame() : void {
         if((this._view) && (this.showEnabled))
         {
            Tweener.removeTweens(this._view,"alpha");
            Tweener.addTween(this._view,
               {
                  "alpha":1,
                  "time":0.2,
                  "transition":"easeOutSine"
               });
         }
      }
      
      public function hideGame() : void {
         if(this._view)
         {
            Tweener.removeTweens(this._view,"alpha");
            Tweener.addTween(this._view,
               {
                  "alpha":0,
                  "time":0.25,
                  "delay":0.25,
                  "transition":"easeOutSine"
               });
         }
      }
      
      public function destroyGame() : void {
         this.view = null;
      }
      
      public function maximizeGame() : void {
      }
      
      public function onFriendRequestSentBack(param1:Object) : void {
         this.view.onMinigameFriendRequestSentBack(param1);
      }
      
      public function get commandDispatcher() : ICommandDispatcher {
         return this._commandDispatcher;
      }
      
      public function set commandDispatcher(param1:ICommandDispatcher) : void {
         this._commandDispatcher = param1;
      }
      
      public function get mainDisp() : MovieClip {
         return this._mainDisp;
      }
      
      public function get userModel() : IUserModel {
         return this._userModel;
      }
      
      public function set userModel(param1:IUserModel) : void {
         this._userModel = param1;
      }
      
      public function get showEnabled() : Boolean {
         return this._showEnabled;
      }
      
      public function set showEnabled(param1:Boolean) : void {
         this._showEnabled = param1;
      }
      
      public function get view() : MinigameView {
         return this._view;
      }
      
      public function set view(param1:MinigameView) : void {
         this._view = param1;
      }
      
      public function set configModel(param1:ConfigModel) : void {
         this._configModel = param1;
      }
   }
}
