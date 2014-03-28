package com.zynga.rad.containers.layouts
{
   import com.zynga.rad.interfaces.IReversible;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import com.zynga.rad.containers.UnboundedContainer;
   
   public dynamic class HReversibleLayout extends HBaseLayout implements IReversible
   {
      
      public function HReversibleLayout() {
         super();
         this.m_rightEdge = getBounds(this).right;
      }
      
      private var m_rightEdge:Number = 0;
      
      override public function doLayout() : void {
         var _loc2_:* = false;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         var _loc5_:SpacingData = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Rectangle = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         super.doLayout();
         var _loc1_:Number = getBounds(this).right;
         if(rtl == BIDI_RTL)
         {
            _loc2_ = true;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < m_sortedChildren.length)
            {
               _loc5_ = m_sortedChildren[_loc4_];
               _loc6_ = _loc5_.object;
               _loc7_ = _loc6_.getBounds(this);
               if(_loc6_ is UnboundedContainer)
               {
                  _loc7_ = (_loc6_ as UnboundedContainer).getLayoutBounds(this);
               }
               _loc8_ = _loc7_.width;
               if(!m_removedObjectsToDataMap[_loc6_])
               {
                  _loc9_ = _loc6_.x - _loc7_.x;
                  _loc6_.x = _loc1_ - (_loc7_.x - _loc9_ + _loc8_);
               }
               _loc4_++;
            }
         }
      }
      
      public function isReversible() : Boolean {
         return true;
      }
   }
}
