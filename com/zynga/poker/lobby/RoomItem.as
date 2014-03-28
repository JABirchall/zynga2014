package com.zynga.poker.lobby
{
   import com.zynga.poker.PokerGlobalData;
   
   public class RoomItem extends Object
   {
      
      public function RoomItem(param1:Array) {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         super();
         var _loc2_:Array = ["_roomName","id","users","maxUsers","players","smallBlind","bigBlind","gameType","entryFee","hostFee","maxBuyin","maxPlayers","_prizes","_status","tableType","gid","lastPot","type","unlockLevel","creatorId","minBuyin","playerSpeed","roomTypeId"];
         var _loc3_:Array = ["id","users","maxUsers","players","smallBlind","bigBlind","entryFee","hostFee","minBuyin","maxBuyin","maxPlayers","lastPot","unlockLevel","playerSpeed","roomTypeId"];
         var _loc4_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc4_ > param1.length-1)
            {
               break;
            }
            if(_loc2_[_loc4_] == "_roomName")
            {
               param1[_loc4_] = param1[_loc4_].replace(new RegExp("_","g")," ");
            }
            else
            {
               if(_loc2_[_loc4_] == "creatorId")
               {
                  _loc6_ = param1[_loc4_].toString().split(" ");
                  if(_loc6_.length)
                  {
                     param1[_loc4_] = _loc6_[_loc6_.length-1];
                  }
               }
               else
               {
                  if(_loc2_[_loc4_] == "playerSpeed")
                  {
                     if(param1[_loc4_] == "" || param1[_loc4_] == "NaN")
                     {
                        param1[_loc4_] = "-1";
                     }
                  }
               }
            }
            this[_loc2_[_loc4_]] = param1[_loc4_];
            _loc4_++;
         }
         for (_loc5_ in _loc3_)
         {
            this[_loc3_[_loc5_]] = parseFloat(this[_loc3_[_loc5_]]);
         }
         this.prizes = this._prizes.split("/");
         if(!(this._status == null) && !(this._status == "") && this._status.length > 0)
         {
            this.status = this._status == "0"?false:true;
         }
      }
      
      public static const LOBBY_ID:Number = 1;
      
      private var _roomName:String;
      
      public var gameType:String;
      
      public var playersList:Array;
      
      public var id:Number;
      
      public var gid:Number;
      
      public var users:Number;
      
      public var maxUsers:Number;
      
      public var smallBlind:Number;
      
      public var bigBlind:Number;
      
      public var entryFee:Number;
      
      public var hostFee:Number;
      
      public var minBuyin:Number;
      
      public var maxBuyin:Number;
      
      public var players:Number;
      
      public var maxPlayers:Number;
      
      public var lastPot:Number;
      
      public var prizes:Array;
      
      public var tableType:String;
      
      private var _prizes:String;
      
      public var status:Boolean;
      
      private var _status:String;
      
      public var type:String;
      
      public var unlockLevel:Number;
      
      public var creatorId:String;
      
      public var playerSpeed:String;
      
      public var roomTypeId:Number;
      
      public function refresh(param1:Array) : void {
         var _loc3_:Object = null;
         this.playersList = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new Object();
            _loc3_.chips = param1[_loc2_ + 1];
            _loc3_.name = param1[_loc2_];
            this.playersList.push(_loc3_);
            _loc2_ = _loc2_ + 2;
         }
      }
      
      public function get roomName() : String {
         if(PokerGlobalData.instance.enableRoomTypeOnly)
         {
            return this.gameType == "Challenge"?this._roomName.substring(0,this._roomName.indexOf("-")-1):this._roomName.substring(0,this._roomName.lastIndexOf(" ")-1);
         }
         return this._roomName;
      }
   }
}
