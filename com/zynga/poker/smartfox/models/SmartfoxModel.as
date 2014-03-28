package com.zynga.poker.smartfox.models
{
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.zynga.poker.smartfox.messages.SmartfoxResponse;
   import com.zynga.poker.smartfox.messages.SmartfoxRequest;
   
   public class SmartfoxModel extends Object
   {
      
      public function SmartfoxModel() {
         super();
      }
      
      public static const DEFAULT_HTTP_POLL_SPEED:int = 750;
      
      public static const DEFAULT_SOCKET_TIMEOUT_MS:int = 20000;
      
      private var _registeredCallbacks:Dictionary;
      
      public function get registeredCallbacks() : Dictionary {
         return this._registeredCallbacks;
      }
      
      private var _targetZone:String;
      
      public function get targetZone() : String {
         return this._targetZone;
      }
      
      public function set targetZone(param1:String) : void {
         this._targetZone = param1;
      }
      
      private var _ipAddress:String;
      
      public function get ipAddress() : String {
         return this._ipAddress;
      }
      
      public function set ipAddress(param1:String) : void {
         this._ipAddress = param1;
      }
      
      private var _port:int;
      
      public function get port() : int {
         return this._port;
      }
      
      public function set port(param1:int) : void {
         this._port = param1;
      }
      
      private var _hasRoomList:Boolean;
      
      public function get hasRoomList() : Boolean {
         return this._hasRoomList;
      }
      
      public function set hasRoomList(param1:Boolean) : void {
         this._hasRoomList = param1;
      }
      
      private var _responseBacklog:Vector.<SmartfoxResponse>;
      
      public function get responseBacklog() : Vector.<SmartfoxResponse> {
         return this._responseBacklog;
      }
      
      public function init() : void {
         this._registeredCallbacks = new Dictionary();
         this._targetZone = SmartfoxRequest.ZONE_TEXASHOLDEMUP;
         this._hasRoomList = false;
         this._responseBacklog = new Vector.<SmartfoxResponse>();
      }
      
      public function dispose() : void {
         var _loc1_:String = null;
         if(this._registeredCallbacks == null)
         {
            for (_loc1_ in this._registeredCallbacks)
            {
               this._registeredCallbacks[_loc1_].length = 0;
               delete this._registeredCallbacks[[_loc1_]];
            }
         }
         this._registeredCallbacks = null;
      }
   }
}
