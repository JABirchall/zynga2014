package com.zynga.poker.minigame
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.PokerConnectionManager;
   import com.zynga.poker.PokerGlobalData;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.lobby.LobbyController;
   import com.zynga.poker.table.TableController;
   import com.zynga.poker.nav.NavController;
   import flash.utils.Dictionary;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.minigame.minigameHelper.MinigameUtils;
   import com.zynga.poker.minigame.events.MGEvent;
   import com.zynga.poker.events.CommandEvent;
   import com.zynga.poker.popups.Popup;
   import com.zynga.load.LoadManager;
   import com.greensock.events.LoaderEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.poker.protocol.RMgfwResponse;
   import com.zynga.poker.protocol.mgfw.RSupportedMiniGameTypes;
   
   public class MinigameController extends EventDispatcher
   {
      
      public function MinigameController() {
         super();
         this._controllers = new Dictionary(true);
         this._enabledGameTypes = new Dictionary();
         this._currentGameType = "";
      }
      
      private var pcmConnect:PokerConnectionManager;
      
      private var pgData:PokerGlobalData;
      
      private var mainDisp:MovieClip;
      
      private var pControl:PokerController;
      
      private var lControl:LobbyController;
      
      private var tControl:TableController;
      
      private var nControl:NavController;
      
      private var _controllers:Dictionary;
      
      private var _enabledGameTypes:Dictionary;
      
      private var _currentGameType:String;
      
      public var externalInterface:IExternalCall;
      
      public var configModel:ConfigModel;
      
      public function startMinigameController(param1:PokerConnectionManager, param2:MovieClip, param3:PokerGlobalData, param4:PokerController, param5:LobbyController, param6:TableController, param7:NavController) : void {
         this.pcmConnect = param1;
         this.mainDisp = param2;
         this.pgData = param3;
         this.pControl = param4;
         this.lControl = param5;
         this.tControl = param6;
         this.nControl = param7;
         this._enabledGameTypes[MinigameUtils.HIGHLOW] = this.configModel.isFeatureEnabled("highLow");
         this.initEventlistenersMinigameFramework();
         this.externalInterface.addCallback("onMinigameFriendRequestSentBack",this.onFriendRequestSentBack);
         this.externalInterface.addCallback("onMinigameHighLowAutoOpen",this.onMinigameHighLowAutoOpen);
      }
      
      public function autoOpenGame(param1:String) : void {
         var _loc2_:MinigameViewController = this._controllers[param1];
         if(_loc2_)
         {
            _loc2_.maximizeGame();
         }
      }
      
      public function showGame(param1:Boolean=false) : void {
         var _loc2_:String = null;
         var _loc3_:MinigameViewController = null;
         for (_loc2_ in this._controllers)
         {
            _loc3_ = this._controllers[_loc2_];
            if(_loc3_)
            {
               if(param1)
               {
                  _loc3_.showEnabled = true;
               }
               _loc3_.showGame();
               this._currentGameType = _loc2_;
               return;
            }
         }
      }
      
      public function hideGame(param1:Boolean=false) : void {
         var _loc2_:MinigameViewController = this._controllers[this._currentGameType];
         if(_loc2_)
         {
            if(param1)
            {
               _loc2_.showEnabled = false;
            }
            _loc2_.hideGame();
         }
      }
      
      private function onMinigameHighLowAutoOpen(param1:Object) : void {
         if(!this.pgData.inLobbyRoom)
         {
            this.autoOpenGame(MinigameUtils.HIGHLOW);
         }
      }
      
      private function onFriendRequestSentBack(param1:Object) : void {
         var _loc2_:MinigameViewController = null;
         if(!this.pgData.inLobbyRoom && (this.checkGameAvailability(param1.location.split("_")[0])))
         {
            _loc2_ = this._controllers[param1.location.split("_")[0]];
            _loc2_.onFriendRequestSentBack(param1);
         }
      }
      
      private function initEventlistenersMinigameFramework() : void {
         this.pcmConnect.addEventListener("onMessage",this.onProtocolMessage);
         this.tControl.addEventListener(MGEvent.MG_MAXIMIZE_GAME_BY_TYPE,this.maximizeMinigameScreenByType,false,0,true);
         this.tControl.addEventListener(MGEvent.MG_DESTROY_GAME_BY_TYPE,this.destroyMinigameScreenByType,false,0,true);
         this.pControl.addEventListener(MGEvent.MG_DESTROY_GAME_BY_TYPE,this.destroyMinigameScreenByType,false,0,true);
         this.lControl.addEventListener(MGEvent.MG_DESTROY_GAME_BY_TYPE,this.destroyMinigameScreenByType,false,0,true);
         addEventListener(CommandEvent.TYPE_ATTACH_MINIGAME,this.onAttachMinigame,false,0,true);
      }
      
      private function initiateMinigameScreenByType(param1:String) : void {
         var popupConfig:Popup = null;
         var type:String = param1;
         var basePath:String = this.configModel.getStringForFeatureConfig("core","basePath");
         if(this._controllers[type] == null && (basePath))
         {
            popupConfig = this.pControl.getPopupConfigByID(type);
            LoadManager.load(basePath + popupConfig.moduleSource,{"onComplete":function(param1:LoaderEvent):void
            {
               var _loc2_:* = PokerClassProvider.getClass(popupConfig.moduleClassName);
               var _loc3_:* = param1.data.content.rawContent as _loc2_;
               _loc3_.externalInterface = externalInterface;
               _loc3_.configModel = configModel;
               _loc3_.load(mainDisp,pgData,PokerCommandDispatcher.getInstance(),param1);
               _controllers[type] = _loc3_;
            }});
         }
      }
      
      private function destroyMinigameScreenByType(param1:MGEvent) : void {
         var _loc2_:MinigameViewController = null;
         if(this.checkGameAvailability(param1.params.type))
         {
            _loc2_ = this._controllers[param1.params.type];
            if((_loc2_) && (_loc2_.view))
            {
               this.pControl.removeViewFromLayer(_loc2_.view,PokerControllerLayers.MINIGAME_LAYER);
               _loc2_.destroyGame();
               this._controllers[param1.params.type] = null;
            }
         }
      }
      
      private function maximizeMinigameScreenByType(param1:MGEvent) : void {
         var _loc2_:MinigameViewController = null;
         if(this.checkGameAvailability(param1.params.type))
         {
            _loc2_ = this._controllers[param1.params.type];
            if(_loc2_)
            {
               _loc2_.maximizeGame();
            }
         }
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         switch(_loc2_.type)
         {
            case "RMgfwResponse":
               this.onMinigameFrameworkResponse(_loc2_);
               break;
         }
         
      }
      
      private function onMinigameFrameworkResponse(param1:Object) : void {
         var _loc3_:MinigameViewController = null;
         var _loc2_:RMgfwResponse = RMgfwResponse(param1);
         _loc2_.mgfwPayload.gametype = MinigameUtils.HIGHLOW;
         switch(_loc2_.mgfwPayload.type)
         {
            case "supportedMiniGameTypes":
               this.onTypeAvailabiltyReceived(RSupportedMiniGameTypes(new RSupportedMiniGameTypes(_loc2_.mgfwPayload.value)));
               break;
            case "supportedMiniGameTypesError":
               break;
            default:
               if(this.checkGameAvailability(_loc2_.mgfwPayload.gametype))
               {
                  _loc3_ = this._controllers[_loc2_.mgfwPayload.gametype];
                  if(_loc3_)
                  {
                     _loc3_.onGameMessage(param1);
                  }
               }
         }
         
      }
      
      private function onTypeAvailabiltyReceived(param1:RSupportedMiniGameTypes) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc2_:* = 0;
         while(_loc2_ < param1.gameTypes.length)
         {
            _loc4_ = param1.gameTypes[_loc2_];
            _loc5_ = this._enabledGameTypes[_loc4_];
            if(_loc5_)
            {
               this.initiateMinigameScreenByType(_loc4_);
            }
            _loc2_++;
         }
         for (_loc3_ in this._enabledGameTypes)
         {
            if(param1.gameTypes.indexOf(_loc3_) == -1)
            {
               this._enabledGameTypes[_loc3_] = false;
            }
         }
      }
      
      private function checkGameAvailability(param1:String) : Boolean {
         if(this._enabledGameTypes[param1])
         {
            return true;
         }
         return false;
      }
      
      private function onAttachMinigame(param1:CommandEvent) : void {
         if(param1.params == null)
         {
            return;
         }
         var _loc2_:Object = param1.params;
         this.pControl.attachViewToLayer(_loc2_.view,PokerControllerLayers.MINIGAME_LAYER,true);
      }
   }
}
