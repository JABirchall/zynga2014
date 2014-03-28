package com.zynga.rad.lists
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.buttons.ZButton;
   import flash.display.MovieClip;
   import com.zynga.rad.scrollbars.BaseScrollBar;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.display.DisplayObject;
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import com.zynga.rad.RadManager;
   import flash.external.ExternalInterface;
   
   public dynamic class GridSkipList extends BaseUI
   {
      
      public function GridSkipList() {
         this.m_items = [];
         this.m_externalItems = [];
         this.m_displayedItems = [];
         this.m_arrowPos = new Point();
         super();
         this.m_width = 6;
         this.m_height = 2;
         this.m_slotRegistrationPoint = SLOT_REGISTRATION_UPPER_LEFT;
      }
      
      private static const MOUSE_WHEEL_DELTA:Number = 0.01;
      
      public static const SLOT_REGISTRATION_UPPER_LEFT:Number = 0;
      
      public static const SLOT_REGISTRATION_CENTER:Number = 1;
      
      protected var m_width:int;
      
      protected var m_height:int;
      
      protected var m_items:Array;
      
      protected var m_externalItems:Array;
      
      protected var m_displayedItems:Array;
      
      protected var m_currentIndex:int = -1;
      
      protected var m_scrollRightButton:ZButton;
      
      protected var m_scrollLeftButton:ZButton;
      
      protected var m_pageRightButton:ZButton;
      
      protected var m_pageLeftButton:ZButton;
      
      protected var m_gotoEndButton:ZButton;
      
      protected var m_gotoStartButton:ZButton;
      
      protected var m_fixedWidth:Number = 0;
      
      protected var m_fixedHeight:Number = 0;
      
      protected var m_horizDisplay:Boolean = true;
      
      protected var m_displayEmpties:Boolean = false;
      
      protected var m_forceScrollButtonVisible:Boolean = false;
      
      protected var m_showDisabledButtons:Boolean = true;
      
      protected var m_isScrollingLeft:Boolean = false;
      
      protected var m_isScrollingRight:Boolean = false;
      
      public var backing:MovieClip;
      
      private var m_scrollBar:BaseScrollBar;
      
      protected var m_slotRegistrationPoint:Number = 0;
      
      protected var m_autoScaleVert:Boolean = true;
      
      protected var m_fixedSpacingX:Number = 5;
      
      protected var m_fixedSpacingY:Number = 5;
      
      protected var m_arrowPos:Point;
      
      public function setRegPoint(param1:Number) : void {
         this.m_slotRegistrationPoint = param1;
      }
      
      public function init() : void {
         if((this.backing) && (this.backing.parent))
         {
            this.m_fixedWidth = this.backing.width;
            this.m_fixedHeight = this.backing.height;
            this.backing.alpha = 0.5;
            this.backing.parent.removeChild(this.backing);
            this.backing = null;
         }
      }
      
      public function postSetData() : void {
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle {
         return super.getBounds(param1);
      }
      
      public function get currentIndex() : int {
         return this.m_currentIndex;
      }
      
      protected function destroySlot(param1:DisplayObject, param2:Boolean=true) : void {
         removeChild(param1);
      }
      
      public function set displayEmpties(param1:Boolean) : void {
         this.m_displayEmpties = param1;
      }
      
      public function seekToItemByListItem(param1:ListItem) : void {
         var _loc2_:int = this.m_items.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.currentIndex = Math.floor(_loc2_ / this.m_height);
         }
      }
      
      public function get showDisabledButtons() : Boolean {
         return this.m_showDisabledButtons;
      }
      
      public function set showDisabledButtons(param1:Boolean) : void {
         this.m_showDisabledButtons = param1;
         this.updateButtonsEnabled();
      }
      
      public function set currentIndex(param1:int) : void {
         var param1:int = Math.min(param1,this.m_items.length - this.m_width * this.m_height);
         this.m_currentIndex = param1;
         this.setSize(this.m_width,this.m_height);
      }
      
      public function get items() : Array {
         var _loc1_:ListItem = null;
         this.m_externalItems.length = 0;
         for each (_loc1_ in this.m_items)
         {
            if(_loc1_.item)
            {
               this.m_externalItems.push(_loc1_.item);
            }
         }
         return this.m_externalItems;
      }
      
      public function get displayedItems() : Array {
         var _loc1_:ListItem = null;
         this.m_externalItems.length = 0;
         for each (_loc1_ in this.m_displayedItems)
         {
            if(_loc1_.item)
            {
               this.m_externalItems.push(_loc1_.item);
            }
         }
         return this.m_externalItems;
      }
      
      public function get rawListItems() : Array {
         return this.m_items;
      }
      
      public function setSize(param1:int, param2:int) : void {
         var _loc3_:ListItem = null;
         var _loc4_:* = 0;
         for each (_loc3_ in this.m_displayedItems)
         {
            if(_loc3_.item.parent == this)
            {
               this.destroySlot(_loc3_.item);
            }
         }
         this.m_displayedItems.length = 0;
         if(this.m_horizDisplay)
         {
            if(this.m_currentIndex * param2 + param1 * param2 > this.m_items.length)
            {
               this.m_currentIndex = Math.ceil(this.m_items.length / param2) - param1;
            }
         }
         else
         {
            if(this.m_currentIndex * param1 + param1 * param2 > this.m_items.length)
            {
               this.m_currentIndex = Math.ceil(this.m_items.length / param1) - param2;
            }
         }
         this.m_currentIndex = Math.max(0,this.m_currentIndex);
         if(this.m_horizDisplay)
         {
            _loc4_ = this.m_currentIndex * param2;
            while(_loc4_ < this.m_currentIndex * param2 + param1 * param2 && _loc4_ < this.m_items.length)
            {
               _loc3_ = this.m_items[_loc4_];
               _loc3_.generateItem();
               addChild(_loc3_.item);
               this.m_displayedItems.push(_loc3_);
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = this.m_currentIndex * param1;
            while(_loc4_ < this.m_currentIndex * param1 + param1 * param2 && _loc4_ < this.m_items.length)
            {
               _loc3_ = this.m_items[_loc4_];
               _loc3_.generateItem();
               addChild(_loc3_.item);
               this.m_displayedItems.push(_loc3_);
               _loc4_++;
            }
         }
         this.m_width = param1;
         this.m_height = param2;
         this.updateButtonsEnabled();
         this.updateDisplay();
      }
      
      public function set fixedWidth(param1:Number) : void {
         this.m_fixedWidth = param1;
      }
      
      public function get fixedWidth() : Number {
         return this.m_fixedWidth;
      }
      
      public function set fixedHeight(param1:Number) : void {
         this.m_fixedHeight = param1;
      }
      
      public function get fixedHeight() : Number {
         return this.m_fixedHeight;
      }
      
      public function setFirstLastButtons(param1:ZButton, param2:ZButton) : void {
         this.m_gotoEndButton = param1;
         this.m_gotoStartButton = param2;
         this.m_gotoEndButton.addEventListener(ZButtonEvent.RELEASE,this.onGotoStart);
         this.m_gotoStartButton.addEventListener(ZButtonEvent.RELEASE,this.onGotoEnd);
         this.updateButtonsEnabled();
      }
      
      public function setPageButtons(param1:ZButton, param2:ZButton) : void {
         this.m_pageRightButton = param1;
         this.m_pageLeftButton = param2;
         this.m_pageRightButton.addEventListener(ZButtonEvent.RELEASE,this.onPageRight);
         this.m_pageLeftButton.addEventListener(ZButtonEvent.RELEASE,this.onPageLeft);
         this.updateButtonsEnabled();
      }
      
      public function setScrollButtons(param1:ZButton, param2:ZButton, param3:Boolean=false) : void {
         this.m_scrollRightButton = param1;
         this.m_scrollLeftButton = param2;
         this.m_scrollRightButton.addEventListener(ZButtonEvent.RELEASE,this.onScrollRight);
         this.m_scrollLeftButton.addEventListener(ZButtonEvent.RELEASE,this.onScrollLeft);
         this.m_forceScrollButtonVisible = param3;
         this.updateButtonsEnabled();
      }
      
      public function setScrollBar(param1:BaseScrollBar) : void {
         this.m_scrollBar = param1;
         this.m_scrollBar.addEventListener(Event.CHANGE,this.onScroll);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onFocusIn);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onFocusOut);
      }
      
      private function onFocusIn(param1:MouseEvent) : void {
         RadManager.instance.config.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("onMouseWheel",this.onExternalMouseWheel);
         }
      }
      
      private function onFocusOut(param1:MouseEvent) : void {
         RadManager.instance.config.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("onMouseWheel",null);
            RadManager.instance.config.onRegisterMouseWheelCallback();
         }
      }
      
      protected function onExternalMouseWheel(param1:int) : void {
         this.onMouseWheel(new MouseEvent(MouseEvent.MOUSE_WHEEL,true,false,0,0,null,false,false,false,false,param1));
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void {
         this.m_scrollBar.position = this.m_scrollBar.position - param1.delta * MOUSE_WHEEL_DELTA;
         this.onScroll();
      }
      
      public function removeScrollButtons() : void {
         if((this.m_scrollRightButton) && (this.m_scrollLeftButton))
         {
            this.m_scrollRightButton.enabled = false;
            this.m_scrollRightButton.removeEventListener(ZButtonEvent.RELEASE,this.onScrollRight);
            this.m_scrollLeftButton.enabled = false;
            this.m_scrollLeftButton.removeEventListener(ZButtonEvent.RELEASE,this.onScrollLeft);
            this.m_scrollRightButton = null;
            this.m_scrollLeftButton = null;
         }
         if((this.m_pageRightButton) && (this.m_pageLeftButton))
         {
            this.m_pageRightButton.enabled = false;
            this.m_pageLeftButton.enabled = false;
            this.m_pageRightButton.removeEventListener(ZButtonEvent.RELEASE,this.onPageRight);
            this.m_pageLeftButton.removeEventListener(ZButtonEvent.RELEASE,this.onPageLeft);
            this.m_pageRightButton = null;
            this.m_pageLeftButton = null;
         }
         if((this.m_gotoEndButton) && (this.m_gotoStartButton))
         {
            this.m_gotoEndButton.enabled = false;
            this.m_gotoStartButton.enabled = false;
            this.m_gotoEndButton.removeEventListener(ZButtonEvent.RELEASE,this.onPageRight);
            this.m_gotoStartButton.removeEventListener(ZButtonEvent.RELEASE,this.onPageLeft);
            this.m_gotoEndButton = null;
            this.m_gotoStartButton = null;
         }
      }
      
      public function refreshButtonsEnabled() : void {
         this.updateButtonsEnabled();
      }
      
      protected function updateButtonsEnabled() : void {
         var _loc2_:* = false;
         var _loc1_:Boolean = this.m_currentIndex > 0 && (m_enabled);
         if(this.m_horizDisplay)
         {
            _loc2_ = this.m_items.length - this.m_currentIndex * this.m_height > this.m_width * this.m_height && (m_enabled);
         }
         else
         {
            _loc2_ = this.m_items.length - this.m_currentIndex * this.m_width > this.m_width * this.m_height && (m_enabled);
         }
         if((this.m_scrollLeftButton) && (this.m_scrollRightButton))
         {
            this.m_scrollLeftButton.enabled = _loc1_;
            this.m_scrollRightButton.enabled = _loc2_;
            if(!this.showDisabledButtons)
            {
               this.m_scrollLeftButton.visible = _loc1_;
               this.m_scrollRightButton.visible = _loc2_;
            }
         }
         if((this.m_pageLeftButton) && (this.m_pageRightButton))
         {
            this.m_pageLeftButton.enabled = _loc1_;
            this.m_pageRightButton.enabled = _loc2_;
            if(!this.showDisabledButtons)
            {
               this.m_pageLeftButton.visible = _loc1_;
               this.m_pageRightButton.visible = _loc2_;
            }
         }
         if((this.m_gotoStartButton) && (this.m_gotoEndButton))
         {
            this.m_gotoStartButton.enabled = _loc1_;
            this.m_gotoEndButton.enabled = _loc2_;
         }
         if(this.m_scrollBar)
         {
            this.m_scrollBar.position = this.m_currentIndex / (this.m_items.length - (this.m_horizDisplay?this.m_width:this.m_height));
         }
      }
      
      public function forceStartAtIndex(param1:int) : void {
         this.m_currentIndex = param1;
      }
      
      public function clear(param1:Boolean=true) : void {
         var _loc2_:ListItem = null;
         for each (_loc2_ in this.m_displayedItems)
         {
            if((_loc2_.item.parent) && _loc2_.item.parent == this)
            {
               this.destroySlot(_loc2_.item);
            }
         }
         if(param1)
         {
            for each (_loc2_ in this.m_displayedItems)
            {
               _loc2_.destroy();
            }
         }
         this.m_items.length = 0;
         this.m_displayedItems.length = 0;
         this.m_currentIndex = 0;
         this.updateButtonsEnabled();
      }
      
      public function onScroll(param1:Event=null) : void {
         var _loc2_:int = this.m_horizDisplay?this.m_width:this.m_height;
         this.currentIndex = Math.round(this.m_scrollBar.position * (this.m_items.length - _loc2_));
      }
      
      protected function onScrollRight(param1:ZButtonEvent) : void {
         var _loc2_:int = this.m_horizDisplay?this.m_height:this.m_width;
         this.currentIndex = this.m_currentIndex + _loc2_;
      }
      
      protected function onScrollLeft(param1:ZButtonEvent) : void {
         var _loc2_:int = this.m_horizDisplay?this.m_height:this.m_width;
         this.currentIndex = this.m_currentIndex - _loc2_;
      }
      
      protected function onPageRight(param1:ZButtonEvent) : void {
         this.currentIndex = this.m_currentIndex + this.m_width;
      }
      
      protected function onPageLeft(param1:ZButtonEvent) : void {
         this.currentIndex = this.m_currentIndex - this.m_width;
      }
      
      protected function onGotoStart(param1:ZButtonEvent) : void {
         this.currentIndex = 0;
      }
      
      protected function onGotoEnd(param1:ZButtonEvent) : void {
         this.currentIndex = this.m_items.length-1;
      }
      
      public function addItemLazy(param1:Function, param2:Object=null, param3:Boolean=true) : ListItem {
         var _loc4_:ListItem = new ListItem();
         _loc4_.factory = param1;
         _loc4_.data = param2;
         if(this.m_items.length < this.m_width * this.m_height)
         {
            _loc4_.generateItem();
            addChild(_loc4_.item);
            this.m_displayedItems.push(_loc4_);
         }
         this.m_items.push(_loc4_);
         if(param3)
         {
            this.updateButtonsEnabled();
            this.updateDisplay();
         }
         return _loc4_;
      }
      
      public function unshiftItemLazy(param1:Function, param2:Object=null, param3:Boolean=true) : ListItem {
         var _loc5_:ListItem = null;
         var _loc4_:ListItem = new ListItem();
         _loc4_.factory = param1;
         _loc4_.data = param2;
         if(this.m_displayedItems.length >= this.m_width * this.m_height)
         {
            _loc5_ = this.m_displayedItems.pop();
            this.destroySlot(_loc5_.item);
            _loc5_.destroy();
         }
         _loc4_.generateItem();
         addChild(_loc4_.item);
         this.m_displayedItems.unshift(_loc4_);
         this.m_items.unshift(_loc4_);
         if(param3)
         {
            this.updateButtonsEnabled();
            this.updateDisplay();
         }
         return _loc4_;
      }
      
      public function addItemLazyIndex(param1:Function, param2:Object=null, param3:int=0) : ListItem {
         var _loc4_:ListItem = new ListItem();
         _loc4_.factory = param1;
         _loc4_.data = param2;
         _loc4_.generateItem();
         addChild(_loc4_.item);
         this.m_items[param3] = _loc4_;
         this.m_displayedItems[param3] = _loc4_;
         this.updateButtonsEnabled();
         this.updateDisplay();
         return _loc4_;
      }
      
      public function addListItem(param1:ListItem) : void {
         if(this.m_items.length < this.m_width * this.m_height)
         {
            param1.generateItem();
            addChild(param1.item);
            this.m_displayedItems.push(param1);
         }
         this.m_items.push(param1);
         this.updateButtonsEnabled();
         this.updateDisplay();
      }
      
      public function sort(param1:Function) : void {
         if(this.m_displayedItems.length == 0)
         {
            return;
         }
         var _loc2_:ListItem = this.m_displayedItems[0];
         this.m_items.sort(param1);
         var _loc3_:int = this.m_items.indexOf(_loc2_);
         this.currentIndex = _loc3_;
      }
      
      public function findItemIndexByFunction(param1:Function) : int {
         var _loc2_:ListItem = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.m_items.length)
         {
            _loc2_ = this.m_items[_loc3_];
            if(param1(_loc2_.data))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function gotoItemByFindFunction(param1:Function) : ListItem {
         var _loc2_:int = this.findItemIndexByFunction(param1);
         if(_loc2_ >= 0)
         {
            this.currentIndex = _loc2_;
            return this.m_items[_loc2_];
         }
         return null;
      }
      
      public function setFixedSpacing(param1:Number, param2:Number) : void {
         this.m_fixedSpacingX = param1;
         this.m_fixedSpacingY = param2;
      }
      
      public function updateDisplay() : void {
         var _loc1_:Number = this.m_displayedItems.length;
         if(this.m_displayEmpties)
         {
            _loc1_ = this.m_width * this.m_height + 10;
         }
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:ListItem = null;
         _loc7_ = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = this.m_displayedItems[_loc7_];
            if(_loc8_)
            {
               if(this.m_slotRegistrationPoint == SLOT_REGISTRATION_CENTER)
               {
                  _loc5_ = _loc8_.item.width / 2;
                  _loc6_ = _loc8_.item.height / 2;
               }
               _loc8_.item.x = _loc2_ + _loc5_;
               _loc8_.item.y = _loc3_ + _loc6_;
            }
            _loc7_++;
            if(this.m_horizDisplay)
            {
               if(_loc7_ % this.m_width == 0)
               {
                  _loc2_ = 0;
                  if(this.m_fixedWidth > 0)
                  {
                     if(this.m_autoScaleVert)
                     {
                        _loc3_ = _loc3_ + (_loc8_.item.height + this.m_fixedSpacingY);
                     }
                     else
                     {
                        _loc3_ = _loc3_ + this.m_fixedHeight / this.m_height;
                     }
                  }
                  else
                  {
                     _loc3_ = _loc3_ + _loc8_.item.height;
                  }
               }
               else
               {
                  if(this.m_fixedWidth > 0)
                  {
                     if(this.m_fixedSpacingX > 0)
                     {
                        _loc2_ = _loc2_ + (_loc8_.item.width + this.m_fixedSpacingX);
                     }
                     else
                     {
                        _loc2_ = _loc2_ + this.m_fixedWidth / this.m_width;
                     }
                  }
                  else
                  {
                     _loc2_ = _loc2_ + (_loc8_.item.width + this.m_fixedSpacingX);
                  }
               }
            }
            else
            {
               if(_loc7_ % this.m_height == 0)
               {
                  _loc3_ = 0;
                  if(this.m_fixedWidth > 0)
                  {
                     _loc2_ = _loc2_ + this.m_fixedWidth / this.m_width;
                  }
                  else
                  {
                     _loc2_ = _loc2_ + (_loc8_.item.width + this.m_fixedSpacingX);
                  }
               }
               else
               {
                  if(this.m_fixedHeight > 0)
                  {
                     _loc3_ = _loc3_ + this.m_fixedHeight / this.m_height;
                  }
                  else
                  {
                     _loc3_ = _loc3_ + _loc8_.item.height;
                  }
               }
            }
         }
         this.m_arrowPos.y = _loc3_ / 2;
      }
      
      public function get arrowPos() : Point {
         return this.m_arrowPos;
      }
      
      override public function set enabled(param1:Boolean) : void {
         var _loc2_:ListItem = null;
         super.enabled = param1;
         this.updateButtonsEnabled();
         for each (_loc2_ in this.m_displayedItems)
         {
            if(_loc2_.item is BaseUI)
            {
               BaseUI(_loc2_.item).enabled = m_enabled;
            }
         }
      }
      
      public function displayHorizontally() : void {
         this.m_horizDisplay = true;
      }
      
      public function ignoreHorizontalBacking() : void {
         this.m_fixedWidth = 0;
      }
      
      public function displayVertically() : void {
         this.m_horizDisplay = false;
      }
      
      public function get elementsWidth() : int {
         return this.m_width;
      }
      
      public function get elementsHeight() : int {
         return this.m_height;
      }
      
      public function get fixedSpacingX() : Number {
         return this.m_fixedSpacingX;
      }
      
      public function set fixedSpacingX(param1:Number) : void {
         this.m_fixedSpacingX = param1;
      }
      
      public function get fixedSpacingY() : Number {
         return this.m_fixedSpacingY;
      }
      
      public function set fixedSpacingY(param1:Number) : void {
         this.m_fixedSpacingY = param1;
      }
      
      protected function togglePageButtons(param1:Boolean) : void {
         if(this.m_pageLeftButton != null)
         {
            this.m_pageLeftButton.enabled = param1;
         }
         if(this.m_pageRightButton != null)
         {
            this.m_pageRightButton.enabled = param1;
         }
      }
      
      public function getItemIndex(param1:BaseUI) : int {
         var _loc2_:* = 0;
         while(_loc2_ < this.m_items.length)
         {
            if(this.m_items[_loc2_].item == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function isDisplayingHorizontally() : Boolean {
         return this.m_horizDisplay;
      }
   }
}
