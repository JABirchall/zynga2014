package com.zynga.io
{
   import flash.events.EventDispatcher;
   import it.gotoandplay.smartfoxserver.SmartFoxClient;
   import flash.system.Security;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class SmartfoxConnectionManager extends EventDispatcher
   {
      
      public function SmartfoxConnectionManager() {
         this.timeSlots = [1,2,3,5,8,10,15,20,30,50,100];
         super();
         this.smartfox = new SmartFoxClient();
         this.smartfox.httpPollSpeed = DEFAULT_POLL_RATE;
         this.smartfox.smartConnect = false;
      }
      
      public static const CONNECTED:String = "connected";
      
      public static const CONNECT_FAILED:String = "connectfail";
      
      public static const DEFAULT_POLL_RATE:Number = 750;
      
      public static const DEFAULT_SOCKET_TIMEOUT:Number = 20000;
      
      public static const DEFAULT_PORTS:Array = ["9339","443"];
      
      public var smartfox:SmartFoxClient;
      
      public var host:String;
      
      public var portOrder:Array;
      
      private var serverId:String;
      
      private var lastKnownGoodPort:String;
      
      private var currentPort:String;
      
      private var currentPortIndex:int = 0;
      
      private var portsTried:int;
      
      private var connectionResultLogging:Boolean = false;
      
      private var connectionRequestTimeStamp:Number;
      
      private var timeSlots:Array;
      
      public function get isConnected() : Boolean {
         return this.smartfox.isConnected;
      }
      
      public function connect(param1:String, param2:Array, param3:String="", param4:String="", param5:int=20000, param6:int=750) : void {
         this.smartfox.httpPollSpeed = DEFAULT_POLL_RATE;
         this.smartfox.socketTimeout = DEFAULT_SOCKET_TIMEOUT;
         this.portsTried = 0;
         this.currentPortIndex = 0;
         this.host = param1;
         var param2:Array = this.throw_out_bad_ports(param2);
         if(param2.length == 0)
         {
            this.portOrder = DEFAULT_PORTS;
         }
         else
         {
            this.portOrder = param2;
         }
         this.lastKnownGoodPort = param3;
         this.serverId = param4;
         if(199 < param6 < 1001)
         {
            this.smartfox.httpPollSpeed = param6;
         }
         if(param5 > 0)
         {
            this.smartfox.socketTimeout = param5 * 1000;
         }
         Security.loadPolicyFile("xmlsocket://" + param1 + ":843");
         this.connectHelper();
      }
      
      private function connectHelper() : void {
         this.connectionRequestTimeStamp = new Date().time;
         this.smartfox.addEventListener(SFSEvent.onConnection,this.onConnectHandler);
         if(this.portsTried == 0 && !(this.portOrder.indexOf(this.lastKnownGoodPort) == -1))
         {
            this.currentPort = this.lastKnownGoodPort;
         }
         else
         {
            this.currentPort = this.portOrder[this.currentPortIndex];
            this.currentPortIndex++;
         }
         this.portsTried++;
         if(this.currentPort.indexOf("b") == 0)
         {
            this.smartfox.connectBlueBox(this.host,int(this.currentPort.slice(1)));
         }
         else
         {
            this.smartfox.connect(this.host,int(this.currentPort));
         }
      }
      
      public function disconnect() : void {
         this.smartfox.disconnect();
      }
      
      public function disconnectWithoutReconnect() : void {
         this.smartfox.disconnect(false);
      }
      
      public function assignSFClient(param1:Object) : void {
         this.smartfox = SmartFoxClient(param1);
      }
      
      public function onConnectHandler(param1:SFSEvent) : void {
         this.smartfox.removeEventListener(SFSEvent.onConnection,this.onConnectHandler);
         if(param1.params.success)
         {
            param1.stopPropagation();
            if(this.connectionResultLogging)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"SWF Other SFXConnect o:Status:SUCCESS:ID:" + this.serverId + ":Port:" + this.currentPort + ":Time:" + this.getTimeSlot() + ":2010-09-01","",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_NAV3));
            }
            dispatchEvent(new SmartfoxConnectionEvent(SmartfoxConnectionManager.CONNECTED,this.currentPort));
         }
         else
         {
            if(this.connectionResultLogging)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"SWF Other SFXConnect o:Status:FAIL:ID:" + this.serverId + ":Port:" + this.currentPort + ":Time:" + this.getTimeSlot() + ":2010-09-01","",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_NAV3));
            }
            if(this.currentPortIndex < this.portOrder.length && this.portOrder[this.currentPortIndex] == this.lastKnownGoodPort)
            {
               this.currentPortIndex++;
            }
            if(this.currentPortIndex < this.portOrder.length)
            {
               this.connectHelper();
            }
            else
            {
               dispatchEvent(new SmartfoxConnectionEvent(SmartfoxConnectionManager.CONNECT_FAILED,this.currentPort));
            }
         }
      }
      
      private function throw_out_bad_ports(param1:Array) : Array {
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:* = 0;
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = false;
            if(_loc4_.indexOf("b") == 0)
            {
               _loc4_ = _loc4_.slice(1);
               _loc5_ = true;
            }
            _loc6_ = int(_loc4_);
            if(_loc4_ == String(_loc6_) && _loc6_ > 0 && _loc6_ < 65536)
            {
               if(_loc5_)
               {
                  _loc4_ = "b" + _loc4_;
               }
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getTimeSlot() : Number {
         var _loc1_:Number = 0;
         var _loc2_:Number = new Date().time;
         var _loc3_:Number = _loc2_ - this.connectionRequestTimeStamp;
         _loc3_ = _loc3_ / 1000;
         var _loc4_:* = 0;
         while(_loc4_ < this.timeSlots.length)
         {
            if(_loc3_ < this.timeSlots[_loc4_] && _loc1_ == 0)
            {
               _loc1_ = this.timeSlots[_loc4_];
            }
            _loc4_++;
         }
         if(_loc1_ == 0)
         {
            _loc1_ = 200;
         }
         return _loc1_;
      }
      
      public function setConnectionLogging(param1:Boolean) : void {
         this.connectionResultLogging = param1;
      }
   }
}
