package com.zynga.poker.protocol
{
   public class RAllinWar extends Object
   {
      
      public function RAllinWar(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.hands = param2;
      }
      
      public var type:String;
      
      public var hands:Array;
   }
}
