package com.zynga.poker.protocol
{
   public class RRatholingUserState extends Object
   {
      
      public function RRatholingUserState(param1:String, param2:int, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.expireSecs = param2;
         this.roomId = param3;
         this.minBuyin = param4;
      }
      
      public var type:String;
      
      public var expireSecs:int;
      
      public var roomId:Number;
      
      public var minBuyin:Number;
   }
}
