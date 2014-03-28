package com.zynga.poker.protocol
{
   public class RRoomInfo extends Object
   {
      
      public function RRoomInfo(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.aPlayerList = param2;
      }
      
      public var type:String;
      
      public var aPlayerList:Array;
   }
}
