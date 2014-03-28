package com.zynga.poker.protocol
{
   public class RNewBuddy extends Object
   {
      
      public function RNewBuddy(param1:String, param2:String, param3:String) {
         super();
         this.type = param1;
         this.zid = param2;
         this.name = param3;
      }
      
      public var type:String;
      
      public var zid:String;
      
      public var name:String;
   }
}
