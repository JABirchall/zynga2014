package com.zynga.poker.protocol
{
   public class RNOPC extends Object
   {
      
      public function RNOPC(param1:String, param2:Number, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.roomId = param2;
         this.players = param3;
         this.status = param4;
      }
      
      public var type:String;
      
      public var roomId:Number;
      
      public var players:Number;
      
      public var status:Number;
   }
}
