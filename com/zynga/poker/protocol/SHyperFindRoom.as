package com.zynga.poker.protocol
{
   public final class SHyperFindRoom extends Object implements ISmartFoxMessage
   {
      
      public function SHyperFindRoom(param1:Number, param2:uint, param3:String) {
         super();
         this._smallBlind = param1;
         this._maximumPlayers = param2;
         this._speed = param3;
      }
      
      public static const PROTOCOL_TYPE:String = "SHyperFindRoom";
      
      private var _smallBlind:Number;
      
      private var _maximumPlayers:uint;
      
      private var _speed:String;
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function getParameters() : Object {
         return 
            {
               "smallBlind":this._smallBlind,
               "maxPlayers":this._maximumPlayers,
               "speed":this._speed
            };
      }
      
      public function toString() : String {
         return PROTOCOL_TYPE + "{smallBlind=" + this._smallBlind + ", maxPlayers=" + this._maximumPlayers + ", speed=" + this._speed + "}";
      }
   }
}
