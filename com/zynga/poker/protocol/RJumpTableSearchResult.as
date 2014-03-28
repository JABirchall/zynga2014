package com.zynga.poker.protocol
{
   import com.zynga.poker.lobby.RoomItem;
   
   public class RJumpTableSearchResult extends Object
   {
      
      public function RJumpTableSearchResult(param1:String, param2:RoomItem) {
         super();
         this.type = param1;
         this.roomItem = param2;
      }
      
      public var type:String;
      
      public var roomItem:RoomItem;
   }
}
