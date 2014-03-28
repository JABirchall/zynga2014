package com.zynga.poker.table.events.view
{
   import flash.events.Event;
   
   public class BettingPanelViewEvent extends Event
   {
      
      public function BettingPanelViewEvent(param1:String, param2:Object=null) {
         super(param1);
         this._params = param2;
      }
      
      public static const TYPE_ALL_IN:String = "BPVE.AllIn";
      
      public static const TYPE_BET_POT:String = "BPVE.BetPot";
      
      public static const TYPE_BET_HALF_POT:String = "BPVE.BetHalfPot";
      
      public static const TYPE_CALL:String = "BPVE.Call";
      
      public static const TYPE_FOLD:String = "BPVE.Fold";
      
      public static const TYPE_RAISE:String = "BPVE.Raise";
      
      public static const TYPE_BOT_DETECTED_BY_FOLD_POS:String = "BPVE.BotDetected";
      
      private var _params:Object;
      
      public function get params() : Object {
         return this._params;
      }
      
      override public function clone() : Event {
         return new BettingPanelViewEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("BettingPanelViewEvent","type","bubbles","cancelable","eventPhase","params");
      }
   }
}
