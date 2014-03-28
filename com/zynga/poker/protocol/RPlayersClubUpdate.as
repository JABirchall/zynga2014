package com.zynga.poker.protocol
{
   public class RPlayersClubUpdate extends Object
   {
      
      public function RPlayersClubUpdate(param1:String, param2:String, param3:int) {
         super();
         this.type = param1;
         this.tier = param2;
         this.seat = param3;
      }
      
      public var type:String = "";
      
      public var tier:String = "";
      
      public var seat:int = -1;
   }
}
