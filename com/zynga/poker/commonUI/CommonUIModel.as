package com.zynga.poker.commonUI
{
   import com.zynga.poker.feature.FeatureModel;
   import fl.data.DataProvider;
   import flash.utils.Dictionary;
   import com.zynga.poker.UserPresence;
   
   public class CommonUIModel extends FeatureModel
   {
      
      public function CommonUIModel() {
         super();
         this.joinIssued = new Dictionary(true);
         this.inviteIssued = new Dictionary(true);
         this.friendsOnlineDP = new DataProvider();
         this.friendsOfflineDP = new DataProvider();
         this.playingNowDP = new DataProvider();
         this.friendsInviteDP = new DataProvider();
         this.outstandingInvites = new Array();
         this.playingNowZids = new Object();
         this.onlineFeed = new Array();
      }
      
      private const REAL_TIME_INVITE_TABLE_MAX_VIEWABLE_ITEMS:int = 5;
      
      private var playingNowDP:DataProvider;
      
      private var friendsOnlineDP:DataProvider;
      
      private var friendsOfflineDP:DataProvider;
      
      private var friendsInviteDP:DataProvider;
      
      private var outstandingInvites:Array;
      
      private var playingNowZids:Object;
      
      private var onlineFeed:Array;
      
      private var onlineZids:Array;
      
      public var nOnline:int = 0;
      
      public var nOffline:int = 0;
      
      public var inLobby:Boolean = true;
      
      public var isLeaderboardEnabled:Boolean = false;
      
      public var browserName:String;
      
      public var nFacebookFriendsOnline:int = 0;
      
      public var serverTypeList:Array;
      
      public var idList:Array;
      
      public var isTwoAtTable:Boolean = false;
      
      private var joinIssued:Dictionary;
      
      private var inviteIssued:Dictionary;
      
      public var gameUsersCount:int;
      
      public var toolbarUsersCount:int;
      
      public var friendSelectorConfig:Object;
      
      public function addInviteIssued(param1:String) : void {
         this.inviteIssued[param1] = true;
         this.checkInvited();
      }
      
      public function removeInviteIssued(param1:String) : void {
         this.inviteIssued[param1] = false;
         this.checkInvited();
      }
      
      public function getSameTableIds(param1:Number) : Array {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc2_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.friendsInviteDP.length)
         {
            _loc4_ = this.friendsInviteDP.getItemAt(_loc3_);
            if(_loc4_["room_id"] == param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.playingNowDP.length)
         {
            _loc4_ = this.playingNowDP.getItemAt(_loc3_);
            if(_loc4_["room_id"] == param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function updateFOnline(param1:Array=null) : void {
         var _loc2_:* = 0;
         if(param1 == null)
         {
            param1 = this.onlineFeed.concat();
         }
         else
         {
            this.onlineFeed = param1.concat();
         }
         if(param1.length > 0)
         {
            _loc2_ = param1.length-1;
            while(_loc2_ > -1)
            {
               if(this.playingNowZids != null)
               {
                  if(this.playingNowZids.hasOwnProperty("1:" + param1[_loc2_].uid))
                  {
                     param1.splice(_loc2_,1);
                  }
               }
               _loc2_--;
            }
         }
         this.onlineZids = param1.concat();
         this.nOnline = this.onlineZids.length;
      }
      
      public function resetJoins() : void {
         this.joinIssued = new Dictionary(true);
      }
      
      public function updateFOffline(param1:Array) : void {
         this.nOffline = param1.length;
      }
      
      public function addInvite(param1:Object) : void {
         this.outstandingInvites.push(param1);
         this.checkInvites();
      }
      
      public function checkOutstandingInvite(param1:String) : Boolean {
         var _loc2_:* = false;
         var _loc3_:* = 0;
         while(_loc3_ < this.outstandingInvites.length)
         {
            if(param1 == this.outstandingInvites[_loc3_]["uid"])
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function removeInvite(param1:Object) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.outstandingInvites.length)
         {
            if(param1["uid"] == this.outstandingInvites[_loc2_]["uid"])
            {
               this.outstandingInvites.splice(_loc2_,1);
               this.playingNowDP.addItem(param1);
               break;
            }
            _loc2_++;
         }
         this.checkInvites();
      }
      
      public function getTableBuddyCount(param1:int) : Number {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < this.friendsInviteDP.length)
         {
            _loc4_ = this.friendsInviteDP.getItemAt(_loc3_);
            if(_loc4_["room_id"] == param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.playingNowDP.length)
         {
            _loc4_ = this.playingNowDP.getItemAt(_loc3_);
            if(_loc4_["room_id"] == param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function checkInvites() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc6_:* = false;
         this.friendsInviteDP = new DataProvider();
         _loc1_ = 0;
         while(_loc1_ < this.playingNowDP.length)
         {
            _loc3_ = this.playingNowDP.getItemAt(_loc1_);
            _loc2_ = 0;
            while(_loc2_ < this.outstandingInvites.length)
            {
               _loc4_ = this.outstandingInvites[_loc2_];
               if(_loc3_["uid"] == _loc4_["uid"])
               {
                  this.playingNowDP.removeItem(_loc3_);
                  this.friendsInviteDP.addItem(_loc3_);
               }
               _loc2_++;
            }
            _loc1_++;
         }
         var _loc5_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < this.outstandingInvites.length)
         {
            _loc4_ = this.outstandingInvites[_loc2_];
            if(this.playingNowZids[_loc4_["uid"]] != 1)
            {
               _loc5_.push(this.outstandingInvites[_loc2_]);
            }
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this.outstandingInvites.length)
            {
               if(_loc5_[_loc1_]["uid"] == this.outstandingInvites[_loc2_]["uid"])
               {
                  this.outstandingInvites.splice(_loc2_,1);
               }
               _loc2_++;
            }
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.outstandingInvites.length)
         {
            _loc4_ = this.outstandingInvites[_loc2_];
            _loc6_ = false;
            _loc1_ = 0;
            while(_loc1_ < this.friendsInviteDP.length)
            {
               _loc3_ = this.friendsInviteDP.getItemAt(_loc1_);
               if(_loc3_["uid"] == _loc4_["uid"])
               {
                  _loc6_ = true;
               }
               _loc1_++;
            }
            if(!_loc6_)
            {
               this.friendsInviteDP.addItem(_loc4_);
            }
            _loc2_++;
         }
      }
      
      private function checkInvited() : void {
         var _loc1_:* = 0;
         var _loc2_:Object = null;
         var _loc3_:* = false;
         _loc1_ = 0;
         while(_loc1_ < this.friendsInviteDP.length)
         {
            _loc2_ = this.friendsInviteDP.getItemAt(_loc1_);
            if(this.inviteIssued[_loc2_["uid"]] == true)
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
            if(_loc3_ == true)
            {
               _loc2_["invited"] = true;
               this.friendsInviteDP.replaceItemAt(_loc2_,_loc1_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.playingNowDP.length)
         {
            _loc2_ = this.playingNowDP.getItemAt(_loc1_);
            if(this.inviteIssued[_loc2_["uid"]] != true)
            {
               _loc3_ = false;
            }
            else
            {
               _loc3_ = true;
            }
            if(_loc3_)
            {
               _loc2_["invited"] = true;
               this.playingNowDP.replaceItemAt(_loc2_,_loc1_);
            }
            _loc1_++;
         }
      }
      
      private function checkOnline(param1:String) : Boolean {
         var _loc2_:* = 0;
         while(_loc2_ < this.onlineZids.length)
         {
            if(param1 == this.onlineZids[_loc2_].uid)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get fInvDP() : DataProvider {
         return this.friendsInviteDP;
      }
      
      public function get pNowDP() : DataProvider {
         return this.playingNowDP;
      }
      
      public function zoomUpdateFriends(param1:Array, param2:Number, param3:String) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getOnlineUser(param1:String) : Object {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.playingNowDP.length)
         {
            _loc4_ = this.playingNowDP.getItemAt(_loc3_);
            if(_loc4_["uid"] == param1)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function removeSameTables(param1:String) : void {
         var _loc2_:* = 0;
         var _loc3_:Object = null;
         _loc2_ = 0;
         while(_loc2_ < this.playingNowDP.length)
         {
            _loc3_ = this.playingNowDP.getItemAt(_loc2_);
            switch(_loc3_["tableType"])
            {
               case "Points":
                  _loc3_["playStatus"] = "join";
                  _loc3_["serverType"] = "Points";
                  break;
               case "SitNGo":
                  _loc3_["playStatus"] = "join";
                  _loc3_["serverType"] = "SitNGo";
                  _loc3_["tableStakes"] = "SitNGo";
                  break;
               case "ShootOut":
                  _loc3_["playStatus"] = "shootout";
                  _loc3_["serverType"] = "ShootOut";
                  _loc3_["tableStakes"] = "ShootOut";
                  break;
               case "Showdown":
                  _loc3_["playStatus"] = "showdown";
                  _loc3_["serverType"] = "Showdown";
                  _loc3_["tableStakes"] = "Showdown";
                  break;
            }
            
            if(_loc3_["playStatus"] == "lobbyinvite")
            {
               _loc3_["playStatus"] = "lobby";
               _loc3_["serverType"] = "";
            }
            if(_loc3_["playStatus"] == "toolbar")
            {
               _loc3_["serverType"] = "toolbar";
            }
            this.playingNowDP.replaceItemAt(_loc3_,_loc2_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.friendsInviteDP.length)
         {
            _loc3_ = this.friendsInviteDP.getItemAt(_loc2_);
            switch(_loc3_["tableType"])
            {
               case "Points":
                  _loc3_["playStatus"] = "join";
                  _loc3_["serverType"] = "Points";
                  break;
               case "LimitNormal":
                  _loc3_["playStatus"] = "join";
                  _loc3_["serverType"] = "LimitNormal";
                  break;
               case "SitNGo":
                  _loc3_["playStatus"] = "join";
                  _loc3_["serverType"] = "SitNGo";
                  _loc3_["tableStakes"] = "SitNGo";
                  break;
               case "ShootOut":
                  _loc3_["playStatus"] = "shootout";
                  _loc3_["serverType"] = "ShootOut";
                  _loc3_["tableStakes"] = "ShootOut";
                  break;
               case "Showdown":
                  _loc3_["playStatus"] = "showdown";
                  _loc3_["serverType"] = "Showdown";
                  _loc3_["tableStakes"] = "Showdown";
                  break;
            }
            
            if(_loc3_["playStatus"] == "lobbyinvite")
            {
               _loc3_["playStatus"] = "lobby";
               _loc3_["serverType"] = "";
            }
            this.friendsInviteDP.replaceItemAt(_loc3_,_loc2_);
            _loc2_++;
         }
      }
      
      public function checkSameTable(param1:int, param2:int, param3:String) : Array {
         var _loc5_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc4_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < this.friendsInviteDP.length)
         {
            _loc6_ = this.friendsInviteDP.getItemAt(_loc5_);
            if(_loc6_["room_id"] == param1)
            {
               if(this.joinIssued[_loc6_["uid"]] != true)
               {
                  _loc4_.push(_loc6_);
                  this.joinIssued[_loc6_["uid"]] = true;
               }
               this.removeInviteIssued(_loc6_["uid"]);
               _loc6_["playStatus"] = "table";
            }
            if(_loc6_["playStatus"] == "join")
            {
               this.joinIssued[_loc6_["uid"]] = false;
               if(param3.split("shootout")[0] == "" || param3.split("premium")[0] == "" || !(_loc6_["uid"].split("1:")[0] == ""))
               {
                  _loc6_["playStatus"] = "join";
               }
               else
               {
                  _loc6_["playStatus"] = "liveinvite";
               }
            }
            if(_loc6_["playStatus"] == "lobby")
            {
               if(param3.split("shootout")[0] == "" || param3.split("premium")[0] == "" || !(_loc6_["uid"].split("1:")[0] == ""))
               {
                  _loc6_["playStatus"] = "lobby";
               }
               else
               {
                  _loc6_["playStatus"] = "lobbyinvite";
               }
            }
            this.friendsInviteDP.replaceItemAt(_loc6_,_loc5_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.playingNowDP.length)
         {
            _loc6_ = this.playingNowDP.getItemAt(_loc5_);
            _loc7_ = this.getServerType(String(_loc6_["server_id"]));
            if(_loc6_["room_id"] == param1)
            {
               if(param3 == "normal" && !(_loc6_["serverType"] == "Points"))
               {
                  _loc6_["playStatus"] = "offline";
               }
               else
               {
                  _loc6_["playStatus"] = "table";
               }
               if(this.joinIssued[_loc6_["uid"]] != true)
               {
                  _loc4_.push(_loc6_);
                  this.joinIssued[_loc6_["uid"]] = true;
               }
               this.removeInviteIssued(_loc6_["uid"]);
            }
            if(_loc6_["playStatus"] == "join")
            {
               if(!(param3.split("shootout")[0] == "" || param3.split("premium")[0] == "" || !(_loc6_["uid"].split("1:")[0] == "")))
               {
                  this.joinIssued[_loc6_["uid"]] = false;
                  _loc6_["playStatus"] = "liveinvite";
               }
            }
            if(_loc6_["playStatus"] == "lobby")
            {
               if(!(param3.split("shootout")[0] == "" || param3.split("premium")[0] == "" || !(_loc6_["uid"].split("1:")[0] == "")))
               {
                  this.joinIssued[_loc6_["uid"]] = false;
                  _loc6_["playStatus"] = "lobbyinvite";
               }
            }
            if(_loc6_["playStatus"] == "toolbar")
            {
               _loc6_["serverType"] = "toolbar";
               if(param3.split("shootout")[0] == "" || param3.split("premium")[0] == "" || !(_loc6_["uid"].split("1:")[0] == ""))
               {
                  _loc6_["serverType"] = "shootout";
               }
            }
            this.playingNowDP.replaceItemAt(_loc6_,_loc5_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.friendsInviteDP.length)
         {
            _loc6_ = this.friendsInviteDP.getItemAt(_loc5_);
            if(_loc6_["room_id"] == param1)
            {
               this.removeInvite(_loc6_);
            }
            _loc5_++;
         }
         return _loc4_;
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
   }
}
