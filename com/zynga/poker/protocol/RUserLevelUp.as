package com.zynga.poker.protocol
{
   public class RUserLevelUp extends Object
   {
      
      public function RUserLevelUp(param1:String, param2:Number, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.zId = param2;
         this.rank = param3;
         this.showBurst = param4;
      }
      
      public var type:String;
      
      public var zId:Number;
      
      public var rank:Number;
      
      public var showBurst:Number;
   }
}
