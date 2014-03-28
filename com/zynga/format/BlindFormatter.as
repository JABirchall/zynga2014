package com.zynga.format
{
   import com.zynga.locale.LocaleManager;
   
   public class BlindFormatter extends Object
   {
      
      public function BlindFormatter() {
         super();
      }
      
      public static function formatBlinds(param1:Number, param2:Number, param3:String="") : String {
         var _loc4_:String = "" + param1 + "/" + param2;
         if(param3 != "")
         {
            _loc4_ = _loc4_ + ("/" + param3);
         }
         return _loc4_;
      }
      
      public static function parseBlinds(param1:String) : String {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return param1;
         }
         var _loc3_:String = PokerCurrencyFormatter.numberToCurrency(Number(_loc2_[0]),true,0,false) + "/" + PokerCurrencyFormatter.numberToCurrency(Number(_loc2_[1]),true,0,false);
         if(_loc2_.length == 3 && _loc2_[2] == "Fast")
         {
            _loc3_ = _loc3_ + ("-" + LocaleManager.localize("flash.lobby.gameSelector.subTabs.fastSubTab"));
         }
         return _loc3_;
      }
   }
}
