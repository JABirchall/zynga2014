package com.zynga.poker.protocol
{
   public class RBuddyRequest extends Object
   {
      
      public function RBuddyRequest(param1:String, param2:int, param3:String, param4:String) {
         super();
         this.type = param1;
         this.shoutId = param2;
         this.zid = param3;
         this.name = param4;
      }
      
      public var type:String;
      
      public var shoutId:int;
      
      public var zid:String;
      
      public var name:String;
   }
}
