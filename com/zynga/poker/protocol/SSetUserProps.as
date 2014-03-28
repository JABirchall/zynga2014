package com.zynga.poker.protocol
{
   public class SSetUserProps extends Object
   {
      
      public function SSetUserProps(param1:String, param2:String, param3:Number, param4:String, param5:Number, param6:String, param7:Number, param8:Number, param9:String, param10:Number) {
         super();
         this.type = param1;
         this.pic_url = param2;
         this.rank = param3;
         this.pic_lrg_url = param4;
         this.sn_id = param5;
         this.tourneyState = param6;
         this.protoVersion = param7;
         this.capabilities = param8;
         this.clientType = param9;
         this.firstTimePlaying = param10;
      }
      
      public var type:String;
      
      public var pic_url:String;
      
      public var rank:Number;
      
      public var pic_lrg_url:String;
      
      public var sn_id:Number;
      
      public var prof_url:String;
      
      public var tourneyState:String;
      
      public var protoVersion:Number;
      
      public var capabilities:Number;
      
      public var clientType:String;
      
      public var firstTimePlaying:Number;
   }
}
