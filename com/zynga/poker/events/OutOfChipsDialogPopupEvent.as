package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class OutOfChipsDialogPopupEvent extends PopupEvent
   {
      
      public function OutOfChipsDialogPopupEvent(param1:String, param2:Array, param3:Number, param4:Number, param5:Number) {
         super(param1);
         this._pricePoints = param2;
         this._minBuyIn = param3;
         this._maxBuyIn = param4;
         this._roomId = param5;
      }
      
      private var _pricePoints:Array;
      
      private var _minBuyIn:Number;
      
      private var _maxBuyIn:Number;
      
      private var _roomId:Number;
      
      public function get pricePoints() : Array {
         return this._pricePoints;
      }
      
      public function get minBuyIn() : Number {
         return this._minBuyIn;
      }
      
      public function get maxBuyIn() : Number {
         return this._maxBuyIn;
      }
      
      public function get roomId() : Number {
         return this._roomId;
      }
      
      override public function clone() : Event {
         return new OutOfChipsDialogPopupEvent(this.type,this.pricePoints,this.minBuyIn,this.maxBuyIn,this.roomId);
      }
      
      override public function toString() : String {
         return formatToString("OutOfChipsDialogPopupEvent","type","pricePoints","minBuyIn","maxBuyIn","roomId");
      }
   }
}
