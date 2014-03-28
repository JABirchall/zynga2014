package com.zynga.poker.protocol
{
   public class SBuyGift2 extends Object
   {
      
      public function SBuyGift2(param1:String, param2:Number, param3:Number, param4:String, param5:Boolean=false) {
         super();
         this.type = param1;
         this.giftType = param2;
         this.giftId = param3;
         this.zid = param4;
         this.fromLobby = param5;
      }
      
      public var type:String;
      
      public var giftType:Number;
      
      public var giftId:Number;
      
      public var zid:String;
      
      public var fromLobby:Boolean;
   }
}
