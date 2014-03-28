package com.zynga.poker.protocol
{
   public class RShowAllHoles extends Object
   {
      
      public function RShowAllHoles(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.hands = param2;
      }
      
      public var type:String;
      
      public var hands:Array;
   }
}
