package com.zynga.poker.protocol
{
   public class RReplayPlayers extends Object
   {
      
      public function RReplayPlayers(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.sits = param2;
      }
      
      public var type:String;
      
      public var sits:Array;
   }
}
