package com.zynga.poker.protocol
{
   public class RBlindChange extends Object
   {
      
      public function RBlindChange(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.blind = param2;
      }
      
      public var type:String;
      
      public var blind:Number;
   }
}
