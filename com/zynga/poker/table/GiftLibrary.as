package com.zynga.poker.table
{
   import flash.display.MovieClip;
   import com.zynga.poker.SSLMigration;
   import com.zynga.poker.events.GiftLibraryEvent;
   import com.greensock.events.LoaderEvent;
   import flash.display.Bitmap;
   import com.zynga.load.LoadManager;
   
   public class GiftLibrary extends MovieClip
   {
      
      public function GiftLibrary(param1:GiftLibrary_SingletonLockingClass) {
         this.maAllGifts = new Array();
         this.maAllCats = new Array();
         this.maCatOrder = new Array();
         super();
         if((mSingletonInst) || param1 == null)
         {
            throw new Error("GiftLibrary class cannot be instantiated");
         }
         else
         {
            mSingletonInst = this;
            return;
         }
      }
      
      private static var mSingletonInst:GiftLibrary = null;
      
      private static var mbHasLoadedAllGiftInfo:Boolean = false;
      
      public static const knIMAGE_SIZE_40x40:int = 40;
      
      public static const knIMAGE_SIZE_60x60:int = 60;
      
      public static const knIMAGE_SIZE_100x100:int = 100;
      
      public static function GetInst() : GiftLibrary {
         var _loc1_:GiftLibrary = null;
         if(!mSingletonInst)
         {
            _loc1_ = new GiftLibrary(new GiftLibrary_SingletonLockingClass());
         }
         return mSingletonInst;
      }
      
      public static function GetImageFromCache(param1:String) : GiftItemInst {
         var _loc4_:GiftItemInst = null;
         var _loc2_:GiftItem = GiftLibrary.GetInst().GetGift(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(_loc2_.maCachedInst_Free.length > 0)
         {
            _loc4_ = _loc2_.maCachedInst_Free.pop();
            _loc4_.Wake();
            return _loc4_;
         }
         var _loc3_:GiftItemInst = new GiftItemInst(_loc2_);
         return _loc3_;
      }
      
      private var msDefaultCategory:String = null;
      
      private var maAllGifts:Array;
      
      private var maAllCats:Array;
      
      private var maCatOrder:Array;
      
      private var _giftFilters:int = 0;
      
      public function HasLoadedAllGiftInfo() : Boolean {
         return mbHasLoadedAllGiftInfo;
      }
      
      public function GetDefaultCategory() : String {
         return this.msDefaultCategory;
      }
      
      public function GetGift(param1:String) : GiftItem {
         if(!this.maAllGifts[param1])
         {
            return null;
         }
         return this.maAllGifts[param1];
      }
      
      public function GetAllCategories() : Array {
         return this.maAllCats;
      }
      
      public function GetGiftCategory(param1:String) : GiftCategory {
         if(!this.maAllCats[param1])
         {
            return null;
         }
         return this.maAllCats[param1];
      }
      
      public function GetCategoryOrder() : Array {
         return this.maCatOrder;
      }
      
      public function getGiftsForCategory(param1:int) : Array {
         var _loc3_:String = null;
         var _loc4_:GiftItem = null;
         var _loc2_:Array = [];
         for (_loc3_ in this.maAllGifts)
         {
            _loc4_ = this.maAllGifts[_loc3_] as GiftItem;
            if(!(_loc4_ == null) && _loc4_.mnCatId == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function GetGiftArrayForCategory(param1:String) : Array {
         var _loc5_:* = 0;
         var _loc2_:Array = new Array();
         var _loc3_:GiftCategory = this.maAllCats[param1];
         if(_loc3_ == null)
         {
            return _loc2_;
         }
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.maGiftsInCat.length)
         {
            _loc5_ = _loc3_.maGiftsInCat[_loc4_];
            if(this.maAllGifts[_loc5_])
            {
               _loc2_.push(this.maAllGifts[_loc5_]);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function AddGiftInfoList(param1:Object) : void {
         var _loc3_:String = null;
         var _loc4_:GiftItem = null;
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_].id;
            if(!this.maAllGifts[_loc3_])
            {
               this.maAllGifts[_loc3_] = new GiftItem();
            }
            _loc4_ = this.maAllGifts[_loc3_] as GiftItem;
            if(param1[_loc2_].id)
            {
               _loc4_.mnId = param1[_loc2_].id;
            }
            _loc4_.mbUserFilter = param1[_loc2_].userFilter?true:false;
            _loc4_.miFilterMask = param1[_loc2_].userFilter;
            if(param1[_loc2_].picLargeUrl)
            {
               _loc4_.msPicLargeUrl = SSLMigration.getSecureURL(param1[_loc2_].picLargeUrl);
            }
            if(param1[_loc2_].picMediumUrl)
            {
               _loc4_.msPicMediumUrl = SSLMigration.getSecureURL(param1[_loc2_].picMediumUrl);
            }
            if(param1[_loc2_].picSmallUrl)
            {
               _loc4_.msPicSmallUrl = SSLMigration.getSecureURL(param1[_loc2_].picSmallUrl);
            }
            if(param1[_loc2_].picAs3Url)
            {
               _loc4_.msPicAs3Url = SSLMigration.getSecureURL(param1[_loc2_].picAs3Url);
            }
            if(param1[_loc2_].as3Classname)
            {
               _loc4_.msClassDef = param1[_loc2_].as3Classname;
            }
            if(param1[_loc2_].name)
            {
               _loc4_.msName = param1[_loc2_].name;
            }
            if(param1[_loc2_].actionText)
            {
               _loc4_.msActionText = param1[_loc2_].actionText;
            }
            if(param1[_loc2_].clientData)
            {
               _loc4_.msClientData = param1[_loc2_].clientData;
            }
            if(param1[_loc2_].premium)
            {
               _loc4_.isPremium = param1[_loc2_].premium == "1"?true:false;
            }
            if(param1[_loc2_].category_id)
            {
               _loc4_.mnCatId = int(param1[_loc2_].category_id);
            }
            if(param1[_loc2_].category_rank)
            {
               _loc4_.mnCatRank = int(param1[_loc2_].category_rank);
            }
            _loc2_++;
         }
         mbHasLoadedAllGiftInfo = true;
         this.dispatchEvent(new GiftLibraryEvent(GiftLibraryEvent.GIFTS_LOADED));
      }
      
      public function AddCategoryList(param1:Array) : void {
         var _loc3_:String = null;
         var _loc4_:GiftCategory = null;
         this.maCatOrder = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_].id;
            if(!this.maAllCats[_loc3_])
            {
               this.maAllCats[_loc3_] = new GiftCategory();
            }
            _loc4_ = this.maAllCats[_loc3_] as GiftCategory;
            if(param1[_loc2_].id)
            {
               _loc4_.mnId = param1[_loc2_].id;
            }
            _loc4_.msName = param1[_loc2_].name?param1[_loc2_].name:"name unkown";
            _loc4_.premiumRows = param1[_loc2_].premiumrows?int(param1[_loc2_].premiumrows):0;
            this.maCatOrder.push(_loc4_.mnId);
            _loc2_++;
         }
      }
      
      public function AddGiftPriceList(param1:String, param2:Array) : void {
         var _loc5_:* = 0;
         var _loc6_:GiftItem = null;
         if(this.msDefaultCategory == null)
         {
            this.msDefaultCategory = param1;
         }
         if(!this.maAllCats[param1])
         {
            this.maAllCats[param1] = new GiftCategory();
         }
         var _loc3_:GiftCategory = this.maAllCats[param1];
         _loc3_.maGiftsInCat = new Array();
         _loc3_.maPremiumGifts = new Array();
         _loc3_.maStandardGifts = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2[_loc4_].id;
            _loc3_.maGiftsInCat.push(_loc5_);
            if(!this.maAllGifts[_loc5_])
            {
               this.maAllGifts[_loc5_] = new GiftItem();
            }
            _loc6_ = this.maAllGifts[_loc5_] as GiftItem;
            if(_loc6_.isPremium)
            {
               _loc3_.maPremiumGifts.push(_loc5_);
            }
            else
            {
               _loc3_.maStandardGifts.push(_loc5_);
            }
            if(param2[_loc4_].id)
            {
               _loc6_.mnId = param2[_loc4_].id;
            }
            _loc6_.mnPrice = param2[_loc4_].price?param2[_loc4_].price:0;
            _loc6_.mnUnlockLevel = param2[_loc4_].unlock_level?param2[_loc4_].unlock_level:0;
            _loc6_.mbGreyOut = param2[_loc4_].greyOut?true:false;
            _loc6_.sponsored_gift = param2[_loc4_].sponsored_gift?true:false;
            if(param2[_loc4_].sponsor_state)
            {
               _loc6_.sponsors_needed = param2[_loc4_].sponsor_state.sponsors_needed;
               if(param2[_loc4_].sponsor_state.sponsors_accepted is Array)
               {
                  _loc6_.sponsors_accepted = param2[_loc4_].sponsor_state.sponsors_accepted;
               }
               else
               {
                  _loc6_.sponsors_accepted = [];
               }
            }
            _loc4_++;
         }
      }
      
      public function ReleaseGiftMovieClip(param1:MovieClip) : void {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:GiftItemInst = param1 as GiftItemInst;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.moGift)
         {
            _loc2_.Sleep();
            _loc2_.moGift.maCachedInst_Free.push(_loc2_);
         }
         else
         {
            _loc2_.Release();
         }
      }
      
      public function CreateGiftMovieClip(param1:Number, param2:String) : MovieClip {
         var container:GiftItemInst = null;
         var nSize:Number = param1;
         var sGiftId:String = param2;
         if(!this.maAllGifts[sGiftId])
         {
            return null;
         }
         var oGift:GiftItem = this.GetGift(sGiftId);
         var sImageUrl:String = null;
         switch(nSize)
         {
            case knIMAGE_SIZE_40x40:
               if(!(oGift.msPicAs3Url == null) && !(oGift.msPicAs3Url == ""))
               {
                  sImageUrl = oGift.msPicAs3Url;
               }
               else
               {
                  sImageUrl = oGift.msPicSmallUrl;
               }
               break;
            case knIMAGE_SIZE_60x60:
               sImageUrl = oGift.msPicMediumUrl;
               break;
            case knIMAGE_SIZE_100x100:
               sImageUrl = oGift.msPicLargeUrl;
               break;
         }
         
         if(sImageUrl == null)
         {
            return null;
         }
         container = GetImageFromCache(sGiftId);
         var params:Object = 
            {
               "classDef":this.GetGift(sGiftId).msClassDef,
               "onComplete":function(param1:LoaderEvent):void
               {
                  var _loc2_:* = undefined;
                  var _loc3_:* = undefined;
                  if(param1.data.classDef)
                  {
                     _loc2_ = new param1.data.classDef();
                     container.addGiftDisplayObject(_loc2_);
                  }
                  if(param1.data.bmpData)
                  {
                     _loc3_ = new Bitmap(param1.data.bmpData);
                     container.addGiftDisplayObject(_loc3_);
                  }
               }
            };
         LoadManager.load(sImageUrl,params,LoadManager.PRIORITY_HIGH);
         return container as MovieClip;
      }
      
      public function get giftFilters() : int {
         return this._giftFilters;
      }
      
      public function set giftFilters(param1:int) : void {
         this._giftFilters = param1;
      }
   }
}
class GiftLibrary_SingletonLockingClass extends Object
{
   
   function GiftLibrary_SingletonLockingClass() {
      super();
   }
}
