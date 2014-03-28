package com.zynga.poker.protocol
{
   public class SHandStrengthMeterStatus extends Object
   {
      
      public function SHandStrengthMeterStatus(param1:String, param2:int) {
         super();
         this.type = param1;
         this.params = {"status":param2};
      }
      
      public var type:String;
      
      public var params:Object;
   }
}
