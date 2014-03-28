package com.zynga.poker.protocol
{
   public class RRoomInfo2 extends Object
   {
      
      public function RRoomInfo2(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.aPlayerList = param2;
      }
      
      public var type:String;
      
      public var aPlayerList:Array;
   }
}
