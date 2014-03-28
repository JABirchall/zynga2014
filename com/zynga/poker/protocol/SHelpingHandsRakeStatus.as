package com.zynga.poker.protocol
{
   public class SHelpingHandsRakeStatus extends Object
   {
      
      public function SHelpingHandsRakeStatus(param1:String, param2:Boolean) {
         super();
         this.type = param1;
         this.params = {"rakeEnabled":param2};
      }
      
      public var type:String;
      
      public var params:Object;
   }
}
