package com.zynga.rad.buttons
{
   import __AS3__.vec.*;
   
   public class TabGroup extends Object
   {
      
      public function TabGroup(... rest) {
         var _loc2_:ZSelectableButton = null;
         this.m_tabs = new Vector.<ZSelectableButton>(0);
         super();
         for each (_loc2_ in rest)
         {
            _loc2_.addEventListener(ZButtonEvent.RELEASE,this.onTabRelease);
            this.m_tabs.push(_loc2_);
         }
         if(this.m_tabs.length > 0)
         {
            this.m_tabs[0].click();
            this.m_selectedTab = this.m_tabs[0];
         }
      }
      
      private var m_tabs:Vector.<ZSelectableButton>;
      
      private var m_selectedTab:ZSelectableButton;
      
      private var m_enabled:Boolean = true;
      
      public function addTab(param1:ZSelectableButton) : void {
         param1.addEventListener(ZButtonEvent.RELEASE,this.onTabRelease);
         this.m_tabs.push(param1);
         if(this.m_tabs.length == 1)
         {
            this.selectTab(this.m_tabs[0]);
            this.m_selectedTab = this.m_tabs[0];
         }
      }
      
      public function removeTab(param1:ZSelectableButton) : void {
         var _loc2_:int = this.m_tabs.indexOf(param1);
         if(_loc2_ >= 0)
         {
            param1.removeEventListener(ZButtonEvent.RELEASE,this.onTabRelease);
            this.m_tabs.splice(_loc2_,1);
         }
         if(param1 == this.m_selectedTab)
         {
            this.selectTab(this.m_tabs[0]);
            this.m_selectedTab = this.m_tabs[0];
         }
      }
      
      private function onTabRelease(param1:ZButtonEvent) : void {
         var _loc2_:ZSelectableButton = ZSelectableButton(param1.target);
         this.m_selectedTab = _loc2_;
         this.selectTab(_loc2_);
      }
      
      public function selectTabByIndex(param1:int) : void {
         if(param1 < this.m_tabs.length)
         {
            this.m_tabs[param1].click();
         }
      }
      
      public function selectTab(param1:ZSelectableButton) : void {
         var _loc2_:ZSelectableButton = null;
         for each (_loc2_ in this.m_tabs)
         {
            if(_loc2_ == param1)
            {
               _loc2_.select();
            }
            else
            {
               _loc2_.unselect();
            }
         }
      }
      
      public function destroy() : void {
         var _loc1_:ZSelectableButton = null;
         for each (_loc1_ in this.m_tabs)
         {
            _loc1_.removeEventListener(ZButtonEvent.RELEASE,this.onTabRelease);
         }
         this.m_tabs.length = 0;
      }
      
      public function get tabs() : Vector.<ZSelectableButton> {
         return this.m_tabs;
      }
      
      public function get selectedTab() : ZSelectableButton {
         return this.m_selectedTab;
      }
      
      public function set enabled(param1:Boolean) : void {
         var _loc2_:ZSelectableButton = null;
         this.m_enabled = param1;
         for each (_loc2_ in this.m_tabs)
         {
            _loc2_.enabled = this.m_enabled;
         }
      }
      
      public function get enabled() : Boolean {
         return this.m_enabled;
      }
   }
}
