package com.zynga.poker.protocol
{
   public class SSitShootout extends Object
   {
      
      public function SSitShootout(param1:String, param2:Number, param3:int, param4:Number, param5:Boolean=false, param6:Number=0, param7:int=0) {
         super();
         this.type = param1;
         this.buyIn = param2;
         this.sitId = param3;
         this.round = param4;
         this.isFastRR = param5;
         this.tableChips = param6;
         this.smallBlind = param7;
      }
      
      public var type:String;
      
      public var buyIn:Number;
      
      public var sitId:int;
      
      public var round:Number;
      
      public var isFastRR:Boolean;
      
      public var tableChips:Number;
      
      public var smallBlind:int;
   }
}
