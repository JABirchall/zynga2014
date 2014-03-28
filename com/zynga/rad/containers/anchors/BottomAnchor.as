package com.zynga.rad.containers.anchors
{
   import com.zynga.rad.containers.IPostLayout;
   import flash.display.MovieClip;
   
   public dynamic class BottomAnchor extends BaseAnchor implements IPostLayout
   {
      
      public function BottomAnchor() {
         super();
         var _loc1_:MovieClip = m_parentContainer.backing;
         this.distance = _loc1_.y + _loc1_.height - (m_topLevelAnchor.y + m_topLevelAnchor.getTopLevelAnchorBounds(this).height);
      }
      
      private var distance:Number;
      
      override public function doPostLayout() : void {
         super.doPostLayout();
         var _loc1_:MovieClip = m_parentContainer.backing;
         m_topLevelAnchor.y = _loc1_.y + _loc1_.height - (this.distance + m_topLevelAnchor.getTopLevelAnchorBounds(this).height);
      }
   }
}
