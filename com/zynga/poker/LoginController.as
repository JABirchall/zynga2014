package com.zynga.poker
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.io.SmartfoxConnectionManager;
   import com.zynga.poker.events.SFLoginEvent;
   import flash.events.Event;
   import com.zynga.io.SmartfoxConnectionEvent;
   import com.zynga.poker.protocol.SSuperLogin;
   
   public class LoginController extends FeatureController
   {
      
      public function LoginController() {
         super();
      }
      
      private const CONN_PORT:int = 9339;
      
      public var lcmConnect:LoginConnectionManager;
      
      public var sHost:String;
      
      public var nPort:int;
      
      public var flashVars:Object;
      
      public var pokerLoader:IPokerLoader;
      
      public var loadBalance:LoadBalancer;
      
      public var nRetryLB:int = 0;
      
      private var nRetryLimitLB:int = 2;
      
      public var nRetrySF:int = 0;
      
      public var nRetryLimitSF:int = 3;
      
      private var nRetries:int;
      
      override protected function initModel() : FeatureModel {
         this.sHost = this.flashVars.ip;
         this.nPort = this.CONN_PORT;
         pgData.loadConfigData();
         pgData.assignFlashVars(this.flashVars);
         this.nRetries = pgData.nRetries;
         this.lcmConnect = new LoginConnectionManager(pgData.trace_stats,pgData);
         this.loadBalance = new LoadBalancer(pgData);
         this.loadBalance.configModel = configModel;
         return null;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override protected function postInit() : void {
         if(this.pokerLoader.debugMode)
         {
            this.lcmConnect.connect(this.sHost,[String(this.nPort)]);
         }
         else
         {
            this.loadBalance.chooseBestServer();
         }
      }
      
      override public function addListeners() : void {
         this.lcmConnect.addEventListener(SmartfoxConnectionManager.CONNECTED,this.onConnectionHandler);
         this.lcmConnect.addEventListener(SmartfoxConnectionManager.CONNECT_FAILED,this.onConnectFailed);
         this.lcmConnect.addEventListener(LoginConnectionManager.LOGIN_FAILED,this.onLoginFailed);
         this.lcmConnect.addEventListener(LoginConnectionManager.LOBBYJOIN_COMPLETE,this.onLobbyJoinComplete);
         this.lcmConnect.addEventListener(SFLoginEvent.SF_LOGIN_FAILED,this.onSFLoginFailed);
         this.loadBalance.addEventListener(LBEvent.onServerChosen,this.onServerChosen);
         this.loadBalance.addEventListener(LBEvent.serverStatusError,this.onLoadBalanceError);
         this.loadBalance.addEventListener(LBEvent.serverListError,this.onLoadBalanceError);
         this.loadBalance.addEventListener(LBEvent.findServerError,this.onLoadBalanceError);
      }
      
      override public function removeListeners() : void {
         this.lcmConnect.removeEventListener(SmartfoxConnectionManager.CONNECTED,this.onConnectionHandler);
         this.lcmConnect.removeEventListener(SmartfoxConnectionManager.CONNECT_FAILED,this.onConnectFailed);
         this.lcmConnect.removeEventListener(LoginConnectionManager.LOGIN_FAILED,this.onLoginFailed);
         this.lcmConnect.removeEventListener(LoginConnectionManager.LOBBYJOIN_COMPLETE,this.onLobbyJoinComplete);
         this.lcmConnect.removeEventListener(SFLoginEvent.SF_LOGIN_FAILED,this.onSFLoginFailed);
         this.loadBalance.removeEventListener(LBEvent.onServerChosen,this.onServerChosen);
         this.loadBalance.removeEventListener(LBEvent.serverStatusError,this.onLoadBalanceError);
         this.loadBalance.removeEventListener(LBEvent.serverListError,this.onLoadBalanceError);
         this.loadBalance.removeEventListener(LBEvent.findServerError,this.onLoadBalanceError);
      }
      
      private function onServerChosen(param1:Event) : void {
         this.nRetryLB = 0;
         var _loc2_:Array = pgData.ip.split(":");
         var _loc3_:Array = this.loadBalance.getPortOrder(pgData.serverId);
         var _loc4_:String = pgData.ip;
         if(_loc2_.length > 1)
         {
            _loc4_ = _loc2_[0];
            if(_loc3_.length == 0)
            {
               _loc3_ = [_loc2_[1]];
            }
         }
         this.lcmConnect.connect(_loc4_,_loc3_,pgData.lastKnownGoodPort,pgData.serverId,this.loadBalance.getConnectionTimeout(pgData.serverId),this.loadBalance.getPollRate(pgData.serverId));
         var _loc5_:* = "Connecting";
         this.pokerLoader.setConnectionText(_loc5_);
      }
      
      private function onLoadBalanceError(param1:Event) : void {
         if(pgData.trace_stats == 1 && this.nRetryLB == 0)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LBError:" + param1.type + "_" + this.nRetries + ":2009-04-20","",1,"",PokerStatHit.HITTYPE_FG));
         }
         if(this.nRetryLB < this.nRetryLimitLB)
         {
            this.loadBalance.chooseBestServer();
         }
         else
         {
            this.pokerLoader.loadBalanceError(param1.type);
         }
         this.nRetryLB++;
      }
      
      private function onConnectFailed(param1:SmartfoxConnectionEvent) : void {
         pgData.lastKnownGoodPort = "";
         if(this.nRetrySF < this.nRetryLimitSF)
         {
            this.pokerLoader.setConnectionText("Retrying connection.");
            this.loadBalance.addConnFail(Number(pgData.serverId));
            this.loadBalance.chooseBestServer();
         }
         else
         {
            this.pokerLoader.setConnectionText("Connection failed.");
            this.pokerLoader.connectionFailed();
         }
         this.nRetrySF++;
      }
      
      private function onConnectionHandler(param1:SmartfoxConnectionEvent) : void {
         var _loc2_:* = "Connected.";
         this.pokerLoader.setConnectionText(_loc2_);
         var _loc3_:* = "";
         var _loc4_:* = "";
         var _loc5_:* = "";
         var _loc6_:* = "";
         var _loc7_:* = "";
         var _loc8_:* = "";
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         var _loc11_:* = -1;
         var _loc12_:Object = configModel.getFeatureConfig("user");
         if(_loc12_)
         {
            if(_loc12_.pw)
            {
               _loc4_ = _loc12_.pw;
            }
            if(_loc12_.pic_url)
            {
               _loc5_ = _loc12_.pic_url;
            }
            if(_loc12_.pic_lrg_url)
            {
               _loc6_ = _loc12_.pic_lrg_url;
            }
            if(_loc12_.userLocale)
            {
               _loc7_ = _loc12_.userLocale;
            }
            if(_loc12_.newUserPopup > 0)
            {
               _loc10_ = 1;
            }
            if(_loc12_.clientId)
            {
               _loc11_ = _loc12_.clientId;
            }
            if(_loc12_.uid)
            {
               _loc8_ = _loc12_.uid;
               _loc9_ = Number(_loc8_.split(":")[0]);
            }
         }
         pgData.lastKnownGoodPort = param1.port;
         var _loc13_:int = configModel.getIntForFeatureConfig("table","tourneyId",-1);
         if(_loc13_ > -1)
         {
            _loc8_ = _loc8_ + (":" + _loc13_);
         }
         var _loc14_:SSuperLogin = new SSuperLogin(_loc8_,_loc5_,_loc6_,_loc9_,String(pgData.tourneyState),pgData.protoVersion,0,String("flash"),_loc11_,1,1,1,_loc4_,configModel.getStringForFeatureConfig("core","sZone","TexasHoldemUp"),_loc7_,pgData.nHideGifts,configModel.getIntForFeatureConfig("gift","pgBuyAndSend",1),pgData.pgViewAndDisplay,_loc10_,pgData.emailSubscribed?1:0,pgData.smartfoxVars,pgData.buildVersion,pgData.clientSupportsUnreachableProtection);
         this.lcmConnect.login(_loc14_);
      }
      
      private function onLoginFailed(param1:Event) : void {
         this.pokerLoader.loginFailed();
      }
      
      private function onSFLoginFailed(param1:SFLoginEvent) : void {
         this.pokerLoader.loginSFFailed(param1.message);
      }
      
      private function onLobbyJoinComplete(param1:Event) : void {
         var _loc2_:* = "Logged in.";
         this.pokerLoader.setConnectionText(_loc2_);
         this.pokerLoader.bLobbyJoinComplete = true;
         if(this.pokerLoader.bLobbyAssetsLoaded)
         {
            this.pokerLoader.startPokerController();
         }
      }
   }
}
