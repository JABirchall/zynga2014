package com.zynga.poker.protocol
{
   public class SGetGiftPrices3 extends Object
   {
      
      public function SGetGiftPrices3(param1:String, param2:Number, param3:String, param4:Boolean=false) {
         super();
         this.type = param1;
         this.giftType = param2;
         this.toZid = param3;
         this.isInLobby = param4;
      }
      
      public var type:String;
      
      public var giftType:Number;
      
      public var toZid:String;
      
      public var isInLobby:Boolean;
   }
}
