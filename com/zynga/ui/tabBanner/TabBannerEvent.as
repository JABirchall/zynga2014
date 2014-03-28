package com.zynga.ui.tabBanner
{
   import flash.events.Event;
   
   public class TabBannerEvent extends Event
   {
      
      public function TabBannerEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const CLOSE:String = "tabBannerClose";
      
      public static const DISABLE:String = "tabBannerDisable";
      
      public static const ZPWC_REDIRECT:String = "tabBannerZPWCRedirect";
      
      override public function clone() : Event {
         return new TabBannerEvent(type,bubbles,cancelable);
      }
   }
}
