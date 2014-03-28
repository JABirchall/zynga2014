package com.zynga.poker.lobby
{
   import com.zynga.locale.LocaleManager;
   
   public dynamic class DataGridRoomItem extends Object
   {
      
      public function DataGridRoomItem(param1:RoomItem, param2:Boolean, param3:Boolean=false, param4:Boolean=false, param5:Boolean=false, param6:int=0) {
         var _loc7_:* = NaN;
         super();
         this["chipLocked"] = param3;
         this["levelLocked"] = param5;
         this["starred"] = param4;
         this["id"] = param1.id;
         this["name"] = param1.roomName;
         var _loc8_:int = int(param1.maxPlayers);
         this["sitPlayers"] = int(param1.players);
         this["maxPlayers"] = _loc8_;
         this["type"] = param1.type;
         this["unlockLevel"] = param1.unlockLevel;
         this["creatorId"] = param1.creatorId;
         this["playerSpeed"] = param1.playerSpeed;
         if(param2)
         {
            this["smallBlind"] = Number(param1.smallBlind);
            this["bigBlind"] = Number(param1.bigBlind);
            this["maxBuyIn"] = param1.maxBuyin;
            this["minBuyIn"] = param1.minBuyin;
            if(param6 > 0)
            {
               this["vipPoints"] = param6;
            }
         }
         else
         {
            this["entryFee"] = param1.entryFee;
            this["hostFee"] = param1.hostFee;
            this["status"] = param1.status == 1 || param1.status == true?LocaleManager.localize("flash.lobby.gameSelector.hideRunningTablesLabel"):LocaleManager.localize("flash.lobby.gameSelector.grid.register");
         }
      }
   }
}
