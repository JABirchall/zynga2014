package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class ProfileEvent extends Event
   {
      
      public function ProfileEvent(param1:String, param2:Object=null) {
         super(param1,true);
         this.params = param2;
      }
      
      public static const CASINO_SHOP_CLICK:String = "CASINO_SHOP_CLICK";
      
      public static const CLAIM_COLLECTION:String = "CLAIM_COLLECTION";
      
      public static const DISPLAY_TAB:String = "DISPLAY_TAB";
      
      public static const ITEM_SELECTED:String = "ITEM_SELECTED";
      
      public static const ITEM_CANCELED:String = "ITEM_CANCELED";
      
      public static const SEND_CHIPS_CLICK:String = "SEND_CHIPS_CLICK";
      
      public static const TRADE_COLLECTION_ITEM:String = "TRADE_COLLECTION_ITEM";
      
      public static const WISHLIST_COLLECTION_ITEM:String = "WISHLIST_COLLECTION_ITEM";
      
      public static const REPORT_ABUSE:String = "REPORT_ABUSE";
      
      public static const MODERATE:String = "MODERATE";
      
      public static const TAB_CHANGE:String = "ProfileEvent.tabChange";
      
      public static const HIDE_POPUP:String = "ProfileEvent.hidePopup";
      
      public static const TAB_LOAD_COMPLETE:String = "ProfileEvent.tabLoadComplete";
      
      public static const SELECT_TAB:String = "ProfileEvent.selectTab";
      
      public static const SHOW_BUDDIES_PANEL:String = "ProfileEvent.showBuddiesPanel";
      
      public static const PLAYER_NAME_UPDATED:String = "ProfileEvent.playerNameUpdated";
      
      public var params:Object = null;
      
      override public function clone() : Event {
         return new ProfileEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("ProfileEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
