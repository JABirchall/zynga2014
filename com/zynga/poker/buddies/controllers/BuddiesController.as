package com.zynga.poker.buddies.controllers
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.buddies.commands.BuddiesCommand;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.buddies.events.BuddyEvent;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.PokerConnectionManager;
   import com.zynga.poker.protocol.SAcceptBuddy;
   import com.zynga.poker.protocol.SIgnoreBuddy;
   
   public class BuddiesController extends FeatureController
   {
      
      public function BuddiesController() {
         super();
      }
      
      override protected function postInit() : void {
         (commandDispatcher as PokerCommandDispatcher).addDispatcherForType(BuddiesCommand,this);
      }
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override public function addListeners() : void {
         super.addListeners();
         ListenerManager.addEventListener(this,BuddyEvent.ACCEPT_REQUEST,function(param1:BuddyEvent):void
         {
            acceptBuddyRequest(param1.zid,param1.name);
         });
         ListenerManager.addEventListener(this,BuddyEvent.DENY_REQUEST,function(param1:BuddyEvent):void
         {
            denyBuddyRequest(param1.zid);
         });
      }
      
      public function acceptBuddyRequest(param1:String, param2:String) : void {
         var _loc3_:PokerConnectionManager = registry.getObject(IPokerConnectionManager);
         var _loc4_:SAcceptBuddy = new SAcceptBuddy(param1,param2);
         _loc3_.sendMessage(_loc4_);
         this.removeBuddyRequest(param1);
      }
      
      public function denyBuddyRequest(param1:String) : void {
         var _loc2_:PokerConnectionManager = registry.getObject(IPokerConnectionManager);
         var _loc3_:SIgnoreBuddy = new SIgnoreBuddy(param1);
         _loc2_.sendMessage(_loc3_);
         this.removeBuddyRequest(param1);
      }
      
      private function removeBuddyRequest(param1:String) : void {
         pgData.removeBuddyInvite(param1);
      }
   }
}
