package com.zynga.poker.events
{
   public class ShowLuckyBonusPopupEvent extends PopupEvent
   {
      
      public function ShowLuckyBonusPopupEvent(param1:Boolean=false) {
         super("showLuckyBonus");
         this._bShowGold = param1;
      }
      
      private var _bShowGold:Boolean;
      
      public function get bShowGold() : Boolean {
         return this._bShowGold;
      }
   }
}
