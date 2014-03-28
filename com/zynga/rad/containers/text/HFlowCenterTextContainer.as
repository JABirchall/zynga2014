package com.zynga.rad.containers.text
{
   public dynamic class HFlowCenterTextContainer extends HFlowTextContainer
   {
      
      public function HFlowCenterTextContainer() {
         super();
         this.m_center = this.x + 0.5 * this.width;
      }
      
      private var m_center:Number;
      
      override public function doLayout() : void {
         super.doLayout();
         this.x = this.m_center - 0.5 * this.width;
      }
   }
}
