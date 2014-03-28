package com.zynga.poker.friends.controllers
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.friends.interfaces.INotifController;
   import com.zynga.poker.zoom.handlers.IZoomMessageHandler;
   import com.zynga.poker.IPokerController;
   import com.zynga.poker.friends.interfaces.INotifHandler;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.zoom.ZshimModel;
   import com.zynga.poker.zoom.ZshimModelEvent;
   import com.zynga.poker.UserPresence;
   import com.zynga.poker.table.constants.TableDisplayMode;
   import com.zynga.poker.zoom.ZshimEvent;
   import com.zynga.poker.zoom.messages.ZoomTableInvitationMessage;
   
   public class NotifController extends FeatureController implements INotifController, IZoomMessageHandler
   {
      
      public function NotifController() {
         super();
      }
      
      public var pControl:IPokerController;
      
      private var _notifHandler:INotifHandler;
      
      private var _seenOnlineNotifs:Array;
      
      private var _seenInviteNotifs:Array;
      
      override public function dispose() : void {
         this.pControl.zoomControl.unregisterMessageHandler(this);
         ListenerManager.removeListenersForGroup(this.pControl.zoomModel,"notifController");
         this._notifHandler = null;
         this._seenOnlineNotifs.length = 0;
         this._seenOnlineNotifs = null;
         this._seenInviteNotifs.length = 0;
         this._seenInviteNotifs = null;
         super.dispose();
      }
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override protected function preInit() : void {
         this.pControl = registry.getObject(IPokerController);
      }
      
      override protected function postInit() : void {
         this._seenOnlineNotifs = [];
         this._seenInviteNotifs = [];
         this.pControl.zoomControl.registerMessageHandler(this);
      }
      
      override public function addListeners() : void {
         ListenerManager.addEventListener(this.pControl.zoomModel,ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.onZoomModelFriendsUpdate,0,"notifController");
         ListenerManager.addEventListener(this.pControl.zoomModel,ZshimModel.ZOOM_MODEL_FRIEND_ADDED,this.onZoomModelFriendAdded,0,"notifController");
      }
      
      public function showOnlineNotif(param1:String) : void {
         if(this._notifHandler)
         {
            this._notifHandler.showOnlineNotif(param1);
            this._seenOnlineNotifs[param1] = true;
         }
      }
      
      public function showOfflineNotif(param1:String) : void {
         if(this._notifHandler)
         {
            this._notifHandler.showOfflineNotif(param1);
         }
      }
      
      public function showInviteNotif(param1:String) : void {
         var _loc2_:* = false;
         if(!this.hasShownInviteNotif(param1))
         {
            if(this._notifHandler)
            {
               _loc2_ = this._notifHandler.showInviteNotif(param1);
               if(_loc2_)
               {
                  this._seenInviteNotifs[param1] = true;
               }
            }
         }
      }
      
      public function showJoinNotif(param1:String) : void {
         if(this._notifHandler)
         {
            if(configModel.getBooleanForFeatureConfig("core","disableLiveJoinInvites"))
            {
               return;
            }
            this._notifHandler.showJoinNotif(param1);
         }
      }
      
      public function showJoinedNotif(param1:Object) : void {
         if(this._notifHandler)
         {
            this._notifHandler.showJoinedNotif(param1);
         }
      }
      
      public function set notifHandler(param1:INotifHandler) : void {
         this._notifHandler = param1;
      }
      
      public function get notifHandler() : INotifHandler {
         return this._notifHandler;
      }
      
      private function onZoomModelFriendsUpdate(param1:ZshimModelEvent) : void {
         var _loc2_:UserPresence = null;
         for each (_loc2_ in param1.playerList)
         {
            if((_loc2_) && (!pgData.mttZone) && !(pgData.dispMode == TableDisplayMode.SHOOTOUT_MODE || pgData.dispMode == TableDisplayMode.WEEKLY_MODE || pgData.dispMode == TableDisplayMode.PREMIUM_MODE))
            {
               this.showInviteNotif(_loc2_.sZid);
            }
         }
      }
      
      private function onZoomModelFriendAdded(param1:ZshimModelEvent) : void {
         var _loc2_:UserPresence = param1.playerList[0];
         if((_loc2_) && !(_loc2_.sZid == pgData.zid))
         {
            this.showOnlineNotif(_loc2_.sZid);
         }
      }
      
      public function onZoomTableInvitation(param1:ZshimEvent) : void {
         var _loc3_:UserPresence = null;
         var _loc2_:ZoomTableInvitationMessage = param1.msg as ZoomTableInvitationMessage;
         if((_loc2_) && (_loc2_.fromUserId))
         {
            _loc3_ = this.pControl.zoomModel.getUserById(_loc2_.fromUserId);
            if(_loc3_)
            {
               this.showJoinNotif(_loc3_.sZid);
            }
         }
      }
      
      public function onZoomRemoveFriend(param1:ZshimEvent) : void {
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if((_loc2_) && !(_loc2_.sZid == pgData.zid))
         {
            this.showOfflineNotif(_loc2_.sZid);
         }
      }
      
      public function onZoomUpdate(param1:ZshimEvent) : void {
      }
      
      public function onZoomAddFriend(param1:ZshimEvent) : void {
      }
      
      public function onZoomShout(param1:ZshimEvent) : void {
      }
      
      public function onZoomToolbarJoin(param1:ZshimEvent) : void {
      }
      
      public function onZoomSocketClose(param1:ZshimEvent) : void {
      }
      
      public function onLeaderboardGetUpdate(param1:ZshimEvent) : void {
      }
      
      private function hasShownOnlineNotif(param1:String) : Boolean {
         return (this._seenOnlineNotifs.hasOwnProperty(param1)) && this._seenOnlineNotifs[param1] == true;
      }
      
      private function hasShownInviteNotif(param1:String) : Boolean {
         return (this._seenInviteNotifs.hasOwnProperty(param1)) && this._seenInviteNotifs[param1] == true;
      }
   }
}
