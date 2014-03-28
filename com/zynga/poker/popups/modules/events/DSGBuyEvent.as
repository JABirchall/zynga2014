package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class DSGBuyEvent extends DSGEvent
   {
      
      public function DSGBuyEvent(param1:String, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Number, param8:Array=null) {
         super(param1,param2);
         this.nGiftCat = param3;
         this.nGiftId = param4;
         this.bBuyForTable = param5;
         this.bSelect = param6;
         this.nAmount = param7;
         this.aZids = param8;
      }
      
      public var nGiftCat:int;
      
      public var nGiftId:int;
      
      public var bBuyForTable:Boolean = false;
      
      public var bSelect:Boolean = false;
      
      public var nAmount:Number;
      
      public var aZids:Array;
      
      override public function clone() : Event {
         return new DSGBuyEvent(this.type,this.sZid,this.nGiftCat,this.nGiftId,this.bBuyForTable,this.bSelect,this.nAmount);
      }
      
      override public function toString() : String {
         return formatToString("DSGBuyEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
