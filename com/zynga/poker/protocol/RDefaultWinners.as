package com.zynga.poker.protocol
{
   public class RDefaultWinners extends Object
   {
      
      public function RDefaultWinners(param1:String, param2:int, param3:Number, param4:Array) {
         super();
         this.type = param1;
         this.sit = param2;
         this.chips = param3;
         this.pots = param4;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var chips:Number;
      
      public var pots:Array;
   }
}
