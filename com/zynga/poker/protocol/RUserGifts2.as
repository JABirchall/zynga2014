package com.zynga.poker.protocol
{
   public class RUserGifts2 extends Object
   {
      
      public function RUserGifts2(param1:String, param2:Number, param3:Array) {
         super();
         this.type = param1;
         this.sit = param2;
         this.gifts = param3;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var gifts:Array;
   }
}
