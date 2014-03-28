package com.zynga.poker.protocol
{
   public class SGetChipsSig extends Object
   {
      
      public function SGetChipsSig(param1:String, param2:Boolean) {
         super();
         this.type = param1;
         this.fromLobby = param2;
      }
      
      public var type:String;
      
      public var fromLobby:Boolean;
   }
}
