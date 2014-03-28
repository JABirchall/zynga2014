package com.zynga.rad.containers.anchors
{
   import flash.display.MovieClip;
   
   public dynamic class VCenterAnchor extends BaseAnchor
   {
      
      public function VCenterAnchor() {
         super();
      }
      
      override public function doPostLayout() : void {
         super.doPostLayout();
         var _loc1_:MovieClip = m_parentContainer.backing;
         m_topLevelAnchor.y = _loc1_.y + 0.5 * (_loc1_.height - m_topLevelAnchor.getTopLevelAnchorBounds(this).height);
      }
   }
}
