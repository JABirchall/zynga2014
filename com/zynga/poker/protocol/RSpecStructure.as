package com.zynga.poker.protocol
{
   public class RSpecStructure extends Object
   {
      
      public function RSpecStructure(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.userProfiles = param2;
      }
      
      public var type:String;
      
      public var userProfiles:Array;
   }
}
