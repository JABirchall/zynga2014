package com.zynga.poker.protocol
{
   public class RUserShootoutState extends Object
   {
      
      public function RUserShootoutState(param1:String, param2:Object) {
         super();
         this.type = param1;
         this.userObj = param2;
      }
      
      public var type:String;
      
      public var userObj:Object;
   }
}
