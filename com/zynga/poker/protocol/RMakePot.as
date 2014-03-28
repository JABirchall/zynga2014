package com.zynga.poker.protocol
{
   public class RMakePot extends Object
   {
      
      public function RMakePot(param1:String, param2:int, param3:Array) {
         super();
         this.type = param1;
         this.numPots = param2;
         this.pots = param3;
      }
      
      public var type:String;
      
      public var numPots:int;
      
      public var pots:Array;
   }
}
