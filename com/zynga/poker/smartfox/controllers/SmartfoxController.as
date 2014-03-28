package com.zynga.poker.smartfox.controllers
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.ICommandDispatcher;
   import com.zynga.poker.smartfox.models.SmartfoxModel;
   import it.gotoandplay.smartfoxserver.SmartFoxClient;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import flash.utils.Dictionary;
   import com.zynga.poker.smartfox.messages.SmartfoxRequest;
   import com.zynga.poker.smartfox.messages.SmartfoxResponse;
   import __AS3__.vec.Vector;
   import com.zynga.poker.smartfox.messages.login.SfxLoginRequest;
   import com.zynga.poker.smartfox.events.SmartfoxEvent;
   
   public class SmartfoxController extends EventDispatcher implements ISmartfoxController
   {
      
      public function SmartfoxController() {
         super();
      }
      
      public var pgData:PokerGlobalData;
      
      public var configModel:ConfigModel;
      
      public var registry:IClassRegistry;
      
      public var commandDispatcher:ICommandDispatcher;
      
      private var _smartfoxModel:SmartfoxModel;
      
      private var _sfxClient:SmartFoxClient;
      
      public function init() : void {
         this.initModel();
         this.addListeners();
         this.addInternalCallbacks();
      }
      
      private function initModel() : void {
         this._smartfoxModel = this.registry.getObject(SmartfoxModel) as SmartfoxModel;
         this._smartfoxModel.init();
      }
      
      private function addListeners() : void {
         this._sfxClient.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponse,false,0,true);
         this._sfxClient.addEventListener(SFSEvent.onJoinRoom,this.onJoinRoom,false,0,true);
         this._sfxClient.addEventListener(SFSEvent.onRoomListUpdate,this.onRoomListUpdate,false,0,true);
      }
      
      public function assignSfxClient(param1:SmartFoxClient) : void {
         this._sfxClient = param1;
      }
      
      private function addInternalCallbacks() : void {
         this.registerCallback("logOK",this.onLoginSuccess);
         this.registerCallback("logKO",this.onLoginFailure);
      }
      
      public function registerCallback(param1:String, param2:Function) : void {
         var _loc4_:* = false;
         var _loc5_:Function = null;
         var _loc3_:Dictionary = this._smartfoxModel.registeredCallbacks;
         if(_loc3_[param1] == null)
         {
            _loc3_[param1] = new Vector.<Function>();
            _loc3_[param1].push(param2);
         }
         else
         {
            _loc4_ = false;
            for each (_loc5_ in _loc3_[param1])
            {
               if(_loc5_ === param2)
               {
                  _loc4_ = true;
                  break;
               }
            }
            if(_loc4_ === false)
            {
               _loc3_[param1].push(param2);
            }
         }
      }
      
      public function removeCallback(param1:String, param2:Function) : void {
         var _loc4_:Function = null;
         var _loc3_:Dictionary = this._smartfoxModel.registeredCallbacks;
         if(_loc3_[param1] != null)
         {
            for each (_loc4_ in _loc3_[param1])
            {
               if(_loc4_ === param2)
               {
                  _loc3_[param1].splice(_loc3_[param1].indexOf(_loc4_),1);
                  break;
               }
            }
         }
      }
      
      public function sendRequest(param1:SmartfoxRequest) : void {
         if(this._sfxClient)
         {
            this._sfxClient.sendXtMessage(param1.name,param1.command,param1.toSfxObject(),param1.type);
         }
      }
      
      public function connect(param1:String, param2:int, param3:String) : void {
         this._smartfoxModel.targetZone = param3;
         this._smartfoxModel.ipAddress = param1;
         this._smartfoxModel.port = param2;
         this._smartfoxModel.hasRoomList = false;
         this._sfxClient.httpPollSpeed = SmartfoxModel.DEFAULT_HTTP_POLL_SPEED;
         this._sfxClient.socketTimeout = SmartfoxModel.DEFAULT_SOCKET_TIMEOUT_MS;
         this._sfxClient.addEventListener(SFSEvent.onConnection,this.onConnectionHandler,false,0,true);
         this._sfxClient.connect(param1,param2);
      }
      
      public function reconnect() : void {
         this._smartfoxModel.hasRoomList = false;
         this._sfxClient.connect(this._smartfoxModel.ipAddress,this._smartfoxModel.port);
      }
      
      public function leaveZone() : void {
         this._sfxClient.removeEventListener(SFSEvent.onConnectionLost,this.onConnectionLost);
      }
      
      public function disconnect(param1:Boolean=true) : void {
         this._sfxClient.removeEventListener(SFSEvent.onConnectionLost,this.onConnectionLost);
         this._sfxClient.disconnect(param1);
      }
      
      private function onConnectionHandler(param1:SFSEvent) : void {
         this._sfxClient.removeEventListener(SFSEvent.onConnection,this.onConnectionHandler);
         if(param1.params.success)
         {
            this.login();
         }
      }
      
      private function onExtensionResponse(param1:SFSEvent) : void {
         var _loc2_:SmartfoxResponse = new SmartfoxResponse(param1.params);
         if(this._smartfoxModel.hasRoomList)
         {
            this.processBacklog();
            this.processSmartfoxResponse(_loc2_);
         }
         else
         {
            this._smartfoxModel.responseBacklog.push(_loc2_);
         }
      }
      
      private function processSmartfoxResponse(param1:SmartfoxResponse) : void {
         var _loc3_:Function = null;
         var _loc2_:Vector.<Function> = this._smartfoxModel.registeredCallbacks[param1.command];
         if(_loc2_)
         {
            for each (_loc3_ in _loc2_)
            {
               _loc3_(param1);
            }
         }
      }
      
      private function processBacklog() : void {
         while(this._smartfoxModel.responseBacklog.length > 0)
         {
            this.processSmartfoxResponse(this._smartfoxModel.responseBacklog.shift());
         }
      }
      
      private function onJoinRoom(param1:SFSEvent) : void {
      }
      
      private function onRoomListUpdate(param1:SFSEvent) : void {
         if(this._smartfoxModel.hasRoomList == false)
         {
            this._smartfoxModel.hasRoomList = true;
            this.processBacklog();
         }
      }
      
      public function loginToZone(param1:String) : void {
         this._sfxClient.addEventListener(SFSEvent.onConnectionLost,this.onConnectionLost,false,0,true);
         this._smartfoxModel.hasRoomList = false;
         this._sfxClient.logout();
         this._smartfoxModel.targetZone = param1;
         this.login();
      }
      
      private function login() : void {
         var _loc1_:SfxLoginRequest = new SfxLoginRequest(this._smartfoxModel.targetZone);
         var _loc2_:Object = this.configModel.getFeatureConfig("user");
         if(_loc2_)
         {
            if(_loc2_.pw)
            {
               _loc1_.password = _loc2_.pw;
            }
            if(_loc2_.pic_url)
            {
               _loc1_.picUrl = _loc2_.pic_url;
            }
            if(_loc2_.pic_lrg_url)
            {
               _loc1_.picLrgUrl = _loc2_.pic_lrg_url;
            }
            if(_loc2_.userLocale)
            {
               _loc1_.locale = _loc2_.userLocale;
            }
            if(_loc2_.newUserPopup > 0)
            {
               _loc1_.newUserInstall = 1;
            }
            if(_loc2_.clientId)
            {
               _loc1_.clientId = _loc2_.clientId;
            }
            if(_loc2_.uid)
            {
               _loc1_.userId = _loc2_.uid;
               _loc1_.snId = Number(_loc2_.uid.split(":")[0]);
            }
         }
         _loc1_.tourneyState = String(this.pgData.tourneyState);
         _loc1_.protoVersion = this.pgData.protoVersion;
         _loc1_.hideGifts = this.pgData.nHideGifts;
         _loc1_.pgViewAndDisplay = this.pgData.pgViewAndDisplay;
         _loc1_.emailSubscribed = this.pgData.emailSubscribed?1:0;
         _loc1_.phpToSfxVars = this.pgData.smartfoxVars;
         _loc1_.buildVersion = this.pgData.buildVersion;
         _loc1_.unreachableProtect = this.pgData.clientSupportsUnreachableProtection;
         _loc1_.pgBuyAndSend = this.configModel.getIntForFeatureConfig("gift","pgBuyAndSend",1);
         this._sfxClient.login(_loc1_.name,_loc1_.toJsonEscapedString(),_loc1_.password);
      }
      
      private function onLoginSuccess(param1:SmartfoxResponse) : void {
      }
      
      private function onLoginFailure(param1:SmartfoxResponse) : void {
      }
      
      public function onConnectionLost(param1:SFSEvent) : void {
         dispatchEvent(new SmartfoxEvent(SmartfoxEvent.SMARTFOX_DISCONNECTED));
      }
   }
}
