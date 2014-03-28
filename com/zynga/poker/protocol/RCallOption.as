package com.zynga.poker.protocol
{
   public class RCallOption extends Object
   {
      
      public function RCallOption(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.chipsCall = param2;
      }
      
      public var type:String;
      
      public var chipsCall:Number;
   }
}
