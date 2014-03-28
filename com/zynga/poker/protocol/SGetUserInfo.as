package com.zynga.poker.protocol
{
   public class SGetUserInfo extends Object
   {
      
      public function SGetUserInfo(param1:String, ... rest) {
         super();
         this.type = param1;
         this.reqParams = new Object();
         var _loc3_:* = 0;
         while(_loc3_ < rest.length)
         {
            this.reqParams[rest[_loc3_].toString()] = 1;
            _loc3_++;
         }
      }
      
      public var type:String;
      
      public var reqParams:Object;
   }
}
