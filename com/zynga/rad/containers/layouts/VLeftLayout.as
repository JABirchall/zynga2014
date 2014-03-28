package com.zynga.rad.containers.layouts
{
   public dynamic class VLeftLayout extends VLayout
   {
      
      public function VLeftLayout() {
         var _loc1_:SpacingData = null;
         super();
         this.m_originalMinX = Number.MAX_VALUE;
         for each (_loc1_ in m_sortedChildren)
         {
            this.m_originalMinX = Math.min(_loc1_.object.x,this.m_originalMinX);
         }
      }
      
      private var m_originalMinX:Number = 0;
      
      override public function doLayout() : void {
         var _loc2_:SpacingData = null;
         var _loc3_:* = NaN;
         super.doLayout();
         var _loc1_:Number = Number.MAX_VALUE;
         for each (_loc2_ in m_sortedChildren)
         {
            if(!m_removedObjectsToDataMap[_loc2_.object])
            {
               _loc1_ = Math.min(_loc2_.object.x,_loc1_);
            }
         }
         _loc3_ = this.m_originalMinX - _loc1_;
         for each (_loc2_ in m_sortedChildren)
         {
            if(!m_removedObjectsToDataMap[_loc2_.object])
            {
               _loc2_.object.x = _loc2_.object.x + _loc3_;
            }
         }
      }
   }
}
