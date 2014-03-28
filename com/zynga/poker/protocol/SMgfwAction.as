package com.zynga.poker.protocol
{
   import com.zynga.poker.protocol.mgfw.SMgfwPayload;
   
   public class SMgfwAction extends Object
   {
      
      public function SMgfwAction(param1:String, param2:String, param3:SMgfwPayload) {
         super();
         this.action = param2;
         this.payload = param3;
         this.type = param1;
      }
      
      public var type:String;
      
      public var action:String;
      
      public var payload:SMgfwPayload;
   }
}
