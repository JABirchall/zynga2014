package com.zynga.poker.protocol
{
   public class RInitGameRoom extends Object
   {
      
      public function RInitGameRoom(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.aUsers = param2;
      }
      
      public var type:String;
      
      public var aUsers:Array;
   }
}
