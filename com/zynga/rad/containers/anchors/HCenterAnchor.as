package com.zynga.rad.containers.anchors
{
   import flash.display.MovieClip;
   
   public dynamic class HCenterAnchor extends HBaseAnchor
   {
      
      public function HCenterAnchor() {
         super();
      }
      
      override public function doPostLayout() : void {
         super.doPostLayout();
         var _loc1_:MovieClip = m_parentContainer.backing;
         m_topLevelAnchor.x = _loc1_.x + 0.5 * (_loc1_.width - m_topLevelAnchor.getTopLevelAnchorBounds(this).width);
      }
   }
}
