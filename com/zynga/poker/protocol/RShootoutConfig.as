package com.zynga.poker.protocol
{
   public class RShootoutConfig extends Object
   {
      
      public function RShootoutConfig(param1:String, param2:Object, param3:Object) {
         super();
         this.type = param1;
         this.shootoutObj = param2;
         this.userObj = param3;
      }
      
      public var type:String;
      
      public var shootoutObj:Object;
      
      public var userObj:Object;
   }
}
