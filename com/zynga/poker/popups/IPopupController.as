package com.zynga.poker.popups
{
   public interface IPopupController
   {
      
      function getPopupConfigByID(param1:String, param2:Boolean=false, param3:Function=null, ... rest) : Popup;
      
      function closeAllPopups(param1:Boolean=false) : void;
   }
}
