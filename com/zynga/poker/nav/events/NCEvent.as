package com.zynga.poker.nav.events
{
   import flash.events.Event;
   
   public class NCEvent extends Event
   {
      
      public function NCEvent(param1:String, param2:String="") {
         super(param1);
         this.sZid = param2;
      }
      
      public static const eType:String = "navControl";
      
      public static const VIEW_INIT:String = "VIEW_INIT";
      
      public static const SHOW_USER_PROFILE:String = "SHOW_USER_PROFILE";
      
      public static const SHOW_GIFT_SHOP:String = "SHOW_GIFT_SHOP";
      
      public static const CLOSE_FLASH_POPUPS:String = "CLOSE_FLASH_POPUPS";
      
      public static const CLOSE_PHP_POPUPS:String = "CLOSE_PHP_POPUPS";
      
      public static const REQUEST_GETCHIPS_SIG:String = "REQUEST_GETCHIPS_SIG";
      
      public static const CLOSE_GIFTSHOP:String = "giftShopClosed";
      
      public var sZid:String;
      
      override public function clone() : Event {
         return new NCEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("NCEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
