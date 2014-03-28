package com.zynga.poker.smartfox.messages
{
   public class SmartfoxRequest extends SmartfoxMessage
   {
      
      public function SmartfoxRequest(param1:String="", param2:String="", param3:String="xml") {
         super(param1,param3);
         this._name = param2;
      }
      
      public static const ZONE_TEXASHOLDEMUP:String = "TexasHoldemUp";
      
      public static const ZONE_SITNGO:String = "PokerSitNGo";
      
      public static const ZONE_SHOOTOUT:String = "PokerShootout";
      
      public static const ZONE_CASINO:String = "ZyngaCasino";
      
      public static const XTNAME_CASINOGAME:String = "CasinoGame";
      
      private var _name:String;
      
      public function get name() : String {
         return this._name;
      }
      
      public function toSfxObject() : Object {
         return {"_cmd":command};
      }
   }
}
