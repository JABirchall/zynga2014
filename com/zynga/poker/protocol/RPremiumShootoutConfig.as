package com.zynga.poker.protocol
{
   public class RPremiumShootoutConfig extends Object
   {
      
      public function RPremiumShootoutConfig(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.shootoutObj = param2;
      }
      
      public var type:String;
      
      public var shootoutObj:Array;
   }
}
