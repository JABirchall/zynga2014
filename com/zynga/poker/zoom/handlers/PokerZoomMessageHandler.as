package com.zynga.poker.zoom.handlers
{
   import com.zynga.performance.memory.Disposable;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.zoom.ZshimModel;
   import com.zynga.poker.zoom.ZshimController;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.zoom.ZshimEvent;
   import com.zynga.poker.UserPresence;
   
   public class PokerZoomMessageHandler extends Disposable implements IZoomMessageHandler
   {
      
      public function PokerZoomMessageHandler() {
         super();
      }
      
      public var registry:IClassRegistry;
      
      public var pgData:PokerGlobalData;
      
      public var configModel:ConfigModel;
      
      public var pControl:PokerController;
      
      public var popupControl:IPopupController;
      
      public var zoomModel:ZshimModel;
      
      public var zoomController:ZshimController;
      
      public var externalInterface:IExternalCall;
      
      public function init() : void {
      }
      
      public function onZoomShout(param1:ZshimEvent) : void {
         this.pControl.displayShout(String(param1.msg));
         var _loc2_:Object = param1.msg;
      }
      
      public function onZoomUpdate(param1:ZshimEvent) : void {
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if(_loc2_ != null)
         {
            _loc2_.sRoomDesc = this.pControl.getNetworkUserStatus(_loc2_.nServerId,this.pControl.loadBalancer.getServerType(String(_loc2_.nServerId)),_loc2_.nRoomId);
            this.zoomModel.updatePlayer(_loc2_,"friends");
            this.zoomModel.updatePlayer(_loc2_,"network");
         }
      }
      
      public function onZoomAddFriend(param1:ZshimEvent) : void {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if((_loc2_) && !(_loc2_.sZid == this.pgData.zid))
         {
            _loc3_ = this.pControl.loadBalancer.getServerType(String(_loc2_.nServerId));
            if(!(_loc3_ == "tourney") && _loc3_.length > 0)
            {
               _loc2_.sRoomDesc = this.pControl.getNetworkUserStatus(_loc2_.nServerId,_loc3_,_loc2_.nRoomId);
            }
            this.zoomModel.addPlayer(_loc2_,"friends");
            _loc4_ = this.configModel.getFeatureConfig("zoom");
            if(_loc4_)
            {
               _loc4_.nZoomFriends++;
            }
         }
      }
      
      public function onZoomRemoveFriend(param1:ZshimEvent) : void {
         var _loc3_:Object = null;
         var _loc2_:UserPresence = param1.msg as UserPresence;
         if((_loc2_) && !(_loc2_.sZid == this.pgData.zid))
         {
            this.zoomModel.deletePlayer(_loc2_,"friends");
            _loc3_ = this.configModel.getFeatureConfig("zoom");
            if(_loc3_)
            {
               _loc3_.nZoomFriends--;
            }
         }
      }
      
      public function onZoomTableInvitation(param1:ZshimEvent) : void {
      }
      
      public function onZoomToolbarJoin(param1:ZshimEvent) : void {
         this.zoomController.sendGameSwfLoadedResponse();
         var _loc2_:String = param1.msg.uid;
         this.pControl.joinUser(_loc2_);
      }
      
      public function onZoomSocketClose(param1:ZshimEvent) : void {
         this.zoomModel.clearPlayer("friends");
         this.zoomModel.clearPlayer("network");
      }
      
      public function onLeaderboardGetUpdate(param1:ZshimEvent) : void {
         this.externalInterface.call("zc.feature.leaderboard.retrieveLeaderboardData");
      }
   }
}
