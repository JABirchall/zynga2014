package com.zynga.poker.protocol
{
   public class RJoinRoomError extends Object
   {
      
      public function RJoinRoomError(param1:String, param2:String) {
         super();
         this.type = param1;
         this.sMessage = param2;
      }
      
      public var type:String;
      
      public var sMessage:String;
   }
}
