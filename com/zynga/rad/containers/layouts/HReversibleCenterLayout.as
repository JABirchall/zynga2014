package com.zynga.rad.containers.layouts
{
   public dynamic class HReversibleCenterLayout extends HReversibleLayout
   {
      
      public function HReversibleCenterLayout() {
         super();
         this.m_center = this.x + 0.5 * this.getBounds(this).width;
      }
      
      private var m_center:Number;
      
      override public function doLayout() : void {
         super.doLayout();
         if(this.m_center >= 0)
         {
            this.x = this.m_center - 0.5 * getBounds(this).width;
         }
      }
   }
}
