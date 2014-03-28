package com.zynga.poker.protocol
{
   public class RReplayHoles extends Object
   {
      
      public function RReplayHoles(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) {
         super();
         this.type = param1;
         this.sit = param2;
         this.card1 = param3;
         this.suit1 = param4;
         this.card2 = param5;
         this.suit2 = param6;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var card1:Number;
      
      public var suit1:Number;
      
      public var card2:Number;
      
      public var suit2:Number;
   }
}
