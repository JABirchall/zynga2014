package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   
   public class ChipCalc extends Sprite
   {
      
      public function ChipCalc() {
         super();
      }
      
      public static var denominations:Array = [1.0E12,1.0E11,2.5E10,1.0E10,1000000000,500000000,100000000,25000000,10000000,5000000,1000000,100000,50000,25000,10000,5000,1000,500,100,25,10,5,1];
      
      public static function quantity(param1:Number) : Array {
         var _loc5_:* = NaN;
         var _loc2_:Number = param1;
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         while(_loc4_ < denominations.length)
         {
            _loc5_ = Math.floor(_loc2_ / denominations[_loc4_]);
            _loc3_.push(_loc5_);
            _loc2_ = _loc2_ - _loc5_ * denominations[_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
