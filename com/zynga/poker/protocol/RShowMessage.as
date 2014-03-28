package com.zynga.poker.protocol
{
   public class RShowMessage extends Object
   {
      
      public function RShowMessage(param1:String, param2:String) {
         super();
         this.type = param1;
         this.message = param2;
      }
      
      public var type:String;
      
      public var message:String;
   }
}
