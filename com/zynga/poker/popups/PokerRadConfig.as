package com.zynga.poker.popups
{
   import com.zynga.rad.RadConfig;
   import com.zynga.rad.BaseUI;
   import flash.display.Stage;
   
   public class PokerRadConfig extends RadConfig
   {
      
      public function PokerRadConfig(param1:Stage) {
         super();
         m_stage = param1;
      }
      
      private var _rtl:int = -1;
      
      override public function get rtl() : Number {
         if(this._rtl != BaseUI.BIDI_UNSET)
         {
            return this._rtl;
         }
         if(!(ZLoc.instance == null) && ZLoc.instance.localeCode.substring(0,2).toLowerCase() == "ar")
         {
            this._rtl = BaseUI.BIDI_RTL;
         }
         else
         {
            this._rtl = BaseUI.BIDI_LTR;
         }
         return this._rtl;
      }
   }
}
