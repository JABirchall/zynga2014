package com.zynga.poker.protocol
{
   public class RSetMod extends Object
   {
      
      public function RSetMod(param1:String, param2:Boolean) {
         super();
         this.type = param1;
         this.isMod = param2;
      }
      
      public var type:String;
      
      public var isMod:Boolean;
   }
}
