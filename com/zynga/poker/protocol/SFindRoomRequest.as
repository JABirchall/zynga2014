package com.zynga.poker.protocol
{
   public class SFindRoomRequest extends Object
   {
      
      public function SFindRoomRequest(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:Number, param8:String, param9:Array, param10:Number, param11:Number, param12:Number=0, param13:uint=1.0, param14:Number=0, param15:Number=0) {
         super();
         this.type = param1;
         this.maxPlayers = param2;
         this.smallBlind = param3;
         this.bigBlind = param4;
         this.buyIn = param5;
         this.gameType = param6;
         this.autoJoin = param7;
         this.tableSpeed = param8;
         if(!param9)
         {
            this.excludedRooms = new Array();
         }
         else
         {
            this.excludedRooms = param9;
         }
         this.closeMatch = param10;
         this.allowZeroSeats = param11;
         this.maxBuyInRatio = param12;
         this.minPlayers = param13;
         this.minBuyIn = param14;
         this.maxBuyIn = param15;
      }
      
      public var type:String;
      
      public var maxPlayers:Number;
      
      public var smallBlind:Number;
      
      public var bigBlind:Number;
      
      public var buyIn:Number;
      
      public var gameType:String;
      
      public var autoJoin:Number;
      
      public var tableSpeed:String;
      
      public var excludedRooms:Array;
      
      public var closeMatch:Number;
      
      public var allowZeroSeats:Number;
      
      public var maxBuyInRatio:Number;
      
      public var minPlayers:uint;
      
      public var minBuyIn:Number;
      
      public var maxBuyIn:Number;
      
      public function toString() : String {
         return new String().concat("type: ",this.type,", maxPlayers: ",this.maxPlayers,", smallBlind: ",this.smallBlind,", bigBlind: ",this.bigBlind,", buyIn: ",this.buyIn,", gameType: ",this.gameType,", autoJoin: ",this.autoJoin,", speed: ",this.tableSpeed,", excludedRooms: ",this.excludedRooms,", closeMatch: ",this.closeMatch);
      }
      
      public function get payload() : Object {
         var _loc1_:Object = 
            {
               "_cmd":"findRoom",
               "maxPlayers":this.maxPlayers,
               "smallBlind":this.smallBlind,
               "bigBlind":this.bigBlind,
               "buyin":this.buyIn,
               "gameType":this.gameType,
               "autoJoin":this.autoJoin,
               "speed":this.tableSpeed,
               "excludedRooms":this.excludedRooms,
               "closeMatch":this.closeMatch,
               "allowZeroSeats":this.allowZeroSeats
            };
         if(this.maxBuyInRatio)
         {
            _loc1_.maxBuyInRatio = this.maxBuyInRatio;
         }
         if(this.minPlayers > -1)
         {
            _loc1_.minPlayers = this.minPlayers;
         }
         if(this.minBuyIn)
         {
            _loc1_.buyInMinimum = this.minBuyIn;
         }
         if(this.maxBuyIn)
         {
            _loc1_.buyInMaximum = this.maxBuyIn;
         }
         return _loc1_;
      }
   }
}
