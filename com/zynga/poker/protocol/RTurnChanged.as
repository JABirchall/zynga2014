package com.zynga.poker.protocol
{
   public class RTurnChanged extends Object
   {
      
      public function RTurnChanged(param1:String, param2:int, param3:int) {
         super();
         this.type = param1;
         this.sit = param2;
         this.handId = param3;
      }
      
      public var type:String;
      
      public var sit:int;
      
      public var handId:int;
   }
}
