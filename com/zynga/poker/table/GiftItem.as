package com.zynga.poker.table
{
   import flash.utils.Timer;
   
   public class GiftItem extends Object
   {
      
      public function GiftItem() {
         this.maCachedInst_Free = new Array();
         this.sponsors_accepted = [];
         super();
      }
      
      public static const GIFT_ID_NONE:int = -1;
      
      public var mnId:int = -1;
      
      public var mbUserFilter:Boolean = false;
      
      public var miFilterMask:int = 0;
      
      public var msName:String = null;
      
      public var msActionText:String = null;
      
      public var msClientData:String = null;
      
      public var msPicLargeUrl:String = null;
      
      public var msPicMediumUrl:String = null;
      
      public var msPicSmallUrl:String = null;
      
      public var msPicAs3Url:String = null;
      
      public var msPreloadedPicUrl:String = null;
      
      public var maCachedInst_Free:Array;
      
      public var mnPrice:Number = 0;
      
      public var mnUnlockLevel:Number = 0;
      
      public var mbGreyOut:Boolean = false;
      
      public var mAnimTimer:Timer = null;
      
      public var msClassDef:String = null;
      
      public var isPremium:Boolean = false;
      
      public var mnCatId:int = -1;
      
      public var mnCatRank:int = -1;
      
      public var sponsored_gift:Boolean = false;
      
      public var sponsors_needed:int = 0;
      
      public var sponsors_accepted:Array;
   }
}
