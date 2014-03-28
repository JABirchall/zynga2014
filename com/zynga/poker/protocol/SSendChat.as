package com.zynga.poker.protocol
{
   public class SSendChat extends Object
   {
      
      public function SSendChat(param1:String, param2:String) {
         super();
         this.type = param1;
         this.sMsg = param2;
      }
      
      public var type:String;
      
      public var sMsg:String;
   }
}
