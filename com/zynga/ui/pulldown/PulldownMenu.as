package com.zynga.ui.pulldown
{
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import com.zynga.text.HtmlTextBox;
   import flash.text.TextFormat;
   import com.zynga.ui.pulldown.assets.PulldownMenuList;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import com.zynga.events.UIComponentEvent;
   import flash.events.Event;
   import flash.display.GradientType;
   import flash.display.LineScaleMode;
   import caurina.transitions.Tweener;
   import flash.filters.DropShadowFilter;
   import flash.filters.BitmapFilterQuality;
   import com.zynga.format.StringUtility;
   import flash.text.TextFormatAlign;
   
   public class PulldownMenu extends Sprite
   {
      
      public function PulldownMenu(param1:Number, param2:Number, param3:int=-1, param4:DisplayObjectContainer=null) {
         this.buttonObj = new Sprite();
         this.buttonObjColorArrNormal = new Array(13290186,11908533,14803425,14803425);
         this.buttonObjAlphaArrNormal = new Array(1,1,1,1);
         this.buttonObjRatioArrNormal = new Array(0,127,128,255);
         this.buttonObjColorArrSelected = new Array(24480,14174,11855);
         this.buttonObjAlphaArrSelected = new Array(1,1,1);
         this.buttonObjRatioArrSelected = new Array(0,178,255);
         this.buttonObjMatrix = new Matrix();
         this.buttonObjLabelFormatNormal = new TextFormat("Main",12,0,null,null,null,null,null,TextFormatAlign.LEFT);
         this.buttonObjLabelFormatSelected = new TextFormat("Main",12,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.buttonObjArrow = new Sprite();
         this.menuListDropShadow = new Sprite();
         this.menuListMask = new Sprite();
         this.menuListDropShadowMask = new Sprite();
         this._parentClickMask = new Sprite();
         super();
         this._width = param1;
         this._height = param2;
         this.maxViewableItems = param3;
         this._parent = param4;
         this.setup();
         this.setupListeners();
      }
      
      public static const MAX_VIEWABLE_ITEMS_ALL:int = -1;
      
      public const LISTSTATE_OPEN:int = 0;
      
      public const LISTSTATE_CLOSED:int = 1;
      
      private var buttonObj:Sprite;
      
      private var buttonObjColorArrNormal:Array;
      
      private var buttonObjAlphaArrNormal:Array;
      
      private var buttonObjRatioArrNormal:Array;
      
      private var buttonObjStrokeColorNormal:int = 11119017;
      
      private var buttonObjColorArrSelected:Array;
      
      private var buttonObjAlphaArrSelected:Array;
      
      private var buttonObjRatioArrSelected:Array;
      
      private var buttonObjStrokeColorSelected:int = 78676;
      
      private var buttonObjMatrix:Matrix;
      
      private var buttonObjLabel:HtmlTextBox;
      
      private var buttonObjLabelFormatNormal:TextFormat;
      
      private var buttonObjLabelFormatSelected:TextFormat;
      
      private var buttonObjArrow:Sprite;
      
      private var buttonObjArrowColorNormal:int = 0;
      
      private var buttonObjArrowColorSelected:int = 16777215;
      
      private var menuList:PulldownMenuList;
      
      private var menuListDropShadow:Sprite;
      
      private var menuListMask:Sprite;
      
      private var menuListDropShadowMask:Sprite;
      
      private var listState:int = 1;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var maxViewableItems:int;
      
      private var _parent:DisplayObjectContainer;
      
      private var _parentClickMask:Sprite;
      
      private function setup() : void {
         this.menuList = new PulldownMenuList(this._width,this.maxViewableItems);
         addChild(this.menuListDropShadowMask);
         addChild(this.menuListDropShadow);
         addChild(this.menuListMask);
         addChild(this.menuList);
         this.draw();
         this.buttonObj.buttonMode = true;
         this.buttonObj.addChild(this.buttonObjArrow);
         addChild(this.buttonObj);
      }
      
      private function setupListeners() : void {
         this.buttonObj.addEventListener(MouseEvent.CLICK,this.onButtonObjMouseClick);
         this.menuList.addEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onMenuListCellClick);
         this.menuList.addEventListener(UIComponentEvent.ON_UICOMPONENT_COMPLETE,this.onMenuListCellBlinkComplete);
         this.menuList.addEventListener(UIComponentEvent.ON_UICOMPONENT_RESET,this.onMenuListSetSelected);
         this.menuList.addEventListener(Event.SCROLL,this.onMenuListScrollBarClick);
      }
      
      public function set dataProvider(param1:Array) : void {
         if(param1 == null)
         {
            return;
         }
         this.menuList.dataProvider = param1;
         if(this.menuList.width > this.buttonObj.width)
         {
            this.menuList.x = -(this.menuList.width - this.buttonObj.width);
         }
         this.menuList.y = -this.menuList.height;
         this.menuListMask.graphics.clear();
         this.menuListMask.graphics.beginFill(0,1);
         this.menuListMask.graphics.drawRect(0.0,0.0,this.menuList.width,this.menuList.scrollMask.height);
         this.menuListMask.graphics.endFill();
         this.menuListMask.x = this.menuList.x;
         this.menuListMask.y = this.buttonObj.y + this.buttonObj.height;
         this.menuListDropShadow.graphics.clear();
         this.menuListDropShadow.graphics.beginFill(0,1);
         this.menuListDropShadow.graphics.drawRect(0.0,0.0,this.menuList.width,this.menuList.scrollMask.height);
         this.menuListDropShadow.graphics.endFill();
         this.menuListDropShadow.x = this.menuList.x;
         this.menuListDropShadow.y = this.menuList.y;
         this.menuListDropShadowMask.graphics.clear();
         this.menuListDropShadowMask.graphics.beginFill(0,1);
         this.menuListDropShadowMask.graphics.drawRect(0.0,0.0,this.menuList.width,this.menuList.scrollMask.height);
         this.menuListDropShadowMask.graphics.endFill();
         this.menuListDropShadowMask.x = this.menuList.x;
         this.menuListDropShadowMask.y = this.buttonObj.y + this.buttonObj.height;
         this.menuListMask.scaleY = 0.0;
         this.menuListDropShadowMask.scaleY = 0.0;
         this.menuList.mask = this.menuListMask;
         this.menuListDropShadow.mask = this.menuListDropShadowMask;
      }
      
      private function draw(param1:Boolean=false) : void {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:TextFormat = null;
         var _loc7_:* = 0;
         if(param1)
         {
            _loc2_ = this.buttonObjColorArrSelected;
            _loc3_ = this.buttonObjAlphaArrSelected;
            _loc4_ = this.buttonObjRatioArrSelected;
            _loc5_ = this.buttonObjStrokeColorSelected;
            _loc6_ = this.buttonObjLabelFormatSelected;
            _loc7_ = this.buttonObjArrowColorSelected;
         }
         else
         {
            _loc2_ = this.buttonObjColorArrNormal;
            _loc3_ = this.buttonObjAlphaArrNormal;
            _loc4_ = this.buttonObjRatioArrNormal;
            _loc5_ = this.buttonObjStrokeColorNormal;
            _loc6_ = this.buttonObjLabelFormatNormal;
            _loc7_ = this.buttonObjArrowColorNormal;
         }
         this.buttonObjMatrix.createGradientBox(this._width,this._height,-90 * Math.PI / 180);
         this.buttonObj.graphics.clear();
         this.buttonObj.graphics.beginGradientFill(GradientType.LINEAR,_loc2_,_loc3_,_loc4_,this.buttonObjMatrix);
         this.buttonObj.graphics.lineStyle(1,_loc5_,1,true,LineScaleMode.NONE);
         this.buttonObj.graphics.drawRoundRect(0.0,0.0,this._width,this._height,6,6);
         if(!this.buttonObjLabel)
         {
            this.buttonObjLabel = new HtmlTextBox("Main","",12,4934475,"left",true,true);
            this.buttonObj.addChild(this.buttonObjLabel);
         }
         this.buttonObjLabel.tf.setTextFormat(_loc6_);
         this.buttonObjLabel.x = 4;
         this.buttonObjArrow.graphics.clear();
         this.buttonObjArrow.graphics.beginFill(_loc7_,1);
         this.buttonObjArrow.graphics.moveTo(-5,-4);
         this.buttonObjArrow.graphics.lineTo(5,-4);
         this.buttonObjArrow.graphics.lineTo(0.0,4);
         this.buttonObjArrow.graphics.lineTo(-5,-4);
         this.buttonObjArrow.graphics.endFill();
         this.buttonObjArrow.x = this._width - 14;
         this.buttonObjArrow.y = this._height / 2;
      }
      
      private function onButtonObjMouseClick(param1:MouseEvent) : void {
         if(Tweener.isTweening(this.buttonObjArrow))
         {
            return;
         }
         if(this.listState == this.LISTSTATE_OPEN)
         {
            this.menuList.disableListeners();
            this.draw();
            Tweener.addTween(this.buttonObjArrow,
               {
                  "rotation":0.0,
                  "time":0.25,
                  "transition":"linear"
               });
            Tweener.addTween(this.menuListMask,
               {
                  "scaleY":0.0,
                  "time":0.25,
                  "transition":"linear"
               });
            Tweener.addTween(this.menuListDropShadowMask,
               {
                  "scaleY":0.0,
                  "time":0.25,
                  "transition":"linear"
               });
            Tweener.addTween(this.menuListDropShadow,
               {
                  "y":-this.menuList.height,
                  "time":0.25,
                  "transition":"linear"
               });
            Tweener.addTween(this.menuList,
               {
                  "y":-this.menuList.height,
                  "time":0.25,
                  "transition":"linear",
                  "onComplete":this.disableFilter
               });
            this.listState = this.LISTSTATE_CLOSED;
         }
         else
         {
            if(this.listState == this.LISTSTATE_CLOSED)
            {
               this.menuList.resetSelection(this.buttonObjLabel.tf.text);
               this.draw(true);
               Tweener.addTween(this.buttonObjArrow,
                  {
                     "rotation":180,
                     "time":0.25,
                     "transition":"linear"
                  });
               Tweener.addTween(this.menuList,
                  {
                     "y":this.buttonObj.height,
                     "time":0.25,
                     "transition":"linear"
                  });
               Tweener.addTween(this.menuListDropShadow,
                  {
                     "y":this.buttonObj.height,
                     "time":0.25,
                     "transition":"linear"
                  });
               Tweener.addTween(this.menuListDropShadowMask,
                  {
                     "scaleY":1,
                     "time":0.25,
                     "transition":"linear"
                  });
               Tweener.addTween(this.menuListMask,
                  {
                     "scaleY":1,
                     "time":0.25,
                     "transition":"linear",
                     "onComplete":this.enableFilter
                  });
               this.menuList.refreshList();
               this.menuList.enableListeners();
               this.listState = this.LISTSTATE_OPEN;
            }
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function enableFilter() : void {
         if(this.menuListDropShadow.filters.length == 0)
         {
            this.menuListDropShadow.filters = [new DropShadowFilter(4,45,0,1,4,4,1,BitmapFilterQuality.HIGH)];
         }
      }
      
      public function disableFilter() : void {
         this.menuListDropShadow.filters = null;
      }
      
      public function setSelected(param1:String) : Boolean {
         if(this.menuList)
         {
            return this.menuList.setSelected(param1);
         }
         return false;
      }
      
      public function close() : void {
         if(Tweener.isTweening(this.buttonObjArrow))
         {
            Tweener.removeTweens(this.buttonObjArrow);
            Tweener.removeTweens(this.menuList);
            Tweener.removeTweens(this.menuListDropShadow);
            Tweener.removeTweens(this.menuListDropShadowMask);
            Tweener.removeTweens(this.menuListMask);
         }
         if(this.listState == this.LISTSTATE_OPEN)
         {
            this.onButtonObjMouseClick(null);
         }
      }
      
      private function onMenuListCellClick(param1:UIComponentEvent) : void {
         this.menuList.disableListeners();
         this.buttonObj.removeEventListener(MouseEvent.CLICK,this.onButtonObjMouseClick);
         this.menuList.blinkMenuListCell(String(param1.params));
         this.buttonObjLabel.tf.text = StringUtility.LimitString(15,this.menuList.getItemLabel(String(param1.params)),"...");
         this.buttonObjLabel.tf.setTextFormat(this.buttonObjLabelFormatSelected);
      }
      
      private function onMenuListCellBlinkComplete(param1:UIComponentEvent) : void {
         this.onButtonObjMouseClick(null);
         this.buttonObj.addEventListener(MouseEvent.CLICK,this.onButtonObjMouseClick);
         dispatchEvent(new UIComponentEvent(UIComponentEvent.ON_UICOMPONENT_CLICK,param1.params));
      }
      
      private function onMenuListSetSelected(param1:UIComponentEvent) : void {
         this.buttonObjLabel.tf.text = this.menuList.getItemLabel(String(param1.params));
         this.buttonObjLabel.tf.setTextFormat(this.buttonObjLabelFormatNormal);
      }
      
      private function onMenuListScrollBarClick(param1:Event) : void {
         dispatchEvent(param1);
      }
      
      public function destroy() : void {
         removeChild(this.menuListDropShadowMask);
         removeChild(this.menuListDropShadow);
         removeChild(this.menuListMask);
         removeChild(this.menuList);
         this.buttonObj.removeChild(this.buttonObjArrow);
         removeChild(this.buttonObj);
         this.buttonObj.removeEventListener(MouseEvent.CLICK,this.onButtonObjMouseClick);
         this.menuList.removeEventListener(UIComponentEvent.ON_UICOMPONENT_CLICK,this.onMenuListCellClick);
         this.menuList.removeEventListener(UIComponentEvent.ON_UICOMPONENT_COMPLETE,this.onMenuListCellBlinkComplete);
         this.menuList.removeEventListener(UIComponentEvent.ON_UICOMPONENT_RESET,this.onMenuListSetSelected);
         this.menuList.removeEventListener(Event.SCROLL,this.onMenuListScrollBarClick);
         this.menuList.destroy();
         this.buttonObj = null;
         this.buttonObjLabel = null;
         this.buttonObjArrow = null;
         this.menuList = null;
         this.menuListDropShadow = null;
         this.menuListMask = null;
         this.menuListDropShadowMask = null;
      }
   }
}
