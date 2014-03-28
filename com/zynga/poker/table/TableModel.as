package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.User;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.table.layouts.ITableLayout;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import flash.display.Sprite;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.UserProfile;
   import com.zynga.format.BlindFormatter;
   import com.zynga.poker.table.asset.Pot;
   import com.zynga.poker.table.asset.CardData;
   import com.zynga.utils.Currency;
   import com.zynga.poker.constants.ExternalAsset;
   import com.zynga.utils.ExternalAssetManager;
   import com.zynga.poker.table.constants.TableDisplayMode;
   import com.zynga.poker.constants.TableType;
   
   public class TableModel extends FeatureModel
   {
      
      public function TableModel() {
         this.aBlockedUsers = new Array();
         this.userProfiles = new Object();
         this.tableAcePopupList = new Array();
         super();
      }
      
      private var _aUsers:Array;
      
      public function get aUsers() : Array {
         return this._aUsers;
      }
      
      public function get numberOfPlayers() : uint {
         return this._aUsers?this._aUsers.length:0;
      }
      
      private var _aUsersInHand:Array;
      
      public function get aUsersInHand() : Array {
         return this._aUsersInHand;
      }
      
      public function setUsersForModel(param1:Array) : void {
         this._aUsers = param1.concat();
         this._aUsersInHand = param1.concat();
      }
      
      public var sfxHappyHour:Boolean;
      
      public var tableAceWinnings:Number;
      
      public var aIndexUsers:Array;
      
      public var aBlockedUsers:Array;
      
      public var aUsersInRoom:Array;
      
      public var userProfiles:Object;
      
      public var xpLevels:Array;
      
      public var aRankNames:Array;
      
      public var viewer:User;
      
      private var _room:RoomItem;
      
      public var nMaxBuyIn:Number;
      
      public var nMinBuyIn:Number;
      
      public var nBigblind:Number;
      
      public var nSmallblind:Number;
      
      public var sBlinds:String;
      
      public var nDealerSit:int;
      
      public var nHandId:int;
      
      public var sHandStatus:String;
      
      public var nCurrentTurn:int;
      
      public var nMinBet:Number;
      
      public var nMaxBet:Number;
      
      public var nCallAmt:Number;
      
      public var aPots:Array;
      
      public var aBuddyInvites:Array;
      
      public var sServerName:String;
      
      public var tableBackground:TableBackground;
      
      public var nTourneyId:int;
      
      public var sTourneyMode:String;
      
      public var aJoinFriends:Array;
      
      public var aJoinNetworks:Array;
      
      public var bTableSoundMute:Boolean;
      
      public var sDispMode:String;
      
      public var nZoomFriends:Number;
      
      public var aAddBuddyAttemptsBySit:Array;
      
      public var nPostToPlayFlag:int = 1;
      
      public var bIsBot:Boolean = false;
      
      public var fgID:int;
      
      public var didLoadChallenges:Boolean = false;
      
      public var seatClicked:Boolean = false;
      
      public var isFirstFold:Boolean = true;
      
      public var hsmFreeUsage:Object;
      
      public var hsmIsFree:Boolean = false;
      
      public var uidObfuscator:UIDObfuscator;
      
      public var userBuyInPrefs:Object;
      
      public var nSitinChips:Number;
      
      public var nUltimateWinnerSit:int;
      
      public var hsmConfig:Object;
      
      public var tableConfig:Object;
      
      public var coreConfig:Object;
      
      public var powerTourneyConfig:Object;
      
      public var betAdConfig:Object;
      
      public var giftConfig:Object;
      
      public var socialChallengesGroup:int;
      
      public var tipTheDealerConfig:Object;
      
      public var userConfig:Object;
      
      public var zpwcConfig:Object;
      
      public var redesignConfig:Object;
      
      public var currentTableAce:Array;
      
      private var tableAcePopupList:Array;
      
      private var _isTransitionWaitingForStand:Boolean = false;
      
      public function get isTransitionWaitingForStand() : Boolean {
         return this._isTransitionWaitingForStand;
      }
      
      public function set isTransitionWaitingForStand(param1:Boolean) : void {
         this._isTransitionWaitingForStand = param1;
      }
      
      private var _handsPlayedCounter:Number;
      
      public function get handsPlayedCounter() : Number {
         return this._handsPlayedCounter;
      }
      
      public function set handsPlayedCounter(param1:Number) : void {
         this._handsPlayedCounter = param1;
      }
      
      private var _tableLayout:ITableLayout;
      
      public function get tableLayout() : ITableLayout {
         return this._tableLayout;
      }
      
      public function set tableLayout(param1:ITableLayout) : void {
         this._tableLayout = param1;
      }
      
      private var _playerPosModel:PlayerPositionModel;
      
      public function get playerPosModel() : PlayerPositionModel {
         return this._playerPosModel;
      }
      
      public function set playerPosModel(param1:PlayerPositionModel) : void {
         this._playerPosModel = param1;
      }
      
      public function addTableAcePopup(param1:Sprite, param2:int) : void {
         var _loc3_:Object = new Object();
         _loc3_.textBox = param1;
         _loc3_.seat = param2;
         this.tableAcePopupList.push(_loc3_);
      }
      
      public function get tableAcePopups() : Array {
         return this.tableAcePopupList;
      }
      
      public function initModel() : void {
         var _loc1_:PokerUser = null;
         if(!this.aUsers || !this.aUsersInHand)
         {
            return;
         }
         this.xpLevels = pgData.xpLevels;
         this.aRankNames = pgData.aRankNames;
         this.aBuddyInvites = pgData.aBuddyInvites;
         this.aPots = new Array();
         this.viewer = pgData.viewer;
         this.sServerName = pgData.serverName;
         this.currentTableAce = new Array();
         this.sDispMode = pgData.dispMode;
         this.bIsBot = pgData.flashCookie?pgData.flashCookie.GetValue("bIsBot",false):false;
         this.tableConfig = configModel.getFeatureConfig("table");
         this.coreConfig = configModel.getFeatureConfig("core");
         this.updateTableBackground();
         if(!this.uidObfuscator)
         {
            this.uidObfuscator = new UIDObfuscator();
         }
         for each (_loc1_ in this.aUsers)
         {
            if(_loc1_ is PokerUser)
            {
               this.addUserProfile(new UserProfile(_loc1_.zid,_loc1_.sUserName,_loc1_.sNetwork,_loc1_.sPicURL,_loc1_.sPicLrgURL,_loc1_.sProfileURL,_loc1_.nTotalPoints,_loc1_.nAchievementRank,_loc1_.xpLevel,_loc1_.xp,_loc1_.gender));
            }
         }
         this.aJoinFriends = new Array();
         this.aJoinNetworks = new Array();
         this.aBlockedUsers = new Array();
         this.aAddBuddyAttemptsBySit = new Array();
         this.parseRoomItem();
         this.hsmConfig = configModel.getFeatureConfig("hsm");
         this.powerTourneyConfig = configModel.getFeatureConfig("powerTourney");
         this.betAdConfig = configModel.getFeatureConfig("betAds");
         this.giftConfig = configModel.getFeatureConfig("gift");
         this.socialChallengesGroup = configModel.getIntForFeatureConfig("socialChallenges","socialChallenges");
         this.tipTheDealerConfig = configModel.getFeatureConfig("tipTheDealer");
         this.userConfig = configModel.getFeatureConfig("user");
         this.zpwcConfig = configModel.getFeatureConfig("zpwc");
         this.redesignConfig = configModel.getFeatureConfig("redesign");
         if(!this.redesignConfig)
         {
            this.redesignConfig = {};
         }
         this.hsmFreeUsage = (this.hsmConfig) && (this.hsmConfig.fg_shsm)?this.hsmConfig.fg_shsm:new Object();
         this.hsmIsFree = this.hsmFreeUsage.on == 1?true:false;
         if(this.tableConfig)
         {
            this.nTourneyId = this.tableConfig.tourneyId;
         }
      }
      
      private function parseRoomItem() : void {
         this.nBigblind = this._room.bigBlind;
         this.nSmallblind = this._room.smallBlind;
         this.nMaxBuyIn = this._room.maxBuyin;
         this.nMinBuyIn = this._room.minBuyin;
         this.sBlinds = BlindFormatter.formatBlinds(this.nSmallblind,this.nBigblind);
      }
      
      public function updateBlinds(param1:Number, param2:Number) : void {
         this.nBigblind = param2;
         this.nSmallblind = param1;
         this._room.bigBlind = param2;
         this._room.smallBlind = param1;
         this.sBlinds = BlindFormatter.formatBlinds(this.nSmallblind,this.nBigblind);
      }
      
      public function resetModel() : void {
         this._aUsersInHand = this.aUsers.concat();
         this.aPots = new Array();
         this.nMinBet = 0;
         this.nMaxBet = 0;
         this.nCallAmt = 0;
      }
      
      private function setUsersInHand(param1:int) : void {
         var _loc2_:PokerUser = null;
         var _loc3_:* = 0;
         this.aIndexUsers = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.aUsersInHand.length)
         {
            _loc2_ = this.aUsersInHand[_loc3_];
            this.aIndexUsers[_loc2_.nSit] = _loc2_;
            _loc3_++;
         }
      }
      
      private function updatePlayers(param1:Array, param2:Number) : void {
         var _loc4_:PokerUser = null;
         var _loc3_:Number = 0;
         while(_loc3_ < this.aUsersInHand.length)
         {
            _loc4_ = this.aUsersInHand[_loc3_];
            if(param1.indexOf(_loc4_.nSit) < 0)
            {
               _loc4_.bIsTableAce = true;
               _loc4_.nTableAceWinningsAmount = param2;
            }
            else
            {
               _loc4_.bIsTableAce = false;
            }
            _loc3_++;
         }
      }
      
      public function updateTableAceData(param1:Array, param2:Number, param3:Number) : void {
         this.tableAceWinnings = param2;
         this.updatePlayers(this.currentTableAce,param2);
         this.currentTableAce = param1;
         this.getViewer().nTableAceWinningsAmount = param3;
      }
      
      public function getViewer() : PokerUser {
         var _loc1_:PokerUser = null;
         for each (_loc1_ in this.aUsers)
         {
            if(_loc1_.zid == this.viewer.zid)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function addUser(param1:PokerUser) : void {
         this.aUsers.push(param1);
         if(param1 != null)
         {
            this.addUserProfile(new UserProfile(param1.zid,param1.sUserName,param1.sNetwork,param1.sPicURL,param1.sPicLrgURL,param1.sProfileURL,param1.nTotalPoints,param1.nAchievementRank,param1.xpLevel,param1.xp,param1.gender));
         }
      }
      
      public function removeUser(param1:int) : void {
         var _loc2_:PokerUser = null;
         var _loc3_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < this.aUsers.length)
         {
            _loc2_ = PokerUser(this.aUsers[_loc3_]);
            if(_loc2_.nSit == param1)
            {
               this.aUsers.splice(_loc3_,1);
            }
            _loc3_++;
         }
      }
      
      public function getZidBySit(param1:int) : String {
         var _loc2_:String = null;
         var _loc4_:PokerUser = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aUsers.length)
         {
            _loc4_ = PokerUser(this.aUsers[_loc3_]);
            if(_loc4_.nSit == param1)
            {
               _loc2_ = _loc4_.zid;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getUserBySit(param1:int, param2:Boolean=false) : PokerUser {
         var _loc3_:PokerUser = null;
         var _loc4_:* = 0;
         if(param2)
         {
            _loc4_ = 0;
            while(_loc4_ < this.aUsersInHand.length)
            {
               _loc3_ = PokerUser(this.aUsersInHand[_loc4_]);
               if(_loc3_.nSit == param1)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.aUsers.length)
            {
               _loc3_ = PokerUser(this.aUsers[_loc4_]);
               if(_loc3_.nSit == param1)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      public function getSeatNum(param1:String) : Number {
         var _loc4_:String = null;
         var _loc2_:Number = -1;
         var _loc3_:PokerUser = this.getUserByZid(param1);
         for (_loc4_ in this.aUsers)
         {
            if(param1 == this.aUsers[_loc4_].zid)
            {
               _loc2_ = this.aUsers[_loc4_].nSit;
            }
         }
         return _loc2_;
      }
      
      public function getUserByZid(param1:String, param2:Boolean=false) : PokerUser {
         var _loc3_:PokerUser = null;
         var _loc4_:* = 0;
         if(param2)
         {
            _loc4_ = 0;
            while(_loc4_ < this.aUsersInHand.length)
            {
               _loc3_ = PokerUser(this.aUsersInHand[_loc4_]);
               if(_loc3_.zid == param1)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.aUsers.length)
            {
               _loc3_ = PokerUser(this.aUsers[_loc4_]);
               if(_loc3_.zid == param1)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      public function getNumUsersInHand() : int {
         return this.aUsersInHand.length;
      }
      
      public function isUserInHand(param1:String) : Boolean {
         var _loc3_:PokerUser = null;
         var _loc2_:* = 0;
         while(_loc2_ < this.aUsersInHand.length)
         {
            _loc3_ = PokerUser(this.aUsersInHand[_loc2_]);
            if((_loc3_) && _loc3_.zid == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isUserSeated(param1:String) : Boolean {
         var _loc2_:PokerUser = null;
         for each (_loc2_ in this.aUsers)
         {
            if(_loc2_.zid == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkUserInRoom(param1:String) : Boolean {
         var _loc2_:* = 0;
         while(_loc2_ < this.aUsersInRoom.length)
         {
            if(this.aUsersInRoom[_loc2_].zid == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addBuddyRequestZidToRequestCheck(param1:String) : void {
         this.aAddBuddyAttemptsBySit[this.getUserByZid(param1).nSit] = 1;
      }
      
      public function removeBuddyRequestZidFromRequestCheck(param1:String) : void {
         this.aAddBuddyAttemptsBySit[this.getUserByZid(param1).nSit] = 0;
      }
      
      public function getUserDidClickAddBuddy(param1:String) : Boolean {
         if(this.aAddBuddyAttemptsBySit[this.getUserByZid(param1).nSit])
         {
            return true;
         }
         return false;
      }
      
      public function set postToPlayFlag(param1:int) : void {
         this.nPostToPlayFlag = param1;
      }
      
      public function get postToPlayFlag() : int {
         return this.nPostToPlayFlag;
      }
      
      private var _userSeat:int;
      
      public function get userSeat() : int {
         return this._userSeat;
      }
      
      public function set userSeat(param1:int) : void {
         this._userSeat = param1;
      }
      
      public function addUserProfile(param1:UserProfile) : void {
         if(this.userProfiles == null)
         {
            this.userProfiles = new Object();
         }
         if(!(param1 == null) && (param1.zid))
         {
            this.userProfiles[param1.zid] = param1;
         }
      }
      
      public function removeUserProfile(param1:String) : void {
         if(this.userProfiles != null)
         {
            if(this.userProfiles.hasOwnProperty(param1))
            {
               delete this.userProfiles[[param1]];
            }
         }
      }
      
      public function getUserProfileByZid(param1:String) : UserProfile {
         var _loc2_:UserProfile = null;
         if(this.userProfiles != null)
         {
            if(this.userProfiles.hasOwnProperty(param1))
            {
               _loc2_ = this.userProfiles[param1] as UserProfile;
            }
         }
         return _loc2_;
      }
      
      public function getPotById(param1:int) : Pot {
         var _loc2_:Pot = null;
         var _loc3_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < this.aPots.length)
         {
            _loc2_ = Pot(this.aPots[_loc3_]);
            if(_loc2_.nPotId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function updateBlind(param1:int, param2:Number, param3:Number) : void {
         var _loc5_:* = NaN;
         var _loc4_:PokerUser = this.getUserBySit(param1);
         if(_loc4_ != null)
         {
            _loc4_.nBlind = param2;
            _loc4_.nCurBet = param2;
            _loc5_ = _loc4_.nChips;
            _loc4_.nOldChips = _loc5_;
            _loc4_.nChips = param3;
         }
      }
      
      public function updateHandStartChips(param1:int) : void {
         var _loc2_:PokerUser = this.getUserBySit(param1);
         if(_loc2_ != null)
         {
            _loc2_.nStartHandChips = _loc2_.nChips + _loc2_.nBlind;
         }
      }
      
      public function setupNewHand(param1:int=-1) : void {
         if(param1 != -1)
         {
            this.setUsersInHand(param1);
         }
      }
      
      public function setPot(param1:int, param2:Number) : void {
         var _loc3_:Pot = this.getPotById(param1);
         if(_loc3_ != null)
         {
            _loc3_.nAmt = param2;
         }
         else
         {
            _loc3_ = new Pot(param1,param2);
            this.aPots.push(_loc3_);
         }
      }
      
      public function setPlayerStatus(param1:int, param2:String) : void {
         var _loc3_:PokerUser = this.getUserBySit(param1);
         if(_loc3_)
         {
            _loc3_.sStatusText = param2;
         }
      }
      
      public function updateWinner(param1:int, param2:Number, param3:String, param4:Number, param5:String, param6:Number, param7:Array, param8:String) : void {
         var _loc9_:PokerUser = this.getUserBySit(param1);
         var _loc10_:Number = _loc9_.nChips;
         _loc9_.nOldChips = _loc10_;
         _loc9_.nChips = param2;
         _loc9_.holecard1 = new CardData(param3,param4);
         _loc9_.holecard2 = new CardData(param5,param6);
         _loc9_.aHandString = param7;
         _loc9_.sStatusText = "winner";
         _loc9_.sWinningHand = param8;
      }
      
      public function updateDefaultWinner(param1:int, param2:Number, param3:Array) : void {
         var _loc4_:PokerUser = this.getUserBySit(param1);
         if(_loc4_ != null)
         {
            _loc4_.nChips = param2;
            _loc4_.sStatusText = "winner";
            _loc4_.aPotsWon = param3;
         }
      }
      
      public function updatePlayerAction(param1:int, param2:Number, param3:Number, param4:String) : void {
         var _loc5_:PokerUser = this.getUserBySit(param1);
         var _loc6_:Number = _loc5_.nChips;
         _loc5_.nOldChips = _loc6_;
         _loc5_.nChips = param2;
         _loc5_.nCurBet = param3;
         _loc5_.sStatusText = param4;
      }
      
      public function muteToggle(param1:String, param2:String) : void {
         if(param2 == "add")
         {
            this.addMuteZid(param1);
         }
         else
         {
            if(param2 == "remove")
            {
               this.removeMuteZid(param1);
            }
         }
      }
      
      public function addMuteZid(param1:String) : void {
         var _loc2_:String = null;
         for (_loc2_ in this.aBlockedUsers)
         {
            if(param1 == this.aBlockedUsers[_loc2_])
            {
               return;
            }
         }
         this.aBlockedUsers.push(param1);
      }
      
      public function removeMuteZid(param1:String) : void {
         var _loc2_:String = null;
         for (_loc2_ in this.aBlockedUsers)
         {
            if(param1 == this.aBlockedUsers[_loc2_])
            {
               this.aBlockedUsers.splice(_loc2_,1);
            }
         }
      }
      
      public function isUserMuted(param1:String) : Boolean {
         var _loc2_:String = null;
         for (_loc2_ in this.aBlockedUsers)
         {
            if(param1 == this.aBlockedUsers[_loc2_])
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateUsersInRoom(param1:Array) : void {
         this.aUsersInRoom = param1;
      }
      
      public function updateUserTotal(param1:int, param2:Number, param3:Number) : void {
         var _loc4_:PokerUser = this.getUserBySit(param1);
         var _loc5_:Number = _loc4_.nChips;
         _loc4_.nOldChips = _loc5_;
         _loc4_.nChips = param2;
         _loc4_.nTotalPoints = param3;
      }
      
      public function getXPLevelName(param1:Number) : String {
         var _loc4_:Object = null;
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         if(pgData.smartfoxVars.xpCapVariant < 3 && param1 > 101)
         {
            param1 = 101;
         }
         for each (_loc4_ in this.xpLevels)
         {
            if(param1 >= _loc4_["level"] && _loc4_["level"] > _loc3_)
            {
               _loc2_ = _loc4_["name"];
               _loc3_ = _loc4_["level"];
            }
         }
         return _loc2_;
      }
      
      public function getRankName(param1:Number) : String {
         return this.aRankNames[param1];
      }
      
      public function getTotalPlayers() : Number {
         return this.aUsers.length;
      }
      
      public function getPlayerChips(param1:String) : Number {
         var _loc2_:PokerUser = this.getUserByZid(param1);
         return _loc2_.nChips;
      }
      
      public function getPlayerTotalChips(param1:String) : Number {
         var _loc2_:PokerUser = this.getUserByZid(param1);
         return _loc2_.nTotalPoints;
      }
      
      public function get isTournament() : Boolean {
         return this.sDispMode == "shootout" || this.sDispMode == "tournament" || this.sDispMode == "weekly" || this.sDispMode == "premium";
      }
      
      public function fetchUserBuyInValueRelativeToStakes(param1:Number, param2:Number, param3:Number) : Number {
         var _loc4_:Number = param1;
         var _loc5_:String = Currency.formatter(param2);
         if(this.userBuyInPrefs[_loc5_])
         {
            _loc4_ = this.userBuyInPrefs[_loc5_];
         }
         return _loc4_;
      }
      
      public function updateAndSaveUserBuyInValueRelativeToStakes(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean {
         var _loc5_:String = null;
         if(param1 != param2)
         {
            _loc5_ = Currency.formatter(param3);
            if(!this.userBuyInPrefs)
            {
               this.userBuyInPrefs = new Object();
            }
            if(this.userBuyInPrefs[_loc5_] != param2)
            {
               this.userBuyInPrefs[_loc5_] = param2;
               return true;
            }
         }
         return false;
      }
      
      public function updateTableBackground() : void {
         var _loc4_:String = null;
         var _loc1_:* = "";
         var _loc2_:Boolean = this.useNewTablesWithPlayersClub();
         var _loc3_:Boolean = configModel.isFeatureEnabled("redesign");
         if((this.tableConfig) && this.tableConfig.tourneyId > -1)
         {
            _loc1_ = _loc2_?ExternalAsset.TABLE_WEEKLY_TOURNEY_REDESIGN2:ExternalAsset.TABLE_WEEKLY_TOURNEY;
            this.tableBackground = this.getTableBackground(_loc1_);
         }
         else
         {
            if((configModel.getIntForFeatureConfig("table","showdownRoomId")) && !(ExternalAssetManager.getUrl(ExternalAsset.TABLE_SHOWDOWN) == ""))
            {
               this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_SHOWDOWN);
            }
            else
            {
               if(pgData.dispMode == TableDisplayMode.SHOOTOUT_MODE)
               {
                  switch(pgData.soUser.nRound)
                  {
                     case 1:
                        if(_loc2_)
                        {
                           _loc1_ = ExternalAsset.TABLE_SHOOTOUT_ROUND1_REDESIGN2;
                        }
                        else
                        {
                           _loc1_ = _loc3_?ExternalAsset.TABLE_SHOOTOUT_ROUND1_REDESIGN:ExternalAsset.TABLE_SHOOTOUT_ROUND1_EXT;
                        }
                        break;
                     case 2:
                        if(_loc2_)
                        {
                           _loc1_ = ExternalAsset.TABLE_SHOOTOUT_ROUND2_REDESIGN2;
                        }
                        else
                        {
                           _loc1_ = _loc3_?ExternalAsset.TABLE_SHOOTOUT_ROUND2_REDESIGN:ExternalAsset.TABLE_SHOOTOUT_ROUND2_EXT;
                        }
                        break;
                     case 3:
                        if(_loc2_)
                        {
                           _loc1_ = ExternalAsset.TABLE_SHOOTOUT_ROUND3_REDESIGN2;
                        }
                        else
                        {
                           _loc1_ = _loc3_?ExternalAsset.TABLE_SHOOTOUT_ROUND3_REDESIGN:ExternalAsset.TABLE_SHOOTOUT_ROUND3_EXT;
                        }
                        break;
                     default:
                        if(_loc2_)
                        {
                           _loc1_ = ExternalAsset.TABLE_DEFAULT_REDESIGN2;
                        }
                        else
                        {
                           _loc1_ = _loc3_?ExternalAsset.TABLE_DEFAULT_REDESIGN:ExternalAsset.TABLE_DEFAULT_EXT;
                        }
                  }
                  
                  this.tableBackground = this.getTableBackground(_loc1_);
               }
               else
               {
                  if(pgData.dispMode == TableDisplayMode.PREMIUM_MODE)
                  {
                     if(_loc2_)
                     {
                        _loc1_ = ExternalAsset.TABLE_POWER_TOURNAMENT_REDESIGN2;
                     }
                     else
                     {
                        _loc1_ = _loc3_?ExternalAsset.TABLE_POWER_TOURNAMENT_REDESIGN:ExternalAsset.TABLE_POWER_TOURNAMENT_EXT;
                     }
                     this.tableBackground = this.getTableBackground(_loc1_);
                  }
                  else
                  {
                     _loc4_ = "";
                     if(this._room.entryFee > 0)
                     {
                        if(this._room.entryFee >= 100000)
                        {
                           _loc4_ = "high";
                        }
                        else
                        {
                           if(this._room.entryFee >= 25000)
                           {
                              _loc4_ = "medium";
                           }
                           else
                           {
                              if(this._room.entryFee >= 5000)
                              {
                                 _loc4_ = "low";
                              }
                           }
                        }
                     }
                     else
                     {
                        if(this._room.minBuyin >= 2000000)
                        {
                           _loc4_ = "high";
                        }
                        else
                        {
                           if(this._room.minBuyin >= 100000)
                           {
                              _loc4_ = "medium";
                           }
                           else
                           {
                              if(this._room.minBuyin >= 2000)
                              {
                                 _loc4_ = "low";
                              }
                           }
                        }
                     }
                     if((this.coreConfig) && (this.coreConfig.seasonalTheme))
                     {
                        this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_SEASONAL);
                     }
                     else
                     {
                        if((this.coreConfig) && (this.coreConfig.tablePromoTheme))
                        {
                           if(_loc2_)
                           {
                              this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_PROMO_REDESIGN2);
                           }
                           else
                           {
                              this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_PROMO);
                           }
                        }
                        else
                        {
                           switch(this._room.type)
                           {
                              case TableType.FAST:
                                 switch(_loc4_)
                                 {
                                    case "high":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_FAST_HIGH_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_FAST_HIGH_STAKES_REDESIGN:ExternalAsset.TABLE_FAST_HIGH_STAKES_EXT;
                                       }
                                       break;
                                    case "medium":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_FAST_MEDIUM_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_FAST_MEDIUM_STAKES_REDESIGN:ExternalAsset.TABLE_FAST_MEDIUM_STAKES_EXT;
                                       }
                                       break;
                                    case "low":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_FAST_LOW_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_FAST_LOW_STAKES_REDESIGN:ExternalAsset.TABLE_FAST_LOW_STAKES_EXT;
                                       }
                                       break;
                                    default:
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_FAST_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_FAST_REDESIGN:ExternalAsset.TABLE_FAST_EXT;
                                       }
                                 }
                                 
                                 this.tableBackground = this.getTableBackground(_loc1_);
                                 break;
                              case TableType.LOCKED:
                                 this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_LOCKED_EXT);
                                 break;
                              case TableType.NORMAL:
                              default:
                                 switch(_loc4_)
                                 {
                                    case "high":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_NORMAL_HIGH_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_NORMAL_HIGH_STAKES_REDESIGN:ExternalAsset.TABLE_NORMAL_HIGH_STAKES_EXT;
                                       }
                                       break;
                                    case "medium":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_REDESIGN:ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_EXT;
                                       }
                                       break;
                                    case "low":
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_NORMAL_LOW_STAKES_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_NORMAL_LOW_STAKES_REDESIGN:ExternalAsset.TABLE_NORMAL_LOW_STAKES_EXT;
                                       }
                                       break;
                                    default:
                                       if(_loc2_)
                                       {
                                          _loc1_ = ExternalAsset.TABLE_DEFAULT_REDESIGN2;
                                       }
                                       else
                                       {
                                          _loc1_ = _loc3_?ExternalAsset.TABLE_DEFAULT_REDESIGN:ExternalAsset.TABLE_DEFAULT_EXT;
                                       }
                                 }
                                 
                                 this.tableBackground = this.getTableBackground(_loc1_);
                           }
                           
                           if(this._room.tableType == "Private")
                           {
                              this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_PRIVATE);
                           }
                        }
                     }
                  }
               }
            }
         }
         if((_loc1_) && !(_loc1_ == ""))
         {
            this.tableBackground = this.getTableBackground(_loc1_);
         }
         if(!this.tableBackground)
         {
            if((this.coreConfig) && (this.coreConfig.seasonalTheme))
            {
               this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_SEASONAL);
            }
            else
            {
               if((this.coreConfig) && (this.coreConfig.tablePromoTheme))
               {
                  if(_loc2_)
                  {
                     this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_PROMO_REDESIGN2);
                  }
                  else
                  {
                     this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_PROMO);
                  }
               }
               else
               {
                  this.tableBackground = this.getTableBackground(ExternalAsset.TABLE_DEFAULT);
               }
            }
         }
         if(pgData.mttZone)
         {
            _loc1_ = configModel.getBooleanForFeatureConfig("redesign","updateTableBackgrounds")?ExternalAsset.TABLE_MTT_FINAL_REDESIGN:ExternalAsset.TABLE_MTT_FINAL;
            this.tableBackground = this.getTableBackground(_loc1_);
         }
      }
      
      private function getTableBackground(param1:String) : TableBackground {
         var _loc2_:int = this.tableConfig.overlayPromotionalLogoOnTable != null?this.tableConfig.overlayPromotionalLogoOnTable:0;
         var _loc3_:Boolean = this.useNewTablesWithPlayersClub();
         return new TableBackground(param1,_loc2_,pgData,_loc3_);
      }
      
      public function enableBetControlAds() : Boolean {
         return (configModel.isFeatureEnabled("betAds")) && !this.isTournament && !pgData.mttZone;
      }
      
      public function isTutorialEnabled() : Boolean {
         if(!configModel.isFeatureEnabled("tutorial"))
         {
            return false;
         }
         var _loc1_:Object = configModel.getFeatureConfig("tutorial");
         return (_loc1_) && _loc1_.tutorialLevel > 0 && pgData.xpLevel <= _loc1_.tutorialLevel;
      }
      
      public function isHighLowEnabled() : Boolean {
         return configModel.isFeatureEnabled("highLow");
      }
      
      public function isHsmEnabled() : Boolean {
         return configModel.isFeatureEnabled("hsm");
      }
      
      public function isLeaderboardEnabled() : Boolean {
         return configModel.isFeatureEnabled("leaderboard");
      }
      
      public function isHHFeatureEnabled() : Boolean {
         return configModel.isFeatureEnabled("helpingHands");
      }
      
      public function getUIDWithObfuscationIndex(param1:Number) : String {
         return this.uidObfuscator.getUIDWithObfuscationIndex(param1);
      }
      
      public function get room() : RoomItem {
         return this._room;
      }
      
      public function set room(param1:RoomItem) : void {
         this._room = param1;
      }
      
      public function useNewTablesWithPlayersClub() : Boolean {
         return (configModel.getBooleanForFeatureConfig("table","newTables")) || (configModel.isFeatureEnabled("playersClub")) && pgData.dispMode == TableDisplayMode.CHALLENGE_MODE;
      }
      
      override public function dispose() : void {
         super.dispose();
         this._aUsers = null;
         this._aUsersInHand = null;
         this.aIndexUsers = null;
         this.aBlockedUsers = null;
         this.aUsersInRoom = null;
         this.userProfiles = null;
         this.xpLevels = null;
         this.aRankNames = null;
         this.viewer = null;
         this._room = null;
         this.aPots = null;
         this.aBuddyInvites = null;
         this.tableBackground = null;
         this.aJoinFriends = null;
         this.aJoinNetworks = null;
         this.aAddBuddyAttemptsBySit = null;
         this.hsmFreeUsage = null;
         this.uidObfuscator = null;
         this.userBuyInPrefs = null;
         this.hsmConfig = null;
         this.tableConfig = null;
         this.coreConfig = null;
         this.powerTourneyConfig = null;
         this.betAdConfig = null;
         this.giftConfig = null;
         this.tipTheDealerConfig = null;
         this.userConfig = null;
         this.zpwcConfig = null;
         this.redesignConfig = null;
      }
   }
}
