package com.zynga.poker.protocol
{
   public class SCreateGroupRoom extends Object
   {
      
      public function SCreateGroupRoom(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) {
         super();
         this.type = param1;
         this.roomName = param2;
         this.password = param3;
         this.smallBlind = param4;
         this.bigBlind = param5;
         this.maxBuyin = param6;
         this.maxPlayers = param7;
         this.gid = param8;
      }
      
      public var type:String;
      
      public var roomName:String;
      
      public var password:String;
      
      public var smallBlind:Number;
      
      public var bigBlind:Number;
      
      public var maxBuyin:Number;
      
      public var maxPlayers:Number;
      
      public var gid:Number;
   }
}
