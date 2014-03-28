package com.zynga.poker.protocol
{
   public class SGetRoomInfo2 extends Object
   {
      
      public function SGetRoomInfo2(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.roomId = param2;
      }
      
      public var type:String;
      
      public var roomId:Number;
   }
}
