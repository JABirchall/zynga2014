package com.zynga.poker.protocol
{
   public class RAlert extends Object
   {
      
      public function RAlert(param1:String, param2:String, param3:Object) {
         super();
         this.type = param1;
         this.sJSON = param2;
         this.oJSON = param3;
      }
      
      public var type:String;
      
      public var sJSON:String;
      
      public var oJSON:Object;
   }
}
