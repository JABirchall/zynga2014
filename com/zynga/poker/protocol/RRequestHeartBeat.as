package com.zynga.poker.protocol
{
   public class RRequestHeartBeat extends Object
   {
      
      public function RRequestHeartBeat(param1:String, param2:String, param3:int) {
         super();
         this.type = param1;
         this.id = param2;
         this.delay = param3;
      }
      
      public var type:String;
      
      public var id:String;
      
      public var delay:int;
   }
}
