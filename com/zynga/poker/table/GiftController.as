package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.layouts.ITableLayout;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.feature.FeatureModel;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.zynga.poker.PokerClassProvider;
   
   public class GiftController extends FeatureController
   {
      
      public function GiftController() {
         super();
      }
      
      private var _tableModel:TableModel;
      
      private var _playerPosModel:PlayerPositionModel;
      
      public var cont:DisplayObjectContainer;
      
      private var _sitCoords:Array;
      
      private var _giftCoords:Array;
      
      protected var _giftData:Array;
      
      private var _giftTweenRef:Array;
      
      override protected function preInit() : void {
         this._tableModel = registry.getObject(TableModel);
         this._playerPosModel = registry.getObject(PlayerPositionModel);
         var _loc1_:TableLayoutModel = registry.getObject(TableLayoutModel);
         _loc1_.init();
         var _loc2_:ITableLayout = _loc1_.getTableLayout(this._tableModel.room.gameType,this._tableModel.room.maxPlayers);
         this._sitCoords = _loc2_.getSeatLayout();
         this._giftCoords = _loc2_.getGiftLayout();
      }
      
      override protected function postInit() : void {
         this._giftData = [];
         this._giftTweenRef = [];
      }
      
      override protected function initView() : FeatureView {
         var _loc1_:FeatureView = registry.getObject(FeatureView);
         _loc1_.init(_model);
         return _loc1_;
      }
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      public function sendGift(param1:int, param2:int, param3:int, param4:Number) : void {
      }
      
      public function sendGift2(param1:int, param2:int, param3:Number) : void {
         var gift:MovieClip = null;
         var fromSit:int = param1;
         var toSit:int = param2;
         var inGiftId:Number = param3;
         var pushNew:Function = function():void
         {
            _giftTweenRef[toSit] = null;
            var _loc1_:Object = new Object();
            _loc1_.sit = toSit;
            _loc1_.gift = gift;
            _giftData.push(_loc1_);
         };
         gift = GiftLibrary.GetInst().CreateGiftMovieClip(GiftLibrary.knIMAGE_SIZE_40x40,inGiftId.toString());
         gift.mouseEnabled = true;
         gift.buttonMode = true;
         gift.mouseChildren = false;
         gift.useHandCursor = true;
         gift.addEventListener(MouseEvent.CLICK,this.onGiftClick);
         var fromMappedSitCoords:Point = this.getMappedSitCoords(fromSit);
         gift.x = fromMappedSitCoords.x;
         gift.y = fromMappedSitCoords.y + GiftLibrary.knIMAGE_SIZE_40x40 / 2;
         view.addChild(gift);
         var toMappedGiftCoords:Point = this.getMappedGiftCoords(toSit);
         var toX:int = toMappedGiftCoords.x;
         var toY:int = toMappedGiftCoords.y + GiftLibrary.knIMAGE_SIZE_40x40 / 2;
         TweenLite.to(gift,0.75,
            {
               "x":toX,
               "y":toY,
               "ease":Sine.easeOut,
               "onComplete":function():void
               {
                  clearOld(toSit);
                  pushNew();
               }
            });
         this._giftTweenRef[toSit] = gift;
      }
      
      private function sitHasGift(param1:int) : Boolean {
         var _loc2_:String = null;
         for (_loc2_ in this._giftData)
         {
            if(this._giftData[_loc2_].sit === param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getGiftForSit(param1:int) : MovieClip {
         var _loc2_:String = null;
         for (_loc2_ in this._giftData)
         {
            if(this._giftData[_loc2_].sit === param1)
            {
               return this._giftData[_loc2_].gift;
            }
         }
         return null;
      }
      
      private function clearOld(param1:int) : void {
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         for (_loc2_ in this._giftData)
         {
            if(this._giftData[_loc2_].sit === param1)
            {
               _loc3_ = this._giftData[_loc2_].gift;
               if(_loc3_)
               {
                  _loc3_.removeEventListener(MouseEvent.CLICK,this.onGiftClick);
                  GiftLibrary.GetInst().ReleaseGiftMovieClip(_loc3_);
                  if(view.contains(_loc3_))
                  {
                     view.removeChild(_loc3_);
                  }
               }
               _loc3_ = null;
               this._giftData.splice(_loc2_,1);
            }
         }
      }
      
      public function clearGiftFromSit(param1:int) : void {
         var _loc2_:Object = null;
         if(this._giftTweenRef[param1] !== null)
         {
            TweenLite.killTweensOf(this._giftTweenRef[param1]);
            this.clearOld(param1);
            _loc2_ = new Object();
            _loc2_.sit = param1;
            _loc2_.gift = this._giftTweenRef[param1];
            this._giftData.push(_loc2_);
            this._giftTweenRef[param1] = null;
         }
         this.clearOld(param1);
      }
      
      public function clearGifts() : void {
         var _loc1_:String = null;
         var _loc2_:MovieClip = null;
         for (_loc1_ in this._giftData)
         {
            _loc2_ = this._giftData[_loc1_].gift;
            TweenLite.killTweensOf(_loc2_);
            view.removeChild(_loc2_);
            _loc2_ = null;
         }
         this._giftData.length = 0;
      }
      
      public function placeGift2(param1:Number, param2:int, param3:Number) : void {
         if(param3 === GiftItem.GIFT_ID_NONE)
         {
            this.clearOld(param2);
            this.showEmptyGift(param2);
            return;
         }
         var _loc4_:GiftItem = GiftLibrary.GetInst().GetGift(String(param3));
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:MovieClip = GiftLibrary.GetInst().CreateGiftMovieClip(GiftLibrary.knIMAGE_SIZE_40x40,String(param3));
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 == 1)
         {
            if(_loc4_.mbUserFilter)
            {
               if(!this.sitHasGift(param2))
               {
                  this.showEmptyGift(param2);
               }
               return;
            }
         }
         this.clearOld(param2);
         _loc5_.mouseEnabled = true;
         _loc5_.buttonMode = true;
         _loc5_.mouseChildren = false;
         _loc5_.useHandCursor = true;
         _loc5_.addEventListener(MouseEvent.CLICK,this.onGiftClick);
         var _loc6_:Point = this.getMappedGiftCoords(param2);
         _loc5_.x = _loc6_.x;
         _loc5_.y = _loc6_.y + GiftLibrary.knIMAGE_SIZE_40x40 / 2;
         var _loc7_:Object = new Object();
         _loc7_.sit = param2;
         _loc7_.gift = _loc5_;
         this._giftData.push(_loc7_);
         view.addChild(_loc5_);
      }
      
      private function findGiftSit(param1:MovieClip) : int {
         var _loc2_:* = -1;
         var _loc3_:* = 0;
         while(_loc3_ < this._giftData.length)
         {
            if(this._giftData[_loc3_].gift === param1)
            {
               _loc2_ = this._giftData[_loc3_].sit;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function fadeToAlpha(param1:int, param2:Number, param3:Number=0.5) : void {
         var _loc4_:MovieClip = this.getGiftForSit(param1);
         if(_loc4_)
         {
            TweenLite.killTweensOf(_loc4_);
            TweenLite.to(_loc4_,param3,{"alpha":param2});
         }
      }
      
      public function animateGiftItem(param1:int, param2:String) : void {
         var _loc3_:MovieClip = this.getGiftForSit(param1);
         if(!(_loc3_ === null) && _loc3_ is GiftItemInst)
         {
            (_loc3_ as GiftItemInst).animateGift(param2);
         }
      }
      
      protected function onGiftClick(param1:MouseEvent) : void {
         var _loc2_:TableView = (registry.getObject(TableController) as TableController).ptView;
         _loc2_.giftClick(this.findGiftSit(param1.currentTarget as MovieClip));
      }
      
      protected function showEmptyGift(param1:int) : void {
         var _loc2_:MovieClip = PokerClassProvider.getObject("EmptyGiftIcon");
         var _loc3_:Point = this.getMappedGiftCoords(param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _loc2_.useHandCursor = true;
         _loc2_.buttonMode = true;
         _loc2_.mouseEnabled = true;
         _loc2_.mouseChildren = true;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onGiftClick);
         var _loc4_:Object = new Object();
         _loc4_.sit = param1;
         _loc4_.gift = _loc2_;
         this._giftData.push(_loc4_);
         view.addChild(_loc2_);
      }
      
      protected function getMappedGiftCoords(param1:int) : Point {
         var _loc2_:Point = new Point();
         var _loc3_:int = this._playerPosModel.getMappedPosition(param1);
         _loc2_.x = this._giftCoords[_loc3_].x;
         _loc2_.y = this._giftCoords[_loc3_].y;
         return _loc2_;
      }
      
      protected function getMappedSitCoords(param1:int) : Point {
         var _loc2_:Point = new Point();
         var _loc3_:int = this._playerPosModel.getMappedPosition(param1);
         _loc2_.x = this._sitCoords[_loc3_].x;
         _loc2_.y = this._sitCoords[_loc3_].y;
         return _loc2_;
      }
      
      protected function killAllGiftTweens() : void {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:Object = null;
         for each (_loc1_ in this._giftData)
         {
            TweenLite.killTweensOf(_loc1_.gift,true);
         }
         for (_loc2_ in this._giftTweenRef)
         {
            if(!(this._giftTweenRef[_loc2_] === null) && this._giftTweenRef[_loc2_] is MovieClip)
            {
               TweenLite.killTweensOf(this._giftTweenRef[_loc2_],true);
               _loc3_ = new Object();
               _loc3_.sit = _loc2_;
               _loc3_.gift = this._giftTweenRef[_loc2_];
               this._giftData.push(_loc3_);
               this._giftTweenRef[_loc2_] = null;
            }
         }
      }
      
      public function repositionGifts() : void {
         var _loc1_:Object = null;
         var _loc2_:Point = null;
         this.killAllGiftTweens();
         for each (_loc1_ in this._giftData)
         {
            _loc2_ = this.getMappedGiftCoords(_loc1_.sit);
            if(_loc1_.gift is GiftItemInst)
            {
               _loc1_.gift.x = _loc2_.x;
               _loc1_.gift.y = _loc2_.y + GiftLibrary.knIMAGE_SIZE_40x40 / 2;
            }
            else
            {
               _loc1_.gift.x = _loc2_.x;
               _loc1_.gift.y = _loc2_.y;
            }
         }
      }
      
      public function hideGifts() : void {
         var _loc1_:Object = null;
         for each (_loc1_ in this._giftData)
         {
            _loc1_.gift.visible = false;
         }
      }
      
      public function showGifts() : void {
         var _loc1_:Object = null;
         for each (_loc1_ in this._giftData)
         {
            _loc1_.gift.visible = true;
         }
      }
   }
}
