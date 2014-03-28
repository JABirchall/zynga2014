package com.zynga.poker.protocol
{
   public class RRoomPicked extends Object
   {
      
      public function RRoomPicked(param1:String, param2:int, param3:int, param4:String="") {
         super();
         this.type = param1;
         this.roomId = param2;
         this.bucket = param3;
         this.sIp = param4;
      }
      
      public var type:String;
      
      public var roomId:int;
      
      public var bucket:int;
      
      public var sIp:String;
   }
}
