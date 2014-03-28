package com.zynga.poker.protocol
{
   public class SHeartBeatRes extends Object
   {
      
      public function SHeartBeatRes(param1:String, param2:String) {
         super();
         this.type = param1;
         this.id = param2;
      }
      
      public var type:String;
      
      public var id:String;
   }
}
