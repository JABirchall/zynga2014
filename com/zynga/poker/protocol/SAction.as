package com.zynga.poker.protocol
{
   public class SAction extends Object
   {
      
      public function SAction(param1:String, param2:Number, param3:String) {
         super();
         this.type = param1;
         this.chips = param2;
         this.action = param3;
      }
      
      public var type:String;
      
      public var chips:Number;
      
      public var action:String;
   }
}
