package com.zynga.poker.protocol
{
   public class SGetCardOptions extends Object
   {
      
      public function SGetCardOptions(param1:String, param2:String) {
         super();
         this.type = param1;
         this.zid = param2;
      }
      
      public var type:String;
      
      public var zid:String;
   }
}
