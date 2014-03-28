package com.zynga.poker
{
   import flash.display.MovieClip;
   import com.zynga.poker.zoom.ZshimController;
   import flash.utils.Timer;
   import flash.external.ExternalInterface;
   import flash.events.TimerEvent;
   import com.zynga.poker.zoom.ZshimEvent;
   import flash.system.Security;
   
   public class PokerToolbar extends MovieClip
   {
      
      public function PokerToolbar() {
         this.onlineFriends = new Array();
         super();
         if(!(Security.sandboxType == Security.LOCAL_WITH_FILE || Security.sandboxType == Security.LOCAL_TRUSTED))
         {
            this.init(root.loaderInfo.parameters);
         }
      }
      
      public static const GAME_ID:int = 1;
      
      public static const TOOLBAR_SERVER_ID:int = -100;
      
      public static const TOOLBAR_ROOM_ID:int = -1;
      
      public static const TOOLBAR_ROOM_DESCRIPTION:String = "TOOLBAR";
      
      private var zoomController:ZshimController;
      
      private var initComplete:Boolean = false;
      
      private var onlineFriends:Array;
      
      private var host:String = "";
      
      private var port:String = "";
      
      private var password:String = "";
      
      private var zid:String = "";
      
      private var firstName:String = "";
      
      private var lastName:String = "";
      
      private var pictureUrl:String = "";
      
      private var friendZIDs:String = "";
      
      private var heartbeatDelay:Number = 10;
      
      private var gameSwfLoadedTimer:Timer;
      
      private var gameSwfIsLoaded:Boolean = false;
      
      private var zidUserToJoin:String;
      
      private var startSendingOnlineFriendsToJSTimer:Timer;
      
      public function localInit(param1:Object) : void {
         this.init(param1);
      }
      
      private function init(param1:Object) : void {
         var _loc2_:* = NaN;
         if(!this.initComplete)
         {
            this.initComplete = true;
            if(ExternalInterface.available)
            {
               ExternalInterface.addCallback("connect",this.connect);
               ExternalInterface.addCallback("disconnect",this.disconnect);
               ExternalInterface.addCallback("reconnect",this.reconnect);
               ExternalInterface.addCallback("getIsConnected",this.getIsConnected);
               ExternalInterface.addCallback("getOnlineFriendCount",this.getOnlineFriendCount);
               ExternalInterface.addCallback("joinUser",this.joinUser);
               ExternalInterface.addCallback("updatePlayerStatus",this.updatePlayerStatus);
               ExternalInterface.addCallback("removeUserInvite",this.removeUserInvite);
            }
            if(param1["heartbeat"])
            {
               _loc2_ = Number(unescape(param1["heartbeat"]));
               if(!isNaN(_loc2_) && _loc2_ > 0)
               {
                  this.heartbeatDelay = _loc2_;
               }
            }
            this.connect(param1["host"]?unescape(param1["host"]):"",param1["port"]?unescape(param1["port"]):"",param1["zpw"]?unescape(param1["zpw"]):"",param1["zid"]?unescape(param1["zid"]):"",param1["firstName"]?unescape(param1["firstName"]):"",param1["lastName"]?unescape(param1["lastName"]):"",param1["picUrl"]?unescape(param1["picUrl"]):"",param1["friends"]?unescape(param1["friends"]):"");
         }
      }
      
      public function connect(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Boolean=false) : void {
         var _loc11_:UserPresence = null;
         var _loc10_:Boolean = !(this.host == param1) || !(this.port == param2)?true:false;
         this.host = param1;
         this.port = param2;
         this.password = param3;
         this.zid = param4;
         this.firstName = param5;
         this.lastName = param6;
         this.pictureUrl = param7;
         this.friendZIDs = param8;
         if((param4) && (param1) && (param2) && (param3) && (param8))
         {
            _loc11_ = new UserPresence(this.zid,GAME_ID,TOOLBAR_SERVER_ID,TOOLBAR_ROOM_ID,TOOLBAR_ROOM_DESCRIPTION,this.firstName,this.lastName,"n/a",this.pictureUrl,param8,"n/a");
            if(this.zoomController == null)
            {
               this.zoomController = ZshimController.getInstance(param1,int(param2),param3,_loc11_,param9);
               this.zoomController.addEventListener(ZshimController.ZOOM_SOCKET_CONNECT,this.onZoomSocketConnect);
               this.zoomController.addEventListener(ZshimController.ZOOM_SOCKET_CLOSE,this.onZoomSocketClose);
               this.zoomController.addEventListener(ZshimController.ZOOM_SOCKET_ERROR,this.onZoomSocketError);
               this.zoomController.addEventListener(ZshimController.ZOOM_ADD_FRIEND,this.onZoomAddFriend);
               this.zoomController.addEventListener(ZshimController.ZOOM_REMOVE_FRIEND,this.onZoomRemoveFriend);
               this.zoomController.addEventListener(ZshimController.ZOOM_UPDATE,this.onZoomUpdate);
               this.zoomController.addEventListener(ZshimController.ZOOM_TOOLBAR_INVITATION,this.onZoomToolbarInviteReceived);
               this.zoomController.addEventListener(ZshimController.ZOOM_TOOLBAR_GAMESWFLOADEDCALLBACK,this.onZoomToolbarGameSwfLoadedReponse);
               this.zoomController.addEventListener(ZshimController.ZOOM_TOOLBAR_PLAYERSTATUS,this.onZoomToolbarPlayerStatusReceived);
               this.zoomController.addEventListener(ZshimController.ZOOM_TOOLBAR_INVITATIONREMOVE,this.onZoomToolbarInviteRemove);
               this.zoomController.connect(this.heartbeatDelay);
            }
            else
            {
               if(_loc10_)
               {
                  if(this.zoomController.isConnected())
                  {
                     this.zoomController.disconnect();
                  }
                  this.zoomController = ZshimController.getInstance(param1,int(param2),param3,_loc11_,param9);
                  this.zoomController.connect(this.heartbeatDelay);
               }
               else
               {
                  if(!this.zoomController.isConnected())
                  {
                     this.reconnect();
                  }
               }
            }
            if(this.startSendingOnlineFriendsToJSTimer == null)
            {
               this.startSendingOnlineFriendsToJSTimer = new Timer(1 * 1000,1);
               this.startSendingOnlineFriendsToJSTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onStartSendingOnlineFriendsToJSTimerComplete);
               this.startSendingOnlineFriendsToJSTimer.start();
            }
         }
      }
      
      public function disconnect() : void {
         if((this.zoomController) && (this.zoomController.isConnected()))
         {
            this.zoomController.disconnect();
         }
      }
      
      public function reconnect() : void {
         if((this.zoomController) && !this.zoomController.isConnected())
         {
            this.zoomController.connect(this.heartbeatDelay);
         }
         this.notifyJS("updateOnlineFriendCount",this.numberOfFriendsOnline);
      }
      
      private function onZoomSocketConnect(param1:ZshimEvent) : void {
         this.onlineFriends = new Array();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("onConnected");
         }
         this.notifyJS("updateOnlineFriendCount",this.numberOfFriendsOnline);
      }
      
      private function onZoomSocketClose(param1:ZshimEvent) : void {
         this.onlineFriends = new Array();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("onDisconnected");
         }
      }
      
      private function onZoomSocketError(param1:ZshimEvent) : void {
         this.onlineFriends = new Array();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("onError");
         }
      }
      
      private function onZoomAddFriend(param1:ZshimEvent) : void {
         this.addOrUpdateFriend(param1.msg as UserPresence);
      }
      
      private function onZoomRemoveFriend(param1:ZshimEvent) : void {
         this.removeFriend(param1.msg as UserPresence);
      }
      
      private function onZoomUpdate(param1:ZshimEvent) : void {
         this.addOrUpdateFriend(param1.msg as UserPresence);
      }
      
      private function onZoomToolbarInviteReceived(param1:ZshimEvent) : void {
         var _loc3_:String = null;
         var _loc2_:UserPresence = this.getOnlineFriend(param1.msg.uid);
         if(_loc2_)
         {
            _loc3_ = "";
            _loc3_ = _loc3_ + (_loc2_.sZid + "," + _loc2_.sFirstName + "," + _loc2_.sPicURL);
            this.notifyJS("updateInvites",_loc3_);
         }
      }
      
      private function onZoomToolbarGameSwfLoadedReponse(param1:ZshimEvent) : void {
         this.gameSwfIsLoaded = true;
      }
      
      private function onZoomToolbarPlayerStatusReceived(param1:ZshimEvent) : void {
         this.notifyJS("updatePlayerStatus",param1.msg);
      }
      
      private function onZoomToolbarInviteRemove(param1:ZshimEvent) : void {
         this.notifyJS("removeUserInvite",param1.msg.uid);
      }
      
      public function get numberOfFriendsOnline() : Number {
         return this.onlineFriends?this.onlineFriends.length:0;
      }
      
      public function friendsOnlineZids() : String {
         var _loc2_:* = 0;
         var _loc3_:UserPresence = null;
         var _loc1_:String = null;
         if(this.onlineFriends)
         {
            if(this.onlineFriends.length)
            {
               _loc1_ = "";
               _loc2_ = 0;
               while(_loc2_ < this.onlineFriends.length)
               {
                  _loc3_ = this.onlineFriends[_loc2_] as UserPresence;
                  _loc1_ = _loc1_ + _loc3_.sZid;
                  if(_loc2_ + 1 < this.onlineFriends.length)
                  {
                     _loc1_ = _loc1_ + ",";
                  }
                  _loc2_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function get numberOfFriendsAtTables() : Number {
         var _loc2_:UserPresence = null;
         var _loc1_:Number = 0;
         if(this.onlineFriends)
         {
            for each (_loc2_ in this.onlineFriends)
            {
               if(_loc2_.nRoomId > 0)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      private function addOrUpdateFriend(param1:UserPresence) : void {
         var _loc2_:* = false;
         var _loc3_:* = 0;
         var _loc4_:UserPresence = null;
         if(param1)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < this.onlineFriends.length)
            {
               _loc4_ = this.onlineFriends[_loc3_] as UserPresence;
               if((_loc4_) && param1.sZid == _loc4_.sZid)
               {
                  this.onlineFriends[_loc3_].nServerId = param1.nServerId;
                  this.onlineFriends[_loc3_].nRoomId = param1.nRoomId;
                  this.onlineFriends[_loc3_].sRoomDesc = param1.sRoomDesc;
                  this.onlineFriends[_loc3_].tableStakes = param1.tableStakes;
                  if(param1.sFirstName.length > 0 && !(param1.sFirstName == "n/a"))
                  {
                     this.onlineFriends[_loc3_].sFirstName = param1.sFirstName;
                  }
                  if(param1.sLastName.length > 0 && !(param1.sLastName == "n/a"))
                  {
                     this.onlineFriends[_loc3_].sLastName = param1.sLastName;
                  }
                  if(param1.sPicURL.length > 0 && !(param1.sPicURL == "n/a"))
                  {
                     this.onlineFriends[_loc3_].sPicURL = param1.sPicURL;
                  }
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
            if(!_loc2_)
            {
               this.onlineFriends.push(param1);
            }
            if(this.startSendingOnlineFriendsToJSTimer == null)
            {
               this.notifyJS("updateOnlineFriendCount",this.numberOfFriendsOnline);
               this.notifyJS("updateOnlineFriends",this.friendsOnlineZids());
            }
         }
      }
      
      private function removeFriend(param1:UserPresence) : void {
         var _loc2_:* = 0;
         var _loc3_:UserPresence = null;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.onlineFriends.length)
            {
               _loc3_ = this.onlineFriends[_loc2_] as UserPresence;
               if((_loc3_) && param1.sZid == _loc3_.sZid)
               {
                  this.onlineFriends.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
            this.notifyJS("updateOnlineFriendCount",this.numberOfFriendsOnline);
            this.notifyJS("updateOnlineFriends",this.friendsOnlineZids());
         }
      }
      
      private function notifyJS(param1:String, param2:Object) : void {
         if(ExternalInterface.available)
         {
            ExternalInterface.call(param1,param2);
         }
      }
      
      public function getOnlineFriend(param1:String) : UserPresence {
         var _loc2_:UserPresence = null;
         for each (_loc2_ in this.onlineFriends)
         {
            if(param1 == _loc2_.sZid)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getIsConnected() : Boolean {
         return (this.zoomController) && (this.zoomController.isConnected())?true:false;
      }
      
      public function getOnlineFriendCount() : Number {
         return this.numberOfFriendsOnline;
      }
      
      public function joinUser(param1:String) : void {
         this.zidUserToJoin = param1;
         if(this.zoomController)
         {
            this.zoomController.sendToolbarJoin(param1);
            if(this.gameSwfLoadedTimer == null)
            {
               this.gameSwfIsLoaded = false;
               this.gameSwfLoadedTimer = new Timer(1 * 1000,1);
               this.gameSwfLoadedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onGameSwfLoadedTimerComplete);
               this.gameSwfLoadedTimer.start();
            }
         }
      }
      
      private function onGameSwfLoadedTimerComplete(param1:TimerEvent) : void {
         if(!this.gameSwfIsLoaded)
         {
            this.notifyJS("launchGameAndJoinUser",this.zidUserToJoin);
         }
         if(this.gameSwfLoadedTimer != null)
         {
            this.gameSwfLoadedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onGameSwfLoadedTimerComplete);
            this.gameSwfLoadedTimer.stop();
            this.gameSwfLoadedTimer = null;
         }
      }
      
      public function updatePlayerStatus(param1:String) : void {
         if(this.zoomController)
         {
            this.zoomController.sendToolbarPlayerStatus(param1);
         }
      }
      
      public function removeUserInvite(param1:String) : void {
         if(this.zoomController)
         {
            this.zoomController.sendToolbarInvitationRemove(param1);
         }
      }
      
      private function onStartSendingOnlineFriendsToJSTimerComplete(param1:TimerEvent) : void {
         this.notifyJS("updateOnlineFriendCount",this.numberOfFriendsOnline);
         this.notifyJS("updateOnlineFriends",this.friendsOnlineZids());
         if(this.startSendingOnlineFriendsToJSTimer != null)
         {
            this.startSendingOnlineFriendsToJSTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onStartSendingOnlineFriendsToJSTimerComplete);
            this.startSendingOnlineFriendsToJSTimer.stop();
            this.startSendingOnlineFriendsToJSTimer = null;
         }
      }
   }
}
