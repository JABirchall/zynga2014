package com.zynga.poker
{
   import com.zynga.io.SmartfoxConnectionManager;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import flash.events.Event;
   import com.zynga.poker.protocol.SSuperLogin;
   import com.adobe.serialization.json.JSONParseError;
   import com.adobe.serialization.json.JSON;
   import com.zynga.poker.events.SFLoginEvent;
   
   public class LoginConnectionManager extends SmartfoxConnectionManager
   {
      
      public function LoginConnectionManager(param1:int, param2:PokerGlobalData) {
         super();
         this.nTraceStats = param1;
         this.pgData = param2;
         this.nRetries = this.pgData.nRetries;
         this.initProtocolListeners();
      }
      
      public static const LOBBYJOIN_COMPLETE:String = "LOBBYJOIN_COMPLETE";
      
      public static const LOGIN:String = "LOGIN";
      
      public static const LOGIN_FAILED:String = "LOGIN_FAILED";
      
      public var sfeLogin:SFSEvent;
      
      public var sfeJoinRoom:SFSEvent;
      
      public var sfeRoomList:SFSEvent;
      
      public var sfeDisplayRoomList:SFSEvent;
      
      public var sfeSetMod:SFSEvent;
      
      public var nTraceStats:int;
      
      public var pgData:PokerGlobalData;
      
      private var nRetries:int;
      
      private function initProtocolListeners() : void {
         smartfox.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionHandler);
         smartfox.addEventListener(SFSEvent.onJoinRoom,this.onJoinRoomHandler);
         smartfox.addEventListener(SFSEvent.onRoomListUpdate,this.onRoomListUpdate);
         smartfox.addEventListener(SFSEvent.onLogin,this.onSFLogin);
      }
      
      private function removeListeners() : void {
         smartfox.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionHandler);
         smartfox.removeEventListener(SFSEvent.onJoinRoom,this.onJoinRoomHandler);
         smartfox.removeEventListener(SFSEvent.onRoomListUpdate,this.onRoomListUpdate);
         smartfox.removeEventListener(SFSEvent.onConnection,onConnectHandler);
         smartfox.removeEventListener(SFSEvent.onLogin,this.onSFLogin);
      }
      
      private function checkProgress() : void {
         if(!(this.sfeDisplayRoomList == null) && !(this.sfeJoinRoom == null) && !(this.sfeLogin == null) && !(this.sfeRoomList == null))
         {
            this.removeListeners();
            dispatchEvent(new Event(LOBBYJOIN_COMPLETE));
         }
      }
      
      public function login(param1:SSuperLogin) : void {
         smartfox.login(param1.zone,param1.props_JSON_ESC,param1.pass);
      }
      
      public function sendXtMessage(param1:String, param2:String, param3:Object, param4:String) : void {
         smartfox.sendXtMessage(param1,param2,param3,param4);
      }
      
      public function getLobbyRooms() : void {
         smartfox.sendXtMessage("texasLogin","displayRoomList",{},"xml");
      }
      
      private function onJoinRoomHandler(param1:SFSEvent) : void {
         if(this.pgData.trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LCM:RoomJoined_" + this.nRetries + ":2009-02-06","",1,"",PokerStatHit.HITTYPE_FG));
         }
         this.sfeJoinRoom = param1;
         this.checkProgress();
      }
      
      private function onRoomListUpdate(param1:SFSEvent) : void {
         if(this.pgData.trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LCM:RoomListUpdate_" + this.nRetries + ":2009-02-06","",1,"",PokerStatHit.HITTYPE_FG));
         }
         this.sfeRoomList = param1;
         this.checkProgress();
      }
      
      private function onSetMod(param1:SFSEvent) : void {
         this.sfeSetMod = param1;
      }
      
      private function onExtensionHandler(param1:SFSEvent) : void {
         var _loc2_:Object = param1.params.dataObj;
         switch(_loc2_._cmd)
         {
            case "logOK":
               this.pgData.rejoinRoom = _loc2_.rejoinRoom;
               this.pgData.rejoinType = _loc2_.rejoinType;
               this.pgData.rejoinPass = _loc2_.rejoinPass;
               this.pgData.rejoinTime = _loc2_.rejoinTime;
               this.loginHandler(_loc2_,param1);
               return;
            case "logKO":
               this.loginHandler(_loc2_,param1);
               return;
            case "displayRoomList":
               if(this.pgData.trace_stats == 1)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LCM:DisplayRoomList_" + this.nRetries + ":2009-02-06","",1,"",PokerStatHit.HITTYPE_FG));
               }
               this.sfeDisplayRoomList = param1;
               this.checkProgress();
               return;
            case "contest":
               return;
            case "getBestPlayers":
               return;
            default:
               switch(_loc2_[0])
               {
                  case "setmod":
                     this.onSetMod(param1);
                     return;
                  case "showedGift2":
                     this.onGiftShown2(_loc2_);
                     return;
                  default:
                     return;
               }
               
         }
         
      }
      
      private function onGiftShown2(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[3]));
         }
         catch(ex:JSONParseError)
         {
         }
         this.pgData.shownGiftID = oJSON.giftId;
      }
      
      private function loginHandler(param1:Object, param2:SFSEvent) : void {
         var _loc3_:String = param1._cmd;
         var _loc4_:* = "";
         if(_loc3_ == "logOK")
         {
            if(this.pgData.trace_stats == 1)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LCM:LoginSuccess_" + this.nRetries + ":2009-02-06","",1,"",PokerStatHit.HITTYPE_FG));
            }
            this.sfeLogin = param2;
            this.checkProgress();
         }
         else
         {
            if(_loc3_ == "logKO")
            {
               if(this.pgData.trace_stats == 1)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LCM:LoginFailure_" + this.nRetries + ":2009-02-06","",1,"",PokerStatHit.HITTYPE_FG));
               }
               dispatchEvent(new Event(LOGIN_FAILED));
            }
         }
      }
      
      private function onSFLogin(param1:SFSEvent) : void {
         if(param1.params.success)
         {
            dispatchEvent(new Event(LOGIN));
         }
         else
         {
            dispatchEvent(new SFLoginEvent(SFLoginEvent.SF_LOGIN_FAILED,param1.params.error));
         }
      }
   }
}
