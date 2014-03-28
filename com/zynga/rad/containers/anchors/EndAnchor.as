package com.zynga.rad.containers.anchors
{
   import com.zynga.rad.interfaces.IReversible;
   import flash.geom.Rectangle;
   
   public dynamic class EndAnchor extends HBaseAnchor implements IReversible
   {
      
      public function EndAnchor() {
         super();
         var _loc1_:Rectangle = m_parentContainer.backing.getBounds(m_parentContainer);
         this.distance = _loc1_.right - m_topLevelAnchor.getTopLevelAnchorBounds(m_parentContainer).right;
      }
      
      public var distance:Number;
      
      override public function doPostLayout() : void {
         super.doPostLayout();
         var _loc1_:Rectangle = m_parentContainer.backing.getBounds(m_parentContainer);
         if(rtl == BIDI_LTR)
         {
            m_topLevelAnchor.x = _loc1_.right - (this.distance + m_topLevelAnchor.getTopLevelAnchorBounds(m_parentContainer).width);
         }
         else
         {
            m_topLevelAnchor.x = _loc1_.left + this.distance;
         }
      }
      
      public function isReversible() : Boolean {
         return true;
      }
   }
}
