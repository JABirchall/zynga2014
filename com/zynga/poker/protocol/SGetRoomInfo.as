package com.zynga.poker.protocol
{
   public class SGetRoomInfo extends Object
   {
      
      public function SGetRoomInfo(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.roomId = param2;
      }
      
      public var type:String;
      
      public var roomId:Number;
   }
}
