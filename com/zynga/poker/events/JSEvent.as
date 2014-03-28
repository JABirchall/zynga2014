package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class JSEvent extends Event
   {
      
      public function JSEvent(param1:String, param2:Object=null) {
         super(TYPE_NOTIFYJS);
         this._jsEventType = param1;
         this.params = param2;
      }
      
      public static const TYPE_NOTIFYJS:String = "JSEvent.NotifyJS";
      
      public static const SF_CONNECTED:String = "sfConnected";
      
      public static const SF_DISCONNECTED:String = "sfDisconnected";
      
      public static const SF_MESSAGE_TO_JS:String = "sfMessageToJS";
      
      public static const BRIDGE_CONNECTED:String = "bridgeConnected";
      
      public static const COLLECTIONS_SHOUT:String = "collectionsShout";
      
      public static const LOAD_COMPLETE:String = "loadComplete";
      
      public static const REVEAL_COMPLETE:String = "revealComplete";
      
      public static const NEW_USER_POPUP_CLOSED:String = "newUserPopupClosed";
      
      public static const LEAVING_TABLE:String = "leavingTable";
      
      public static const USER_FOLDED:String = "userFolded";
      
      public static const LOBBY_VISIBLE:String = "lobbyVisible";
      
      public static const LOBBY_HIDDEN:String = "lobbyhidden";
      
      public static const JOINED_TABLE:String = "joinedTable";
      
      public static const ENTER_TABLE:String = "enterTable";
      
      public static const CLAIM_SPONSORED_SHOOTOUTS:String = "claimSponsoredShootouts";
      
      public static const GETCHIPS_CLICKED:String = "getChipsClicked";
      
      public static const GIFTSHOP_CLOSED:String = "giftShopClosed";
      
      public static const NEWS_CLICKED:String = "newsClicked";
      
      public static const SLOT_PLAYED:String = "slotPlayed";
      
      public static const MODULE_CONTROLLER_READY:String = "moduleControllerReady";
      
      public var params:Object;
      
      private var _jsEventType:String;
      
      public function get jsEventType() : String {
         return this._jsEventType;
      }
      
      override public function clone() : Event {
         return new JSEvent(this.jsEventType,this.params);
      }
      
      override public function toString() : String {
         return formatToString("JSEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
