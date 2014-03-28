package com.zynga.poker.table.asset.chips
{
   import __AS3__.vec.Vector;
   import com.zynga.poker.PokerClassProvider;
   
   public class ChipPool extends Object
   {
      
      public function ChipPool(param1:Inner) {
         super();
         this._freeChips = new Vector.<Chip>();
         this._chipGraphic = PokerClassProvider.getClass("ChipGfx");
         this._chipDecor = PokerClassProvider.getClass("ChipDecor");
      }
      
      private static var _instance:ChipPool = null;
      
      public static function getInstance() : ChipPool {
         if(_instance === null)
         {
            _instance = new ChipPool(new Inner());
         }
         return _instance;
      }
      
      private var _freeChips:Vector.<Chip>;
      
      private var _chipGraphic:Class;
      
      private var _chipDecor:Class;
      
      public function getChip() : Chip {
         var _loc1_:Chip = null;
         if(this._freeChips.length > 0)
         {
            _loc1_ = this._freeChips.pop();
         }
         else
         {
            _loc1_ = new Chip(this._chipGraphic,this._chipDecor);
         }
         return _loc1_;
      }
      
      public function freeChip(param1:Chip) : void {
         this._freeChips.push(param1);
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
