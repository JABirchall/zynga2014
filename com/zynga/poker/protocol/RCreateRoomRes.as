package com.zynga.poker.protocol
{
   public class RCreateRoomRes extends Object
   {
      
      public function RCreateRoomRes(param1:String, param2:int, param3:Array, param4:String="") {
         super();
         this.type = param1;
         this.roomId = param2;
         this.password = param4;
         this.rooms = param3;
      }
      
      public var type:String;
      
      public var roomId:int;
      
      public var password:String;
      
      public var rooms:Array;
   }
}
