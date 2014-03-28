package com.zynga.poker.table.layouts
{
   import flash.geom.Point;
   
   public class TableLayoutFixed extends Object implements ITableLayout
   {
      
      public function TableLayoutFixed(param1:Object) {
         super();
         this._maxPlayers = param1.maxPlayers;
         this.createSeatLayout(param1);
         this.createChickletLayout(param1);
         this.createGiftLayout(param1);
         this.createDealerPuckLayout(param1);
         this.createChipLayout(param1);
         this.createCardLayout(param1);
      }
      
      protected var _seatLayout:Array;
      
      protected var _chickletLayout:Array;
      
      protected var _giftLayout:Array;
      
      protected var _dealerPuckLayout:Array;
      
      protected var _chipLayout:IChipLayout;
      
      protected var _cardLayout:ICardLayout;
      
      protected var _maxPlayers:Number;
      
      protected function createSeatLayout(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         _loc2_ = param1.seatPositions;
         this._seatLayout = new Array();
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new Point(_loc3_.x,_loc3_.y);
            this._seatLayout.push(_loc4_);
         }
      }
      
      protected function createChickletLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         var _loc2_:Object = param1.chickletPositions;
         this._chickletLayout = [];
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new Point(_loc3_.x,_loc3_.y);
            this._chickletLayout.push(_loc4_);
         }
      }
      
      protected function createGiftLayout(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         _loc2_ = param1.giftPositions;
         this._giftLayout = new Array();
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new Point(_loc3_.x,_loc3_.y);
            this._giftLayout.push(_loc4_);
         }
      }
      
      protected function createDealerPuckLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         var _loc2_:Object = param1.puckPositions;
         this._dealerPuckLayout = new Array();
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new Point(_loc3_.x,_loc3_.y);
            this._dealerPuckLayout.push(_loc4_);
         }
      }
      
      protected function createChipLayout(param1:Object) : void {
         this._chipLayout = new ChipLayoutFixed(param1);
      }
      
      protected function createCardLayout(param1:Object) : void {
         this._cardLayout = new CardLayoutFixed(param1);
      }
      
      public function getSeatLayout() : Array {
         return this._seatLayout;
      }
      
      public function getChickletLayout() : Array {
         return this._chickletLayout;
      }
      
      public function getGiftLayout() : Array {
         return this._giftLayout;
      }
      
      public function getDealerPuckLayout() : Array {
         return this._dealerPuckLayout;
      }
      
      public function getChipLayout() : IChipLayout {
         return this._chipLayout;
      }
      
      public function getCardLayout() : ICardLayout {
         return this._cardLayout;
      }
      
      public function getMaxPlayers() : int {
         return this._maxPlayers;
      }
   }
}
