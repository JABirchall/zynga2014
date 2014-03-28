package com.zynga.poker
{
   import com.zynga.poker.protocol.RHyperJoin;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.protocol.SHyperPlayNow;
   import com.zynga.poker.protocol.SHyperFindRoom;
   import com.zynga.poker.protocol.SHyperJoin;
   import com.zynga.poker.protocol.SSuperJoinRoom;
   
   public final class JoinRoomTransition extends Object
   {
      
      public function JoinRoomTransition(param1:int=0, param2:Number=1, param3:uint=5, param4:String="normal") {
         this._pgData = PokerGlobalData.instance;
         super();
         if(param1 >= 0)
         {
            this.nRoomId = param1;
            this._pgData.roomIdDisplay = param1;
            this._useRoomId = true;
         }
         else
         {
            this._smallBlind = param2;
            this._maximumPlayers = param3;
            this._roomType = param4;
            this._useRoomId = false;
         }
      }
      
      private static const STATE_INIT:int = 0;
      
      private static const STATE_PASS_REQUESTED:int = 1;
      
      private static const STATE_PASS_ACQUIRED:int = 2;
      
      private static const STATE_END:int = 3;
      
      public var nRoomId:int;
      
      private var _roomName:String;
      
      public var fBeforeJoin:Function = null;
      
      public var fAfterJoin:Function = null;
      
      private var oData:RHyperJoin = null;
      
      private var nState:int = 0;
      
      private var _pgData:PokerGlobalData;
      
      private var _useRoomId:Boolean = true;
      
      private var _smallBlind:Number;
      
      private var _maximumPlayers:uint;
      
      private var _roomType:String;
      
      public var targetServerId:String;
      
      public function isComplete() : Boolean {
         return this.nState == STATE_END;
      }
      
      public function join(param1:IPokerConnectionManager) : Boolean {
         var _loc2_:* = false;
         if(this._pgData.enableHyperJoin)
         {
            this.tryReconnect();
            this.tryRollingReboot();
            switch(this.nState)
            {
               case STATE_INIT:
                  this.start(param1);
                  _loc2_ = true;
                  break;
               case STATE_PASS_REQUESTED:
                  break;
               case STATE_PASS_ACQUIRED:
                  this.end(param1);
                  _loc2_ = true;
                  break;
               case STATE_END:
                  break;
            }
            
         }
         else
         {
            this.performSuperJoin(param1);
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function setHyperJoinResponse(param1:RHyperJoin) : Boolean {
         var _loc2_:* = false;
         switch(this.nState)
         {
            case STATE_INIT:
            case STATE_PASS_REQUESTED:
               this.oData = param1;
               this.nState = STATE_PASS_ACQUIRED;
               _loc2_ = true;
               break;
            case STATE_PASS_ACQUIRED:
               break;
            case STATE_END:
               break;
         }
         
         return _loc2_;
      }
      
      private function start(param1:IPokerConnectionManager) : void {
         if(this._useRoomId)
         {
            if(!(this.nRoomId == RoomItem.LOBBY_ID) && !this._pgData.joiningContact)
            {
               if(this.nRoomId == 0)
               {
                  this.playNowChallenge(param1);
               }
               else
               {
                  this.findChallenge(param1);
               }
            }
            else
            {
               this.startHyperJoin(param1);
            }
         }
         else
         {
            this.findChallenge(param1);
         }
         this._pgData.lastHyperJoin = this;
         this.nState = STATE_PASS_REQUESTED;
      }
      
      private function playNowChallenge(param1:IPokerConnectionManager) : void {
         var _loc2_:SHyperPlayNow = new SHyperPlayNow();
         param1.sendMessage(_loc2_);
      }
      
      private function findChallenge(param1:IPokerConnectionManager) : void {
         var _loc2_:* = NaN;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc6_:RoomItem = null;
         if(this._useRoomId)
         {
            _loc6_ = this._pgData.aRoomsById[this.nRoomId];
            if(_loc6_ === null)
            {
               return;
            }
            _loc2_ = _loc6_.smallBlind;
            _loc3_ = _loc6_.maxPlayers;
            _loc4_ = _loc6_.type;
         }
         else
         {
            _loc2_ = this._smallBlind;
            _loc3_ = this._maximumPlayers;
            _loc4_ = this._roomType;
         }
         var _loc5_:SHyperFindRoom = new SHyperFindRoom(_loc2_,_loc3_,_loc4_);
         param1.sendMessage(_loc5_);
      }
      
      private function startHyperJoin(param1:IPokerConnectionManager) : void {
         var _loc2_:SHyperJoin = new SHyperJoin(uint(this._pgData.serverId),this.getRoomTypeId(this._pgData),String(this.nRoomId));
         if(this._pgData.joiningContact)
         {
            _loc2_.friendZid = this._pgData.joinFriendId;
         }
         param1.sendMessage(_loc2_);
      }
      
      private function end(param1:IPokerConnectionManager) : void {
         var _loc2_:SHyperJoin = null;
         this.callBefore();
         if(this.oData != null)
         {
            this._pgData.gameRoomId = int(this.oData.roomId);
            _loc2_ = new SHyperJoin(this.oData.serverId,this.oData.roomTypeId,this.oData.roomId,this.oData.pass,this.oData.timestamp);
            param1.sendMessage(_loc2_);
         }
         this.callAfter();
         this.nState = STATE_END;
         this._pgData.lastHyperJoin = null;
      }
      
      public function cancel() : void {
         this._pgData.gameRoomId = this._pgData.lobbyRoomId;
         this.nState = STATE_END;
         this._pgData.lastHyperJoin = null;
      }
      
      public function close() : void {
         this._pgData.gameRoomId = this.nRoomId;
         this.callBefore();
         this.callAfter();
         this.nState = STATE_END;
         this._pgData.lastHyperJoin = null;
      }
      
      public function performSuperJoin(param1:IPokerConnectionManager) : void {
         this._pgData.gameRoomId = this.nRoomId;
         this.callBefore();
         param1.sendMessage(new SSuperJoinRoom(this.nRoomId,"",this._pgData.joinFriendId));
         this.callAfter();
         this.nState = STATE_END;
         this._pgData.lastHyperJoin = null;
      }
      
      private function tryReconnect() : void {
         var _loc1_:String = null;
         if(this.nState == STATE_INIT && !this._pgData.joiningContact && this._pgData.rejoinRoom > 1)
         {
            this.setHyperJoinResponse(new RHyperJoin(uint(this._pgData.serverId),this._pgData.rejoinType,String(this._pgData.rejoinRoom),this._pgData.rejoinPass,this._pgData.rejoinTime));
            this.nState = STATE_PASS_ACQUIRED;
            if(this._pgData.flashCookie != null)
            {
               _loc1_ = String(this._pgData.flashCookie.GetValue("sRoomName",""));
               if(_loc1_ != "")
               {
                  this._pgData.roomNameDisplay = _loc1_;
               }
            }
         }
      }
      
      private function tryRollingReboot() : void {
         if((this._pgData.bIsFastRR) && this.nState == STATE_INIT)
         {
            this.setHyperJoinResponse(new RHyperJoin(uint(this._pgData.moveServerId),0,String(this._pgData.moveRoom),this._pgData.movePass,this._pgData.moveTimestamp));
         }
      }
      
      public function get roomName() : String {
         return this._roomName;
      }
      
      private function callBefore() : void {
         if(this.fBeforeJoin != null)
         {
            this.fBeforeJoin.call();
            this.fBeforeJoin = null;
         }
      }
      
      private function callAfter() : void {
         if(this.fAfterJoin != null)
         {
            this.fAfterJoin.call();
            this.fAfterJoin = null;
         }
      }
      
      private function getRoomTypeId(param1:PokerGlobalData) : uint {
         return (param1.joiningContact) || this.nRoomId == param1.lobbyRoomId?0:uint(param1.aRoomsById[this.nRoomId].roomTypeId);
      }
   }
}
