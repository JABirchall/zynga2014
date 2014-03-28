package com.zynga.poker.table.betting
{
   import com.zynga.locale.LocaleManager;
   
   public class BetButtonSize extends Object
   {
      
      public function BetButtonSize() {
         super();
      }
      
      private static const MAX_STATIC_BIG_BUTTON_TEXT_LENGTH:int = 10;
      
      private static const MAX_DYNAMIC_BIG_BUTTON_TEXT_LENGTH:int = 4;
      
      private static const MAX_STATIC_SMALL_BUTTON_TEXT_LENGTH:int = 6;
      
      private static var bettingButtonSize:Object = null;
      
      public static function isMaxButtonSize() : Boolean {
         if(bettingButtonSize == null)
         {
            bettingButtonSize = new Boolean();
            if(LocaleManager.localize("flash.table.controls.checkButton").length > MAX_STATIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.foldButton").length > MAX_STATIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.callAnyButton").length > MAX_STATIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.checkFoldButton").length > MAX_STATIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.raiseButton").length > MAX_STATIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.callButton").length > MAX_DYNAMIC_BIG_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.allInButton").length > MAX_STATIC_SMALL_BUTTON_TEXT_LENGTH || LocaleManager.localize("flash.table.controls.betPotButton").length > MAX_STATIC_SMALL_BUTTON_TEXT_LENGTH)
            {
               bettingButtonSize = true;
            }
            else
            {
               bettingButtonSize = false;
            }
         }
         return bettingButtonSize as Boolean;
      }
   }
}
