package com.zynga.poker.protocol
{
   public class SJoinRoom extends Object
   {
      
      public function SJoinRoom(param1:int, param2:String="") {
         super();
         this.type = "SJoinRoom";
         this.nRoomId = param1;
         this.sPassword = param2;
      }
      
      public var nRoomId:int;
      
      public var sPassword:String;
      
      public var type:String;
   }
}
