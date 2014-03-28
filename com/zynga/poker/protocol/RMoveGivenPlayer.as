package com.zynga.poker.protocol
{
   public final class RMoveGivenPlayer extends Object implements ISmartFoxMessage
   {
      
      public function RMoveGivenPlayer(param1:uint, param2:uint, param3:String, param4:String, param5:Number, param6:int, param7:Number, param8:String, param9:String, param10:String) {
         super();
         this._serverId = param1;
         this._roomTypeId = param2;
         this._roomId = int(param3);
         this._pass = param4;
         this._timestamp = param5;
         this._seat = param6;
         this._buyIn = param7;
         this._serverIp = param8;
         this._serverName = param9;
         this._serverType = param10;
      }
      
      public static const PROTOCOL_TYPE:String = "RMoveGivenPlayer";
      
      private var _serverId:uint;
      
      private var _roomId:int;
      
      private var _roomTypeId:uint;
      
      private var _pass:String;
      
      private var _timestamp:Number;
      
      private var _seat:int;
      
      private var _buyIn:Number;
      
      private var _serverIp:String;
      
      private var _serverType:String;
      
      private var _serverName:String;
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function get serverId() : uint {
         return this._serverId;
      }
      
      public function get roomId() : int {
         return this._roomId;
      }
      
      public function get roomTypeId() : uint {
         return this._roomTypeId;
      }
      
      public function get pass() : String {
         return this._pass;
      }
      
      public function get timestamp() : Number {
         return this._timestamp;
      }
      
      public function get seat() : int {
         return this._seat;
      }
      
      public function get buyIn() : Number {
         return this._buyIn;
      }
      
      public function get serverIp() : String {
         return this._serverIp;
      }
      
      public function get serverType() : String {
         return this._serverType;
      }
      
      public function get serverName() : String {
         return this._serverName;
      }
      
      public function toString() : String {
         return PROTOCOL_TYPE + "{serverId=" + this._serverId + ", roomTypeId=" + this._roomTypeId + ", roomId=" + this._roomId + ", pass=" + this._pass + ", timestamp=" + this._timestamp + ", seat=" + this._seat + ", buyIn=" + this._buyIn + "}";
      }
   }
}
