package com.zynga.poker.protocol
{
   public class RReceiveChat extends Object
   {
      
      public function RReceiveChat(param1:String, param2:String, param3:String, param4:String, param5:Boolean) {
         super();
         this.type = param1;
         this.sZid = param2;
         this.sMessage = param3;
         this.sUserName = param4;
         this.bIsModerator = param5;
      }
      
      public var type:String;
      
      public var sZid:String;
      
      public var sMessage:String;
      
      public var sUserName:String;
      
      public var bIsModerator:Boolean;
   }
}
