package com.zynga.poker.protocol
{
   public class SSuperJoinRoom extends Object
   {
      
      public function SSuperJoinRoom(param1:int, param2:String="", param3:String="") {
         super();
         this.type = "SSuperJoinRoom";
         this.nRoomId = param1;
         this.sPassword = param2;
         this.sToFriendId = param3;
      }
      
      public var nAutoRoom:Number = 1;
      
      public var nRoomId:int;
      
      public var sPassword:String;
      
      public var type:String;
      
      public var sToFriendId:String;
   }
}
