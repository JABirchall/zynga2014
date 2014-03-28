package com.zynga.poker.table.events.controller
{
   import flash.events.Event;
   
   public class BettingPanelControllerEvent extends Event
   {
      
      public function BettingPanelControllerEvent(param1:String, param2:Object=null) {
         super(param1);
         this._params = param2;
      }
      
      public static const TYPE_BET_POT:String = "BPCE.BetPot";
      
      public static const TYPE_BET_HALF_POT:String = "BPCE.BetHalfPot";
      
      public static const TYPE_CALL:String = "BPCE.Call";
      
      public static const TYPE_FOLD:String = "BPCE.Fold";
      
      public static const TYPE_RAISE:String = "BPCE.Raise";
      
      public static const TYPE_BOT_DETECTED_BY_FOLD_POS:String = "BPCE.BotDetected";
      
      private var _params:Object;
      
      public function get params() : Object {
         return this._params;
      }
      
      override public function clone() : Event {
         return new BettingPanelControllerEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("BettingPanelControllerEvent","type","bubbles","cancelable","eventPhase","params");
      }
   }
}
