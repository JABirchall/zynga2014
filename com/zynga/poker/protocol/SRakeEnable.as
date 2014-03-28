package com.zynga.poker.protocol
{
   public class SRakeEnable extends Object
   {
      
      public function SRakeEnable(param1:String, ... rest) {
         var _loc3_:* = undefined;
         super();
         this.type = param1;
         this.params = new Object();
         for each (_loc3_ in rest)
         {
            this.params[_loc3_.toString()] = 1;
         }
      }
      
      public var type:String;
      
      public var params:Object;
   }
}
