package com.zynga.poker.table.layouts
{
   import com.zynga.poker.feature.FeatureModel;
   import flash.utils.Dictionary;
   
   public class TableLayoutModel extends FeatureModel
   {
      
      public function TableLayoutModel() {
         super();
      }
      
      private var _tableLayouts:Dictionary;
      
      override public function init() : void {
         this._tableLayouts = new Dictionary();
      }
      
      public function getTableLayout(param1:String, param2:int) : ITableLayout {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc3_:String = param1 + "_" + param2;
         var _loc4_:ITableLayout = this._tableLayouts[_loc3_];
         if(_loc4_ == null)
         {
            _loc5_ = configModel.getFeatureConfig("table");
            _loc6_ = _loc5_.tableBindings;
            _loc7_ = _loc6_[param1];
            if(_loc7_)
            {
               _loc8_ = _loc5_.tableLayouts;
               _loc9_ = _loc8_[_loc7_.type];
               _loc9_ = _loc9_[param2 + ""];
               if(_loc9_)
               {
                  if(_loc9_.format == "fixed")
                  {
                     _loc4_ = new TableLayoutFixed(_loc9_);
                  }
                  else
                  {
                     if(_loc9_.format == "dynamic")
                     {
                        _loc4_ = new TableLayoutDynamic(_loc9_);
                     }
                  }
                  this._tableLayouts[_loc3_] = _loc4_;
               }
            }
         }
         return _loc4_;
      }
   }
}
