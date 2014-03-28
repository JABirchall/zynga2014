package com.zynga.poker.protocol
{
   public class RGoldUpdate extends Object
   {
      
      public function RGoldUpdate(param1:String, param2:int) {
         super();
         this.type = param1;
         this.amt = param2;
      }
      
      public var type:String;
      
      public var amt:Number;
   }
}
