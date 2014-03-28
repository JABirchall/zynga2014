package com.zynga.poker.protocol
{
   public class SGetRoomPass extends Object
   {
      
      public function SGetRoomPass(param1:String, param2:int) {
         super();
         this.type = param1;
         this.roomId = param2;
      }
      
      public var type:String;
      
      public var roomId:int;
   }
}
