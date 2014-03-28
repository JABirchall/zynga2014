package com.zynga.poker.protocol
{
   public final class SPickSpecificRoomShootout extends Object implements ISmartFoxMessage
   {
      
      public function SPickSpecificRoomShootout(param1:Number, param2:Number, param3:Number) {
         super();
         this._id = param1;
         this._idVersion = param2;
         this._targetRoomId = param3;
      }
      
      public static const PROTOCOL_TYPE:String = "SPickSpecificRoomShootout";
      
      private var _id:Number;
      
      private var _idVersion:Number;
      
      private var _targetRoomId:Number;
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function get id() : Number {
         return this._id;
      }
      
      public function get idVersion() : Number {
         return this._idVersion;
      }
      
      public function get targetRoomId() : Number {
         return this._targetRoomId;
      }
   }
}
