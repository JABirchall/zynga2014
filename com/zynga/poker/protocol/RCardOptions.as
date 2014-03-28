package com.zynga.poker.protocol
{
   public class RCardOptions extends Object
   {
      
      public function RCardOptions(param1:String, param2:String, param3:String) {
         super();
         this.type = param1;
         this.zid = param2;
         this.msgType = param3;
      }
      
      public var type:String;
      
      public var zid:String;
      
      public var msgType:String;
   }
}
