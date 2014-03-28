package com.zynga.poker.protocol
{
   public final class RHyperJoin extends Object implements ISmartFoxMessage
   {
      
      public function RHyperJoin(param1:uint, param2:uint, param3:String, param4:String, param5:Number) {
         super();
         this._serverId = param1;
         this._roomTypeId = param2;
         this._roomId = param3;
         this._pass = param4;
         this._timestamp = param5;
      }
      
      public static const PROTOCOL_TYPE:String = "RHyperJoin";
      
      private var _serverId:uint;
      
      private var _roomId:String;
      
      private var _roomTypeId:uint;
      
      private var _pass:String;
      
      private var _timestamp:Number;
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function get serverId() : uint {
         return this._serverId;
      }
      
      public function get roomId() : String {
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
      
      public function toString() : String {
         return PROTOCOL_TYPE + "{serverId=" + this._serverId + ", roomTypeId=" + this._roomTypeId + ", roomId=" + this._roomId + ", pass=" + this._pass + ", timestamp=" + this._timestamp + "}";
      }
   }
}
