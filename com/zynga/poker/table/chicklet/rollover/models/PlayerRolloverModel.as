package com.zynga.poker.table.chicklet.rollover.models
{
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.PokerUser;
   
   public class PlayerRolloverModel extends FeatureModel
   {
      
      public function PlayerRolloverModel() {
         super();
      }
      
      private var _pokerUser:PokerUser;
      
      private var _xpLevels:Array;
      
      override public function init() : void {
         super.init();
         this._xpLevels = pgData.xpLevels;
      }
      
      public function get pokerUser() : PokerUser {
         return this._pokerUser;
      }
      
      public function set pokerUser(param1:PokerUser) : void {
         this._pokerUser = param1;
         if(pgData.smartfoxVars.xpCapVariant < 3 && this._pokerUser.xpLevel > 101)
         {
            this._pokerUser.xpLevel = 101;
         }
      }
      
      public function getXpLevelName(param1:int) : String {
         var _loc4_:Object = null;
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         for each (_loc4_ in this._xpLevels)
         {
            if(param1 >= _loc4_["level"] && _loc4_["level"] > _loc3_)
            {
               _loc2_ = _loc4_["name"];
               _loc3_ = _loc4_["level"];
            }
         }
         return _loc2_;
      }
   }
}
