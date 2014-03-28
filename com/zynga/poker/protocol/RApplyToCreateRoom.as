package com.zynga.poker.protocol
{
   public class RApplyToCreateRoom extends Object
   {
      
      public function RApplyToCreateRoom(param1:String, param2:Boolean) {
         super();
         this.type = param1;
         this.canCreate = param2;
      }
      
      public var type:String;
      
      public var canCreate:Boolean;
   }
}
