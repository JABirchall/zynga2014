package com.zynga.poker.popups.events
{
   import flash.events.Event;
   
   public class PPVEvent extends Event
   {
      
      public function PPVEvent(param1:String, param2:Object=null) {
         super(param1);
         this.oParams = param2;
      }
      
      public static const eType:String = "popupView";
      
      public static const CLOSE:String = "CLOSE";
      
      public static const REFRESH:String = "REFRESH";
      
      public static const PRIVATE_TABLE_YES:String = "PRIVATE_TABLE_YES";
      
      public static const PRIVATE_TABLE_NO:String = "PRIVATE_TABLE_NO";
      
      public static const ENTER_PASS:String = "ENTER_PASS";
      
      public static const CONFIRM:String = "CONFIRM";
      
      public static const TOURNEY_BUYIN:String = "TOURNEY_BUYIN";
      
      public static const TOURNEY_CONGRATS_CLOSE:String = "TOURNEY_CONGRATS_CLOSE";
      
      public static const SHOOTOUT_CONGRATS_CLOSE:String = "SHOOTOUT_CONGRATS_CLOSE";
      
      public static const SHOOTOUT_ERROR_CLOSE:String = "SHOOTOUT_ERROR_CLOSE";
      
      public static const CLOSE_AND_CHECK_LAST:String = "CLOSE_AND_CHECK_LAST";
      
      public static const SHOW_GET_CHIPS_PANEL:String = "SHOW_GET_CHIPS_PANEL";
      
      public static const FORCE_CHIP_UPDATE:String = "FORCE_CHIP_UPDATE";
      
      public var oParams:Object;
      
      override public function clone() : Event {
         return new PPVEvent(this.type,this.oParams);
      }
      
      override public function toString() : String {
         return formatToString("PPVEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
