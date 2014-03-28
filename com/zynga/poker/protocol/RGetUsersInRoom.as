package com.zynga.poker.protocol
{
   public class RGetUsersInRoom extends Object
   {
      
      public function RGetUsersInRoom(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.userList = param2;
      }
      
      public var type:String;
      
      public var userList:Array;
   }
}
