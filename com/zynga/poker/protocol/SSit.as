package com.zynga.poker.protocol
{
   public class SSit extends Object
   {
      
      public function SSit(param1:String, param2:Number, param3:int, param4:int, param5:int=0, param6:int=0, param7:int=0, param8:int=0, param9:Boolean=false) {
         super();
         this.type = param1;
         this.buyIn = param2;
         this.sitId = param3;
         this.postToPlay = param4;
         this.rakeEnable = param5;
         this.autoRebuy = param6;
         this.autoTopOff = param7;
         this.hsmStatus = param8;
         this.isFastRR = param9;
      }
      
      public var type:String;
      
      public var buyIn:Number;
      
      public var sitId:int;
      
      public var postToPlay:int;
      
      public var rakeEnable:int;
      
      public var autoRebuy:int;
      
      public var autoTopOff:int;
      
      public var hsmStatus:int;
      
      public var isFastRR:Boolean;
   }
}
