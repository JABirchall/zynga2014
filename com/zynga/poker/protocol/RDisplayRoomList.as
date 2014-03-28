package com.zynga.poker.protocol
{
   public class RDisplayRoomList extends Object
   {
      
      public function RDisplayRoomList(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.rooms = param2;
      }
      
      public var type:String;
      
      public var rooms:Array;
   }
}
