package com.zynga.poker
{
   import com.zynga.io.SmartfoxConnectionManager;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import com.zynga.poker.protocol.*;
   import it.gotoandplay.smartfoxserver.data.*;
   import com.zynga.poker.protocol.mgfw.SMgfwPayload;
   import flash.utils.setTimeout;
   import com.adobe.serialization.json.JSON;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.commands.smartfox.GetUserInfoCommand;
   import com.zynga.utils.ObjectUtil;
   import flash.utils.Dictionary;
   import com.zynga.poker.challenges.*;
   import com.adobe.serialization.json.JSONParseError;
   
   public class PokerConnectionManager extends SmartfoxConnectionManager implements IPokerConnectionManager
   {
      
      public function PokerConnectionManager() {
         this.megaBillionsLastForceUpdateTimestamp = new Date().time;
         super();
      }
      
      public static const ZONE_TEXASLOGIN:String = "texasLogin";
      
      public static const FORMAT_XML:String = "xml";
      
      private var challengeCache:Boolean = false;
      
      private var challengeCachedObject:Object = null;
      
      private const GET_CHALLENGE_CACHE_TIME:Number = 2000;
      
      private var megaBillionsLastForceUpdateTimestamp:Number;
      
      private var _rollingRebootStoredInfo:RMoveGivenPlayer = null;
      
      public function initProtocolListeners() : void {
         smartfox.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionHandler);
         smartfox.addEventListener(SFSEvent.onJoinRoom,this.onJoinRoomHandler);
         smartfox.addEventListener(SFSEvent.onRoomListUpdate,this.onRoomListUpdate);
         smartfox.addEventListener(SFSEvent.onPublicMessage,this.onPublicMessage);
         smartfox.addEventListener(SFSEvent.onConnectionLost,this.onConnectionLost);
         smartfox.addEventListener(SFSEvent.onJoinRoomError,this.onJoinRoomError);
         smartfox.addEventListener(SFSEvent.onAdminMessage,this.onAdminMessage);
         smartfox.addEventListener(SFSEvent.onLogin,this.onSFLogin);
      }
      
      private function setChallengeCache(param1:Boolean) : void {
         this.challengeCache = param1;
      }
      
      public function login(param1:SSuperLogin) : void {
         smartfox.login(param1.zone,param1.props_JSON_ESC,param1.pass);
      }
      
      public function joinRoom(param1:SJoinRoom) : void {
         if(param1.sPassword != "")
         {
            smartfox.joinRoom(param1.nRoomId,param1.sPassword);
         }
         else
         {
            smartfox.joinRoom(param1.nRoomId);
         }
      }
      
      public function getUsersInRoom(param1:SGetUsersInRoom) : void {
         var _loc5_:String = null;
         var _loc6_:RGetUsersInRoom = null;
         var _loc7_:Object = null;
         var _loc2_:Room = smartfox.getRoom(param1.roomId);
         var _loc3_:Array = _loc2_.getUserList();
         var _loc4_:Array = new Array();
         for (_loc5_ in _loc3_)
         {
            if(!(param1.userId == _loc3_[_loc5_].getName()) && !_loc3_[_loc5_].isModerator())
            {
               _loc7_ = new Object();
               _loc7_.zid = _loc3_[_loc5_].getName();
               _loc7_.name = _loc3_[_loc5_].getVariable("fullname");
               _loc4_.push(_loc7_);
            }
         }
         _loc6_ = new RGetUsersInRoom("RGetUsersInRoom",_loc4_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc6_));
      }
      
      public function sendMessage(param1:Object) : void {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          */
         throw new IllegalOperationError("Not decompiled due to timeout");
      }
      
      public function sendXtMessage(param1:String, param2:String, param3:Object, param4:String) : void {
         smartfox.sendXtMessage(param1,param2,param3,param4);
      }
      
      public function getLobbyRooms() : void {
         smartfox.sendXtMessage("texasLogin","displayRoomList",{},"xml");
      }
      
      public function onConnectionLost(param1:SFSEvent) : void {
         var _loc2_:RConnectionLost = new RConnectionLost("RConnectionLost");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      public function onJoinRoomHandler(param1:SFSEvent) : void {
         var _loc2_:Room = Room(param1.params.room);
         var _loc3_:RJoinRoom = new RJoinRoom();
         _loc3_.type = "RJoinRoom";
         _loc3_.roomName = _loc2_.getName();
         _loc3_.roomId = _loc2_.getId();
         if(_loc2_.getVariable("numberOfPlayers") != null)
         {
            _loc3_.numPlayers = _loc2_.getVariable("numberOfPlayers");
         }
         if(_loc2_.getVariable("maxPlayers") != null)
         {
            _loc3_.maxPlayers = _loc2_.getVariable("maxPlayers");
         }
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onJoinRoomError(param1:SFSEvent) : void {
         var _loc2_:RJoinRoomError = new RJoinRoomError("RJoinRoomError",param1.params.error);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onAdminMessage(param1:SFSEvent) : void {
         var _loc2_:RAdminMessage = new RAdminMessage("RAdminMessage",param1.params.message);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      public function onRoomListUpdate(param1:SFSEvent) : void {
         var _loc2_:RRoomListUpdate = new RRoomListUpdate();
         _loc2_.type = "RRoomListUpdate";
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      public function onPublicMessage(param1:SFSEvent) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:* = false;
         var _loc7_:RReceiveChat = null;
         var _loc2_:User = User(param1.params.sender);
         if(_loc2_)
         {
            _loc3_ = _loc2_.getName();
            _loc4_ = _loc2_.getVariable("fullname");
            _loc5_ = param1.params.message;
            _loc6_ = false;
            if(_loc5_.charAt(0) == "<")
            {
               _loc6_ = true;
               _loc5_ = _loc5_.substr(1);
            }
            _loc7_ = new RReceiveChat("RReceiveChat",_loc3_,_loc5_,_loc4_,_loc6_);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc7_));
         }
      }
      
      public function onExtensionHandler(param1:SFSEvent) : void {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          */
         throw new IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onMiniGameFrResponse(param1:Object) : void {
         var _loc3_:RMgfwResponse = null;
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         if(_loc2_.type)
         {
            _loc3_ = new RMgfwResponse("RMgfwResponse",_loc2_);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
         }
      }
      
      private function loginHandler(param1:Object) : void {
         var _loc2_:* = undefined;
         var _loc3_:String = param1._cmd;
         switch(_loc3_)
         {
            case "logOK":
               _loc2_ = new RLogin();
               _loc2_.type = "RLogin";
               _loc2_.bSuccess = true;
               _loc2_.name = param1.name;
               _loc2_.playLevel = int(param1.playLevel);
               _loc2_.points = Number(param1.points);
               _loc2_.zid = param1.email;
               _loc2_.usersOnline = Number(param1.usersOnline);
               if(param1.hasOwnProperty("rejoinRoom"))
               {
                  _loc2_.rejoinRoom = int(param1.rejoinRoom);
                  _loc2_.rejoinType = uint(param1.rejoinType);
                  _loc2_.rejoinPass = String(param1.rejoinPass);
                  _loc2_.rejoinTime = Number(param1.rejoinTime);
               }
               else
               {
                  _loc2_.rejoinRoom = -1;
                  _loc2_.rejoinType = 0;
                  _loc2_.rejoinPass = "";
                  _loc2_.rejoinTime = 0;
               }
               _loc2_.bonus = Number(param1.bonus);
               _loc2_.privateTableEnabled = param1.privateTable == "1"?true:false;
               break;
            case "logKO":
               _loc2_ = new RLogKO("RLogKO",false,param1.err,false);
               break;
         }
         
         if(_loc2_ != null)
         {
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
         }
      }
      
      private function roomListHandler(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < param1.rooms.length)
         {
            _loc2_.push(new RoomItem(param1.rooms[_loc3_].split(",")));
            _loc3_++;
         }
         var _loc4_:RDisplayRoomList = new RDisplayRoomList("RDisplayRoomList",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
         PokerCommandDispatcher.getInstance().dispatchCommand(new GetUserInfoCommand());
         if(this._rollingRebootStoredInfo != null)
         {
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,new RFinishPlayerMove(this._rollingRebootStoredInfo.serverId,this._rollingRebootStoredInfo.roomTypeId,String(this._rollingRebootStoredInfo.roomId),this._rollingRebootStoredInfo.pass,this._rollingRebootStoredInfo.timestamp,this._rollingRebootStoredInfo.seat,this._rollingRebootStoredInfo.buyIn,this._rollingRebootStoredInfo.serverType)));
            this._rollingRebootStoredInfo = null;
         }
      }
      
      private function roomHandler(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < param1.rooms.length)
         {
            _loc2_.push(new RoomItem(param1.rooms[_loc3_].split(",")));
            _loc3_++;
         }
         var _loc4_:RDisplayRoom = new RDisplayRoom("RDisplayRoom",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onHyperJoin(param1:Object) : void {
         var _loc2_:RHyperJoin = new RHyperJoin(uint(param1[2]),uint(param1[4]),param1[3],param1[5],Number(param1[6]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRoomPicked(param1:Object) : void {
         var _loc2_:RRoomPicked = new RRoomPicked("RRoomPicked",int(param1[2]),int(param1[3]));
         if(param1[4])
         {
            _loc2_.sIp = param1[4];
         }
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onBuyIn(param1:Object) : void {
         var _loc2_:RBuyIn = new RBuyIn("RBuyIn",Number(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onUpdateTableAce(param1:Object) : void {
         var _loc2_:* = "RTableAceUpdate";
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(param1[2]);
         var _loc4_:Array = _loc3_.no;
         var _loc5_:Number = _loc3_.h;
         var _loc6_:Number = _loc3_.u;
         var _loc7_:RTableAceUpdate = new RTableAceUpdate(_loc2_,_loc4_,_loc5_,_loc6_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc7_));
      }
      
      private function onPointsUpdate(param1:Object) : void {
         var _loc2_:String = ObjectUtil.maybeGetString(param1,"3","");
         var _loc3_:RPointsUpdate = new RPointsUpdate("RPointsUpdate",Number(param1[2]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onUpdatePendingChips(param1:Object) : void {
         var _loc2_:RUpdatePendingChips = new RUpdatePendingChips("RUpdatePendingChips",Number(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onTM(param1:Object) : void {
         var _loc2_:RTM = new RTM("RTM",Number(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRoomInfo(param1:Object) : void {
         param1.splice(0,3);
         var _loc2_:Array = param1.concat();
         var _loc3_:RRoomInfo = new RRoomInfo("RRoomInfo",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onRoomInfo2(param1:Object) : void {
         var oJSON:Object = null;
         var tList:Array = null;
         var msg:RRoomInfo2 = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(inObj[2]);
         }
         catch(ex:Error)
         {
         }
         if(oJSON != null)
         {
            if(oJSON.players != null)
            {
               tList = oJSON.players;
               msg = new RRoomInfo2("RRoomInfo2",tList);
               dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
            }
         }
      }
      
      private function parseUser(param1:Object, param2:int) : PokerUser {
         var _loc3_:PokerUser = null;
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = "masc";
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         try
         {
            _loc4_ = com.adobe.serialization.json.JSON.decode(param1[param2 + 23]);
            if(_loc4_ != null)
            {
               if(_loc4_.hasOwnProperty("level"))
               {
                  _loc5_ = int(_loc4_["level"]);
               }
               if(_loc4_.hasOwnProperty("xp"))
               {
                  _loc6_ = int(_loc4_["xp"]);
               }
               if(_loc4_.hasOwnProperty("emailSubscribed"))
               {
                  _loc7_ = int(_loc4_["emailSubscribed"]);
               }
               if(_loc4_.hasOwnProperty("gender"))
               {
                  _loc8_ = _loc4_["gender"];
               }
               if(_loc4_.hasOwnProperty("handsWon"))
               {
                  _loc9_ = int(_loc4_["handsWon"]);
               }
               if(_loc4_.hasOwnProperty("handsPlayed"))
               {
                  _loc10_ = int(_loc4_["handsPlayed"]);
               }
            }
         }
         catch(error:Error)
         {
         }
         _loc3_ = new PokerUser(int(param1[param2]),param1[param2 + 1],Number(param1[param2 + 2]),param1[param2 + 3],param1[param2 + 4],Number(param1[param2 + 5]),int(param1[param2 + 6]),param1[param2 + 7],Number(param1[param2 + 8]).toString(),param1[param2 + 9],int(param1[param2 + 10]),param1[param2 + 11],param1[param2 + 12],int(param1[param2 + 13]),param1[param2 + 14],Number(param1[param2 + 15]),int(param1[param2 + 17]),int(param1[param2 + 18]),int(param1[param2 + 19]),param1[param2 + 20],int(param1[param2 + 21]),int(param1[param2 + 22]),_loc9_,1,_loc5_,_loc6_,_loc7_,_loc8_,_loc10_);
         return _loc3_;
      }
      
      private function parseUsers(param1:Object) : Array {
         var _loc4_:PokerUser = null;
         var _loc2_:Array = [];
         var _loc3_:int = param1.length % 24;
         while(_loc3_ < param1.length)
         {
            _loc4_ = this.parseUser(param1,_loc3_);
            _loc2_.push(_loc4_);
            _loc3_ = _loc3_ + 24;
         }
         return _loc2_;
      }
      
      private function onInitGameRoom(param1:Object) : void {
         var _loc2_:Array = this.parseUsers(param1);
         var _loc3_:RInitGameRoom = new RInitGameRoom("RInitGameRoom",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onInitTourney(param1:Object) : void {
         var _loc2_:Array = this.parseUsers(param1);
         var _loc3_:RInitTourney = new RInitTourney("RInitTourney",_loc2_,String(param1[2]),Boolean(int(param1[3])));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onSitJoined(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         var xpLevel:int = 0;
         var xp:int = 0;
         var emailSubscribed:int = 0;
         var gender:String = "masc";
         var handsWon:int = 0;
         var handsPlayed:int = 0;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(inObj[24]);
            if(oJSON != null)
            {
               if(oJSON.hasOwnProperty("level"))
               {
                  xpLevel = int(oJSON["level"]);
               }
               if(oJSON.hasOwnProperty("xp"))
               {
                  xp = int(oJSON["xp"]);
               }
               if(oJSON.hasOwnProperty("emailSubscribed"))
               {
                  emailSubscribed = int(oJSON["emailSubscribed"]);
               }
               if(oJSON.hasOwnProperty("gender"))
               {
                  gender = oJSON["gender"];
               }
               if(oJSON.hasOwnProperty("handsWon"))
               {
                  handsWon = int(oJSON["handsWon"]);
               }
               if(oJSON.hasOwnProperty("handsPlayed"))
               {
                  handsPlayed = int(oJSON["handsPlayed"]);
               }
            }
         }
         catch(error:Error)
         {
         }
         var tUser:PokerUser = new PokerUser(int(inObj[5]),inObj[2],Number(inObj[4]),inObj[6],inObj[7],Number(inObj[8]),int(inObj[9]),inObj[10],Number(inObj[11]).toString(),inObj[12],int(inObj[13]),inObj[14],inObj[15],Number(inObj[16]),"joining",0,int(inObj[18]),int(inObj[19]),int(inObj[20]),inObj[21],int(inObj[22]),int(inObj[23]),handsWon,1,xpLevel,xp,emailSubscribed,gender,handsPlayed);
         var msg:RSitJoined = new RSitJoined("RSitJoined",tUser);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onApplyToCreateRoomRes(param1:Object) : void {
         var _loc2_:RApplyToCreateRoom = new RApplyToCreateRoom("RApplyToCreateRoom",param1[2] == "1"?true:false);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onCreateRoomRes(param1:Object) : void {
         var _loc3_:RCreateRoomRes = null;
         var _loc2_:Array = new Array();
         if(param1[1] != -1)
         {
            _loc2_.push(new RoomItem(param1[2].split(",")));
            _loc3_ = new RCreateRoomRes("RCreateRoomRes",int(param1[1]),_loc2_,String(param1[3]));
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
         }
      }
      
      private function onNOPC(param1:Object) : void {
         var _loc2_:RNOPC = new RNOPC("RNOPC",Number(param1[1]),Number(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onSetMod(param1:Object) : void {
         var _loc2_:RSetMod = new RSetMod("RSetMod",Number(param1[2]) > 0);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onLastPot(param1:Object) : void {
         var _loc2_:RLastPot = new RLastPot("RLastPot");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onGoToLobby(param1:Object) : void {
         var _loc2_:RGoToLobby = new RGoToLobby("RGoToLobby");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onSitTaken(param1:Object) : void {
         var _loc2_:RSitTaken = new RSitTaken("RSitTaken");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onSpecStructure(param1:Object) : void {
         var jsonUser:Object = null;
         var userProfile:UserProfile = null;
         var inObj:Object = param1;
         var userProfiles:Array = new Array();
         var i:int = 2;
         while(i < inObj.length)
         {
            try
            {
               jsonUser = com.adobe.serialization.json.JSON.decode(inObj[i]);
               if(jsonUser != null)
               {
                  userProfile = new UserProfile(jsonUser["zid"],jsonUser["fullName"],jsonUser["network"],jsonUser["picUrl"],jsonUser["picLrgUrl"],jsonUser["profileUrl"],Number(jsonUser["totalPoints"]),int(jsonUser["achievement_rank"]),int(jsonUser["level"]),int(jsonUser["xp"]),jsonUser["gender"]);
                  userProfiles.push(userProfile);
               }
            }
            catch(e:Error)
            {
            }
            i++;
         }
         var msg:RSpecStructure = new RSpecStructure("RSpecStructure",userProfiles);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onSpecJoined(param1:Object) : void {
         var jsonUser:Object = null;
         var userProfile:UserProfile = null;
         var msg:RSpecJoined = null;
         var inObj:Object = param1;
         try
         {
            jsonUser = com.adobe.serialization.json.JSON.decode(inObj[2]);
            if(jsonUser != null)
            {
               userProfile = new UserProfile(jsonUser["zid"],jsonUser["fullName"],jsonUser["network"],jsonUser["picUrl"],jsonUser["picLrgUrl"],jsonUser["profileUrl"],Number(jsonUser["totalPoints"]),int(jsonUser["achievement_rank"]),int(jsonUser["level"]),int(jsonUser["xp"]),jsonUser["gender"],jsonUser["isMod"]);
               msg = new RSpecJoined("RSpecJoined",userProfile);
               dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onChallengeState(param1:Object) : void {
         var jsonChallenge:Object = null;
         var challenges:Dictionary = null;
         var challenge:Challenge = null;
         var c:Object = null;
         var initUserChallenge:UserChallenge = null;
         var activeChallenge:Object = null;
         var helpers:Array = null;
         var h:Object = null;
         var history:Object = null;
         var timeRemaining:Number = NaN;
         var assistance:AssistedChallenge = null;
         var inObj:Object = param1;
         this.challengeCachedObject = inObj;
         var userChallenges:Array = new Array();
         var assistedChallenges:Array = new Array();
         var xpMultiplier:Number = 1;
         try
         {
            jsonChallenge = com.adobe.serialization.json.JSON.decode(inObj[2]);
            if(jsonChallenge != null)
            {
               challenges = new Dictionary();
               for each (c in jsonChallenge.ChallengeDetails)
               {
                  challenge = new Challenge(c.TypeId,c.Name,c.Category,c.Description,c.BuddiesRequired,c.ChipReward,c.XpReward,c.Duration,ChallengeStatus.NOT_STARTED,c.SmallIconUrl,c.LargeIconUrl,true,0,c.Ordering,c.XpRewardBonus);
                  challenges[challenge.typeID] = challenge;
                  initUserChallenge = new UserChallenge("",challenge,ChallengeTaskStatus.NOT_STARTED,0,new Array());
                  if(jsonChallenge["ActiveChallenges"])
                  {
                     if(jsonChallenge.ActiveChallenges[String(initUserChallenge.challenge.typeID)])
                     {
                        activeChallenge = jsonChallenge.ActiveChallenges[String(initUserChallenge.challenge.typeID)] as Object;
                        initUserChallenge.taskStatus = activeChallenge.Task.Status;
                        initUserChallenge.challenge.challengeStatus = activeChallenge.ChallengeStatus;
                        initUserChallenge.challenge.chipsRewarded = activeChallenge.ChipReward;
                        initUserChallenge.challenge.xpRewarded = activeChallenge.XpReward;
                        initUserChallenge.id = activeChallenge.Initiator + ":" + activeChallenge.Id + ":" + challenge.typeID;
                        initUserChallenge.timeRemaining = activeChallenge.ChallengeTimeRemaining;
                        helpers = new Array();
                        for each (h in activeChallenge.Helpers)
                        {
                           try
                           {
                              if((h["Zid"]) && (h["TaskStatus"]))
                              {
                                 helpers.push(new ChallengeHelper(h.Zid,h.TaskStatus));
                              }
                           }
                           catch(e:Error)
                           {
                              continue;
                           }
                           continue;
                           if((h["Zid"]) && (h["TaskStatus"]))
                           {
                              helpers.push(new ChallengeHelper(h.Zid,h.TaskStatus));
                           }
                        }
                        initUserChallenge.helpers = helpers;
                     }
                  }
                  if(jsonChallenge["History"])
                  {
                     if(jsonChallenge.History[String(initUserChallenge.challenge.typeID)])
                     {
                        try
                        {
                           history = jsonChallenge.History[String(initUserChallenge.challenge.typeID)];
                           if(history.BestTime > 0)
                           {
                              initUserChallenge.bestTime = history.BestTime;
                           }
                           if(history["LastAttempt"])
                           {
                              if(history.LastAttempt["ChallengeTimeCompleted"])
                              {
                                 initUserChallenge.lastTime = (history.LastAttempt.ChallengeTimeCompleted - history.LastAttempt.ChallengeTimeInitiated) / 1000;
                                 initUserChallenge.challenge.chipsRewarded = history.LastAttempt.ChipReward;
                                 initUserChallenge.challenge.xpRewarded = history.LastAttempt.XpReward;
                                 if(!(initUserChallenge.taskStatus == ChallengeTaskStatus.IN_PROGRESS) && !(initUserChallenge.taskStatus == ChallengeTaskStatus.COMPLETE))
                                 {
                                    if(history.LastAttempt.ChallengeStatus)
                                    {
                                       initUserChallenge.challenge.challengeStatus = history.LastAttempt.ChallengeStatus;
                                    }
                                    if(history.LastAttempt.Task)
                                    {
                                       if(history.LastAttempt.Task.Status)
                                       {
                                          initUserChallenge.taskStatus = history.LastAttempt.Task.Status;
                                       }
                                    }
                                 }
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     if(jsonChallenge.History[String(initUserChallenge.challenge.typeID)])
                     {
                     }
                  }
                  if(jsonChallenge.ChallengeOkToRestart[String(initUserChallenge.challenge.typeID)])
                  {
                     timeRemaining = jsonChallenge.ChallengeOkToRestart[String(initUserChallenge.challenge.typeID)];
                     initUserChallenge.challenge.nextAvailable = timeRemaining;
                  }
                  userChallenges.push(initUserChallenge);
               }
               try
               {
                  for each (c in jsonChallenge.Assistances)
                  {
                     if(challenges[c.TypeId])
                     {
                        challenge = (challenges[c.TypeId] as Challenge).clone();
                        challenge.challengeStatus = c.ChallengeStatus;
                        challenge.chipsRewarded = c.ChipReward;
                        challenge.xpRewarded = c.XpReward;
                        assistance = new AssistedChallenge(c.Id,c.Initiator,challenge,ChallengeDisposition.WILLING,c.Task.Status,c.ChallengeTimeRemaining,c.Task.Status,c.ChallengeTimeInitiated);
                        assistedChallenges.push(assistance);
                     }
                  }
                  for each (c in jsonChallenge.Opportunities)
                  {
                     if(challenges[c.TypeId])
                     {
                        challenge = (challenges[c.TypeId] as Challenge).clone();
                        challenge.challengeStatus = c.ChallengeStatus;
                        challenge.chipsRewarded = c.ChipReward;
                        challenge.xpRewarded = c.XpReward;
                        assistance = new AssistedChallenge(c.Id,c.Initiator,challenge,ChallengeDisposition.UNWILLING,c.Task.Status,c.ChallengeTimeRemaining,ChallengeTaskStatus.NOT_STARTED,c.ChallengeTimeInitiated);
                        assistedChallenges.push(assistance);
                     }
                  }
               }
               catch(e:Error)
               {
               }
               try
               {
                  xpMultiplier = jsonChallenge.xpMultiplier;
               }
               catch(e:Error)
               {
               }
            }
         }
         catch(e:Error)
         {
         }
         userChallenges.sort(function order(param1:UserChallenge, param2:UserChallenge):int
         {
            var _loc3_:Number = param1.challenge.ordering;
            var _loc4_:Number = param2.challenge.ordering;
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            if(_loc3_ > _loc4_)
            {
               return 1;
            }
            return 0;
         });
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,new RChallengeState("RChallengeState",userChallenges,assistedChallenges,xpMultiplier)));
      }
      
      private function onCreateChallengeSuccess(param1:Object) : void {
         var _loc2_:String = param1[2];
         var _loc3_:RCreateChallengeSuccess = new RCreateChallengeSuccess("RCreateChallengeSuccess",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onJoinChallengeStatus(param1:Object) : void {
         var _loc6_:String = null;
         var _loc7_:RJoinChallengeStatus = null;
         var _loc8_:Array = null;
         var _loc2_:String = param1[2];
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         var _loc5_:Array = _loc2_.split(":::");
         for each (_loc6_ in _loc5_)
         {
            _loc8_ = _loc6_.split("::");
            if(_loc8_.length == 2)
            {
               if(_loc8_[1] == 9 || _loc8_[1] == 10)
               {
                  _loc3_.push(_loc8_);
               }
               else
               {
                  _loc4_.push(_loc8_);
               }
            }
         }
         _loc7_ = new RJoinChallengeStatus(_loc3_,_loc4_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc7_));
      }
      
      private function onChallengeError(param1:Object) : void {
         var _loc2_:int = int(param1[2]);
         var _loc3_:RChallengeError = new RChallengeError(_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onPostBlind(param1:Object) : void {
         var _loc2_:RPostBlind = new RPostBlind("RPostBlind",int(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onDealHoles(param1:Object) : void {
         var _loc2_:RDealHoles = new RDealHoles("RDealHoles",int(param1[2]),String(param1[3]),Number(param1[4]),String(param1[5]),Number(param1[6]),int(param1[7]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRaiseOption(param1:Object) : void {
         var _loc2_:RRaiseOption = new RRaiseOption("RRaiseOption",Number(param1[2]),Number(param1[3]),Number(param1[4]),Boolean(param1[5]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onCallOption(param1:Object) : void {
         var _loc2_:RCallOption = new RCallOption("RCallOption",Number(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onMarkTurn(param1:Object) : void {
         var _loc2_:RMarkTurn = new RMarkTurn("RMarkTurn",Number(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onFold(param1:Object) : void {
         var _loc2_:RFold = new RFold("RFold",int(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onCall(param1:Object) : void {
         var _loc2_:RCall = new RCall("RCall",int(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onAllin(param1:Object) : void {
         var _loc2_:RAllin = new RAllin("RAllin",int(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onAllinWar(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.sit = int(param1[_loc3_]);
            _loc5_.card1 = String(param1[_loc3_ + 1]);
            _loc5_.tip1 = Number(param1[_loc3_ + 2]);
            _loc5_.card2 = String(param1[_loc3_ + 3]);
            _loc5_.tip2 = Number(param1[_loc3_ + 4]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 5;
         }
         var _loc4_:RAllinWar = new RAllinWar("RAllinWar",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onShowAllHoles(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.sit = int(param1[_loc3_]);
            _loc5_.card1 = String(param1[_loc3_ + 1]);
            _loc5_.tip1 = Number(param1[_loc3_ + 2]);
            _loc5_.card2 = String(param1[_loc3_ + 3]);
            _loc5_.tip2 = Number(param1[_loc3_ + 4]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 5;
         }
         var _loc4_:RShowAllHoles = new RShowAllHoles("RShowAllHoles",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onFlop(param1:Object) : void {
         var _loc2_:RFlop = new RFlop("RFlop",String(param1[2]),Number(param1[3]),String(param1[4]),Number(param1[5]),String(param1[6]),Number(param1[7]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onStreet(param1:Object) : void {
         var _loc2_:RStreet = new RStreet("RStreet",String(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRiver(param1:Object) : void {
         var _loc2_:RRiver = new RRiver("RRiver",String(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onMakePot(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 3;
         while(_loc3_ < int(param1[2]) + 3)
         {
            _loc2_.push(Number(param1[_loc3_]));
            _loc3_++;
         }
         var _loc4_:RMakePot = new RMakePot("RMakePot",int(param1[2]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onSendGiftChips(param1:Object) : void {
         var _loc2_:RSendGiftChips = new RSendGiftChips("RSendGiftChips",Number(param1[2]),Number(param1[3]),Number(param1[4]),Number(param1[5]),Number(param1[6]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onUpdateChips(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.sit = int(param1[_loc3_]);
            _loc5_.chips = Number(param1[_loc3_ + 1]);
            _loc5_.total = Number(param1[_loc3_ + 2]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 3;
         }
         var _loc4_:RUpdateChips = new RUpdateChips("RUpdateChips",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onRefillPoints(param1:Object) : void {
         var _loc2_:RRefillPoints = new RRefillPoints("RRefillPoints",int(param1[2]),int(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onOutOfChips(param1:Object) : void {
         var _loc2_:ROutOfChips = new ROutOfChips("ROutOfChips");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onWinners(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 4;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.sit = int(param1[_loc3_]);
            _loc5_.chips = Number(param1[_loc3_ + 1]);
            _loc5_.card1 = String(param1[_loc3_ + 2]);
            _loc5_.tip1 = Number(param1[_loc3_ + 3]);
            _loc5_.card2 = String(param1[_loc3_ + 4]);
            _loc5_.tip2 = Number(param1[_loc3_ + 5]);
            if(param1[_loc3_ + 6] != null)
            {
               _loc5_.handString = param1[_loc3_ + 6].split(":");
            }
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 7;
         }
         var _loc4_:RWinners = new RWinners("RWinners",Number(param1[2]),String(param1[3]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onUserLost(param1:Object) : void {
         var _loc2_:RUserLost = new RUserLost("RUserLost",int(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onUserSitOut(param1:Object) : void {
         var _loc2_:RUserSitOut = new RUserSitOut("RUserSitOut",int(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onBustOutMonetization(param1:Object) : void {
         var _loc2_:RBustOutMonetization = new RBustOutMonetization(int(param1[2]),int(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onClear(param1:Object) : void {
         var _loc2_:RClear = new RClear("RClear");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onDefaultWinners(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 4;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(Number(param1[_loc3_]));
            _loc3_++;
         }
         var _loc4_:RDefaultWinners = new RDefaultWinners("RDefaultWinners",int(param1[2]),Number(param1[3]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onRaise(param1:Object) : void {
         var _loc2_:RRaise = new RRaise("RRaise",int(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onTurnChanged(param1:Object) : void {
         var _loc2_:RTurnChanged = new RTurnChanged("RTurnChanged",int(param1[2]),int(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onTourneyOver(param1:Object) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         _loc2_ = Number(param1[2]);
         if(!(param1[3] == null) && !(param1[3] == "nothing."))
         {
            _loc3_ = Number(param1[3]);
         }
         else
         {
            _loc3_ = 0;
         }
         var _loc4_:RTourneyOver = new RTourneyOver("RTourneyOver",_loc2_,_loc3_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onBlindChange(param1:Object) : void {
         var _loc2_:RBlindChange = new RBlindChange("RBlindChange",Number(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onDealerTipped(param1:Object) : void {
         var oJSON:Object = null;
         var fromSit:int = 0;
         var inObj:Object = param1;
         try
         {
            fromSit = com.adobe.serialization.json.JSON.decode(unescape(inObj[2])).fromSit;
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RDealerTipped = new RDealerTipped("RDealerTipped",fromSit);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onDealerTipTooExpensive(param1:Object) : void {
         var _loc2_:RDealerTipTooExpensive = new RDealerTipTooExpensive("RDealerTipTooExpensive");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onBuyinError(param1:Object) : void {
         var _loc2_:RBuyinError = new RBuyinError("RBuyinError",Number(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onBoughtGift(param1:Object) : void {
         var _loc2_:RBoughtGift = new RBoughtGift("RBoughtGift",Number(param1[2]),Number(param1[3]),Number(param1[4]),Number(param1[5]),Number(param1[6]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onBoughtGift2(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RBoughtGift2 = new RBoughtGift2("RBoughtGift2",oJSON.fromSit,oJSON.giftId,oJSON.fromChips,oJSON.toSit);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onUserGifts(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 3;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.type = Number(param1[_loc3_]);
            _loc5_.number = Number(param1[_loc3_ + 1]);
            _loc5_.name = String(param1[_loc3_ + 2]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 3;
         }
         var _loc4_:RUserGifts = new RUserGifts("RUserGifts",Number(param1[2]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onUserGifts2(param1:Object) : void {
         var oJSON:Object = null;
         var gift:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var aGifts:Array = new Array();
         var i:int = 0;
         while(i < oJSON.gifts.length)
         {
            gift = new Object();
            gift.giftId = oJSON.gifts[i].giftId;
            gift.name = oJSON.gifts[i].giverFirstName;
            aGifts.push(gift);
            i++;
         }
         var msg:RUserGifts2 = new RUserGifts2("RUserGifts2",oJSON.sit,aGifts);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onGiftShown(param1:Object) : void {
         var _loc2_:RGiftShown = new RGiftShown("RGiftShown",Number(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onGiftShown2(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[3]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RGiftShown2 = new RGiftShown2("RGiftShown2",Number(inObj[2]),oJSON.giftId);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onBuyGiftTooExpensive(param1:Object) : void {
         var _loc2_:Number = Number(parseInt(param1[2]));
         var _loc3_:Number = Number(parseInt(param1[3]));
         var _loc4_:RGiftTooExpensive = new RGiftTooExpensive("RGiftTooExpensive",_loc2_,_loc3_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onShowEvents(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.eType = Number(param1[_loc3_]);
            _loc5_.fZid = String(param1[_loc3_ + 1]);
            _loc5_.fName = String(param1[_loc3_ + 2]);
            _loc5_.tZid = String(param1[_loc3_ + 3]);
            _loc5_.tName = String(param1[_loc3_ + 4]);
            _loc5_.gType = Number(param1[_loc3_ + 5]);
            _loc5_.gNum = Number(param1[_loc3_ + 6]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 7;
         }
         var _loc4_:RShowEvents = new RShowEvents("RShowEvents",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onAcquireToken(param1:Object) : void {
         var _loc2_:Date = new Date();
         _loc2_.setTime(Number(param1[3]));
         var _loc3_:RAcquireToken = new RAcquireToken("RAcquireToken",String(param1[2]),_loc2_,int(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onShowMessage(param1:Object) : void {
         var _loc2_:RShowMessage = new RShowMessage("RShowMessage",String(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRoomPass(param1:Object) : void {
         var _loc2_:RRoomPass = new RRoomPass("RRoomPass",Number(param1[2]),String(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onReplayCards(param1:Object) : void {
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc5_ = new Object();
            _loc5_.card = Number(param1[_loc3_]);
            _loc5_.suit = Number(param1[_loc3_ + 1]);
            _loc2_.push(_loc5_);
            _loc3_ = _loc3_ + 2;
         }
         var _loc4_:RReplayCards = new RReplayCards("RReplayCards",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onReplayHoles(param1:Object) : void {
         var _loc2_:RReplayHoles = new RReplayHoles("RReplayHoles",Number(param1[2]),Number(param1[3]),Number(param1[4]),Number(param1[5]),Number(param1[6]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onReplayPots(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 3;
         while(_loc3_ < Number(param1[2]) + 3)
         {
            _loc2_.push(Number(param1[_loc3_]));
            _loc3_++;
         }
         var _loc4_:RReplayPots = new RReplayPots("RReplayPots",Number(param1[2]),_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onReplayPlayers(param1:Object) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(Number(param1[_loc3_]));
            _loc3_++;
         }
         var _loc4_:RReplayPlayers = new RReplayPlayers("RReplayPlayers",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onBuddyRequest(param1:Object) : void {
         var _loc2_:RBuddyRequest = new RBuddyRequest("RBuddyRequest",int(param1[2]),String(param1[3]),String(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onNewBuddy(param1:Object) : void {
         var _loc2_:RNewBuddy = new RNewBuddy("RNewBuddy",String(param1[2]),String(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onCardOptions(param1:Object) : void {
         var _loc2_:RCardOptions = new RCardOptions("RCardOptions",String(param1[2]),String(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onUserLevelUp(param1:Object) : void {
         var _loc2_:RUserLevelUp = new RUserLevelUp("RUserLevelUp",Number(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onAchieved(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RAchieved = new RAchieved("RAchieved",oJSON);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onAlert(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RAlert = new RAlert("RAlert",unescape(inObj[2]),oJSON);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onShootoutConfig(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var shootoutObj:Object = null;
         if(oJSON["shootout"] != undefined)
         {
            shootoutObj = oJSON["shootout"];
         }
         var userObj:Object = null;
         if(oJSON["user"] != undefined)
         {
            userObj = oJSON["user"];
         }
         var msg:RShootoutConfig = new RShootoutConfig("RShootoutConfig",shootoutObj,userObj);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onUserShootoutState(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var userObj:Object = null;
         if(oJSON["user"] != undefined)
         {
            userObj = oJSON["user"];
         }
         var msg:RUserShootoutState = new RUserShootoutState("RUserShootoutState",userObj);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onPremiumShootoutConfig(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var shootoutObj:Array = null;
         if(oJSON["shootouts"] != undefined)
         {
            shootoutObj = oJSON["shootouts"];
         }
         var msg:RPremiumShootoutConfig = new RPremiumShootoutConfig("RPremiumShootoutConfig",shootoutObj);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onSFLogin(param1:SFSEvent) : void {
         var _loc2_:RLogKO = new RLogKO("RLogKO",param1.params.success,param1.params.error,false);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onGameAlreadyStarted(param1:Object) : void {
         var _loc2_:RGameAlreadyStarted = new RGameAlreadyStarted("RGameAlreadyStarted");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onAlreadyPlayingShootout(param1:Object) : void {
         var _loc2_:RAlreadyPlayingShootout = new RAlreadyPlayingShootout("RAlreadyPlayingShootout");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onSitPermissionRefused(param1:Object) : void {
         var _loc2_:RSitPermissionRefused = new RSitPermissionRefused("RSitPermissionRefused");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onWrongRound(param1:Object) : void {
         var _loc2_:RWrongRound = new RWrongRound("RWrongRound",Number(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onWrongBuyin(param1:Object) : void {
         var _loc2_:RWrongBuyin = new RWrongBuyin("RWrongBuyin");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onSitNotReserved(param1:Object) : void {
         var _loc2_:RSitNotReserved = new RSitNotReserved("RSitNotReserved");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onShootoutBuyinChanged(param1:Object) : void {
         var _loc2_:RShootoutBuyinChanged = new RShootoutBuyinChanged("RShootoutBuyinChanged",Number(param1[2]),Number(param1[3]),Number(param1[4]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onShootoutConfigChanged(param1:Object) : void {
         var _loc2_:RShootoutConfigChanged = new RShootoutConfigChanged("RShootoutConfigChanged");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onPlayerBounced(param1:Object) : void {
         var _loc2_:RPlayerBounced = new RPlayerBounced("RPlayerBounced");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onRoundChanged(param1:Object) : void {
         var _loc2_:RRoundChanged = new RRoundChanged("RRoundChanged");
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onXPEarned(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RXPEarned = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RXPEarned("RXPEarned",Number(oJSON["xpDelta"]),Number(oJSON["xp"]),Number(oJSON["xpLevelEnd"]),Number(oJSON["level"]),String(oJSON["reason"]));
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onUserInfo(param1:Object) : void {
         var oJSON:Object = null;
         var tXp:Number = NaN;
         var tLevel:Number = NaN;
         var tXpLevelEnd:Number = NaN;
         var tCasinoGold:Number = NaN;
         var tNextGiftUnlock:Number = NaN;
         var tNextAchievementUnlock:Number = NaN;
         var tRakeEnabled:int = 0;
         var tRakePercentage:Number = NaN;
         var tRakeBlindMultiplier:Number = NaN;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         if(oJSON.hasOwnProperty("xp"))
         {
            tXp = oJSON.xp.xp;
            tLevel = oJSON.xp.level;
            tXpLevelEnd = oJSON.xp.xpLevelEnd;
            tNextGiftUnlock = oJSON.xp.nextGiftUnlock;
            tNextAchievementUnlock = oJSON.xp.nextAchievementUnlock;
         }
         if(oJSON.hasOwnProperty("casino_gold"))
         {
            tCasinoGold = oJSON.casino_gold;
         }
         if(oJSON.hasOwnProperty("rakeEnabled"))
         {
            tRakeEnabled = oJSON.rakeEnabled;
            tRakePercentage = oJSON.rakePercentage;
            tRakeBlindMultiplier = oJSON.rakeMaxMultiplier;
         }
         var msg:RGetUserInfo = new RGetUserInfo("RGetUserInfo",tXp,tLevel,tXpLevelEnd,tCasinoGold,tNextGiftUnlock,tNextAchievementUnlock,tRakeEnabled,tRakePercentage,tRakeBlindMultiplier);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onUserLevelledUp(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RUserLevelledUp = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RUserLevelledUp("RUserLevelledUp",int(oJSON["sit"]),oJSON["zid"],int(oJSON["level"]),int(oJSON["xp"]),int(oJSON["nextAchievementUnlock"]),int(oJSON["nextGiftUnlock"]));
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onGoldUpdate(param1:Object) : void {
         var _loc2_:RGoldUpdate = new RGoldUpdate("RGoldUpdate",Number(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onUpdateCurrency(param1:Object) : void {
         var _loc2_:RUpdateCurrency = new RUpdateCurrency("RUpdateCurrency",String(param1[2]),Number(param1[3]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onGiftInfo3(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RGiftInfo3 = new RGiftInfo3("RGiftInfo3",oJSON);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onGiftPrices3(param1:Object) : void {
         var oJSON:Object = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
         }
         catch(e:JSONParseError)
         {
         }
         var msg:RGiftPrices3 = new RGiftPrices3("RGiftPrices3",oJSON.categoryId,oJSON.gifts,oJSON.categories);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
      }
      
      private function onBuyPremiumGiftTooExpensive(param1:Object) : void {
         var _loc2_:Number = Number(parseInt(param1[2]));
         var _loc3_:Number = Number(parseInt(param1[3]));
         var _loc4_:RPremiumGiftTooExpensive = new RPremiumGiftTooExpensive("RPremiumGiftTooExpensive",_loc2_,_loc3_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onBuyRoundSkippingTooExpensive(param1:Object) : void {
         var _loc2_:Number = Number(parseInt(param1[2]));
         var _loc3_:Number = Number(parseInt(param1[3]));
         var _loc4_:RBuyRoundSkippingTooExpensive = new RBuyRoundSkippingTooExpensive("RBuyRoundSkippingTooExpensive",_loc2_,_loc3_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc4_));
      }
      
      private function onCollectionItemEarned(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RCollectionItemEarned = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RCollectionItemEarned("RCollectionItemEarned",oJSON["id"],oJSON["newCnt"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onCollectionsInfo(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RCollectionsInfo = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RCollectionsInfo("RCollectionsInfo",oJSON["staticInfo"],oJSON["userSexyInfo"],oJSON.hasOwnProperty("otherZidUserSexyInfo")?oJSON["otherZidUserSexyInfo"]:null,oJSON["xpMultiplier"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onCollectionsComplete(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RCollectionsComplete = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RCollectionsComplete("RCollectionsComplete",oJSON["collectionId"],oJSON);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onCollectionsClaimError(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RCollectionsClaimError = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RCollectionsClaimError("RCollectionsClaimError",oJSON["title"],oJSON["msg"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onStatsInfo(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RStatsInfo = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RStatsInfo("RStatsInfo",inObj[2]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onGetChipsSig(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RGetChipsSig = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RGetChipsSig("RGetChipsSig",oJSON["sig"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onLadderGameHighScore(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RLadderGameHighScore = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RLadderGameHighScore("RLadderGameHighScore",oJSON["weekNumber"],oJSON["score"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRatholingUserState(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RRatholingUserState = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RRatholingUserState("RRatholingUserState",oJSON["expireSecs"],oJSON["roomId"],oJSON["minBuyin"]);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRakeAmount(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RRakeAmount = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RRakeAmount("RRakeAmount",oJSON);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRakeDisabled(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RRakeDisabled = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RRakeDisabled("RRakeDisabled",oJSON);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRakeEnabled(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RRakeEnabled = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RRakeEnabled("RRakeEnabled",oJSON);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRakeInsufficientFunds(param1:Object) : void {
         var oJSON:Object = null;
         var msg:RRakeInsufficientFunds = null;
         var inObj:Object = param1;
         try
         {
            oJSON = com.adobe.serialization.json.JSON.decode(unescape(inObj[2]));
            msg = new RRakeInsufficientFunds("RRakeInsufficientFunds",oJSON.event);
            dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,msg));
         }
         catch(e:JSONParseError)
         {
         }
      }
      
      private function onRequestHeartBeat(param1:Object) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         var _loc3_:RRequestHeartBeat = new RRequestHeartBeat("RRequestHeartBeat",_loc2_.id,_loc2_.delay);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onUserUnderUP(param1:Object) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         var _loc3_:RUserUnderUP = new RUserUnderUP("RUserUnderUP",_loc2_.sit,_loc2_.type);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onSmartfoxMessageToJS(param1:Object) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         var _loc3_:RSmartfoxMessageToJS = new RSmartfoxMessageToJS("RSmartfoxMessageToJS",_loc2_.messageName,_loc2_.message,_loc2_.jsDest);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onAutoChips(param1:Object) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         var _loc3_:RAutoChips = new RAutoChips("RAutoChips",String(_loc2_.type),Number(_loc2_.sitNo),String(_loc2_.zid),Number(_loc2_.amount));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onFindRoom(param1:Object) : void {
         var _loc2_:RoomItem = null;
         if(param1.rooms.length)
         {
            _loc2_ = new RoomItem(param1.rooms[0].split(","));
         }
         var _loc3_:RJumpTableSearchResult = new RJumpTableSearchResult("RJumpTableSearchResult",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onFindRoomFailure(param1:Object) : void {
         var _loc2_:RJumpTableSearchResult = new RJumpTableSearchResult("RJumpTableSearchResult",null);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onServerStatus(param1:Object) : void {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(unescape(param1[2]));
         var _loc3_:RServerStatus = new RServerStatus("RServerStatus",_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onMTTSitInfo(param1:Object) : void {
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,
            {
               "type":"RMTTSitInfo",
               "seat":param1[3]
            }));
      }
      
      private function onMoveGivenPlayer(param1:Object) : void {
         var _loc2_:RMoveGivenPlayer = new RMoveGivenPlayer(uint(param1[2]),uint(param1[4]),param1[3],param1[5],Number(param1[6]),int(param1[7]),Number(param1[8]),param1[9],param1[10],param1[11]);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onEnterLuckyHandCouponTimestamp(param1:Object) : void {
         var _loc2_:REnterLuckyHandCouponTimestamp = new REnterLuckyHandCouponTimestamp("REnterLuckyHandCouponTimestamp",int(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onEnterUnluckyHandCouponTimestamp(param1:Object) : void {
         var _loc2_:REnterUnluckyHandCouponTimestamp = new REnterUnluckyHandCouponTimestamp("REnterUnluckyHandCouponTimestamp",int(param1[2]));
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onPokerScoreUpdate(param1:Object) : void {
         var _loc2_:RPokerScoreUpdate = new RPokerScoreUpdate("RPokerScoreUpdate",param1[2],param1[3],param1[4]);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onPlayersClubUpdate(param1:Object) : void {
         var _loc2_:RPlayersClubUpdate = new RPlayersClubUpdate("RPlayersClubUpdate",param1[2],param1[3]);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      private function onHelpingHandsUserContributionUpdate(param1:Object) : void {
         var _loc2_:Number = Number(param1[2]);
         var _loc3_:RHelpingHandsUserContributionUpdate = new RHelpingHandsUserContributionUpdate(_loc2_);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc3_));
      }
      
      private function onMegaBillionsUpdate(param1:Object) : void {
         var _loc2_:RMegaBillionsUpdate = new RMegaBillionsUpdate("RMegaBillionsUpdate",param1[2],param1[3],param1[4],param1[5],param1[6],param1[7],param1[8],param1[9]);
         dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage,_loc2_));
      }
      
      public function get rollingRebootStoredInfo() : RMoveGivenPlayer {
         return this._rollingRebootStoredInfo;
      }
      
      public function set rollingRebootStoredInfo(param1:RMoveGivenPlayer) : void {
         this._rollingRebootStoredInfo = param1;
      }
   }
}
