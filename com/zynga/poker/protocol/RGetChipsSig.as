package com.zynga.poker.protocol
{
   public class RGetChipsSig extends Object
   {
      
      public function RGetChipsSig(param1:String, param2:String) {
         super();
         this.type = param1;
         this.sig = param2;
      }
      
      public var type:String;
      
      public var sig:String;
   }
}
