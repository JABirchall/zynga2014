package com.zynga.poker.protocol
{
   public class RMgfwResponse extends Object
   {
      
      public function RMgfwResponse(param1:String, param2:Object) {
         super();
         this.type = param1;
         this.mgfwPayload = param2;
      }
      
      public var type:String;
      
      public var mgfwPayload:Object;
   }
}
