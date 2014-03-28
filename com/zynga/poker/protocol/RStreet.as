package com.zynga.poker.protocol
{
   public class RStreet extends Object
   {
      
      public function RStreet(param1:String, param2:String, param3:Number) {
         super();
         this.type = param1;
         this.card1 = param2;
         this.tip1 = param3;
      }
      
      public var type:String;
      
      public var card1:String;
      
      public var tip1:Number;
   }
}
