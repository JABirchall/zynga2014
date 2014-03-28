package com.zynga.rad.buttons
{
   import flash.events.MouseEvent;
   import flash.display.FrameLabel;
   
   public class ZToggleButton extends ZButton
   {
      
      public function ZToggleButton() {
         var _loc3_:FrameLabel = null;
         super();
         var _loc1_:* = false;
         var _loc2_:* = false;
         for each (_loc3_ in this.currentLabels)
         {
            if(_loc3_.name == "toggled")
            {
               _loc1_ = true;
            }
            if(_loc3_.name == "untoggled")
            {
               _loc2_ = true;
            }
         }
         assert(_loc1_,"Toggle Button with name " + this.name + " does not have a \"toggled\" frame");
         assert(_loc2_,"Toggle Button with name " + this.name + " does not have an \"untoggled\" frame");
      }
      
      protected var m_isToggled:Boolean;
      
      private var m_isToggleable:Boolean = true;
      
      public function setToggled() : void {
         if(this.m_isToggled)
         {
            return;
         }
         this.m_isToggled = true;
         gotoAndStop("toggled");
      }
      
      public function setUntoggled() : void {
         if(!this.m_isToggled)
         {
            return;
         }
         this.m_isToggled = false;
         gotoAndStop("untoggled");
      }
      
      public function get isToggled() : Boolean {
         return this.m_isToggled;
      }
      
      override protected function onRelease(param1:MouseEvent) : void {
         if(this.m_isToggleable)
         {
            this.toggle();
         }
         super.onRelease(param1);
      }
      
      public function toggle() : void {
         if(this.m_isToggled)
         {
            this.setUntoggled();
         }
         else
         {
            this.setToggled();
         }
      }
      
      public function get toggleable() : Boolean {
         return this.m_isToggleable;
      }
      
      public function set toggleable(param1:Boolean) : void {
         this.m_isToggleable = param1;
      }
   }
}
