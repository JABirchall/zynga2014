package com.zynga.poker.lobby.events.view
{
   import flash.events.Event;
   
   public class LobbyAdContainerEvent extends Event
   {
      
      public function LobbyAdContainerEvent(param1:String, param2:String="") {
         super(param1);
         this._adNameKey = param2;
      }
      
      public static const ON_AD_PRE_DISPLAY:String = "onAdPreDisplay";
      
      public static const ON_AD_DISPLAY:String = "onAdDisplay";
      
      public static const ON_AD_PRE_REMOVE:String = "onAdPreRemove";
      
      public static const ON_AD_REMOVE:String = "onAdRemove";
      
      private var _adNameKey:String;
      
      public function get adNameKey() : String {
         return this._adNameKey;
      }
      
      override public function clone() : Event {
         return new LobbyAdContainerEvent(type,this._adNameKey);
      }
      
      override public function formatToString(param1:String, ... rest) : String {
         return super.formatToString("LobbyAdContainerEvent","type","adNameKey","bubbles","cancelable","eventPhase");
      }
   }
}
