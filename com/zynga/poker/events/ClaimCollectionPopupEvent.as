package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class ClaimCollectionPopupEvent extends PopupEvent
   {
      
      public function ClaimCollectionPopupEvent(param1:String, param2:Number, param3:String, param4:Object, param5:Object, param6:Number=1) {
         super(param1);
         this.collectionId = param2;
         this.collectionName = param3;
         this.reward = param4;
         this.jsData = param5;
         this.xpMultiplier = param6;
      }
      
      public static const SHOW_CLAIM_COLLECTION:String = "showClaimCollection";
      
      public var collectionId:Number;
      
      public var collectionName:String;
      
      public var reward:Object;
      
      public var jsData:Object;
      
      public var xpMultiplier:Number;
      
      override public function clone() : Event {
         return new ClaimCollectionPopupEvent(this.type,this.collectionId,this.collectionName,this.reward,this.jsData,this.xpMultiplier);
      }
      
      override public function toString() : String {
         return formatToString("ClaimCollectionPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
