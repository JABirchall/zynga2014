package com.zynga.poker.table.layouts
{
   import flash.geom.Point;
   
   public class TableLayoutDynamic extends TableLayoutFixed
   {
      
      public function TableLayoutDynamic(param1:Object) {
         super(param1);
      }
      
      private var _centroid:Point;
      
      override protected function createSeatLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         var _loc2_:Object = param1.seatPositions;
         _seatLayout = new Array();
         this._centroid = new Point(0,0);
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new Point(_loc3_.x,_loc3_.y);
            _seatLayout.push(_loc4_);
            this._centroid = this._centroid.add(_loc4_);
         }
         this._centroid.x = this._centroid.x / _seatLayout.length;
         this._centroid.y = this._centroid.y / _seatLayout.length;
      }
      
      override protected function createGiftLayout(param1:Object) : void {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:Point = new Point(param1.giftOffset.x,param1.giftOffset.y);
         _giftLayout = new Array();
         for each (_loc3_ in _chickletLayout)
         {
            _loc4_ = _loc3_.add(_loc2_);
            _giftLayout.push(_loc4_);
         }
      }
      
      override protected function createCardLayout(param1:Object) : void {
         _cardLayout = new CardLayoutDynamic(param1);
      }
   }
}
