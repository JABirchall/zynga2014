package com.zynga.poker.protocol
{
   public class RTourneyOver extends Object
   {
      
      public function RTourneyOver(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.place = param2;
         this.win = param3;
      }
      
      public var type:String;
      
      public var place:Number;
      
      public var win:Number;
   }
}
