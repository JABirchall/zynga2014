package com.zynga.poker.commands.smartfox
{
   import com.zynga.poker.commands.SmartfoxCommand;
   import com.zynga.poker.table.GiftLibrary;
   import com.zynga.poker.SSLMigration;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.UpdateCollectionsInfoCommand;
   import com.zynga.poker.protocol.SGetCollectionsInfo;
   
   public class GetCollectionsCommand extends SmartfoxCommand
   {
      
      public function GetCollectionsCommand(param1:String, param2:Boolean, param3:Function=null) {
         super(new SGetCollectionsInfo("SGetCollectionsInfo",param1,param2));
         this.addCallback("RCollectionsInfo",this.onGetCollectionsComplete);
         this._callback = param3;
      }
      
      private var _callback:Function;
      
      private function onGetCollectionsComplete(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:GiftLibrary = GiftLibrary.GetInst();
         for each (_loc3_ in param1.collections)
         {
            if((_loc3_.hasOwnProperty("filledReward")) && (_loc3_["filledReward"].hasOwnProperty("premiumGift")))
            {
               _loc4_ = _loc2_.GetGift(String(_loc3_["filledReward"]["premiumGift"]));
               if(_loc4_ != null)
               {
                  _loc3_["filledReward"]["giftName"] = _loc4_.msName;
                  _loc3_["filledReward"]["giftURL"] = SSLMigration.getSecureURL(_loc4_.msPicMediumUrl);
               }
            }
         }
         if(this._callback != null)
         {
            this._callback(param1);
         }
         PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateCollectionsInfoCommand(param1));
      }
   }
}
