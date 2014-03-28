package com.zynga.poker.protocol
{
   public class SAddBuddy extends Object
   {
      
      public function SAddBuddy(param1:String, param2:String) {
         super();
         this.type = param1;
         this.zid = param2;
      }
      
      public var type:String;
      
      public var zid:String;
   }
}
