package com.zynga.poker.protocol
{
   public class SSendTableBuddyCount extends Object
   {
      
      public function SSendTableBuddyCount(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.buddycount = param2;
      }
      
      public var type:String;
      
      public var buddycount:Number;
   }
}
