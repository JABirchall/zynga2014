package com.zynga.poker.protocol
{
   public class RAcquireToken extends Object
   {
      
      public function RAcquireToken(param1:String, param2:String, param3:Date, param4:int) {
         super();
         this.type = param1;
         this.token = param2;
         this.expirationDate = param3;
         this.tokenCounter = param4;
      }
      
      public var type:String;
      
      public var token:String;
      
      public var expirationDate:Date;
      
      public var tokenCounter:int;
   }
}
