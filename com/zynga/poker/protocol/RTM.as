package com.zynga.poker.protocol
{
   public class RTM extends Object
   {
      
      public function RTM(param1:String, param2:Number) {
         super();
         this.type = param1;
         this.chips = param2;
      }
      
      public var type:String;
      
      public var chips:Number;
   }
}
