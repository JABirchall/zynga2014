package com.zynga.poker.zoom
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.UserPresence;
   import flash.net.Socket;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.zynga.poker.zoom.handlers.IZoomMessageHandler;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.zoom.messages.*;
   import flash.events.Event;
   import flash.system.Security;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.utils.ByteArray;
   
   public class ZshimController extends EventDispatcher
   {
      
      public function ZshimController(param1:ZshimController_SingletonLockingClass) {
         this.msgQ = new Array();
         this.commandBuffer = new Array();
         super();
         if((mSingletonInst) || param1 == null)
         {
            throw new Error("ZshimController class cannot be instantiated");
         }
         else
         {
            mSingletonInst = this;
            return;
         }
      }
      
      public static const ZOOM_UPDATE:String = "zoom_update";
      
      public static const ZOOM_ADD_FRIEND:String = "zoom_add_friend";
      
      public static const ZOOM_REMOVE_FRIEND:String = "zoom_remove_friend";
      
      public static const ZOOM_ADD_NETWORK:String = "zoom_add_network";
      
      public static const ZOOM_REMOVE_NETWORK:String = "zoom_remove_network";
      
      public static const ZOOM_SOCKET_CONNECT:String = "zoom_socket_connect";
      
      public static const ZOOM_SOCKET_CLOSE:String = "zoom_socket_close";
      
      public static const ZOOM_SOCKET_ERROR:String = "zoom_socket_error";
      
      public static const ZOOM_TABLE_INVITATION:String = "zoom_table_invitation";
      
      public static const ZOOM_PROFILE_REQUEST:String = "zoom_profile_request";
      
      public static const ZOOM_TOOLBAR_INVITATION:String = "zoom_toolbar_invitation";
      
      public static const ZOOM_TOOLBAR_JOIN:String = "zoom_toolbar_join";
      
      public static const ZOOM_TOOLBAR_GAMESWFLOADEDCALLBACK:String = "zoom_toolbar_gameswfloadedcallback";
      
      public static const ZOOM_TOOLBAR_PLAYERSTATUS:String = "zoom_toolbar_playerstatus";
      
      public static const ZOOM_TOOLBAR_INVITATIONREMOVE:String = "zoom_toolbar_invitationremove";
      
      public static const ZOOM_SHOUT:String = "zoom_shout";
      
      public static const ZOOM_LEADERBOARD_UPDATE:String = "updateLeaderBoard";
      
      public static const ZOOM_SCORECARD_UPDATE:String = "updateScoreCard";
      
      public static const ZOOM_PLAYERSCLUB_VIPUPDATE:String = "PlayersClubVIPPointsUpdate";
      
      public static const ZOOM_PLAYERSCLUB_BIGHANDREWARD:String = "PlayersClubBigHandReward";
      
      public static const ZOOM_PLAYERSCLUB_POSTPURCHASEREWARD:String = "PlayersClubPostPurchaseReward";
      
      public static const ZOOM_PLAYERSCLUB_APPENTRYREWARD:String = "PlayersClubAppEntryReward";
      
      public static const ZOOM_INITIATE_MINIGAMES:String = "initiateMinigames";
      
      public static const ZOOM_XPBOOST_WITH_PURCHASE:String = "XPBoostWithPurchase";
      
      public static const ZOOM_FORCE_CHIP_UPDATE:String = "forceChipUpdate";
      
      private static var mSingletonInst:ZshimController = null;
      
      public static function getInstance(param1:String, param2:int, param3:String, param4:UserPresence, param5:Boolean=false) : ZshimController {
         var _loc6_:ZshimController = null;
         if(param4 == null)
         {
            throw new Error("ZshimController.getInstance: invalid UserPresence");
         }
         else
         {
            if(!mSingletonInst)
            {
               _loc6_ = new ZshimController(new ZshimController_SingletonLockingClass());
            }
            mSingletonInst.bind(param1,param2,param3,param4,param5);
            return mSingletonInst;
         }
      }
      
      private var socket:Socket = null;
      
      private var connected:Boolean = false;
      
      private var hasConnected:Boolean = false;
      
      private var isConnecting:Boolean = false;
      
      private var reconnectAttemptsMax:Number = 5;
      
      private var reconnectAttempts:Number = 0;
      
      private var reconnectTimer:Timer = null;
      
      private var host:String = "";
      
      private var port:Number = -1;
      
      private var password:String = "";
      
      private var doReconnect:Boolean = false;
      
      private var hidePresence:Boolean = false;
      
      private var heartbeatTimer:Timer;
      
      private var heartbeatDelay:Number = 10;
      
      private var user:UserPresence = null;
      
      private var msgQ:Array;
      
      private var inBuffer:String = "";
      
      private var commandBuffer:Array;
      
      private var _handlers:Array;
      
      private function bind(param1:String, param2:int, param3:String, param4:UserPresence, param5:Boolean=false) : void {
         if(!(this.host == param1) || !(this.port == param2) || !(param3 == param3))
         {
            this.doReconnect = true;
            this.host = param1;
            this.port = param2;
            this.password = param3;
         }
         this.hidePresence = param5;
         if(this.user == null)
         {
            this.user = param4;
         }
         else
         {
            this.updateGameInfo(param4.nServerId,param4.nRoomId,param4.sRoomDesc,param4.tableStakes,param4.nChipStack,param4.nLevel);
         }
      }
      
      public function isConnected() : Boolean {
         return this.connected;
      }
      
      public function startHeartbeatTimer() : void {
         if(this.heartbeatTimer == null)
         {
            this.heartbeatTimer = new Timer(Math.round(this.heartbeatDelay * 60 * 1000));
            this.heartbeatTimer.addEventListener(TimerEvent.TIMER,this.onHeartbeatTimer);
         }
         this.heartbeatTimer.reset();
         this.heartbeatTimer.start();
      }
      
      public function stopHeartbeatTimer() : void {
         if(this.heartbeatTimer)
         {
            this.heartbeatTimer.reset();
         }
      }
      
      private function onHeartbeatTimer(param1:TimerEvent) : void {
         this.sendHeartbeat();
      }
      
      public function sendHeartbeat() : void {
         this.sendMsg("4 ping");
      }
      
      public function sendStatRequest(param1:String, param2:String, param3:Number=1, param4:String="server") : Boolean {
         var _loc5_:String = null;
         if((param1) && (param4) && (param2) && param3 > 0)
         {
            _loc5_ = "4 stat " + param1 + " " + param4 + " " + escape(param2) + ":" + param3;
            return this.sendMsg(_loc5_,false);
         }
         return false;
      }
      
      public function sendTableInvitation(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 ochat to:" + param1 + " msg:tableInvitation");
         }
      }
      
      public function sendProfileReq(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 ochat to:" + param1 + " msg:profileReq");
         }
      }
      
      public function sendProfileURL(param1:String, param2:String) : void {
         if(param2)
         {
            this.sendMsg("4 ochat to:" + param2 + " msg:" + encodeURIComponent("profileURL " + param1));
         }
      }
      
      public function sendToolbarInvitation(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 ochat to:" + param1 + " msg:toolbarInvitation");
         }
      }
      
      public function sendToolbarJoin(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 ochat to:" + this.user.sZid + " msg:" + encodeURIComponent("toolbarJoin " + param1));
         }
      }
      
      public function sendGameSwfLoadedResponse() : void {
         this.sendMsg("4 ochat to:" + this.user.sZid + " msg:gameSwfLoadedCallback");
      }
      
      public function sendToolbarPlayerStatus(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 hide " + param1);
         }
      }
      
      public function sendToolbarInvitationRemove(param1:String) : void {
         if(param1)
         {
            this.sendMsg("4 ochat to:" + this.user.sZid + " msg:" + encodeURIComponent("toolbarInvitationRemove " + param1));
         }
      }
      
      public function updateGameInfo(param1:Number, param2:Number, param3:String, param4:String="", param5:Number=-1, param6:Number=-1) : void {
         if(this.user.nServerId == param1 && this.user.nRoomId == param2 && this.user.tableStakes == param4 && param5 == -1 && param6 == -1)
         {
            return;
         }
         this.user.nServerId = param1;
         this.user.nRoomId = param2;
         this.user.sRoomDesc = param3;
         this.user.tableStakes = param4;
         var _loc7_:String = String(this.user.nServerId);
         _loc7_ = _loc7_ + (" " + this.user.nRoomId);
         _loc7_ = _loc7_ + (" " + this.user.sRoomDesc);
         _loc7_ = _loc7_ + (param4 != ""?" " + param4:" 0");
         _loc7_ = _loc7_ + (" " + param5);
         _loc7_ = _loc7_ + (" " + param6);
         this.sendMsg("4 update scope:both msg:gameInfo:" + encodeURIComponent(_loc7_) + " gid:" + this.user.nGameId);
      }
      
      public function registerMessageHandler(param1:IZoomMessageHandler) : void {
         if(!this._handlers)
         {
            this._handlers = [];
            ListenerManager.addEventListener(this,ZshimController.ZOOM_UPDATE,this.onZoomUpdate,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_ADD_FRIEND,this.onZoomAddFriend,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_REMOVE_FRIEND,this.onZoomRemoveFriend,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_SOCKET_CLOSE,this.onZoomSocketClose,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_SHOUT,this.onZoomShout,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_TABLE_INVITATION,this.onZoomTableInvitation,0,"zoomListeners");
            ListenerManager.addEventListener(this,ZshimController.ZOOM_LEADERBOARD_UPDATE,this.onLeaderboardGetUpdate,0,"zoomListeners");
         }
         if(this._handlers.indexOf(param1) == -1)
         {
            this._handlers.push(param1);
         }
      }
      
      public function unregisterMessageHandler(param1:IZoomMessageHandler) : void {
         var _loc2_:* = 0;
         if((this._handlers) && (param1))
         {
            _loc2_ = this._handlers.indexOf(param1);
            if(_loc2_ != -1)
            {
               this._handlers = this._handlers.splice(_loc2_,1);
            }
         }
      }
      
      private function broadcastMessage(param1:String, param2:*) : void {
         var handler:IZoomMessageHandler = null;
         var functionName:String = param1;
         var args:* = param2;
         if(this._handlers)
         {
            for each (handler in this._handlers)
            {
               try
               {
                  handler[functionName](args);
               }
               catch(error:Error)
               {
                  continue;
               }
            }
         }
      }
      
      private function onZoomUpdate(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomUpdate",param1);
      }
      
      private function onZoomAddFriend(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomAddFriend",param1);
      }
      
      private function onZoomRemoveFriend(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomRemoveFriend",param1);
      }
      
      private function onZoomShout(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomShout",param1);
      }
      
      private function onZoomTableInvitation(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomTableInvitation",param1);
      }
      
      private function onZoomToolbarJoin(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomToolbarJoin",param1);
      }
      
      private function onZoomSocketClose(param1:ZshimEvent) : void {
         this.broadcastMessage("onZoomSocketClose",param1);
      }
      
      private function onLeaderboardGetUpdate(param1:ZshimEvent) : void {
         this.broadcastMessage("onLeaderboardGetUpdate",param1);
      }
      
      private function getSessionCommand() : String {
         var _loc2_:Array = null;
         var _loc1_:Array = new Array("4","session");
         _loc1_.push("uid:" + this.user.sZid);
         _loc1_.push("gid:" + this.user.nGameId);
         if(this.user.sFriendIds)
         {
            _loc1_.push("friends:" + this.user.sFriendIds);
         }
         if((this.user.sFirstName) || (this.user.sLastName))
         {
            _loc1_.push("name:" + encodeURIComponent((this.user.sFirstName?this.user.sFirstName:"n/a") + " " + (this.user.sLastName?this.user.sLastName:"n/a")));
         }
         if(this.user.sPicURL)
         {
            _loc1_.push("image:" + encodeURIComponent(this.user.sPicURL));
         }
         _loc1_.push("gameInfo:" + encodeURIComponent(this.user.nServerId + " " + this.user.nRoomId + " " + this.user.sRoomDesc + " " + this.user.tableStakes));
         if(this.password)
         {
            _loc2_ = this.password.split(":");
            if(_loc2_.length == 2)
            {
               _loc1_.push("SKEY:" + _loc2_[0]);
               _loc1_.push("timestamp:" + _loc2_[1]);
            }
         }
         _loc1_.push("notif:1");
         if(this.hidePresence)
         {
            _loc1_.push("hide:1");
         }
         return _loc1_.join(" ");
      }
      
      private function reconnect() : void {
         if(this.reconnectTimer == null || !this.reconnectTimer.running)
         {
            if(this.reconnectTimer == null)
            {
               this.reconnectTimer = new Timer(5000,1);
            }
            this.reconnectTimer.addEventListener(TimerEvent.TIMER,this.onReconnectTimer);
            this.reconnectTimer.start();
         }
      }
      
      private function onReconnectTimer(param1:Event) : void {
         this.reconnectTimer.stop();
         this.reconnectTimer.removeEventListener(TimerEvent.TIMER,this.onReconnectTimer);
         if(++this.reconnectAttempts <= this.reconnectAttemptsMax)
         {
            if(!(this.socket == null) && (this.socket.connected))
            {
               this.socket.close();
            }
            this.connect();
         }
      }
      
      public function connect(param1:Number=10) : void {
         var heartbeatDelay:Number = param1;
         this.heartbeatDelay = heartbeatDelay;
         if(this.host == null || this.port == -1)
         {
            return;
         }
         if((this.doReconnect) && !(this.socket == null))
         {
            this.socket.close();
         }
         this.doReconnect = false;
         if(this.socket == null || !this.socket.connected)
         {
            Security.loadPolicyFile("xmlsocket://" + this.host + ":843");
            this.msgQ.splice(0,0,this.getSessionCommand());
            this.isConnecting = true;
            try
            {
               this.socket = new Socket(this.host,this.port);
               this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketIOError);
               this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
               this.socket.addEventListener(Event.CONNECT,this.onSocketConnect);
               this.socket.addEventListener(Event.CLOSE,this.onSocketClose);
               this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      public function disconnect() : void {
         this.sendMsg("quit");
      }
      
      private function sendMsg(param1:String, param2:Boolean=true) : Boolean {
         this.msgQ.push(param1);
         var _loc3_:* = false;
         if(this.connected)
         {
            _loc3_ = this.processMsg();
            if(param1.indexOf("heartbeat") < 0)
            {
               this.startHeartbeatTimer();
            }
         }
         else
         {
            if(!this.isConnecting && (param2))
            {
               this.reconnect();
            }
         }
         if(!_loc3_ && !param2)
         {
            this.msgQ.shift();
         }
         return _loc3_;
      }
      
      private function consolidateCommands() : void {
         var _loc3_:String = null;
         var _loc5_:Array = null;
         var _loc1_:* = false;
         var _loc2_:* = "";
         var _loc4_:Array = new Array();
         while(this.msgQ.length > 0)
         {
            _loc3_ = this.msgQ.shift();
            _loc5_ = _loc3_.split(" ");
            if(_loc5_.length > 1)
            {
               switch(_loc5_[1])
               {
                  case "session":
                     _loc1_ = true;
                     continue;
                  case "update":
                     _loc2_ = _loc3_;
                     continue;
               }
               
            }
            _loc4_.push(_loc3_);
         }
         if(_loc2_.length > 0)
         {
            _loc4_.unshift(_loc2_);
         }
         if(_loc1_)
         {
            _loc4_.unshift(this.getSessionCommand());
         }
         this.msgQ = _loc4_;
      }
      
      private function processMsg() : Boolean {
         var _loc1_:String = null;
         this.consolidateCommands();
         while(this.msgQ.length > 0)
         {
            _loc1_ = this.msgQ.shift();
            this.socket.writeUTFBytes(_loc1_);
            this.socket.writeByte(0);
            this.socket.flush();
         }
         return true;
      }
      
      private function onSocketSecurityError(param1:SecurityErrorEvent) : void {
         var event:SecurityErrorEvent = param1;
         this.connected = false;
         this.isConnecting = false;
         dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SOCKET_ERROR,null));
         try
         {
            PokerStatsManager.DoHitForStat(this.hasConnected?new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_ALWAYS,"Zoom Other Unknown o:ZoomConnectionFailureSecurity:PostInit:2010-07-07",null,1,""):new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_ALWAYS,"Zoom Other Unknown o:ZoomConnectionFailureSecurity:Init:2010-07-07",null,1,""));
         }
         catch(error:TypeError)
         {
         }
         this.stopHeartbeatTimer();
      }
      
      private function onSocketIOError(param1:IOErrorEvent) : void {
         var event:IOErrorEvent = param1;
         this.connected = false;
         this.isConnecting = false;
         dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SOCKET_ERROR,null));
         try
         {
            PokerStatsManager.DoHitForStat(this.hasConnected?new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_ALWAYS,"Zoom Other Unknown o:ZoomConnectionFailureIO:PostInit:2010-07-07",null,1,""):new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_ALWAYS,"Zoom Other Unknown o:ZoomConnectionFailureIO:Init:2010-07-07",null,1,""));
         }
         catch(error:TypeError)
         {
         }
         this.stopHeartbeatTimer();
      }
      
      private function onSocketConnect(param1:Event) : void {
         var event:Event = param1;
         this.connected = true;
         this.hasConnected = true;
         this.isConnecting = false;
         this.processMsg();
         dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SOCKET_CONNECT,null));
         try
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_THROTTLED,"Zoom Other Unknown o:ZoomConnectionSuccess:Init:2010-07-07","",1,""));
         }
         catch(error:TypeError)
         {
         }
         this.startHeartbeatTimer();
      }
      
      private function onSocketClose(param1:Event) : void {
         var event:Event = param1;
         this.connected = false;
         this.isConnecting = false;
         dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SOCKET_CLOSE,null));
         try
         {
            PokerStatsManager.DoHitForStat(this.hasConnected?new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_THROTTLED,"Zoom Other Unknown o:ZoomConnectionClosed:PostInit:2010-07-07",null,1,""):new PokerStatHit("",12,11,2010,PokerStatHit.TRACKHIT_THROTTLED,"Zoom Other Unknown o:ZoomConnectionClosed:Init:2010-07-07",null,1,""));
         }
         catch(error:TypeError)
         {
         }
         this.stopHeartbeatTimer();
      }
      
      private function getUserPresence(param1:String, param2:Number, param3:String, param4:String, param5:String) : UserPresence {
         var _loc16_:Array = null;
         var _loc6_:Number = -1;
         var _loc7_:Number = -1;
         var _loc8_:* = "Lobby";
         var _loc9_:Array = decodeURIComponent(param3).split(" ");
         var _loc10_:* = "";
         var _loc11_:Number = -1;
         var _loc12_:* = -1;
         if(_loc9_.length >= 3)
         {
            if(param3.indexOf(":",0) != -1)
            {
               _loc16_ = _loc9_[0].split(":");
               _loc6_ = _loc9_[0] == "n/a"?-1:_loc16_[1];
            }
            else
            {
               _loc6_ = _loc9_[0] == "n/a"?-1:_loc9_[0];
            }
            _loc7_ = _loc9_[1] == "n/a"?-1:_loc9_[1];
            _loc8_ = _loc9_[2] == "n/a"?"Lobby":_loc9_[2];
            if(_loc9_[3] != null)
            {
               _loc10_ = _loc9_[3];
            }
            if(_loc9_.length == 6)
            {
               if(_loc9_[4] != null)
               {
                  _loc11_ = Number(_loc9_[4]);
               }
               if(_loc9_[5] != null)
               {
                  _loc12_ = Number(_loc9_[5]);
               }
            }
         }
         var _loc13_:Array = decodeURIComponent(param4).split(" ");
         var _loc14_:String = param4;
         var _loc15_:* = "";
         if(_loc13_.length >= 2)
         {
            _loc14_ = _loc13_[0] == "n/a"?"":_loc13_[0];
            _loc15_ = _loc13_[1] == "n/a"?"":_loc13_[1];
         }
         return new UserPresence(param1,param2,_loc6_,_loc7_,_loc8_,_loc14_,_loc15_,"",param5,"",_loc10_,_loc11_,_loc12_);
      }
      
      private function onSocketData(param1:ProgressEvent) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.socket.readBytes(_loc2_,0,this.socket.bytesAvailable);
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != 0)
            {
               this.inBuffer = this.inBuffer + String.fromCharCode(_loc2_[_loc3_]);
            }
            else
            {
               this.commandBuffer.push(this.inBuffer);
               this.inBuffer = "";
            }
            _loc3_++;
         }
         this.processCommand();
      }
      
      private function processCommand() : void {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:UserPresence = null;
         var _loc5_:Array = null;
         var _loc6_:* = 0;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:* = 0;
         var _loc11_:Array = null;
         var _loc12_:UserPresence = null;
         var _loc13_:Array = null;
         var _loc14_:UserPresence = null;
         var _loc15_:String = null;
         var _loc16_:Array = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:Object = null;
         var _loc20_:String = null;
         var _loc21_:Object = null;
         var _loc22_:String = null;
         var _loc23_:Object = null;
         var _loc24_:Object = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         while(this.commandBuffer.length > 0)
         {
            _loc1_ = this.commandBuffer.shift();
            _loc2_ = _loc1_.split(" ");
            _loc3_ = _loc2_[0];
            switch(_loc3_)
            {
               case "pres":
                  if(_loc2_[3] == "on")
                  {
                     _loc4_ = this.getUserPresence(_loc2_[1],_loc2_[2],_loc2_[6],_loc2_[4],_loc2_[5]);
                     dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_FRIEND,_loc4_));
                  }
                  else
                  {
                     _loc4_ = this.getUserPresence(_loc2_[1],this.user.nGameId,"","","");
                     dispatchEvent(new ZshimEvent(ZshimController.ZOOM_REMOVE_FRIEND,_loc4_));
                  }
                  continue;
               case "groupIdList":
                  _loc5_ = _loc2_[2].split(":::");
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_.length)
                  {
                     _loc7_ = _loc5_[_loc6_].split("::");
                     _loc8_ = _loc7_[0];
                     _loc9_ = _loc7_[1].split(",");
                     _loc10_ = 0;
                     while(_loc10_ < _loc9_.length)
                     {
                        _loc11_ = _loc9_[_loc10_].split("&");
                        _loc12_ = this.getUserPresence(_loc11_[0],this.user.nGameId,_loc11_[3],_loc11_[1],_loc11_[2]);
                        if(this.user.sZid != _loc12_.sZid)
                        {
                           dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_NETWORK,_loc12_));
                        }
                        _loc10_++;
                     }
                     _loc6_++;
                  }
                  continue;
               case "presLogon":
                  _loc13_ = decodeURIComponent(_loc2_[3]).split("&");
                  _loc14_ = this.getUserPresence(_loc2_[1],this.user.nGameId,_loc13_[2],_loc13_[0],_loc13_[1]);
                  dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_NETWORK,_loc14_));
                  continue;
               case "presLogoff":
                  dispatchEvent(new ZshimEvent(ZshimController.ZOOM_REMOVE_NETWORK,this.getUserPresence(_loc2_[1],this.user.nGameId,"","","")));
                  continue;
               case "updateNotify":
                  dispatchEvent(new ZshimEvent(ZshimController.ZOOM_UPDATE,this.getUserPresence(_loc2_[1],this.user.nGameId,_loc2_[2],"","")));
                  continue;
               case "ichat":
                  _loc15_ = decodeURIComponent(_loc2_[3]);
                  _loc16_ = _loc15_.split(" ");
                  _loc17_ = _loc16_[0];
                  switch(_loc17_)
                  {
                     case "tableInvitation":
                        _loc18_ = String(_loc2_[2]);
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TABLE_INVITATION,new ZoomTableInvitationMessage(_loc18_)));
                        break;
                     case "profileReq":
                        _loc18_ = String(_loc2_[2]);
                        _loc19_ = new Object();
                        _loc19_.uid = _loc18_;
                        dispatchEvent(new ZshimEvent(ZshimEvent.ZOOM_PROFILE_REQUEST,_loc19_));
                        break;
                     case "profileURL":
                        _loc18_ = String(_loc2_[2]);
                        _loc20_ = String(_loc16_[1]);
                        dispatchEvent(new ZoomProfileURLMessage(ZshimEvent.ZOOM_PROFILE_MESSAGE,_loc18_,_loc20_));
                        break;
                     case "toolbarInvitation":
                        _loc18_ = String(_loc2_[2]);
                        _loc21_ = new Object();
                        _loc21_.uid = _loc18_;
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TOOLBAR_INVITATION,_loc21_));
                        break;
                     case "toolbarJoin":
                        _loc18_ = String(_loc2_[2]);
                        _loc22_ = String(_loc16_[1]);
                        _loc23_ = new Object();
                        _loc23_.uid = _loc22_;
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TOOLBAR_JOIN,_loc23_));
                        break;
                     case "gameSwfLoadedCallback":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TOOLBAR_GAMESWFLOADEDCALLBACK));
                        break;
                     case "toolbarInvitationRemove":
                        _loc18_ = String(_loc2_[2]);
                        _loc24_ = new Object();
                        _loc24_.uid = String(_loc16_[1]);
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TOOLBAR_INVITATIONREMOVE,_loc24_));
                        break;
                     case "updateLeaderBoard":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_LEADERBOARD_UPDATE));
                        break;
                     case "updateScoreCard":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SCORECARD_UPDATE));
                        break;
                     case "zoomShout":
                        _loc25_ = String(_loc2_[2]);
                        if(_loc25_ == "1" || _loc25_ == "1:1" || _loc25_ == this.user.sZid)
                        {
                           dispatchEvent(new ZshimEvent(ZshimController.ZOOM_SHOUT,String(_loc2_[4])));
                           PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Zoom Other Unknown o:ZoomShoutReceived:2012-07-24",null,1,""));
                        }
                        break;
                     case "initiateMiniGames":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_INITIATE_MINIGAMES));
                        break;
                     case "PlayersClubVIPPointsUpdate":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_PLAYERSCLUB_VIPUPDATE,String(_loc2_[4])));
                        break;
                     case "PlayersClubBigHandReward":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_PLAYERSCLUB_BIGHANDREWARD,String(_loc2_[4])));
                        break;
                     case "PlayersClubPostPurchaseReward":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_PLAYERSCLUB_POSTPURCHASEREWARD,String(_loc2_[4])));
                        break;
                     case "PlayersClubAppEntryReward":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_PLAYERSCLUB_APPENTRYREWARD,String(_loc2_[4])));
                        break;
                     case "XPBoostWithPurchase":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_XPBOOST_WITH_PURCHASE,String(_loc2_[4])));
                        break;
                     case "forceChipUpdate":
                        dispatchEvent(new ZshimEvent(ZshimController.ZOOM_FORCE_CHIP_UPDATE,String(_loc2_[4])));
                        break;
                  }
                  
                  continue;
               case "hideRequest":
                  _loc26_ = String(_loc2_[1]);
                  dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TOOLBAR_PLAYERSTATUS,_loc26_));
                  continue;
               default:
                  continue;
            }
            
         }
      }
   }
}
class ZshimController_SingletonLockingClass extends Object
{
   
   function ZshimController_SingletonLockingClass() {
      super();
   }
}
