package com.zynga.poker.protocol
{
   public class SPickRoom extends Object
   {
      
      public function SPickRoom(param1:String, param2:String="", param3:int=0) {
         super();
         this.type = param1;
         this.tableType = param2;
         this.smallBlind = param3;
      }
      
      public var type:String;
      
      public var tableType:String;
      
      public var smallBlind:int;
   }
}
