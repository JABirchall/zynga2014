package com.zynga.poker.table
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   
   public class RedesignGiftController extends GiftController
   {
      
      public function RedesignGiftController() {
         super();
      }
      
      override protected function showEmptyGift(param1:int) : void {
         var _loc2_:MovieClip = null;
         _loc2_ = PokerClassProvider.getObject("RedesignGiftIcon");
         var _loc3_:Point = getMappedGiftCoords(param1);
         _loc2_.x = _loc3_.x - _loc2_.width / 2;
         _loc2_.y = _loc3_.y - _loc2_.height / 2;
         _loc2_.useHandCursor = true;
         _loc2_.buttonMode = true;
         _loc2_.mouseEnabled = true;
         _loc2_.mouseChildren = false;
         _loc2_.addEventListener(MouseEvent.CLICK,onGiftClick,false,0,true);
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onGiftMouseOver,false,0,true);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onGiftMouseOut,false,0,true);
         var _loc4_:Object = new Object();
         _loc4_.sit = param1;
         _loc4_.gift = _loc2_;
         _giftData.push(_loc4_);
         view.addChild(_loc2_);
      }
      
      private function onGiftMouseOver(param1:MouseEvent) : void {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function onGiftMouseOut(param1:MouseEvent) : void {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      override public function repositionGifts() : void {
         var _loc1_:Object = null;
         var _loc2_:Point = null;
         killAllGiftTweens();
         for each (_loc1_ in _giftData)
         {
            _loc2_ = getMappedGiftCoords(_loc1_.sit);
            if(_loc1_.gift is GiftItemInst)
            {
               _loc1_.gift.x = _loc2_.x;
               _loc1_.gift.y = _loc2_.y + GiftLibrary.knIMAGE_SIZE_40x40 / 2;
            }
            else
            {
               _loc1_.gift.x = _loc2_.x - _loc1_.gift.width / 2;
               _loc1_.gift.y = _loc2_.y - _loc1_.gift.height / 2;
            }
         }
      }
   }
}
