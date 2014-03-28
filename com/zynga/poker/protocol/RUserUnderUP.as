package com.zynga.poker.protocol
{
   public class RUserUnderUP extends Object
   {
      
      public function RUserUnderUP(param1:String, param2:int, param3:String) {
         super();
         this.type = param1;
         this.sit = param2;
         this.context = param3;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var context:String;
   }
}
