package com.zynga.poker.table.layouts
{
   import flash.geom.Point;
   
   public class CardLayoutFixed extends Object implements ICardLayout
   {
      
      public function CardLayoutFixed(param1:Object) {
         super();
         this.initCardDimensions(param1);
         this.createCommunityLayout(param1);
         this.createHoleLayout(param1);
         this.createDummyCardLayout(param1);
      }
      
      protected var _cardDimensions:Array;
      
      protected var _communityCardLayout:Array;
      
      protected var _holeCardLayout:Array;
      
      protected var _dummyCardLayout:Array;
      
      private function initCardDimensions(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = param1.cardDimensions;
         if(_loc2_)
         {
            this._cardDimensions = new Array();
            for each (_loc3_ in _loc2_)
            {
               this._cardDimensions[_loc3_.type] = new Point(_loc3_.w,_loc3_.h);
            }
         }
      }
      
      private function createCommunityLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = param1.communityCardPositions;
         if(_loc2_)
         {
            this._communityCardLayout = new Array();
            for each (_loc3_ in _loc2_)
            {
               this._communityCardLayout.push(new Point(_loc3_.x,_loc3_.y));
            }
         }
      }
      
      protected function createHoleLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc2_:Object = param1.holeCardPositions;
         if(_loc2_)
         {
            this._holeCardLayout = new Array();
            for each (_loc3_ in _loc2_)
            {
               _loc4_ = [];
               for each (_loc5_ in _loc3_)
               {
                  _loc4_.push(new Point(_loc5_.x,_loc5_.y));
               }
               this._holeCardLayout.push(_loc4_);
            }
         }
      }
      
      protected function createDummyCardLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = param1.dummyCardPositions;
         if(_loc2_)
         {
            this._dummyCardLayout = new Array();
            for each (_loc3_ in _loc2_)
            {
               this._dummyCardLayout.push(new Point(_loc3_.x,_loc3_.y));
            }
         }
      }
      
      public function getCardDimensions() : Array {
         return this._cardDimensions;
      }
      
      public function getCommunityCardLayout() : Array {
         return this._communityCardLayout;
      }
      
      public function getHoleCardLayout() : Array {
         return this._holeCardLayout;
      }
      
      public function getDummyCardLayout() : Array {
         return this._dummyCardLayout;
      }
   }
}
