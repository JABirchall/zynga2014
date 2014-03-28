package com.zynga.rad.lists
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.buttons.ZToggleButton;
   import com.zynga.rad.containers.ZContainer;
   import com.zynga.rad.buttons.TabGroup;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import com.zynga.rad.buttons.ZButtonEvent;
   import com.zynga.rad.RadManager;
   import com.zynga.rad.util.ZuiUtil;
   import com.zynga.rad.buttons.ZButton;
   import com.zynga.rad.buttons.ZSelectableButton;
   
   public class ZComboBox extends BaseUI implements ILayout
   {
      
      public function ZComboBox() {
         this.m_group = new TabGroup();
         super();
         ZuiUtil.setNamedInstances(this);
         this.button.addEventListener(ZButtonEvent.RELEASE,this.onListToggle);
         removeChild(this.listContainer);
         this.m_originalListPosition = new Point(this.listContainer.x,this.listContainer.y);
         if(!(RadManager.instance.config == null) && !(RadManager.instance.config.stage == null))
         {
            RadManager.instance.config.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageRelease,false,0,true);
         }
      }
      
      public var button:ZToggleButton;
      
      public var list:VStackList;
      
      public var listContainer:ZContainer;
      
      private var m_group:TabGroup;
      
      private var m_originalListPosition:Point;
      
      private function onStageRelease(param1:MouseEvent) : void {
         if(!this.listContainer.parent)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         while(_loc2_ != null)
         {
            if(_loc2_ == this)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.button.click();
      }
      
      private function onListToggle(param1:ZButtonEvent) : void {
         var _loc2_:Point = null;
         if(this.button.isToggled)
         {
            if(RadManager.instance.config.stage != null)
            {
               _loc2_ = ZuiUtil.convertCoordinateSpace(this,RadManager.instance.config.stage,this.m_originalListPosition);
               this.listContainer.x = _loc2_.x;
               this.listContainer.y = _loc2_.y;
               RadManager.instance.config.stage.addChild(this.listContainer);
            }
         }
         else
         {
            if(this.listContainer.parent)
            {
               this.listContainer.parent.removeChild(this.listContainer);
            }
         }
      }
      
      public function addItem(param1:ZButton) : void {
         param1.addEventListener(ZButtonEvent.RELEASE,this.onItemSelected);
         this.m_group.addTab(param1 as ZSelectableButton);
         this.list.addItem(param1);
         this.doLayout();
      }
      
      public function addItems(param1:Array) : void {
         var _loc2_:ZButton = null;
         for each (_loc2_ in param1)
         {
            this.m_group.addTab(_loc2_ as ZSelectableButton);
            this.list.addItem(_loc2_);
         }
         this.doLayout();
      }
      
      public function removeItem(param1:ZButton) : void {
         this.m_group.removeTab(param1 as ZSelectableButton);
         this.list.removeItem(param1);
         this.doLayout();
      }
      
      public function clear() : void {
         this.m_group.destroy();
         this.m_group = new TabGroup();
         this.list.clear();
         this.doLayout();
      }
      
      public function doLayout() : void {
         ZuiUtil.doAllLayout(this);
         this.listContainer.doLayout();
      }
      
      private function onItemSelected(param1:ZButtonEvent) : void {
         if(this.button.isToggled)
         {
            this.button.click();
         }
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.button.enabled = m_enabled;
      }
   }
}
