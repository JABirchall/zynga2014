package com.zynga.poker.protocol
{
   public class RUserLost extends Object
   {
      
      public function RUserLost(param1:String, param2:int) {
         super();
         this.type = param1;
         this.sit = param2;
      }
      
      public var type:String;
      
      public var sit:int;
   }
}
