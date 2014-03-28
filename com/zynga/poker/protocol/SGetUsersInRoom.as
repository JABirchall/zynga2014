package com.zynga.poker.protocol
{
   public class SGetUsersInRoom extends Object
   {
      
      public function SGetUsersInRoom(param1:String, param2:String, param3:int) {
         super();
         this.type = param1;
         this.userId = param2;
         this.roomId = param3;
      }
      
      public var type:String;
      
      public var roomId:int;
      
      public var userId:String;
   }
}
