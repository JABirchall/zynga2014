package com.zynga.poker.protocol
{
   public class SJSMessageToSmartfox extends Object
   {
      
      public function SJSMessageToSmartfox(param1:String, param2:Object, param3:Boolean) {
         super();
         this.type = param1;
         this.params = param2;
         this.fromLobby = param3;
      }
      
      public var type:String;
      
      public var params:Object;
      
      public var fromLobby:Boolean;
   }
}
