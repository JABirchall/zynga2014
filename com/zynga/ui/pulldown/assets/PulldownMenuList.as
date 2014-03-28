package com.zynga.ui.pulldown.assets
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import com.zynga.events.UIComponentEvent;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   import flash.display.GradientType;
   import flash.display.SpreadMethod;
   import com.zynga.text.HtmlTextBox;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class PulldownMenuList extends Sprite
   {
      
      public function PulldownMenuList(param1:Number=100.0, param2:Number=16) {
         this.scrollWellColorArr = new Array(5197647,13027014);
         this.scrollWellAlphaArr = new Array(1,1);
         this.scrollWellRatioArr = new Array(0,255);
         this.scrollHandleColorArr = new Array(9013641,2171169);
         this.scrollHandleAlphaArr = new Array(1,1);
         this.scrollHandleRatioArr = new Array(0,255);
         this.contentArr = new Array();
         this.scrollPane = new Sprite();
         this.scrollMask = new Sprite();
         this.scrollWell = new Sprite();
         this.scrollHandle = new Sprite();
         this.captureMask = new Sprite();
         super();
         this.defaultWidth = param1;
         this.listWidth = this.defaultWidth;
         this.maxViewableItems = param2;
         this.scrollPane.mask = this.scrollMask;
         addChild(this.scrollMask);
         addChild(this.scrollPane);
         addChild(this.scrollWell);
         addChild(this.scrollHandle);
      }
      
      private const LISTITEM_GAP:Number = 0.0;
      
      private const LIST_WIDTH_PADDING:Number = 8.0;
      
      private var scrollWellColorArr:Array;
      
      private var scrollWellAlphaArr:Array;
      
      private var scrollWellRatioArr:Array;
      
      private var scrollWellStrokeColor:int = 2171169;
      
      private var scrollHandleColorArr:Array;
      
      private var scrollHandleAlphaArr:Array;
      
      private var scrollHandleRatioArr:Array;
      
      private var scrollHandleStrokeColor:int = 2171169;
      
      private var contentArr:Array;
      
      public var scrollPane:Sprite;
      
      public var scrollMask:Sprite;
      
      private var scrollWell:Sprite;
      
      private var scrollHandle:Sprite;
      
      private var captureMask:Sprite;
      
      private var maxViewableItems:Number;
      
      private var defaultWidth:Number;
      
      private var listWidth:Number;
      
      public function set dataProvider(param1:Array) : void {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         this.clearListItems();
         var _loc2_:Number = this.calculateListWidth(param1);
         this.listWidth = _loc2_ < this.defaultWidth?this.defaultWidth + this.LIST_WIDTH_PADDING:_loc2_;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               if((_loc4_) && (_loc4_.hasOwnProperty("label")) && (_loc4_.hasOwnProperty("value")))
               {
                  this.addListItem(_loc4_.label,_loc4_.value,_loc4_.icon);
               }
               _loc3_++;
            }
         }
         if(this.contentArr.length > this.maxViewableItems && !(this.maxViewableItems == -1))
         {
            this.drawScrollMask(this.listWidth,this.scrollPane.height / this.contentArr.length * this.maxViewableItems);
            this.drawScrollWell(this.listWidth,this.scrollPane.height / this.contentArr.length * this.maxViewableItems);
         }
         else
         {
            this.drawScrollMask(this.listWidth,this.scrollPane.height);
         }
         this.captureMask.graphics.clear();
         this.captureMask.graphics.beginFill(0,0.0);
         this.captureMask.graphics.drawRect(0.0,0.0,this.scrollMask.width,this.scrollMask.height);
         this.captureMask.graphics.endFill();
         this.enableListeners();
      }
      
      public function enableListeners() : void {
         this.scrollHandle.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollHandleMouseDown);
         this.scrollHandle.addEventListener(MouseEvent.MOUSE_UP,this.onScrollHandleMouseUp);
         var _loc1_:* = 0;
         while(_loc1_ < this.contentArr.length)
         {
            try
            {
               this.contentArr[_loc1_].enableListeners();
               this.contentArr[_loc1_].addEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onPulldownMenuListCellClick);
            }
            catch(e:Error)
            {
            }
            _loc1_++;
         }
      }
      
      public function disableListeners() : void {
         this.scrollHandle.removeEventListener(MouseEvent.MOUSE_DOWN,this.onScrollHandleMouseDown);
         this.scrollHandle.removeEventListener(MouseEvent.MOUSE_UP,this.onScrollHandleMouseUp);
         var _loc1_:* = 0;
         while(_loc1_ < this.contentArr.length)
         {
            try
            {
               this.contentArr[_loc1_].disableListeners();
               this.contentArr[_loc1_].removeEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onPulldownMenuListCellClick);
               if(this.contentArr[_loc1_].hasEventListener(UIComponentEvent.ON_UICOMPONENT_COMPLETE))
               {
                  this.contentArr[_loc1_].removeEventListener(UIComponentEvent.ON_UICOMPONENT_COMPLETE,this.onMenuListCellBlinkComplete);
               }
            }
            catch(e:Error)
            {
            }
            _loc1_++;
         }
      }
      
      public function refreshList() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.contentArr.length)
         {
            this.contentArr[_loc1_].refresh();
            if((this.contentArr[_loc1_] as PulldownMenuListCell).isSelected)
            {
               this.contentArr[_loc1_].refresh(true);
            }
            _loc1_++;
         }
      }
      
      public function resetSelection(param1:String) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.contentArr.length)
         {
            if(param1 == (this.contentArr[_loc2_] as PulldownMenuListCell).value)
            {
               this.contentArr[_loc2_].isSelected = true;
            }
            else
            {
               this.contentArr[_loc2_].isSelected = false;
            }
            _loc2_++;
         }
      }
      
      public function setSelected(param1:String) : Boolean {
         var _loc2_:* = 0;
         while(_loc2_ < this.contentArr.length)
         {
            if(param1 == this.contentArr[_loc2_].value)
            {
               this.onMenuListSetSelected(new UIComponentEvent(UIComponentEvent.ON_UICOMPONENT_RESET,param1));
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function blinkMenuListCell(param1:String) : void {
         var _loc2_:PulldownMenuListCell = null;
         for each (_loc2_ in this.contentArr)
         {
            if(_loc2_.value == param1)
            {
               _loc2_.blink();
               _loc2_.addEventListener(UIComponentEvent.ON_UICOMPONENT_COMPLETE,this.onMenuListCellBlinkComplete);
               break;
            }
         }
      }
      
      private function clearListItems() : void {
         this.disableListeners();
         var _loc1_:int = this.contentArr.length-1;
         while(_loc1_ > -1)
         {
            this.scrollPane.removeChildAt(_loc1_);
            this.contentArr[_loc1_].destroy();
            this.contentArr[_loc1_] = null;
            this.contentArr.pop();
            _loc1_--;
         }
         this.contentArr = new Array();
      }
      
      private function addListItem(param1:String, param2:String, param3:DisplayObject=null) : void {
         var _loc4_:PulldownMenuListCell = new PulldownMenuListCell(param1,param2,param3);
         _loc4_.setSize(this.listWidth,PulldownMenuListCell.DEFAULT_HEIGHT);
         this.contentArr.push(_loc4_);
         this.contentArr[this.contentArr.length-1].y = (this.contentArr.length-1) * this.contentArr[this.contentArr.length-1].height;
         this.scrollPane.addChild(this.contentArr[this.contentArr.length-1]);
      }
      
      public function getItemLabel(param1:*) : String {
         var _loc3_:PulldownMenuListCell = null;
         var _loc2_:* = "";
         if(this.contentArr)
         {
            for each (_loc3_ in this.contentArr)
            {
               if(_loc3_.value == param1)
               {
                  _loc2_ = _loc3_.label;
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      private function drawScrollMask(param1:Number, param2:Number) : void {
         this.scrollMask.graphics.clear();
         this.scrollMask.graphics.beginFill(65280,1);
         this.scrollMask.graphics.drawRect(0.0,0.0,param1,param2);
         this.scrollMask.graphics.endFill();
      }
      
      private function drawScrollWell(param1:Number, param2:Number) : void {
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(16,param2,-180 * Math.PI / 180);
         this.scrollWell.graphics.clear();
         this.scrollWell.graphics.lineStyle(1,this.scrollWellStrokeColor,1,true,LineScaleMode.NONE,CapsStyle.NONE,JointStyle.MITER);
         this.scrollWell.graphics.beginGradientFill(GradientType.LINEAR,this.scrollWellColorArr,this.scrollWellAlphaArr,this.scrollWellRatioArr,_loc3_);
         this.scrollWell.graphics.drawRect(param1 - 16,0.0,16,param2);
         this.scrollWell.graphics.endFill();
         this.drawScrollHandle(param1 - 16,0.0,16,this.scrollMask.height - (this.contentArr.length - this.maxViewableItems) * PulldownMenuListCell.DEFAULT_HEIGHT);
      }
      
      private function drawScrollHandle(param1:Number, param2:Number, param3:Number, param4:Number) : void {
         var _loc5_:Matrix = new Matrix();
         _loc5_.createGradientBox(param3,param4,-180 * Math.PI / 180);
         this.scrollHandle.graphics.clear();
         this.scrollHandle.graphics.lineStyle(1,this.scrollHandleStrokeColor,1,true,LineScaleMode.NONE,CapsStyle.NONE,JointStyle.MITER);
         this.scrollHandle.graphics.beginGradientFill(GradientType.LINEAR,this.scrollHandleColorArr,this.scrollHandleAlphaArr,this.scrollHandleRatioArr,_loc5_,SpreadMethod.REFLECT);
         this.scrollHandle.graphics.drawRoundRect(param1,param2,param3,param4,6,6);
         this.scrollHandle.graphics.endFill();
         this.scrollHandle.buttonMode = true;
      }
      
      private function calculateListWidth(param1:Array) : Number {
         var _loc4_:HtmlTextBox = null;
         var _loc5_:TextFormat = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc8_:* = NaN;
         var _loc2_:Number = this.defaultWidth;
         if(param1)
         {
            _loc4_ = new HtmlTextBox("Arial","",12,0,"left",true,false);
            _loc5_ = new TextFormat("Arial",12,0,null,null,null,null,null,TextFormatAlign.LEFT);
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc7_ = param1[_loc6_];
               if((_loc7_) && (_loc7_.hasOwnProperty("label")))
               {
                  _loc4_.tf.text = _loc7_.label;
                  _loc4_.tf.setTextFormat(_loc5_);
                  _loc8_ = _loc4_.width;
                  if(_loc8_ > _loc2_)
                  {
                     _loc2_ = _loc8_;
                  }
               }
               _loc6_++;
            }
         }
         var _loc3_:Number = this.listWidth;
         return _loc3_;
      }
      
      private function onHandleScroll(param1:Event) : void {
         this.scrollPane.y = -this.scrollHandle.y;
      }
      
      private function onScrollHandleMouseDown(param1:MouseEvent) : void {
         this.scrollHandle.startDrag(false,new Rectangle(0.0,0.0,0.0,this.scrollWell.height - this.scrollHandle.height));
         addChild(this.captureMask);
         this.captureMask.addEventListener(MouseEvent.MOUSE_UP,this.onScrollHandleMouseUp);
         this.captureMask.addEventListener(MouseEvent.MOUSE_OUT,this.onScrollHandleMouseUp);
         addEventListener(Event.ENTER_FRAME,this.onHandleScroll);
         dispatchEvent(new Event(Event.SCROLL));
      }
      
      private function onScrollHandleMouseUp(param1:MouseEvent) : void {
         this.scrollHandle.stopDrag();
         removeChild(this.captureMask);
         this.captureMask.removeEventListener(MouseEvent.MOUSE_UP,this.onScrollHandleMouseUp);
         this.captureMask.removeEventListener(MouseEvent.MOUSE_OUT,this.onScrollHandleMouseUp);
         removeEventListener(Event.ENTER_FRAME,this.onHandleScroll);
      }
      
      private function onPulldownMenuListCellClick(param1:UIComponentEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onMenuListCellBlinkComplete(param1:UIComponentEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onMenuListSetSelected(param1:UIComponentEvent) : void {
         dispatchEvent(param1);
      }
      
      public function destroy() : void {
         removeChild(this.scrollMask);
         removeChild(this.scrollPane);
         removeChild(this.scrollWell);
         removeChild(this.scrollHandle);
         try
         {
            removeChild(this.captureMask);
            this.captureMask.removeEventListener(MouseEvent.MOUSE_UP,this.onScrollHandleMouseUp);
            this.captureMask.removeEventListener(MouseEvent.MOUSE_OUT,this.onScrollHandleMouseUp);
            removeEventListener(Event.ENTER_FRAME,this.onHandleScroll);
         }
         catch(e:Error)
         {
         }
         this.clearListItems();
         this.contentArr = null;
         this.scrollPane = null;
         this.scrollMask = null;
         this.scrollWell = null;
         this.scrollHandle = null;
         this.captureMask = null;
      }
   }
}
