package com.zynga.poker.protocol
{
   public class RGameAlreadyStarted extends Object
   {
      
      public function RGameAlreadyStarted(param1:String) {
         super();
         this.type = param1;
      }
      
      public var type:String;
   }
}
