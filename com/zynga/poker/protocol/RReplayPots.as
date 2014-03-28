package com.zynga.poker.protocol
{
   public class RReplayPots extends Object
   {
      
      public function RReplayPots(param1:String, param2:Number, param3:Array) {
         super();
         this.type = param1;
         this.numPots = param2;
         this.pots = param3;
      }
      
      public var type:String;
      
      public var numPots:Number;
      
      public var pots:Array;
   }
}
