package com.zynga.rad.containers.anchors
{
   import com.zynga.rad.interfaces.IReversible;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public dynamic class StartAnchor extends HBaseAnchor implements IReversible
   {
      
      public function StartAnchor() {
         super();
         var _loc1_:Rectangle = m_parentContainer.backing.getBounds(m_parentContainer);
         var _loc2_:Rectangle = m_topLevelAnchor.getTopLevelAnchorBounds(m_parentContainer);
         this.distance = _loc2_.left - _loc1_.left;
         this.boundsOffset = m_originalPosition.x - _loc2_.left;
      }
      
      public var distance:Number;
      
      public var boundsOffset:Number;
      
      override public function doPostLayout() : void {
         var _loc1_:MovieClip = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Rectangle = null;
         super.doPostLayout();
         if(rtl == BIDI_RTL)
         {
            _loc1_ = m_parentContainer.backing;
            _loc2_ = _loc1_.getBounds(m_parentContainer);
            _loc3_ = m_topLevelAnchor.getTopLevelAnchorBounds(m_parentContainer);
            m_topLevelAnchor.x = _loc2_.right - (this.distance - this.boundsOffset + _loc3_.width);
         }
      }
      
      public function isReversible() : Boolean {
         return true;
      }
   }
}
