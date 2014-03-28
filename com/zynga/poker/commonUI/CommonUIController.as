package com.zynga.poker.commonUI
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.friends.interfaces.INotifHandler;
   import com.zynga.poker.commonUI.commands.CommonUICommand;
   import com.zynga.poker.commonUI.commands.CommonUIInviteUserCommand;
   import com.zynga.poker.commonUI.commands.CommonUIJoinUserCommand;
   import com.zynga.poker.commonUI.commands.CommonUIInviteFriendsCommand;
   import com.zynga.poker.buddies.commands.BuddiesCommand;
   import com.zynga.poker.buddies.commands.BuddyDenyRequestCommand;
   import com.zynga.poker.buddies.commands.BuddyAcceptRequestCommand;
   import com.zynga.poker.commands.navcontroller.BuddiesListCommand;
   import com.zynga.poker.friends.controllers.NotifController;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.commonUI.events.*;
   import com.zynga.poker.commands.js.CloseAllPHPPopupsCommand;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.commonUI.notifs.RealTimeInviteNotif;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.events.PCEvent;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.commands.navcontroller.UpdateNavItemCountCommand;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.zoom.ZshimModel;
   import com.zynga.poker.zoom.ZshimModelEvent;
   import com.zynga.poker.statistic.ZTrack;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.commands.selfcontained.casino.ChangeServerCommand;
   import com.zynga.poker.events.OpenGraphEvent;
   import com.zynga.poker.commands.selfcontained.CheckLobbyTimerCommand;
   
   public class CommonUIController extends FeatureController implements INotifHandler
   {
      
      public function CommonUIController() {
         super();
         this.notifs = new Notifications();
      }
      
      private static var sClasses:Array;
      
      public var uiModel:CommonUIModel;
      
      public var uiView:CommonUIView;
      
      public var notifController:NotifController;
      
      private var pControl:PokerController;
      
      private var isFirstZoomUpdate:Boolean = true;
      
      private var notifs:Notifications;
      
      override protected function alignToParentContainer() : void {
         if(!this.uiView || !_parentContainer)
         {
            return;
         }
         this.uiView.x = 0;
         this.uiView.y = 40;
      }
      
      public function onZLivePost(param1:CommonVEvent) : void {
         externalInterface.call("postZLivePlay","");
      }
      
      public function showOnlineNotif(param1:String) : Boolean {
         return false;
      }
      
      public function showOfflineNotif(param1:String) : Boolean {
         return false;
      }
      
      public function showInviteNotif(param1:String) : Boolean {
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc2_:* = false;
         var _loc3_:Object = this.uiModel.getOnlineUser(param1);
         if(_loc3_)
         {
            _loc4_ = this.uiModel.getServerType(_loc3_.server_id);
            if(String(_loc3_.tableType.toLowerCase()) == "lobby")
            {
               _loc3_.isRT = true;
               _loc5_ = false;
               if(pgData.dispMode == "tournament" || pgData.dispMode == "shootout" || pgData.dispMode == "weekly" || pgData.dispMode == "premium" || (pgData.inLobbyRoom) || pgData.gameRoomId == _loc3_.room_id)
               {
                  _loc5_ = true;
               }
               this.notifs.addRTInviteNotif(_loc3_,_loc5_);
               if(!_loc5_)
               {
                  dispatchCommand(new CloseAllPHPPopupsCommand());
               }
            }
            else
            {
               this.notifs.addRTInviteNotif(_loc3_,true);
            }
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function showJoinNotif(param1:String) : Boolean {
         var _loc2_:* = false;
         var _loc3_:Object = this.uiModel.getOnlineUser(param1);
         if(_loc3_ != null)
         {
            _loc3_.isRT = false;
            this.notifs.addInviteNotif(_loc3_);
            dispatchCommand(new CloseAllPHPPopupsCommand());
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function showJoinedNotif(param1:Object) : Boolean {
         this.notifs.addJoinedNotif(param1);
         return true;
      }
      
      public function getSameTableIds(param1:Number) : Array {
         return this.uiModel.getSameTableIds(param1);
      }
      
      public function getTableBuddyCount() : Number {
         return this.uiModel.getTableBuddyCount(pgData.gameRoomId);
      }
      
      public function startCommonUIController(param1:PokerController) : void {
         this.pControl = param1;
      }
      
      private function onRTNotifDisplayed(param1:CommonVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:RealTimeNotif:DealerChat:2011-06-13"));
      }
      
      private function onInviteNotifDisplayed(param1:CommonVEvent) : void {
         if(pgData.inLobbyRoom)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Impression o:InviteNotif:2011-06-13"));
         }
      }
      
      private function onInviteClosed(param1:CloseNotifEvent) : void {
         this.uiView.updatePlayingNowDP(this.uiModel.pNowDP);
         this.uiView.updateFriendsInviteDP(this.uiModel.fInvDP);
         this.pControl.updatezLiveButtonText(this.uiModel.fInvDP.length);
         if(param1.notif is RealTimeInviteNotif && (param1.notif.closedByCloseButtonClick))
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:RealTimeNotif:CloseButton:2011-06-13"));
         }
      }
      
      override protected function initModel() : FeatureModel {
         this.uiModel = registry.getObject(CommonUIModel);
         this.uiModel.setServerTypeList(this.pControl.loadBalancer.serverTypeList,this.pControl.loadBalancer.idList);
         this.uiModel.browserName = configModel.getStringForFeatureConfig("user","browserName","").toLowerCase();
         this.uiModel.nFacebookFriendsOnline = configModel.getIntForFeatureConfig("user","frndOnline",0);
         this.uiModel.friendSelectorConfig = configModel.getFeatureConfig("friendSelector");
         this.uiModel.isLeaderboardEnabled = configModel.isFeatureEnabled("leaderboard");
         return this.uiModel;
      }
      
      override protected function initView() : FeatureView {
         this.uiView = registry.getObject(CommonUIView);
         this.uiView.y = 40;
         this.uiView.visible = false;
         this.uiView.addEventListener(CommonVEvent.JOIN_USER,this.onJoinUserClicked,true);
         this.uiView.addEventListener(CommonVEvent.INVITE_USER,this.onInviteUserClicked,true);
         this.uiView.addEventListener(CommonVEvent.ZLIVE_HIDE,this.onZLiveHide,true);
         this.uiView.addEventListener(CommonVEvent.SHOW_PROFILE,this.onUserProfileImgClicked,true);
         this.uiView.addEventListener(CommonVEvent.INVITE_FRIENDS,this.onInviteFriendsClick,true);
         this.uiView.uiModel = this.uiModel;
         this.uiView.init(this.uiModel);
         this.uiView.addChild(this.notifs);
         this.notifs.x = 7;
         this.notifs.y = 38;
         return this.uiView;
      }
      
      override protected function postInit() : void {
         super.postInit();
         (commandDispatcher as PokerCommandDispatcher).addDispatcherForType(CommonUICommand,this);
      }
      
      override public function addListeners() : void {
         this.pControl.addEventListener(PCEvent.LOBBY_JOINED,this.onLobbyJoined);
         this.pControl.addEventListener(PCEvent.TABLE_JOINED,this.onTableJoined);
         this.notifs.init(pgData);
         this.notifs.addEventListener(CommonVEvent.CLOSE_INVITE,this.onInviteClosed);
         this.notifs.addEventListener(CommonVEvent.REALTIMENOTIF_DISPLAYED,this.onRTNotifDisplayed,false,0,true);
         this.notifs.addEventListener(CommonVEvent.INVITENOTIF_DISPLAYED,this.onInviteNotifDisplayed,false,0,true);
         ListenerManager.addEventListener(this,CommonVEvent.JOIN_USER,this.onJoinUserClicked);
         ListenerManager.addEventListener(this,CommonVEvent.INVITE_USER,this.onInviteUserClicked);
         ListenerManager.addEventListener(this,CommonVEvent.INVITE_FRIENDS,this.onInviteFriendsClick);
      }
      
      private function onLobbyJoined(param1:PCEvent) : void {
         this.uiModel.inLobby = true;
         this.uiView.ZLiveHideClose(true);
         this.uiModel.removeSameTables(this.pControl.loadBalancer.getServerType(pgData.serverId));
         this.notifs.updateNotifButtons("lobby");
         this.uiView.updatePlayingNowDP(this.uiModel.pNowDP);
         this.uiView.updateFriendsInviteDP(this.uiModel.fInvDP);
         this.pControl.updatezLiveButtonText(this.uiModel.fInvDP.length);
         this.uiView.ZLiveScrollToTop();
         this.uiView.showFriendSelector();
         if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
         {
            commandDispatcher.dispatchCommand(new UpdateNavItemCountCommand("OnlineBuddiesIcon",this.uiModel.pNowDP.length));
         }
      }
      
      public function showPlayWithYourBuddiesNotification() : void {
         var _loc1_:Object = configModel.getFeatureConfig("user");
         if((this.uiModel.inLobby) && (_loc1_) && (_loc1_.joinedViaChatInvite))
         {
            _loc1_.joinedViaChatInvite = false;
            if(this.uiModel.pNowDP.length)
            {
               this.pControl.showPlayWithYourPokerBuddies(this.uiView as DisplayObjectContainer,500,80,-1);
            }
         }
      }
      
      public function showPlayWithYourBuddiesNotificationNonChatInviteDependent() : void {
         if(this.uiModel.inLobby)
         {
            if(this.uiModel.pNowDP.length)
            {
               this.pControl.showPlayWithYourPokerBuddies(this.uiView as DisplayObjectContainer,500,80,-1);
            }
         }
      }
      
      private function onTableJoined(param1:PCEvent) : void {
         this.uiModel.resetJoins();
         this.notifs.updateNotifButtons("table");
         this.uiModel.inLobby = false;
         this.uiView.ZLiveHideClose(false);
         this.uiView.hideFriendSelector();
         var _loc2_:String = this.pControl.loadBalancer.getServerType(pgData.serverId);
         this.uiModel.checkSameTable(pgData.gameRoomId,pgData.rejoinRoom,_loc2_);
         this.uiView.updatePlayingNowDP(this.uiModel.pNowDP);
         this.uiView.updateFriendsInviteDP(this.uiModel.fInvDP);
         pgData.ZLiveToggle = -1;
      }
      
      public function showView() : void {
         this.uiView.visible = true;
         this.uiView.updateOnline(0);
         this.uiView.updateOffline(0);
         this.initZoomModelListeners();
      }
      
      public function hideView() : void {
         this.uiView.visible = false;
      }
      
      private function onZLiveHide(param1:CommonVEvent) : void {
         this.uiView.hideFriendSelector();
         pgData.ZLiveToggle = -pgData.ZLiveToggle;
         dispatchEvent(new CommonCEvent(CommonCEvent.ON_ZLIVE_HIDE));
      }
      
      public function hideFriendSelector() : void {
         this.uiView.hideFriendSelector();
      }
      
      public function showFriendSelector() : void {
         this.uiView.showFriendSelector();
      }
      
      public function expandFriendSelectorFriendsSectionToFullSize() : void {
         this.uiView.expandFriendSelectorFriendsSectionToFullSize();
      }
      
      public function updateFriendSelectorPlayersOnlineNowText(param1:int) : void {
         this.uiView.updateFriendSelectorPlayersOnlineNowText(param1);
      }
      
      private function onSeeMorePlayingNow(param1:CommonVEvent) : void {
         fireStat(new PokerStatHit("FriendsSeeMore",5,14,2010,PokerStatHit.TRACKHIT_ALWAYS,"Table Other FriendsSeeMore o:LiveJoin:2009-05-14",null,1));
      }
      
      public function onInviteFriendsClick(param1:CommonVEvent) : void {
         externalInterface.call("ZY.App.lobbyFriendSelectorInviteMFS.OpenMFS");
      }
      
      public function updateView() : void {
         this.uiModel.updateFOnline();
         this.uiView.updatePlayingNowDP(this.uiModel.pNowDP);
         this.uiView.updateFriendsInviteDP(this.uiModel.fInvDP);
         this.pControl.updatezLiveButtonText(this.uiModel.fInvDP.length);
         this.uiView.updateOnline(this.uiModel.nOnline);
         this.uiView.updateOffline(this.uiModel.nOffline);
         this.uiView.refreshFriendSelector();
      }
      
      private function initZoomModelListeners() : void {
         this.pControl.zoomModel.addEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.onZoomModelFriendsUpdate);
      }
      
      private function removeZoomModelListeners() : void {
         this.pControl.zoomModel.removeEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.onZoomModelFriendsUpdate);
      }
      
      private function onZoomModelFriendsUpdate(param1:ZshimModelEvent) : void {
         var _loc6_:Array = null;
         var _loc2_:Array = param1.playerList;
         var _loc3_:int = _loc2_.length;
         var _loc4_:Number = pgData.rejoinRoom != -1?pgData.rejoinRoom:pgData.gameRoomId;
         this.uiModel.zoomUpdateFriends(_loc2_,_loc4_,pgData.serverId);
         var _loc5_:String = this.pControl.loadBalancer.getServerType(pgData.serverId);
         if(this.uiModel.inLobby == false)
         {
            _loc6_ = this.uiModel.checkSameTable(pgData.gameRoomId,pgData.rejoinRoom,_loc5_);
            this.dispatchJoinedNotifs(_loc6_);
         }
         else
         {
            this.uiModel.removeSameTables(_loc5_);
         }
         this.uiModel.updateFOnline();
         this.uiView.updatePlayingNowDP(this.uiModel.pNowDP);
         this.uiView.updateFriendsInviteDP(this.uiModel.fInvDP);
         this.pControl.updatezLiveButtonText(this.uiModel.fInvDP.length);
         this.uiView.updateOnline(this.uiModel.nOnline);
         this.uiView.updateOffline(this.uiModel.nOffline);
         if(configModel.getBooleanForFeatureConfig("redesign","onlineBuddies"))
         {
            commandDispatcher.dispatchCommand(new UpdateNavItemCountCommand("OnlineBuddiesIcon",this.uiModel.pNowDP.length));
         }
         if(this.isFirstZoomUpdate)
         {
            this.isFirstZoomUpdate = false;
            if(this.uiModel.isTwoAtTable)
            {
            }
         }
         if(this.uiModel.pNowDP.length == 0)
         {
            this.pControl.hidePlayWithYourPokerBuddies();
         }
         this.showPlayWithYourBuddiesNotification();
      }
      
      private function dispatchJoinedNotifs(param1:Array) : void {
         var _loc2_:Object = null;
         if(pgData.showJoinNotifs == true)
         {
            for each (_loc2_ in param1)
            {
               this.notifController.showJoinedNotif(_loc2_);
            }
         }
         if(param1.length > 0)
         {
            this.pControl.glowZLiveButton();
         }
         dispatchCommand(new CloseAllPHPPopupsCommand());
      }
      
      private function onInviteUserClicked(param1:InviteUserEvent) : void {
         var _loc4_:String = null;
         if(!pgData.inLobbyRoom)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other InviteFriend o:LiveJoin:2011-04-18"));
         }
         if(param1.jointype == "notif")
         {
            if(!pgData.inLobbyRoom && (param1.friend.isRT))
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:RealTimeNotif:InviteClick:2011-06-13"));
            }
         }
         var _loc2_:Object = param1.hasOwnProperty("friend")?param1["friend"]:null;
         if(_loc2_ != null)
         {
            if(!(_loc2_.server_id == null) && !(_loc2_.room_id == "null"))
            {
               if(_loc2_.playStatus == "toolbar")
               {
                  this.pControl.zoomControl.sendToolbarInvitation(_loc2_.uid);
                  this.uiModel.addInviteIssued(_loc2_.uid);
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:FriendSelector:InviteToolbarFriend:2010-07-09"));
               }
               else
               {
                  _loc4_ = this.pControl.loadBalancer.getServerType(_loc2_.server_id);
                  this.pControl.zoomControl.sendTableInvitation(_loc2_.uid);
                  this.pControl.zoomControl.sendToolbarInvitation(_loc2_.uid);
                  this.uiModel.addInviteIssued(_loc2_.uid);
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:TopNav:InviteToPlay:2010-04-06"));
                  fireStat(new PokerStatHit("lobbyClickInviteToPlay",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other Click o:TopNav:InviteToPlayOnce:2010-04-06"));
               }
            }
         }
         var _loc3_:* = "no_prompt";
         if(param1.jointype == "notif")
         {
            _loc3_ = "prompt";
         }
         if(pgData.inLobbyRoom == true)
         {
            this.pControl.handleToolbarFriendInviteFromLobby(_loc2_.gender);
            ZTrack.logSocial("invite_friend",param1.friend.uid,"","livejoin",_loc3_,"lobby");
         }
         else
         {
            ZTrack.logSocial("invite_friend",param1.friend.uid,"","livejoin",_loc3_,"table");
         }
      }
      
      public function forceExternalZLiveJoin(param1:JoinUserEvent) : void {
         this.onJoinUserClicked(param1);
      }
      
      private function onJoinUserClicked(param1:JoinUserEvent) : void {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:RoomItem = null;
         var _loc7_:* = false;
         if((this.pControl.tableControl) && (this.pControl.tableControl.ptView))
         {
            this.pControl.tableControl.cancelJumpTableSearch();
         }
         pgData.isJoinFriend = false;
         pgData.isJoinFriendSit = false;
         var _loc2_:* = "no_prompt";
         if(param1.jointype == "notif")
         {
            _loc2_ = "prompt";
         }
         if(pgData.inLobbyRoom)
         {
            ZTrack.logSocial("join_friend",param1.friend.uid,"","livejoin",_loc2_,"lobby");
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other JoinFriend o:LiveJoin:2011-04-18"));
         }
         else
         {
            ZTrack.logSocial("join_friend",param1.friend.uid,"","livejoin",_loc2_,"table");
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other JoinFriend o:LiveJoin:2011-04-18"));
         }
         var _loc3_:Object = param1.hasOwnProperty("friend")?param1["friend"]:null;
         if(_loc3_ != null)
         {
            _loc4_ = this.uiModel.getOnlineUser(_loc3_.uid);
            if(!_loc4_)
            {
               this.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
               return;
            }
            if(param1.jointype == "notif")
            {
               if(pgData.inLobbyRoom)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other Click o:InviteNotif:JoinButton:2011-06-13"));
               }
            }
            else
            {
               if(this.uiModel.checkOutstandingInvite(_loc4_["uid"]) != true)
               {
                  fireStat(new PokerStatHit("TableJoinFriendSelector",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other TableJoinFriendSelector o:LiveJoin:2009-05-14",null,1));
               }
            }
            if(_loc4_.room_id == -1)
            {
               this.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
               return;
            }
            if(!(_loc4_.server_id == null) && !(_loc4_.server_id == "null"))
            {
               _loc5_ = this.pControl.loadBalancer.getServerType(_loc4_.server_id);
               if(_loc5_.split("shootout")[0] == "" || _loc5_.split("premium")[0] == "")
               {
                  this.showPlayWithYourBuddiesNotificationNonChatInviteDependent();
                  return;
               }
               if(_loc4_.room_id > -1)
               {
                  pgData.isJoinFriend = true;
                  pgData.joinFriendId = _loc4_.uid;
                  pgData.joinFriendName = _loc4_.label;
                  _loc6_ = pgData.getRoomById(_loc4_.room_id);
                  if(_loc6_)
                  {
                     if(_loc6_.tableType == "Private")
                     {
                        fireStat(new PokerStatHit("PrivateTableJoinFriendSelector",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Lobby Other FriendSelectorPrivateTableJoin o:LiveJoin:2010-06-09",null,1));
                        fireStat(new PokerStatHit("PrivateTableJoinFriendSelectorOnce",0,0,0,PokerStatHit.TRACKHIT_ONCE,"Lobby Other FriendSelectorPrivateTableJoinOnce o:LiveJoin:2010-06-09"));
                     }
                  }
               }
               if(!this.uiModel.inLobby)
               {
                  this.pControl.tableJoin(_loc4_);
               }
               else
               {
                  _loc5_ = this.pControl.loadBalancer.getServerType(_loc4_.server_id);
                  _loc7_ = _loc5_.split("shootout")[0] == "" || _loc5_.split("premium")[0] == ""?true:false;
                  dispatchCommand(new ChangeServerCommand(_loc4_.server_id,_loc4_.room_id,true,_loc7_));
               }
               if(pgData.sn_id == pgData.SN_FACEBOOK && int(param1.friend.uid.split(":")[0]) == pgData.SN_FACEBOOK && !(this.pControl.openGraphController == null))
               {
                  this.pControl.openGraphController.dispatchEvent(new OpenGraphEvent(OpenGraphEvent.liveJoin,Number(param1.friend.uid.split(":")[1])));
               }
               this.pControl.zoomControl.sendToolbarInvitationRemove("clearall");
            }
         }
         dispatchCommand(new CheckLobbyTimerCommand());
      }
      
      private function onUserProfileImgClicked(param1:InviteUserEvent) : void {
         var _loc2_:Object = param1.hasOwnProperty("friend")?param1["friend"]:null;
         if(_loc2_ != null)
         {
            this.pControl.showProfile(_loc2_["uid"],_loc2_["label"],"ZLive");
         }
      }
   }
}
