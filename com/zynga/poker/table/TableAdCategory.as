package com.zynga.poker.table
{
   public class TableAdCategory extends Object
   {
      
      public function TableAdCategory(param1:int, param2:String, param3:Array) {
         var _loc4_:Object = null;
         this._ads = [];
         super();
         this._weight = param1;
         this._categoryName = param2;
         this._ads = param3;
         for each (_loc4_ in this._ads)
         {
            _loc4_.impressions = 0;
            this._maxWeight = this._maxWeight + _loc4_.weight;
         }
      }
      
      private var _weight:int = 0;
      
      private var _categoryName:String = "";
      
      private var _ads:Array;
      
      private var _maxWeight:int = 0;
      
      public function get weight() : int {
         return this._weight;
      }
      
      public function get categoryName() : String {
         return this._categoryName;
      }
      
      public function getRandomAd(param1:Boolean=false) : Object {
         var _loc4_:Object = null;
         var _loc2_:int = Math.floor(Math.random() * this._maxWeight);
         var _loc3_:* = 0;
         while(_loc3_ < this._maxWeight)
         {
            _loc4_ = this._ads[_loc3_];
            if(_loc2_ < _loc4_.weight)
            {
               if(!param1)
               {
                  _loc4_.impressions = _loc4_.impressions + 1;
               }
               if((_loc4_.sessionLimit) && _loc4_.sessionLimit <= _loc4_.impressions)
               {
                  this._maxWeight = this._maxWeight - _loc4_.weight;
                  this._ads.splice(_loc3_,1);
               }
               return _loc4_;
            }
            _loc2_ = _loc2_ - _loc4_.weight;
            _loc3_++;
         }
         return null;
      }
   }
}
