package com.zynga.poker.protocol
{
   public class RUserSitOut extends Object
   {
      
      public function RUserSitOut(param1:String, param2:int) {
         super();
         this.type = param1;
         this.sit = param2;
      }
      
      public var type:String;
      
      public var sit:int;
   }
}
