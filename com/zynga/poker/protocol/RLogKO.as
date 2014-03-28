package com.zynga.poker.protocol
{
   public class RLogKO extends Object
   {
      
      public function RLogKO(param1:String, param2:Boolean, param3:String, param4:Boolean) {
         super();
         this.type = param1;
         this.success = param2;
         this.message = param3;
         this.cancelable = param4;
      }
      
      public var type:String;
      
      public var success:Boolean;
      
      public var message:String;
      
      public var cancelable:Boolean;
   }
}
