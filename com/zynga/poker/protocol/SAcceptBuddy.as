package com.zynga.poker.protocol
{
   public class SAcceptBuddy extends Object
   {
      
      public function SAcceptBuddy(param1:String, param2:String) {
         super();
         this.type = "SAcceptBuddy";
         this.zid = param1;
         this.name = param2;
      }
      
      public var type:String;
      
      public var zid:String;
      
      public var name:String;
   }
}
