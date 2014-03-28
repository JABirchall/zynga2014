package com.zynga.rad.buttons
{
   import flash.display.DisplayObject;
   
   public class ZTabButton extends ZSelectableButton
   {
      
      public function ZTabButton() {
         super();
      }
      
      private var m_pane:DisplayObject;
      
      override public function select() : void {
         super.select();
         if(this.m_pane)
         {
            this.m_pane.visible = m_isSelected;
         }
      }
      
      override public function unselect() : void {
         super.unselect();
         if(this.m_pane)
         {
            this.m_pane.visible = m_isSelected;
         }
      }
      
      public function set pane(param1:DisplayObject) : void {
         this.m_pane = param1;
         if(this.m_pane)
         {
            this.m_pane.visible = m_isSelected;
         }
      }
      
      public function get pane() : DisplayObject {
         return this.m_pane;
      }
   }
}
