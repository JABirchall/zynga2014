package com.zynga.poker.protocol
{
   public class RSmartfoxMessageToJS extends Object
   {
      
      public function RSmartfoxMessageToJS(param1:String, param2:String, param3:Object, param4:String) {
         super();
         this.type = param1;
         this.messageName = param2;
         this.message = param3;
         this.jsDest = param4;
      }
      
      public var type:String;
      
      public var messageName:String;
      
      public var message:Object;
      
      public var jsDest:String;
   }
}
