package com.zynga.rad.containers.text
{
   public dynamic class HCenterTextContainer extends HTextContainer
   {
      
      public function HCenterTextContainer() {
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
