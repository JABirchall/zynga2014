package com.zynga.poker.pokerscore
{
   import com.zynga.poker.feature.FeatureService;
   import com.zynga.poker.pokerscore.interfaces.IPokerScoreService;
   import __AS3__.vec.Vector;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.PokerConnectionManager;
   import com.zynga.poker.protocol.RPokerScoreUpdate;
   import com.zynga.poker.protocol.ProtocolEvent;
   
   public class PokerScoreService extends FeatureService implements IPokerScoreService
   {
      
      public function PokerScoreService() {
         this._dataObject = new PokerScoreDataObject();
         this._callbacks = new Vector.<Function>();
         super();
      }
      
      private static const NUM_HANDS_PLAYED_TO_SYNC:int = 5;
      
      private var _dataObject:PokerScoreDataObject;
      
      private var _callbacks:Vector.<Function>;
      
      private var _hasValidData:Boolean = false;
      
      private var _initialized:Boolean = false;
      
      public function init() : void {
         if(this._initialized)
         {
            return;
         }
         var _loc1_:PokerConnectionManager = registry.getObject(IPokerConnectionManager);
         _loc1_.addEventListener("onMessage",this.onProtocolMessage);
         externalInterface.addCallback("updateScoreCardData",this.updateScoreCardData);
         this._initialized = true;
      }
      
      public function requestData() : void {
         externalInterface.call("zc.feature.scoreCard.retrieveScoreCardData");
      }
      
      public function updateScoreCardData(param1:Object) : void {
         if(this._dataObject.checkAndUpdateScoreCardData(param1))
         {
            this._hasValidData = true;
            this.returnDataToCallbacks();
         }
      }
      
      public function updatePokerScoreData(param1:RPokerScoreUpdate) : void {
         if(this._dataObject.checkAndUpdatePokerScoreData(param1))
         {
            this._hasValidData = true;
            this.returnDataToCallbacks();
         }
      }
      
      public function registerDataListener(param1:Function) : Boolean {
         if(this._callbacks.indexOf(param1) === -1)
         {
            this._callbacks.push(param1);
            this.returnDataToCallback(param1);
            return true;
         }
         return false;
      }
      
      public function unregisterDataListener(param1:Function) : Boolean {
         var _loc2_:int = this._callbacks.indexOf(param1);
         if(_loc2_ !== -1)
         {
            this._callbacks.splice(_loc2_,1);
            return true;
         }
         return false;
      }
      
      private function returnDataToCallbacks() : void {
         var _loc1_:Function = null;
         if(this._hasValidData)
         {
            for each (_loc1_ in this._callbacks)
            {
               this.returnDataToCallback(_loc1_);
            }
         }
      }
      
      private function returnDataToCallback(param1:Function) : void {
         if(this._hasValidData)
         {
            param1(this._dataObject);
         }
      }
      
      private function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         var _loc3_:String = _loc2_.type;
         if(_loc3_ == "RPokerScoreUpdate")
         {
            this.onPokerScoreUpdate(_loc2_);
         }
      }
      
      private function onPokerScoreUpdate(param1:Object) : void {
         var _loc2_:RPokerScoreUpdate = RPokerScoreUpdate(param1);
         this.updatePokerScoreData(_loc2_);
      }
      
      public function updateHandsPlayedCount(param1:uint=1) : void {
         this._dataObject.handsPlayedCountUnsaved = this._dataObject.handsPlayedCountUnsaved + param1;
         if(this._dataObject.handsPlayedCountUnsaved >= NUM_HANDS_PLAYED_TO_SYNC)
         {
            externalInterface.call("zc.feature.scoreCard.updateHandsPlayedCount",this._dataObject.handsPlayedCountUnsaved);
            this._dataObject.saveHandsPlayedCount();
         }
      }
   }
}
