package com.zynga.rad.containers.layouts
{
   import flash.display.DisplayObject;
   import com.zynga.rad.containers.ILayout;
   import flash.geom.Rectangle;
   
   public dynamic class HBaseLayout extends BaseLayout
   {
      
      public function HBaseLayout() {
         var _loc1_:Rectangle = null;
         var _loc2_:SpacingData = null;
         var _loc3_:SpacingData = null;
         var _loc4_:Rectangle = null;
         super();
         for each (m_objectToDataMap[_loc3_.object] in m_sortedChildren)
         {
            _loc4_ = _loc3_.object.getBounds(this);
            if(!_loc1_)
            {
               _loc3_.left = _loc3_.object.x;
            }
            else
            {
               _loc3_.left = _loc3_.object.x - (_loc2_.object.x + _loc1_.width);
            }
            _loc3_.rightEdge = (_loc3_.object.x - _loc4_.x) * 2;
            _loc1_ = _loc4_;
            _loc2_ = _loc3_;
         }
      }
      
      override protected function sortingFunction(param1:SpacingData, param2:SpacingData) : int {
         return param1.object.x - param2.object.x;
      }
      
      override public function doLayout() : void {
         var _loc4_:SpacingData = null;
         var _loc5_:DisplayObject = null;
         if(!m_sortedChildren)
         {
            return;
         }
         var _loc1_:* = true;
         var _loc2_:Number = 0;
         var _loc3_:* = 0;
         while(_loc3_ < m_sortedChildren.length)
         {
            _loc4_ = m_sortedChildren[_loc3_];
            _loc5_ = _loc4_.object;
            if(!m_removedObjectsToDataMap[_loc5_])
            {
               if(_loc1_)
               {
                  _loc4_ = m_sortedChildren[0];
                  _loc1_ = false;
               }
               if(_loc5_ is ILayout)
               {
                  ILayout(_loc5_).doLayout();
               }
               _loc5_.x = _loc4_.left + _loc2_;
               _loc2_ = _loc5_.x + _loc5_.getBounds(this).width;
            }
            _loc3_++;
         }
      }
   }
}
