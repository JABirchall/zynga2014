package com.zynga.rad.containers.anchors
{
   import flash.display.MovieClip;
   
   public dynamic class RightAnchor extends HBaseAnchor
   {
      
      public function RightAnchor() {
         super();
         var _loc1_:MovieClip = m_parentContainer.backing;
         if(_loc1_)
         {
            this.distance = _loc1_.x + _loc1_.width - (m_topLevelAnchor.x + m_topLevelAnchor.getTopLevelAnchorBounds(this).width);
         }
      }
      
      public var distance:Number;
      
      override public function doPostLayout() : void {
         super.doPostLayout();
         var _loc1_:MovieClip = m_parentContainer.backing;
         if(_loc1_)
         {
            m_topLevelAnchor.x = _loc1_.x + _loc1_.width - (this.distance + m_topLevelAnchor.getTopLevelAnchorBounds(this).width);
         }
      }
   }
}
