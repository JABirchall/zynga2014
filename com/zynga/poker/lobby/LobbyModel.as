package com.zynga.poker.lobby
{
   import fl.data.DataProvider;
   import com.zynga.poker.UserPreferencesContainer;
   import com.zynga.poker.shootout.ShootoutConfig;
   import com.zynga.poker.shootout.ShootoutUser;
   import com.zynga.poker.ConfigModel;
   import flash.utils.Dictionary;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.locale.LocaleManager;
   import com.zynga.io.ExternalCall;
   
   public class LobbyModel extends Object
   {
      
      public function LobbyModel() {
         this.smallBlindLevels = [];
         super();
         this.serverTypeList = new Array();
         this.casinoNameList = new Array();
         this.idList = new Array();
      }
      
      public var playerName:String;
      
      public var playerGender:String;
      
      private var _serverName:String;
      
      public var serverId:int;
      
      public var roomId:int;
      
      public var playersOnline:Number;
      
      public var playerRank:String;
      
      public var totalChips:Number;
      
      public var aFriends:Array;
      
      public var bShowGetPoints:Boolean = false;
      
      public var aGameRooms:Array;
      
      public var aRoomsById:Array;
      
      public var nSelectedTable:int;
      
      public var mouseOverRoomId:int;
      
      private var _sLobbyMode:String;
      
      public var sSelServerName:String;
      
      public var sSelServerIp:String;
      
      public var sSelServerType:String;
      
      public var sSelServerId:String;
      
      public var lobbyGridData:DataProvider;
      
      public var seatedPlayersGridData:DataProvider;
      
      public var casinoListData:DataProvider;
      
      public var oWeeklyData:Object;
      
      public var sn_id:int;
      
      public var fb_sig_user:Number;
      
      public var pic_url:String;
      
      public var casinoNameList:Array;
      
      public var sZid:String;
      
      public var nWeeklyTourneyState:Number;
      
      public var serverTypeList:Array;
      
      public var idList:Array;
      
      public var currentSortDataField:String = "";
      
      public var currentSortDescending:Boolean = true;
      
      public var filterTableType:String = "normal";
      
      public var fastFilterKey:String = "All";
      
      public var normalFilterKey:String = "All";
      
      public var userPreferencesContainer:UserPreferencesContainer;
      
      public var bPostWeeklyTourneyStatusToFeed:Boolean = false;
      
      public var oShootoutConfig:ShootoutConfig;
      
      public var oShootoutUser:ShootoutUser;
      
      public var xpLevel:Number = 0;
      
      public var newbieMaxLevel:Number = 0;
      
      public var sortByStakesLevel:int = 0;
      
      public var selectedRoomItem:Object;
      
      public var disableShareWithFriendsCheckboxes:Boolean = false;
      
      public var sponsorShootoutsTotal:int;
      
      public var sponsorShootoutsAccepted:int;
      
      public var sponsorShootoutsState:Boolean;
      
      public var enableSponsorShootoutsButton:Boolean;
      
      public var tabsGlowingTags:Object;
      
      public var playerSpeedTestVariant:int = 0;
      
      public var configModel:ConfigModel;
      
      public var lobbyConfig:Object;
      
      public var shootoutConfig:Object;
      
      public var sponsoredShootoutsConfig:Object;
      
      public var tableConfig:Object;
      
      public var smallBlindLevels:Array;
      
      private var _realTimeTableData:ServerStatusDictionary;
      
      public function init() : void {
         this.lobbyConfig = this.configModel.getFeatureConfig("lobby");
         this.shootoutConfig = this.configModel.getFeatureConfig("shootout");
         this.sponsoredShootoutsConfig = this.configModel.getFeatureConfig("sponsoredShootouts");
         this.tableConfig = this.configModel.getFeatureConfig("table");
      }
      
      public function setSponsoredShootoutVars() : void {
         this.sponsorShootoutsTotal = (this.sponsoredShootoutsConfig) && (this.sponsoredShootoutsConfig.sponsorShootoutsTotal)?this.sponsoredShootoutsConfig.sponsorShootoutsTotal:0;
         this.sponsorShootoutsAccepted = (this.sponsoredShootoutsConfig) && (this.sponsoredShootoutsConfig.sponsorShootoutsAccepted)?this.sponsoredShootoutsConfig.sponsorShootoutsAccepted:0;
         this.sponsorShootoutsState = (this.sponsoredShootoutsConfig) && (this.sponsoredShootoutsConfig.sponsorShootoutsState);
         this.enableSponsorShootoutsButton = (this.sponsoredShootoutsConfig) && (this.sponsoredShootoutsConfig.enableSponsorShootoutsButton);
      }
      
      public function setServerTypeList(param1:Array, param2:Array) : void {
         this.serverTypeList = param1;
         this.idList = param2;
      }
      
      public function getServerType(param1:String) : String {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.serverTypeList[_loc2_];
            }
            _loc2_++;
         }
         return "";
      }
      
      public function set realTimeTableData(param1:ServerStatusDictionary) : void {
         this._realTimeTableData = param1;
      }
      
      public function get realTimeTableData() : ServerStatusDictionary {
         return this._realTimeTableData;
      }
      
      public function getDataGridRoomItemWithRoomId(param1:String) : DataGridRoomItem {
         var _loc2_:* = 0;
         var _loc3_:DataGridRoomItem = null;
         if((this.lobbyGridData) && (this.lobbyGridData.length))
         {
            _loc2_ = 0;
            while(_loc2_ < this.lobbyGridData.length)
            {
               _loc3_ = this.lobbyGridData.getItemAt(_loc2_) as DataGridRoomItem;
               if(_loc3_["id"] == param1)
               {
                  return _loc3_;
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function updateRoomList(param1:Array) : void {
         var _loc5_:RoomItem = null;
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc11_:* = 0;
         var _loc12_:DataGridRoomItem = null;
         var _loc2_:Object = null;
         var _loc3_:Dictionary = new Dictionary();
         if(this.lobbyGridData != null)
         {
            _loc6_ = 0;
            while(_loc6_ < this.lobbyGridData.length)
            {
               _loc2_ = this.lobbyGridData.getItemAt(_loc6_);
               _loc3_[_loc2_["id"]] = _loc2_["sitPlayers"];
               _loc6_++;
            }
         }
         this.aGameRooms = param1;
         this.aRoomsById = new Array();
         var _loc4_:Array = new Array();
         this.lobbyGridData = new DataProvider();
         for each (this.aRoomsById[int(_loc5_.id)] in param1)
         {
            _loc7_ = uint(_loc4_[_loc5_.roomTypeId]);
            if(!((PokerGlobalData.instance.enableRoomTypeOnly) && _loc7_ > 0))
            {
               _loc4_[_loc5_.roomTypeId] = _loc7_ + 1;
               if(_loc5_.gameType.toLowerCase() == this.sLobbyMode && _loc5_.tableType == "Public")
               {
                  _loc8_ = false;
                  _loc9_ = false;
                  _loc10_ = false;
                  _loc8_ = this.checkRoomChipsLocked(_loc5_);
                  if(this.sLobbyMode == "challenge")
                  {
                     _loc9_ = this.xpLevel < _loc5_.unlockLevel?true:false;
                     _loc10_ = _loc5_.unlockLevel > 0?true:false;
                     _loc11_ = 0;
                     if(_loc5_.bigBlind >= 40000)
                     {
                        _loc11_ = 10;
                     }
                     if(_loc5_.bigBlind >= 1000000)
                     {
                        _loc11_ = 20;
                     }
                     this.lobbyGridData.addItem(new DataGridRoomItem(_loc5_,true,_loc8_,_loc9_,_loc10_,_loc11_));
                  }
                  if(this.sLobbyMode == "tournament")
                  {
                     _loc9_ = this.xpLevel < _loc5_.unlockLevel?true:false;
                     _loc10_ = _loc5_.unlockLevel > 0?true:false;
                     this.lobbyGridData.addItem(new DataGridRoomItem(_loc5_,false,_loc8_,_loc9_,_loc10_));
                  }
               }
               else
               {
                  if(this.sLobbyMode == "private" && _loc5_.tableType == "Private")
                  {
                     this.lobbyGridData.addItem(new DataGridRoomItem(_loc5_,true,false));
                  }
               }
               if((this._realTimeTableData) && this.lobbyGridData.length > 0)
               {
                  _loc12_ = this.lobbyGridData.getItemAt(this.lobbyGridData.length-1) as DataGridRoomItem;
                  if(this._realTimeTableData[String(_loc12_["id"])] != null)
                  {
                     _loc12_["sitPlayers"] = this._realTimeTableData.getNumberOfPlayersForRoomId(String(_loc12_["id"]));
                  }
                  else
                  {
                     if(_loc3_[_loc12_["id"]] != null)
                     {
                        _loc12_["sitPlayers"] = _loc3_[_loc12_["id"]];
                     }
                  }
                  if(this.sLobbyMode == "tournament" && !(_loc12_["maxPlayers"] == null) && !(_loc12_["sitPlayers"] == null) && _loc12_["maxPlayers"] == _loc12_["sitPlayers"])
                  {
                     _loc12_["status"] = LocaleManager.localize("flash.lobby.gameSelector.hideRunningTablesLabel");
                  }
               }
            }
         }
         _loc3_ = null;
         if(this.currentSortDataField != "")
         {
            this.sortTables(this.currentSortDataField,this.currentSortDescending);
         }
         else
         {
            if(this.sortByStakesLevel > 0 && this.xpLevel <= this.sortByStakesLevel)
            {
               this.sortTables("stakes",false);
            }
            else
            {
               this.sortTables("players",true);
            }
         }
      }
      
      public function sortTables(param1:String, param2:Boolean=false) : void {
         var _loc3_:* = false;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.currentSortDataField = param1;
         this.currentSortDescending = param2;
         if(!(this.lobbyGridData == null) && this.lobbyGridData.length > 0)
         {
            _loc3_ = this.lobbyGridData.getItemAt(0).hasOwnProperty("Fee")?true:false;
            _loc4_ = param2?Array.DESCENDING:0;
            _loc6_ = Array.DESCENDING | Array.NUMERIC;
            if((this.userPreferencesContainer) && (this.userPreferencesContainer.getHasAppliedPreferences()))
            {
               if(this.userPreferencesContainer.everFiltered == "0")
               {
                  this.userPreferencesContainer.everFiltered = "1";
               }
               this.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.SORT_FILTER,param1);
               this.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.SORT_BY,_loc4_);
            }
            switch(param1)
            {
               case "id":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["id"],[_loc5_]);
                  break;
               case "name":
                  _loc5_ = _loc4_;
                  this.lobbyGridData.sortOn(["name"],[_loc5_]);
                  break;
               case "players":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  if(_loc3_)
                  {
                     this.lobbyGridData.sortOn(["sitPlayers","maxPlayers","entryFee","hostFee","maxBuyIn","minBuyIn","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  }
                  else
                  {
                     this.lobbyGridData.sortOn(["sitPlayers","maxPlayers","bigBlind","smallBlind","maxBuyIn","minBuyIn","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  }
                  break;
               case "fee":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["entryFee","hostFee","sitPlayers","maxPlayers","id"],[_loc5_,_loc5_,_loc6_,_loc6_,Array.NUMERIC]);
                  break;
               case "stakes":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["bigBlind","smallBlind","sitPlayers","maxPlayers","maxBuyIn","minBuyIn","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  break;
               case "minMaxBuyIn":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["maxBuyIn","minBuyIn","bigBlind","smallBlind","sitPlayers","maxPlayers","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  break;
               case "maxBuyIn":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  if(_loc3_)
                  {
                     this.lobbyGridData.sortOn(["maxBuyIn","minBuyIn","sitPlayers","maxPlayers","entryFee","hostFee","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  }
                  else
                  {
                     this.lobbyGridData.sortOn(["maxBuyIn","minBuyIn","sitPlayers","maxPlayers","bigBlind","smallBlind","id"],[_loc5_,_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  }
                  break;
               case "status":
                  _loc5_ = _loc4_;
                  this.lobbyGridData.sortOn(["status","sitPlayers","maxPlayers","entryFee","hostFee","maxBuyIn","minBuyIn","id"],[_loc5_,_loc6_,_loc6_,_loc6_,_loc6_,_loc6_,_loc6_,Array.NUMERIC]);
                  break;
               case "newbie":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["sitPlayers","maxPlayers","bigBlind","smallBlind","maxBuyIn","minBuyIn","id"],[_loc5_,_loc5_,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
                  break;
               case "playerSpeed":
                  _loc5_ = _loc4_ | Array.NUMERIC;
                  this.lobbyGridData.sortOn(["playerSpeed"],[_loc5_]);
                  break;
            }
            
         }
      }
      
      public function updateCasinoList(param1:Array) : void {
         param1.sortOn(["label"]);
         this.casinoListData = new DataProvider();
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            this.casinoListData.addItem(
               {
                  "label":param1[_loc2_].label,
                  "data":param1[_loc2_].data,
                  "id":param1[_loc2_].id
               });
            this.casinoNameList.push(param1[_loc2_].label);
            _loc2_++;
         }
      }
      
      public function get sLobbyMode() : String {
         return this._sLobbyMode;
      }
      
      public function set sLobbyMode(param1:String) : void {
         if(this._sLobbyMode == param1)
         {
            return;
         }
         this._sLobbyMode = param1;
         ExternalCall.getInstance().call("ZY.App.Flash.setTableType",this._sLobbyMode);
      }
      
      public function calculateRoomChipsShortage(param1:RoomItem) : Number {
         var _loc2_:Number = 0;
         switch(this.sLobbyMode)
         {
            case PokerGlobalData.LOBBY_MODE_CHALLENGE:
               _loc2_ = param1.minBuyin - this.totalChips;
               break;
            case PokerGlobalData.LOBBY_MODE_TOURNAMENT:
               _loc2_ = param1.entryFee + param1.hostFee - this.totalChips;
               break;
         }
         
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function checkRoomChipsLocked(param1:RoomItem) : Boolean {
         var _loc3_:* = NaN;
         var _loc2_:* = false;
         if(PokerGlobalData.LOBBY_MODE_CHALLENGE == this.sLobbyMode)
         {
            if((this.configModel.isFeatureEnabled("oOCTableFlow")) && this.calculateRoomChipsShortage(param1) > 0)
            {
               _loc3_ = this.configModel.getNumberForFeatureConfig("oOCTableFlow","maxChipsPackage");
               if(isNaN(_loc3_))
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc2_ = _loc3_ < (param1.minBuyin + param1.maxBuyin) / 2;
               }
            }
            else
            {
               _loc2_ = this.calculateRoomChipsShortage(param1) > 0;
            }
         }
         else
         {
            if(PokerGlobalData.LOBBY_MODE_TOURNAMENT == this.sLobbyMode)
            {
               _loc2_ = this.calculateRoomChipsShortage(param1) > 0?true:false;
            }
         }
         return _loc2_;
      }
      
      public function get serverName() : String {
         return this._serverName;
      }
      
      public function set serverName(param1:String) : void {
         this._serverName = param1;
      }
   }
}
