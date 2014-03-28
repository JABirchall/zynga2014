package com.zynga.poker.table.layouts
{
   import flash.geom.Point;
   
   public class ChipLayoutFixed extends Object implements IChipLayout
   {
      
      public function ChipLayoutFixed(param1:Object) {
         super();
         this.createChipLayout(param1);
         this.createPotLayout(param1);
      }
      
      protected var _chipLayout:Array;
      
      protected var _potLayout:Array;
      
      protected function createChipLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = param1.chipPositions;
         this._chipLayout = new Array();
         for each (_loc3_ in _loc2_)
         {
            this._chipLayout.push(new Point(_loc3_.x,_loc3_.y));
         }
      }
      
      protected function createPotLayout(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = param1.potPositions;
         this._potLayout = new Array();
         for each (_loc3_ in _loc2_)
         {
            this._potLayout.push(new Point(_loc3_.x,_loc3_.y));
         }
      }
      
      public function getChipLayout() : Array {
         return this._chipLayout;
      }
      
      public function getPotLayout() : Array {
         return this._potLayout;
      }
   }
}
