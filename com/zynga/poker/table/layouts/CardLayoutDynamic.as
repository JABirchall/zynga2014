package com.zynga.poker.table.layouts
{
   import flash.geom.Point;
   
   public class CardLayoutDynamic extends CardLayoutFixed
   {
      
      public function CardLayoutDynamic(param1:Object) {
         super(param1);
      }
      
      override protected function createHoleLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc2_:Array = new Array();
         for each (_loc3_ in param1.holeCardOffset)
         {
            _loc2_.push(new Point(_loc3_.x,_loc3_.y));
         }
         _holeCardLayout = new Array();
         _loc4_ = param1.chickletPositions;
         for each (_loc5_ in _loc4_)
         {
            _loc6_ = [new Point(_loc5_.x + _loc2_[0].x,_loc5_.y + _loc2_[0].y),new Point(_loc5_.x + _loc2_[1].x,_loc5_.y + _loc2_[1].y)];
            _holeCardLayout.push(_loc6_);
         }
      }
   }
}
