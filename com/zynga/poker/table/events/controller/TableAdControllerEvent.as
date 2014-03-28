package com.zynga.poker.table.events.controller
{
   import flash.events.Event;
   
   public class TableAdControllerEvent extends Event
   {
      
      public function TableAdControllerEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const GET_AD_TOOLTIP:String = "getAdTooltip";
      
      public static const GET_AD_TOOLTIP_COMPLETE:String = "getAdTooltipComplete";
      
      public static const GET_AD_VALIDATOR:String = "getAdValidator";
      
      public static const GET_AD_VALIDATOR_COMPLETE:String = "getAdValidatorComplete";
      
      public static const STOP_ADS:String = "stopAds";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new TableAdControllerEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("TableAdControllerEvent","type","bubbles","cancelable","eventPhase","params");
      }
   }
}
