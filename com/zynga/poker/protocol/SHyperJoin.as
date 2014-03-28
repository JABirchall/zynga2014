package com.zynga.poker.protocol
{
   public final class SHyperJoin extends Object implements ISmartFoxMessage
   {
      
      public function SHyperJoin(param1:uint, param2:uint, param3:String, param4:String=null, param5:Number=0.0) {
         super();
         this._serverId = param1;
         this._roomTypeId = param2;
         this._roomId = param3;
         this._pass = param4;
         this._timestamp = param5;
      }
      
      public static const PROTOCOL_TYPE:String = "SHyperJoin";
      
      private var _serverId:uint;
      
      private var _roomTypeId:uint;
      
      private var _roomId:String;
      
      private var _pass:String;
      
      private var _timestamp:Number;
      
      private var _friendZid:String;
      
      public function getParameters() : Object {
         var _loc1_:Object = {};
         if(this._serverId)
         {
            _loc1_.server = this._serverId;
         }
         if(this._roomTypeId)
         {
            _loc1_.type = this._roomTypeId;
         }
         if(this._roomId)
         {
            _loc1_.room = this._roomId;
         }
         if(this._pass)
         {
            _loc1_.pass = this._pass;
         }
         if(this._timestamp)
         {
            _loc1_.timestamp = this._timestamp;
         }
         if(this._friendZid)
         {
            _loc1_.friend = this._friendZid;
         }
         return _loc1_;
      }
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function set friendZid(param1:String) : void {
         this._friendZid = param1;
      }
      
      public function toString() : String {
         return PROTOCOL_TYPE + "{serverId=" + this._serverId + ", roomTypeId=" + this._roomTypeId + ", roomId=" + this._roomId + ", pass=" + this._pass + ", timestamp=" + this._timestamp + ", friendZid=" + this._friendZid + "}";
      }
   }
}
