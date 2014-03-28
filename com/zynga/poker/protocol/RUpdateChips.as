package com.zynga.poker.protocol
{
   public class RUpdateChips extends Object
   {
      
      public function RUpdateChips(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.playerChips = param2;
      }
      
      public var type:String;
      
      public var playerChips:Array;
   }
}
