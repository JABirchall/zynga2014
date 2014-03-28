package com.zynga.poker.protocol
{
   public class RWrongRound extends Object
   {
      
      public function RWrongRound(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.nUserRound = param2;
         this.nRoomRound = param3;
      }
      
      public var type:String;
      
      public var nUserRound:Number;
      
      public var nRoomRound:Number;
   }
}
