package com.zynga.poker.commonUI
{
   import flash.display.MovieClip;
   import com.zynga.poker.lobby.asset.DrawFrame;
   import flash.display.Sprite;
   import com.zynga.ui.scroller.ScrollSystem;
   import fl.controls.TileList;
   import fl.data.DataProvider;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.commonUI.asset.FriendsOnlinePlaceholder;
   import com.zynga.poker.commonUI.asset.FriendsOfflinePlaceholder;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.controls.listClasses.FriendSelectorCellBg;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.events.MouseEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.controls.listClasses.FriendSelectorCell;
   import com.zynga.poker.controls.listClasses.FriendSelectorTileListSkin;
   import fl.controls.ScrollBarDirection;
   import fl.events.ListEvent;
   import flash.geom.Point;
   import caurina.transitions.Tweener;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.FireStatHitCommand;
   
   public class FriendSelector extends MovieClip
   {
      
      public function FriendSelector() {
         super();
      }
      
      private var dfFriends:DrawFrame;
      
      private var listCont:Sprite;
      
      private var scroller:ScrollSystem;
      
      private var friendsOnlineList:TileList;
      
      private var friendsOfflineList:TileList;
      
      private var friendsInviteList:TileList;
      
      private var friendsInviteDP:DataProvider;
      
      private var closeButton:MovieClip;
      
      private var playingNowLimit:Number = 100;
      
      private var overLimit:Boolean = false;
      
      private var scrolling:Boolean;
      
      public var hideChatFriends:Boolean;
      
      public var hideTellAllFriends:Boolean;
      
      public var hideOfflineInvite:Boolean;
      
      private var modelzid:String;
      
      private var tooltip:Tooltip;
      
      private var tooltipParent:DisplayObjectContainer;
      
      private var friendSelectorCellMouseOverIdx:int = 0;
      
      private var fullContainer:int;
      
      private var maxContainer:int;
      
      public var friendsStatusIndicator:MovieClip;
      
      public var availableToPlayDP:DataProvider;
      
      public var facebookFriendsCount:int = 0;
      
      public var availableToPlayList:TileList;
      
      public var currContainerHeight:Number = 0;
      
      public var maxContainerHeight:Number;
      
      public var fullContainerHeight:Number = 388;
      
      private var friendsOnlinePlaceholder:FriendsOnlinePlaceholder;
      
      private var friendsOfflinePlaceholder:FriendsOfflinePlaceholder;
      
      private var playersOnlineNowTF:EmbeddedFontTextField;
      
      private var feedsLoadingIndicator:MovieClip;
      
      private var hideInviteFriendsButton:Boolean = false;
      
      private var _friendSelectorConfig:Object;
      
      public function init(param1:Object, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean) : void {
         this._friendSelectorConfig = param1;
         if((param1.hideFriendSelectorItems) && (param1.hideFriendSelectorItems.indexOf("chatFriends") >= 0) || !param4)
         {
            this.hideChatFriends = true;
         }
         this.hideInviteFriendsButton = param1.hideFriendSelectorInviteFriendsButton;
         if(param1.hideFriendSelectorItems)
         {
            if(param1.hideFriendSelectorItems.indexOf("tellAllFriends") >= 0)
            {
               this.hideTellAllFriends = true;
            }
            if(param1.hideFriendSelectorItems.indexOf("offlineInvite") >= 0)
            {
               this.hideOfflineInvite = true;
            }
         }
         this.facebookFriendsCount = param3;
         this.fullContainer = param6?1:7;
         this.maxContainer = param6?1:3;
         this.maxContainerHeight = FriendSelectorCellBg.HEIGHT * this.maxContainer;
         this.fullContainerHeight = FriendSelectorCellBg.HEIGHT * this.fullContainer;
         this.scrolling = false;
         this.closeButton = PokerClassProvider.getObject("GenericCloseButton");
         this.createDPs();
         this.dfFriends = new DrawFrame(242,param5?this.maxContainerHeight:389,false,false);
         this.dfFriends.renderZLiveTitle(LocaleManager.localize("flash.friendSelector.headers.friendsOnline",{"count":0}));
         addChild(this.dfFriends);
         this.friendsStatusIndicator = PokerClassProvider.getObject("FriendsStatus");
         this.friendsStatusIndicator.buttonMode = false;
         this.friendsStatusIndicator.mouseChildren = false;
         this.friendsStatusIndicator.mouseEnabled = false;
         this.friendsStatusIndicator.x = 1;
         this.friendsStatusIndicator.y = -17.5;
         this.dfFriends.addChild(this.friendsStatusIndicator);
         if(!param5)
         {
            this.playersOnlineNowTF = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.messages.playersOnlineNowMessage",
               {
                  "count":PokerCurrencyFormatter.numberToCurrency(param2,false,0,false),
                  "player":
                     {
                        "type":"tk",
                        "key":"player",
                        "attributes":"",
                        "count":int(param2)
                     }
               }),"Main",16,7764604,"center");
            this.playersOnlineNowTF.width = 240;
            this.playersOnlineNowTF.height = 30;
            this.playersOnlineNowTF.y = 360;
            this.playersOnlineNowTF.alpha = 0;
            this.playersOnlineNowTF.multiline = false;
            this.playersOnlineNowTF.visible = false;
            this.dfFriends.addChild(this.playersOnlineNowTF);
         }
         this.feedsLoadingIndicator = PokerClassProvider.getObject("GiftItemInstSpinner");
         this.feedsLoadingIndicator.x = 240 / 2 - this.feedsLoadingIndicator.width / 2;
         this.feedsLoadingIndicator.y = 285;
         this.dfFriends.addChild(this.feedsLoadingIndicator);
         this.dfFriends.addChild(this.closeButton);
         this.closeButton.x = 230;
         this.closeButton.y = -18;
         this.closeButton.buttonMode = true;
         this.closeButton.useHandCursor = true;
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick);
         this.listCont = new Sprite();
         this.createLists();
         this.cacheAsBitmap = true;
      }
      
      private function onCloseClick(param1:MouseEvent) : void {
         dispatchEvent(new CommonVEvent(CommonVEvent.ZLIVE_HIDE));
      }
      
      public function hideClose(param1:Boolean) : void {
         this.closeButton.visible = !param1;
      }
      
      public function updateFIusers(param1:DataProvider) : void {
      }
      
      public function updatePNusers(param1:DataProvider) : void {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:* = false;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc3_ = param1.getItemAt(_loc6_);
            this.modelzid = _loc3_["uid"];
            _loc2_ = false;
            _loc7_ = 0;
            while(_loc7_ < this.availableToPlayDP.length)
            {
               _loc5_ = this.availableToPlayDP.getItemAt(_loc7_);
               _loc4_ = _loc5_["uid"];
               if(_loc4_ == this.modelzid)
               {
                  _loc2_ = true;
                  this.availableToPlayDP.replaceItemAt(param1.getItemAt(_loc6_),_loc7_);
               }
               _loc7_++;
            }
            if(_loc2_ == false)
            {
               this.availableToPlayDP.addItem(_loc3_);
            }
            _loc6_++;
         }
         _loc2_ = false;
         _loc6_ = 0;
         while(_loc6_ < this.availableToPlayDP.length)
         {
            _loc3_ = this.availableToPlayDP.getItemAt(_loc6_);
            this.modelzid = _loc3_["uid"];
            _loc2_ = false;
            _loc7_ = 0;
            while(_loc7_ < param1.length)
            {
               _loc5_ = param1.getItemAt(_loc7_);
               _loc4_ = _loc5_["uid"];
               if(_loc4_ == this.modelzid)
               {
                  _loc2_ = true;
               }
               _loc7_++;
            }
            if(_loc2_ != true)
            {
               this.availableToPlayDP.removeItem(_loc3_);
            }
            _loc6_++;
         }
         if(this.availableToPlayDP.length > 0)
         {
            this.availableToPlayDP.sortOn(["playStatus","label"],[Array.CASEINSENSITIVE,Array.CASEINSENSITIVE]);
         }
         this.overLimit = false;
         this.updateContainerProperties();
      }
      
      public function updateFONusers(param1:Number) : void {
      }
      
      public function updateFOFFusers(param1:Number) : void {
      }
      
      public function updateFInviteUsers(param1:Number) : void {
      }
      
      private function createDPs() : void {
         this.availableToPlayDP = new DataProvider();
      }
      
      private function createLists() : void {
         this.availableToPlayList = new TileList();
         this.availableToPlayList.setStyle("cellRenderer",FriendSelectorCell);
         this.availableToPlayList.setStyle("skin",FriendSelectorTileListSkin);
         this.availableToPlayList.dataProvider = this.availableToPlayDP;
         this.availableToPlayList.verticalLineScrollSize = FriendSelectorCellBg.HEIGHT;
         this.availableToPlayList.verticalPageScrollSize = FriendSelectorCellBg.HEIGHT;
         this.availableToPlayList.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpScroll);
         this.availableToPlayList.direction = ScrollBarDirection.VERTICAL;
         this.availableToPlayList.columnWidth = FriendSelectorCellBg.WIDTH;
         this.availableToPlayList.columnCount = 1;
         this.availableToPlayList.rowHeight = FriendSelectorCellBg.HEIGHT;
         this.availableToPlayList.rowCount = 0;
         this.availableToPlayList.setSize(this.availableToPlayList.columnWidth,0);
         this.availableToPlayList.x = 2;
         this.availableToPlayList.addEventListener(ListEvent.ITEM_ROLL_OVER,this.onFriendSelectorCellMouseOver);
         this.availableToPlayList.addEventListener(ListEvent.ITEM_ROLL_OUT,this.onFriendSelectorCellMouseOut);
         this.dfFriends.addChild(this.availableToPlayList);
         this.updateContainerProperties();
      }
      
      public function onMouseUpScroll(param1:MouseEvent) : void {
         var _loc2_:int = Math.round(this.availableToPlayList.verticalScrollBar.scrollPosition / FriendSelectorCellBg.HEIGHT);
         this.availableToPlayList.verticalScrollBar.scrollPosition = _loc2_ * FriendSelectorCellBg.HEIGHT;
      }
      
      public function scrollToTop() : void {
      }
      
      public function onChatFriends(param1:MouseEvent) : void {
         dispatchEvent(new CommonVEvent(CommonVEvent.CHAT_FRIENDS));
      }
      
      public function updateDP(param1:DataProvider, param2:String) : void {
      }
      
      private function onFriendSelectorCellMouseOver(param1:ListEvent) : void {
         this.friendSelectorCellMouseOverIdx = param1.index;
      }
      
      private function onFriendSelectorCellMouseOut(param1:ListEvent) : void {
      }
      
      public function showGameBarTooltip() : void {
         var _loc1_:Number = 45 + this.availableToPlayList.rowHeight * this.friendSelectorCellMouseOverIdx;
         this.showTooltip(LocaleManager.localize("flash.friendSelector.tooltips.gameBarTitle"),LocaleManager.localize("flash.friendSelector.tooltips.gameBarBody"),200,21,_loc1_);
      }
      
      private function showTooltip(param1:String, param2:String, param3:Number, param4:Number, param5:Number) : void {
         this.hideTooltip();
         this.tooltipParent = this;
         this.tooltip = new Tooltip(param3,param2,param1);
         var _loc6_:Point = this.tooltipParent.globalToLocal(localToGlobal(new Point(param4,param5)));
         this.tooltip.x = _loc6_.x;
         this.tooltip.y = _loc6_.y;
         this.tooltipParent.addChild(this.tooltip);
      }
      
      public function hideTooltip() : void {
         if(!(this.tooltip == null) && !(this.tooltipParent == null) && (this.tooltipParent.contains(this.tooltip)))
         {
            this.tooltip.visible = false;
            this.tooltipParent.removeChild(this.tooltip);
            this.tooltip = null;
         }
      }
      
      public function updateMaxContainerHeight(param1:int) : void {
         this.maxContainerHeight = this.availableToPlayList.rowHeight * param1;
         if(this.maxContainerHeight > this.fullContainerHeight)
         {
            this.maxContainerHeight = this.fullContainerHeight;
         }
         this.updateContainerProperties();
      }
      
      public function expandFriendSelectorFriendsSectionToFullSize() : void {
         this.updateMaxContainerHeight(this.fullContainer);
         this.hideFeedsLoadingSpinner();
      }
      
      public function updatePlayersOnlineNowText(param1:int) : void {
      }
      
      private function hideFeedsLoadingSpinner() : void {
         if(this.feedsLoadingIndicator)
         {
            Tweener.addTween(this.feedsLoadingIndicator,
               {
                  "alpha":0,
                  "time":0.5,
                  "transition":"easeOutSine",
                  "onComplete":function():void
                  {
                     dfFriends.removeChild(feedsLoadingIndicator);
                     feedsLoadingIndicator = null;
                  }
               });
         }
      }
      
      private function updateContainerProperties() : void {
         if(this.availableToPlayDP.length == 0)
         {
            this.availableToPlayList.setSize(this.availableToPlayList.columnWidth,0);
            if(this.facebookFriendsCount)
            {
               this.friendsStatusIndicator.gotoAndStop(1);
               if(!this.friendsOnlinePlaceholder)
               {
                  this.friendsOnlinePlaceholder = new FriendsOnlinePlaceholder();
                  this.friendsOnlinePlaceholder.x = 2;
                  this.friendsOnlinePlaceholder.inviteToPlayBtn.addEventListener(MouseEvent.CLICK,this.onChatFriends,false,0,true);
                  this.dfFriends.addChild(this.friendsOnlinePlaceholder);
               }
               else
               {
                  this.friendsOnlinePlaceholder.visible = true;
               }
               this.friendsOnlinePlaceholder.updateText(LocaleManager.localize("flash.friendSelector.messages.friendsOnlineMessage",
                  {
                     "count":this.facebookFriendsCount,
                     "friend":
                        {
                           "type":"tk",
                           "key":"friend",
                           "attributes":"",
                           "count":this.facebookFriendsCount
                        }
                  }));
               if(this.friendsOfflinePlaceholder)
               {
                  this.friendsOfflinePlaceholder.visible = false;
               }
            }
            else
            {
               this.friendsStatusIndicator.gotoAndStop(2);
               if(!this.friendsOfflinePlaceholder)
               {
                  this.friendsOfflinePlaceholder = new FriendsOfflinePlaceholder();
                  this.friendsOfflinePlaceholder.x = 2;
                  if(!this.hideInviteFriendsButton)
                  {
                     this.friendsOfflinePlaceholder.inviteFriendsBtn.addEventListener(MouseEvent.CLICK,this.onInviteFriendsClick,false,0,true);
                  }
                  else
                  {
                     this.friendsOfflinePlaceholder.inviteFriendsBtn.visible = false;
                  }
                  this.dfFriends.addChild(this.friendsOfflinePlaceholder);
               }
               else
               {
                  this.friendsOfflinePlaceholder.visible = true;
               }
               if(this.friendsOnlinePlaceholder)
               {
                  this.friendsOnlinePlaceholder.visible = false;
               }
            }
            this.dfFriends.renderZLiveTitle(LocaleManager.localize("flash.friendSelector.headers.friendsOnline",{"count":this.facebookFriendsCount}));
            return;
         }
         this.friendsStatusIndicator.gotoAndStop(1);
         this.dfFriends.renderZLiveTitle(LocaleManager.localize("flash.friendSelector.headers.availableToPlay",{"count":this.availableToPlayDP.length}));
         if(this.friendsOnlinePlaceholder)
         {
            this.friendsOnlinePlaceholder.visible = false;
         }
         if(this.friendsOfflinePlaceholder)
         {
            this.friendsOfflinePlaceholder.visible = false;
         }
         this.currContainerHeight = this.availableToPlayDP.length * this.availableToPlayList.rowHeight;
         if(this.currContainerHeight > this.maxContainerHeight)
         {
            this.currContainerHeight = this.maxContainerHeight;
         }
         this.availableToPlayList.setSize(this.availableToPlayList.columnWidth,this.currContainerHeight);
      }
      
      private function onInviteFriendsClick(param1:MouseEvent) : void {
         this.fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Invite Click i:Lobby:LobbyInvite:2012-01-25"));
         PokerStageManager.hideFullScreenMode();
         dispatchEvent(new CommonVEvent(CommonVEvent.INVITE_FRIENDS));
      }
      
      public function updateVisibility(param1:Boolean) : void {
         visible = param1;
      }
      
      private function onAddMoreBtn(param1:MouseEvent) : void {
         this.availableToPlayDP.addItem(
            {
               "invited":true,
               "label":"Karl" + this.availableToPlayDP.length,
               "source":unescape("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png"),
               "playStatus":"join",
               "tableStakes":"5K/10K",
               "tableType":"normal",
               "uid":"1:1000009597901" + this.availableToPlayDP.length,
               "game_id":"",
               "server_id":"",
               "room_id":"",
               "first_name":"Karl",
               "last_name":"Boghossian",
               "relationship":"friend"
            });
         this.updateContainerProperties();
      }
      
      private function fireStat(param1:PokerStatHit) : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new FireStatHitCommand(param1));
      }
   }
}
