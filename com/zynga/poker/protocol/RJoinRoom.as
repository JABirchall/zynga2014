package com.zynga.poker.protocol
{
   public class RJoinRoom extends Object
   {
      
      public function RJoinRoom() {
         super();
      }
      
      public var type:String;
      
      public var roomName:String;
      
      public var roomId:int;
      
      public var numPlayers:int = -1;
      
      public var maxPlayers:int;
      
      public function toString() : String {
         return "roomId=" + this.roomId + ", roomName=" + this.roomName + ", numPlayers=" + this.numPlayers + ", maxPlayers=" + this.maxPlayers;
      }
   }
}
