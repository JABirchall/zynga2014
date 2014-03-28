package com.zynga.poker.protocol
{
   public class RXPEarned extends Object
   {
      
      public function RXPEarned(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:String) {
         super();
         this.type = param1;
         this.xpDelta = param2;
         this.xpTotal = param3;
         this.xpToNextLevel = param4;
         this.level = param5;
         this.reason = param6;
      }
      
      public var type:String;
      
      public var xpDelta:Number;
      
      public var xpTotal:Number;
      
      public var xpToNextLevel:Number;
      
      public var level:Number;
      
      public var reason:String;
   }
}
