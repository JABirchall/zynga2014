package com.zynga.poker.protocol
{
   public class RFold extends Object
   {
      
      public function RFold(param1:String, param2:int) {
         super();
         this.type = param1;
         this.sit = param2;
      }
      
      public var type:String;
      
      public var sit:int;
   }
}
