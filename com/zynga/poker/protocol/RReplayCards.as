package com.zynga.poker.protocol
{
   public class RReplayCards extends Object
   {
      
      public function RReplayCards(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.commCards = param2;
      }
      
      public var type:String;
      
      public var commCards:Array;
   }
}
