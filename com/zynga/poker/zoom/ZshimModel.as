package com.zynga.poker.zoom
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.UserPresence;
   
   public class ZshimModel extends EventDispatcher
   {
      
      public function ZshimModel() {
         this.friendsList = new Array();
         this.networkList = new Array();
         super();
      }
      
      public static const ZOOM_MODEL_FRIENDS_UPDATED:String = "zoom_model_friends_updated";
      
      public static const ZOOM_MODEL_NETWORK_UPDATED:String = "zoom_model_network_updated";
      
      public static const ZOOM_MODEL_FRIEND_ADDED:String = "zoom_model_friend_added";
      
      public static const ZOOM_MODEL_FRIEND_REMOVED:String = "zoom_model_friend_removed";
      
      public var friendsList:Array;
      
      public var networkList:Array;
      
      public function addPlayer(param1:UserPresence, param2:String="friends") : void {
         if(param2 == "friends")
         {
            if(!this.isPlayerExist(param1,this.friendsList))
            {
               this.friendsList.push(param1);
               this.fnSortBy("friends");
               dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.friendsList));
               dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIEND_ADDED,[param1]));
            }
            else
            {
               this.updatePlayer(param1,param2);
            }
         }
         else
         {
            if(param2 == "network")
            {
               if(!this.isPlayerExist(param1,this.networkList))
               {
                  this.networkList.push(param1);
                  this.fnSortBy("networks");
                  dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED,this.networkList));
               }
               else
               {
                  this.updatePlayer(param1,param2);
               }
            }
         }
      }
      
      public function deletePlayer(param1:UserPresence, param2:String="friends") : void {
         var _loc4_:UserPresence = null;
         var _loc5_:UserPresence = null;
         var _loc3_:Number = 0;
         if(param2 == "friends")
         {
            _loc3_ = 0;
            while(_loc3_ < this.friendsList.length)
            {
               _loc4_ = this.friendsList[_loc3_];
               if(_loc4_.sZid == param1.sZid)
               {
                  this.friendsList.splice(_loc3_,1);
                  dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.friendsList));
                  dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIEND_REMOVED,[param1]));
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            if(param2 == "network")
            {
               _loc3_ = 0;
               while(_loc3_ < this.networkList.length)
               {
                  _loc5_ = this.networkList[_loc3_];
                  if(_loc5_.sZid == param1.sZid)
                  {
                     this.networkList.splice(_loc3_,1);
                     dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED,this.networkList));
                     break;
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      public function updatePlayer(param1:UserPresence, param2:String="friends") : void {
         var _loc4_:UserPresence = null;
         var _loc5_:UserPresence = null;
         var _loc3_:Number = 0;
         if(param2 == "friends")
         {
            _loc3_ = 0;
            while(_loc3_ < this.friendsList.length)
            {
               _loc4_ = this.friendsList[_loc3_];
               if(_loc4_.sZid == param1.sZid)
               {
                  _loc4_.nServerId = param1.nServerId;
                  _loc4_.nRoomId = param1.nRoomId;
                  _loc4_.sRoomDesc = param1.sRoomDesc;
                  _loc4_.tableStakes = param1.tableStakes;
                  _loc4_.nChipStack = param1.nChipStack;
                  _loc4_.nLevel = param1.nLevel;
                  dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.friendsList));
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            if(param2 == "network")
            {
               _loc3_ = 0;
               while(_loc3_ < this.networkList.length)
               {
                  _loc5_ = this.networkList[_loc3_];
                  if(_loc5_.sZid == param1.sZid)
                  {
                     _loc5_.nServerId = param1.nServerId;
                     _loc5_.nRoomId = param1.nRoomId;
                     _loc5_.sRoomDesc = param1.sRoomDesc;
                     dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED,this.networkList));
                     break;
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      public function clearPlayer(param1:String="friends") : void {
         if(param1 == "friends")
         {
            this.friendsList.splice(0,this.friendsList.length);
            dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED,this.friendsList));
         }
         else
         {
            if(param1 == "network")
            {
               this.networkList.splice(0,this.networkList.length);
               dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED,this.networkList));
            }
         }
      }
      
      public function isPlayerExist(param1:UserPresence, param2:Array) : Boolean {
         var _loc4_:UserPresence = null;
         var _loc3_:* = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            if(_loc4_.sZid == param1.sZid)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getUserById(param1:String) : UserPresence {
         var _loc2_:UserPresence = null;
         for each (_loc2_ in this.friendsList)
         {
            if(_loc2_.sZid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function fnSortBy(param1:String) : void {
         var _loc4_:UserPresence = null;
         var _loc5_:UserPresence = null;
         var _loc6_:UserPresence = null;
         var _loc7_:UserPresence = null;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1 == "friends")
         {
            _loc2_ = 0;
            while(_loc2_ < this.friendsList.length)
            {
               _loc3_ = 0;
               while(_loc3_ < this.friendsList.length-1)
               {
                  _loc4_ = this.friendsList[_loc3_];
                  _loc5_ = this.friendsList[_loc3_ + 1];
                  if(_loc4_.sFirstName > _loc5_.sFirstName)
                  {
                     _loc6_ = _loc5_;
                     this.friendsList[_loc3_ + 1] = _loc4_;
                     this.friendsList[_loc3_] = _loc6_;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this.networkList.length)
            {
               _loc3_ = 0;
               while(_loc3_ < this.networkList.length-1)
               {
                  _loc4_ = this.networkList[_loc3_];
                  _loc5_ = this.networkList[_loc3_ + 1];
                  if(_loc4_.sFirstName > _loc5_.sFirstName)
                  {
                     _loc7_ = _loc5_;
                     this.networkList[_loc3_ + 1] = _loc4_;
                     this.networkList[_loc3_] = _loc7_;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
      }
   }
}
