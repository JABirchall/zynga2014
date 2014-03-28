package com.zynga.rad.containers.layouts
{
   public dynamic class VCenterLayout extends VLayout
   {
      
      public function VCenterLayout() {
         super();
         this.m_center = this.y + 0.5 * this.getBounds(this).height;
      }
      
      private var m_center:Number;
      
      override public function doLayout() : void {
         super.doLayout();
         this.y = this.m_center - 0.5 * getBounds(this).height;
      }
   }
}
