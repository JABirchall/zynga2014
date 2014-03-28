package com.zynga.poker.commonUI
{
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.PokerGlobalData;
   import fl.data.DataProvider;
   
   public class CommonUIView extends FeatureView
   {
      
      public function CommonUIView() {
         super();
      }
      
      public var uiModel:CommonUIModel;
      
      private var fSelector:FriendSelector;
      
      override protected function _init() : void {
         var _loc1_:PokerGlobalData = featureModel.pgData;
         this.fSelector = new FriendSelector();
         if(this.uiModel.isLeaderboardEnabled)
         {
            this.fSelector.x = 503;
            this.fSelector.y = 114;
         }
         else
         {
            this.fSelector.x = 506;
            this.fSelector.y = 127;
         }
         var _loc2_:* = !(_loc1_.flashVersionGood == false && this.uiModel.browserName == "msie");
         var _loc3_:Boolean = (this.uiModel.friendSelectorConfig) && (this.uiModel.friendSelectorConfig.shrinkLiveJoin) || (this.uiModel.isLeaderboardEnabled);
         this.fSelector.init(this.uiModel.friendSelectorConfig,_loc1_.usersOnline,this.uiModel.nFacebookFriendsOnline,_loc2_,this.uiModel.isLeaderboardEnabled,_loc3_);
         this.fSelector.hideClose(true);
         addChild(this.fSelector);
      }
      
      public function ZLiveHideClose(param1:Boolean) : void {
         this.fSelector.hideClose(param1);
      }
      
      public function ZLiveScrollToTop() : void {
         if(this.fSelector)
         {
            this.fSelector.scrollToTop();
         }
      }
      
      public function updatePlayingNowDP(param1:DataProvider) : void {
         this.fSelector.updatePNusers(param1);
      }
      
      public function updateFriendsInviteDP(param1:DataProvider) : void {
         this.fSelector.updateFIusers(param1);
      }
      
      public function updateOnline(param1:int) : void {
         this.fSelector.updateFONusers(param1);
      }
      
      public function updateOffline(param1:int) : void {
         this.fSelector.updateFOFFusers(-1);
      }
      
      public function hideFriendSelector() : void {
         this.fSelector.updateVisibility(false);
      }
      
      public function showFriendSelector() : void {
         this.fSelector.updateVisibility(true);
      }
      
      public function showGameBarTooltip() : void {
         this.fSelector.showGameBarTooltip();
      }
      
      public function hideTooltip() : void {
         this.fSelector.hideTooltip();
      }
      
      public function refreshFriendSelector() : void {
         this.fSelector.availableToPlayList.drawNow();
      }
      
      public function expandFriendSelectorFriendsSectionToFullSize() : void {
         this.fSelector.expandFriendSelectorFriendsSectionToFullSize();
      }
      
      public function updateFriendSelectorPlayersOnlineNowText(param1:int) : void {
         this.fSelector.updatePlayersOnlineNowText(param1);
      }
   }
}
