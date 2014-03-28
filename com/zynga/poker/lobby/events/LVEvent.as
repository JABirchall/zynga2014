package com.zynga.poker.lobby.events
{
   import flash.events.Event;
   
   public class LVEvent extends Event
   {
      
      public function LVEvent(param1:String, param2:Object=null) {
         super(param1);
         this.oParams = param2;
      }
      
      public static const lobbyView:String = "lobbyView";
      
      public static const onPointsTabClick:String = "onPointsTabClick";
      
      public static const onTourneyTabClick:String = "onTourneyTabClick";
      
      public static const onTourneyTabOver:String = "onTourneyTabOver";
      
      public static const onTourneyTabOut:String = "onTourneyTabOut";
      
      public static const onPrivateTabClick:String = "onPrivateTabClick";
      
      public static const onPremiumTabClick:String = "onPremiumTabClick";
      
      public static const onViewInit:String = "onViewInit";
      
      public static const TABLE_MOUSE_OVER:String = "tableMouseOver";
      
      public static const TABLE_MOUSE_OUT:String = "tableMouseOut";
      
      public static const TABLE_SELECTED:String = "tableSelected";
      
      public static const CASINO_SELECTED:String = "casinoSelected";
      
      public static const FRIEND_SELECTED:String = "friendSelected";
      
      public static const JOIN_ROOM:String = "joinRoom";
      
      public static const LOCKED_ROOM_CLICK:String = "lockedRoomClick";
      
      public static const ROOMINFO:String = "roomInfo";
      
      public static const REFRESH_NETWORK:String = "refreshNetwork";
      
      public static const REFRESH_FRIEND:String = "refreshFriend";
      
      public static const JOIN_USER:String = "joinUser";
      
      public static const CREATE_TABLE:String = "createTable";
      
      public static const CHANGE_CASINO:String = "changeCasino";
      
      public static const FIND_SEAT:String = "findSeat";
      
      public static const SHOW_TUTORIAL:String = "showTutorial";
      
      public static const PLAY_TOURNAMENT:String = "playTournament";
      
      public static const REFRESH_LIST:String = "refreshList";
      
      public static const REFRESH_LOBBY:String = "refreshLobby";
      
      public static const FULL_TABLES:String = "fullTables";
      
      public static const RUNNING_TABLES:String = "runningTables";
      
      public static const EMPTY_TABLES:String = "emptyTables";
      
      public static const PICK_NEW_CASINO:String = "pickNewCasino";
      
      public static const REFRESH_LOBBY_ROOMS:String = "refreshLobbyRooms";
      
      public static const CONNECT_TO_NEW_CASINO:String = "connectToNewCasino";
      
      public static const CANCEL_NEW_CASINO_CONNECT:String = "cancelNewCasinoConnection";
      
      public static const onHelpButtonClick:String = "onHelpButtonClick";
      
      public static const ON_SELECT_FRIEND:String = "onSelectFriend";
      
      public static const RECORD_STAT:String = "RECORD_STAT";
      
      public static const GET_MORE_CHIPS:String = "GET_MORE_CHIPS";
      
      public static const BUZZ_AD_IMPRESSION:String = "BUZZ_AD_IMPRESSION";
      
      public static const BUZZ_AD_CLICK:String = "BUZZ_AD_CLICK";
      
      public static const SHOOTOUT_CLICK:String = "SHOOTOUT_CLICK";
      
      public static const SITNGO_CLICK:String = "SITNGO_CLICK";
      
      public static const MTT_CLICK:String = "MTT_CLICK";
      
      public static const ZPWC_CLICK:String = "ZPWC_CLICK";
      
      public static const WEEKLY_CLICK:String = "WEEKLY_CLICK";
      
      public static const PREMIUM_CLICK:String = "PREMIUM_CLICK";
      
      public static const REGISTER_WEEKLY_CLICK:String = "REGISTER_WEEKLY_CLICK";
      
      public static const BUYIN_CLICK:String = "BUYIN_CLICK";
      
      public static const HOWTOPLAY_CLICK:String = "HOWTOPLAY_CLICK";
      
      public static const SHOOTOUT_LEARNMORE_CLICK:String = "SHOOTOUT_LEARNMORE_CLICK";
      
      public static const ON_TELL_FRIENDS_CHECK_BOX_CLICK:String = "ON_TELL_FRIENDS_CHECK_BOX_CLICK";
      
      public static const REFRESHED_USER_INFO:String = "REFRESHED_USER_INFO";
      
      public static const GIFT_SHOP_CLICK:String = "GIFT_SHOP_CLICK";
      
      public static const SKIP_SHOOTOUT_ROUND_CLICK:String = "SKIP_SHOOTOUT_ROUND_CLICK";
      
      public static const REQUEST_SPONSORED_SHOOTOUTS:String = "requestSponsoredShootouts";
      
      public static const CLAIM_SPONSORED_SHOOTOUTS:String = "claimSponsoredShootouts";
      
      public static const FAST_TABLES_SELECTED:String = "FAST_TABLES_SELECTED";
      
      public static const NORMAL_TABLES_SELECTED:String = "NORMAL_TABLES_SELECTED";
      
      public static const MINMAX_FILTER_BUTTON_CLICK:String = "MINMAX_FILTER_BUTTON_CLICK";
      
      public static const MINMAX_FILTER_SCROLLBAR_CLICK:String = "MINMAX_FILTER_SCROLLBAR_CLICK";
      
      public static const MINMAX_FILTER_KEY_SELECTED:String = "MINMAX_FILTER_KEY_SELECTED";
      
      public static const DISPLAY_ROOM_SORT_DROPDOWN_ARROW:String = "DISPLAY_ROOM_SORT_DROPDOWN_ARROW";
      
      public static const LOBBYGRID_SCROLLBAR_MOUSE_DOWN:String = "LOBBYGRID_SCROLLBAR_MOUSE_DOWN";
      
      public static const LOBBYGRID_SCROLLBAR_CLICK:String = "LOBBYGRID_SCROLLBAR_CLICK";
      
      public static const LOBBYGRID_SCROLLBAR_MOUSE_UP:String = "LOBBYGRID_SCROLLBAR_MOUSE_UP";
      
      public static const LOBBYGRIDLOCK_PURCHASEFASTTABLES:String = "LOBBYGRIDLOCK_PURCHASEFASTTABLES";
      
      public static const LOBBYGRID_ROLLOVER:String = "LOBBYGRID_ROLLOVER";
      
      public static const LOBBYGRID_ROLLOUT:String = "LOBBYGRID_ROLLOUT";
      
      public static const SCRATCHERS_AD_CLICK:String = "onScratchersAdClick";
      
      public static const HIDE_TABLE_REBAL_FTUE:String = "hideTableRebalFTUE";
      
      public static const BLACKJACK_AD_CLICK:String = "onBlackjackAdClick";
      
      public static const POKER_GENIUS_AD_CLICK:String = "onPokerGeniusAdClick";
      
      public static const ADD_VIEW_TO_LAYER:String = "addViewToLayer";
      
      public static const SHOW_VIDEO_POKER:String = "showVideoPoker";
      
      public static const VIDEO_POKER_IMPRESSION:String = "videoPokerImpression";
      
      public var oParams:Object;
      
      override public function clone() : Event {
         return new LVEvent(this.type,this.oParams);
      }
      
      override public function toString() : String {
         return formatToString("ProtocolEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
