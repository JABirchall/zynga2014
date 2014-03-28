package com.zynga.poker.protocol
{
   public class SSitNGo extends Object
   {
      
      public function SSitNGo(param1:String, param2:Number, param3:int, param4:Boolean=false, param5:Number=0, param6:int=0) {
         super();
         this.type = param1;
         this.buyIn = param2;
         this.sitId = param3;
         this.isFastRR = param4;
         this.tableChips = param5;
         this.smallBlind = param6;
      }
      
      public var type:String;
      
      public var buyIn:Number;
      
      public var sitId:int;
      
      public var isFastRR:Boolean;
      
      public var tableChips:Number;
      
      public var smallBlind:int;
   }
}
