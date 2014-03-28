package com.zynga.poker.protocol
{
   public class RFlop extends Object
   {
      
      public function RFlop(param1:String, param2:String, param3:Number, param4:String, param5:Number, param6:String, param7:Number) {
         super();
         this.type = param1;
         this.card1 = param2;
         this.tip1 = param3;
         this.card2 = param4;
         this.tip2 = param5;
         this.card3 = param6;
         this.tip3 = param7;
      }
      
      public var type:String;
      
      public var card1:String;
      
      public var tip1:Number;
      
      public var card2:String;
      
      public var tip2:Number;
      
      public var card3:String;
      
      public var tip3:Number;
   }
}
