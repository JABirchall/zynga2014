package com.zynga.ui.lobbyBanner
{
   import flash.events.Event;
   
   public class LobbyBannerEvent extends Event
   {
      
      public function LobbyBannerEvent(param1:String, param2:String="", param3:String="", param4:Boolean=false, param5:Boolean=false) {
         super(param1,param4,param5);
         this._actionType = param2;
         this._bannerType = param3;
      }
      
      public static const TYPE_CLOSE:String = "lobbyBannerClose";
      
      public static const TYPE_DISABLE:String = "lobbyBannerDisable";
      
      public static const TYPE_ACTION:String = "lobbyBannerAction";
      
      public static const TYPE_MTT_BANNER:String = "lobbyBannerMtt";
      
      private var _actionType:String;
      
      public function get actionType() : String {
         return this._actionType;
      }
      
      private var _bannerType:String;
      
      public function get bannerType() : String {
         return this._bannerType;
      }
      
      override public function clone() : Event {
         return new LobbyBannerEvent(type,this._actionType,this._bannerType,bubbles,cancelable);
      }
   }
}
