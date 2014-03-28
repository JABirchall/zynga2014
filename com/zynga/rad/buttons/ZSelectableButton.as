package com.zynga.rad.buttons
{
   import flash.display.MovieClip;
   import __AS3__.vec.*;
   import flash.events.MouseEvent;
   
   public class ZSelectableButton extends ZButton
   {
      
      public function ZSelectableButton() {
         super();
         assert(!(this.selected == null),"Selectable button must include a selected state");
         this.m_isSelected = this.selected.visible;
         m_states = [up,over,down,disabled,this.selected];
         init();
      }
      
      public var selected:MovieClip;
      
      protected var m_isSelected:Boolean;
      
      override protected function wrapStates() : void {
         var _loc1_:MovieClip = null;
         m_states = [up,over,down,disabled,this.selected];
         m_stateControllers = new Vector.<ButtonState>(0);
         for each (_loc1_ in m_states)
         {
            m_stateControllers.push(new ButtonState(_loc1_,m_originalScaleX,this));
         }
      }
      
      public function get isSelected() : Boolean {
         return this.m_isSelected;
      }
      
      public function select() : void {
         if(!this.m_isSelected)
         {
            if(m_tooltip)
            {
               m_tooltip.onTooltipRollOut();
            }
            this.m_isSelected = true;
            this.enabled = this.enabled;
         }
      }
      
      public function unselect() : void {
         if(this.m_isSelected)
         {
            this.m_isSelected = false;
            this.enabled = this.enabled;
         }
      }
      
      override protected function onMousePress(param1:MouseEvent) : void {
         m_mouseDown = true;
         if(!this.m_isSelected)
         {
            super.onMousePress(param1);
         }
      }
      
      override protected function onRelease(param1:MouseEvent) : void {
         m_mouseDown = false;
         if(!this.m_isSelected)
         {
            super.onRelease(param1);
         }
      }
      
      override protected function onRollOverInternal(param1:MouseEvent) : void {
         if(!this.m_isSelected)
         {
            super.onRollOverInternal(param1);
         }
      }
      
      override protected function doRollOut() : void {
         if(!this.m_isSelected)
         {
            super.doRollOut();
         }
      }
      
      override public function click() : void {
         this.onRelease(new MouseEvent(MouseEvent.CLICK));
         this.over.visible = false;
         this.selected.visible = (enabled) && (this.m_isSelected);
         this.up.visible = (enabled) && !this.m_isSelected;
         dispatchEvent(new ZButtonEvent(ZButtonEvent.RELEASE));
      }
      
      override public function gotoAndStop(param1:Object, param2:String=null) : void {
         super.gotoAndStop(param1,param2);
         over.visible = false;
         down.visible = false;
         this.selected.visible = (enabled) && (this.m_isSelected);
         up.visible = (enabled) && !this.m_isSelected;
         disabled.visible = !enabled;
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.selected.visible = (param1) && (this.m_isSelected);
         up.visible = (param1) && !this.m_isSelected;
         disabled.visible = !param1;
         buttonMode = (param1) && !this.m_isSelected;
         useHandCursor = (param1) && !this.m_isSelected;
      }
   }
}
