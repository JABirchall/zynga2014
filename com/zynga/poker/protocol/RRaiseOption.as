package com.zynga.poker.protocol
{
   public class RRaiseOption extends Object
   {
      
      public function RRaiseOption(param1:String, param2:Number, param3:Number, param4:Number, param5:Boolean=false) {
         super();
         this.type = param1;
         this.chipsCall = param2;
         this.minVal = param3;
         this.maxVal = param4;
         this.raiseCountOverLimit = param5;
      }
      
      public var type:String;
      
      public var chipsCall:Number;
      
      public var minVal:Number;
      
      public var maxVal:Number;
      
      public var raiseCountOverLimit:Boolean = false;
   }
}
