package com.zynga.display.Dialog
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import com.zynga.rad.buttons.ZButton;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.DisplayObject;
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.display.GradientType;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;
   import com.zynga.poker.popups.events.PPVEvent;
   
   public class DialogBox extends Sprite
   {
      
      public function DialogBox(param1:DialogSkin, param2:Number=-1, param3:Number=-1, param4:Boolean=false, param5:Boolean=true, param6:Boolean=false) {
         super();
         this.wide = param2;
         this.high = param3;
         this.skin = param1;
         this.origw = param2;
         this.origh = param3;
         this.isPanel = param4;
         this._showBG = param5;
         this._showDarkOverlay = param6;
         this.titleTextField = this.skin.titleItem;
         this.titleTextField.text = "";
         this.bodyTextField = this.skin.bodyItem;
         this.bodyTextField.wordWrap = true;
         addEventListener(MouseEvent.CLICK,this.onFocus);
      }
      
      public static const SIMPLE:Number = 0;
      
      public static const COMPLEX:Number = 1;
      
      public static const AUTOSIZE:Number = -1;
      
      public var type:Number = 0;
      
      public var cancelable:Boolean = true;
      
      public var module:Object;
      
      public var locked:Boolean = false;
      
      public var shown:Boolean = false;
      
      public var modal:Boolean = false;
      
      public var wide:Number;
      
      public var high:Number;
      
      public var layer:DialogLayer;
      
      private var skin:DialogSkin;
      
      private var content:Sprite;
      
      private var titleTextField:TextField;
      
      private var bodyTextField:TextField;
      
      private var origw:Number;
      
      private var origh:Number;
      
      private var buttonIndex:Array;
      
      private var buttonOffset:Number = 0;
      
      private var isPanel:Boolean;
      
      private var _bgColors:Array;
      
      private var _showBG:Boolean;
      
      private var _showDarkOverlay:Boolean;
      
      private var _closeButton:ZButton;
      
      public var hideOnClose:Boolean = true;
      
      protected var _darkOverlay:Sprite;
      
      public function init() : void {
         var _loc14_:MovieClip = null;
         var _loc18_:Rectangle = null;
         var _loc19_:Matrix = null;
         var _loc20_:* = NaN;
         this.content = new Sprite();
         var _loc1_:MovieClip = this.skin.TopLeftCorner.resource;
         var _loc2_:MovieClip = this.skin.TopRightCorner.resource;
         var _loc3_:MovieClip = this.skin.BottomLeftCorner.resource;
         var _loc4_:MovieClip = this.skin.BottomRightCorner.resource;
         var _loc5_:MovieClip = this.skin.LeftBand.resource;
         var _loc6_:MovieClip = this.skin.RightBand.resource;
         var _loc7_:MovieClip = this.skin.TopBand.resource;
         var _loc8_:MovieClip = this.skin.BottomBand.resource;
         var _loc9_:ZButton = this.skin.closeButton;
         var _loc10_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc5_));
         var _loc11_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc6_));
         var _loc12_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc7_));
         var _loc13_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc8_));
         this.titleTextField.y = -Math.round(_loc12_.height / 2) - Math.round(this.titleTextField.height / 2);
         this.titleTextField.width = this.wide;
         if(!(this.type == DialogBox.COMPLEX) && this.module == null)
         {
            this.bodyTextField.y = this.skin.defaultPadding;
            this.bodyTextField.x = this.skin.defaultPadding;
            this.content.addChild(this.bodyTextField);
            this.high = this.high + this.buttonOffset;
         }
         else
         {
            if(this.module)
            {
               this.wide = this.origw;
               this.high = this.origh;
               this.content.addChild(this.module as DisplayObject);
               if(this.high == DialogBox.AUTOSIZE)
               {
                  this.high = this.module.height;
               }
               if(this.wide == DialogBox.AUTOSIZE)
               {
                  this.wide = this.module.width;
               }
               if(this.high < this.buttonOffset + this.skin.defaultPadding)
               {
                  this.high = this.buttonOffset + this.skin.defaultPadding;
               }
               _loc18_ = new Rectangle(0,0,this.wide,this.high);
               this.content.scrollRect = _loc18_;
            }
         }
         if(this.cancelable)
         {
            this._closeButton = PokerClassProvider.getUntypedObject(PokerClassProvider.getClassName(_loc9_)) as ZButton;
            this._closeButton.x = this.wide - this.skin.closeOffset.x;
            this._closeButton.y = -this.skin.closeOffset.y;
            this._closeButton.addEventListener(ZButtonEvent.RELEASE,this.hide);
         }
         if(this._showBG)
         {
            if(this.isPanel)
            {
               _loc19_ = new Matrix();
               _loc19_.createGradientBox(this.wide,this.high,Math.PI / 2,0,0);
               this.content.graphics.beginGradientFill(GradientType.LINEAR,[16777215,14540253],[1,1],[0,255],_loc19_);
               this.content.graphics.drawRoundRect(0,0,this.wide,this.high,10,10);
               this.content.graphics.endFill();
            }
            else
            {
               if(!this.skin.bgBitmap)
               {
                  this.content.graphics.beginFill(this.skin.bgColor,this.skin.bgOpacity);
               }
               else
               {
                  this.content.graphics.beginBitmapFill(this.skin.bgBitmap);
               }
               _loc20_ = 0;
               if(Math.round(this.high) % 2 === 1)
               {
                  _loc20_ = 1;
               }
               this.content.graphics.drawRect(0,-(_loc20_ / 4),this.wide,Math.round(this.high) + _loc20_ / 2);
            }
         }
         if(this._showDarkOverlay)
         {
            this.addDarkOverlay();
         }
         _loc14_ = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc1_));
         _loc14_.x = -_loc10_.width;
         _loc14_.y = -_loc14_.height;
         var _loc15_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc2_));
         _loc15_.x = this.wide - _loc15_.width + _loc11_.width;
         _loc15_.y = -_loc15_.height;
         var _loc16_:* = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc3_));
         _loc16_.x = -_loc16_.width;
         _loc16_.y = this.high;
         var _loc17_:MovieClip = PokerClassProvider.getObject(PokerClassProvider.getClassName(_loc4_));
         _loc17_.x = this.wide;
         _loc17_.y = this.high;
         _loc10_.x = -_loc10_.width;
         _loc11_.x = this.wide;
         _loc12_.y = -_loc12_.height;
         _loc13_.y = this.high;
         _loc12_.x = _loc14_.width - _loc10_.width;
         if(this.skin.LeftBand.skintype == DialogSkin.STRETCH)
         {
            _loc10_.height = this.high;
         }
         else
         {
            _loc10_.graphics.beginBitmapFill(this.makeTileable(_loc10_));
            _loc10_.graphics.drawRect(0,0,_loc10_.width,this.high);
         }
         if(this.skin.RightBand.skintype == DialogSkin.STRETCH)
         {
            _loc11_.height = this.high;
         }
         else
         {
            _loc11_.graphics.beginBitmapFill(this.makeTileable(_loc11_));
            _loc11_.graphics.drawRect(0,0,_loc11_.width,this.high);
         }
         if(this.skin.TopBand.skintype == DialogSkin.STRETCH)
         {
            _loc12_.width = this.wide - _loc12_.x - _loc15_.width + _loc11_.width;
         }
         else
         {
            _loc12_.graphics.beginBitmapFill(this.makeTileable(_loc12_));
            _loc12_.graphics.drawRect(0,0,this.wide,_loc12_.height);
         }
         if(this.skin.BottomBand.skintype == DialogSkin.STRETCH)
         {
            _loc13_.width = this.wide;
         }
         else
         {
            _loc13_.graphics.beginBitmapFill(this.makeTileable(_loc13_));
            _loc13_.graphics.drawRect(0,0,_loc13_.width,this.high);
         }
         filters = this.skin.filterlist;
         this.content.filters = this.skin.contentFilterList;
         addChild(this.content);
         if(!this.isPanel && (this._showBG))
         {
            addChild(_loc10_);
            addChild(_loc11_);
            addChild(_loc12_);
            addChild(_loc13_);
            addChild(_loc14_);
            addChild(_loc15_);
            addChild(_loc16_);
            addChild(_loc17_);
            addChild(this.titleTextField);
         }
         if(this.cancelable)
         {
            addChild(this._closeButton);
         }
         this.layoutButtons();
      }
      
      private function makeTileable(param1:DisplayObject) : BitmapData {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height);
         _loc2_.draw(param1);
         return _loc2_;
      }
      
      private function layoutButtons() : void {
         var _loc2_:String = null;
         var _loc1_:Number = 0;
         for (_loc2_ in this.buttonIndex)
         {
            switch(this.buttonIndex[_loc2_].action)
            {
               case DialogButton.CLOSE:
                  this.buttonIndex[_loc2_].button.addEventListener(MouseEvent.CLICK,this.hide);
                  break;
               case DialogButton.DISABLE:
                  this.buttonIndex[_loc2_].button.addEventListener(MouseEvent.CLICK,this.disable);
                  break;
            }
            
            if(this.buttonIndex[_loc2_].offset == null)
            {
               this.buttonIndex[_loc2_].button.x = this.wide - _loc1_ - this.skin.defaultPadding - this.buttonIndex[_loc2_].button.width;
               this.buttonIndex[_loc2_].button.y = this.high - this.skin.defaultPadding - this.buttonIndex[_loc2_].button.height;
               _loc1_ = _loc1_ + (this.buttonIndex[_loc2_].button.width + this.skin.buttonPadding);
            }
            else
            {
               this.buttonIndex[_loc2_].button.x = this.wide - this.buttonIndex[_loc2_].offset.x;
               this.buttonIndex[_loc2_].button.y = this.high - this.buttonIndex[_loc2_].offset.y;
            }
            addChild(this.buttonIndex[_loc2_].button);
         }
      }
      
      private function onFocus(param1:MouseEvent) : void {
         DialogEvent.quickThrow(DialogEvent.ACTIVE,this);
      }
      
      public function set titleText(param1:String) : void {
         this.titleTextField.text = param1;
      }
      
      public function get titleText() : String {
         return this.titleTextField.htmlText;
      }
      
      public function set bodyText(param1:String) : void {
         if(this.wide == DialogBox.AUTOSIZE)
         {
            this.wide = this.skin.defaultwidth;
         }
         this.bodyTextField.width = this.wide - this.skin.defaultPadding * 2;
         this.bodyTextField.text = param1;
         if(this.high == DialogBox.AUTOSIZE)
         {
            this.bodyTextField.autoSize = TextFieldAutoSize.LEFT;
            this.high = this.bodyTextField.textHeight + this.skin.defaultPadding * 2;
         }
         else
         {
            this.bodyTextField.height = this.high - this.skin.defaultPadding;
         }
      }
      
      protected function addDarkOverlay() : void {
         var _loc1_:Number = 760;
         var _loc2_:Number = 530;
         this._darkOverlay = new Sprite();
         this._darkOverlay.graphics.beginFill(0,0.8);
         this._darkOverlay.graphics.drawRect((this.realWide - _loc1_) / 2,(this.realHigh - _loc2_) / 2,_loc1_,_loc2_);
         this._darkOverlay.graphics.endFill();
         this._darkOverlay.visible = true;
         addChild(this._darkOverlay);
      }
      
      public function get closeButton() : MovieClip {
         return this._closeButton;
      }
      
      public function addButton(param1:DialogButton) : void {
         if(!this.buttonIndex)
         {
            this.buttonIndex = new Array();
         }
         param1.owner = this;
         this.buttonIndex.push(param1);
         this.buttonOffset = param1.button.height + this.skin.defaultPadding;
      }
      
      public function disable(param1:MouseEvent=null) : void {
         mouseChildren = false;
         alpha = 0.5;
      }
      
      public function enable() : void {
         mouseChildren = true;
         alpha = 1;
      }
      
      public function show(param1:Boolean=false) : void {
         if(!this.layer.contains(this))
         {
            this.layer.addChild(this);
         }
         visible = true;
         this.shown = true;
         DialogEvent.quickThrow(DialogEvent.OPEN,this);
         if(param1)
         {
            DialogEvent.quickThrow(DialogEvent.ALONE,this);
         }
         if(this.skin.showEffect != null)
         {
            this.skin.showEffect(this);
         }
      }
      
      public function hide(param1:Event=null, param2:Boolean=false) : void {
         if(!this.hideOnClose)
         {
            dispatchEvent(new PPVEvent(PPVEvent.CLOSE));
            return;
         }
         if(!(this.skin.showEffect == null) && !param2)
         {
            this.skin.hideEffect(this);
         }
         else
         {
            visible = false;
         }
         this.shown = false;
         DialogEvent.quickThrow(DialogEvent.CLOSED,this);
         dispatchEvent(new PPVEvent(PPVEvent.CLOSE));
         if(this.layer.contains(this))
         {
            this.layer.removeChild(this);
         }
      }
      
      public function isolate() : void {
         DialogEvent.quickThrow(DialogEvent.ISOLATE,this);
      }
      
      public function release() : void {
         DialogEvent.quickThrow(DialogEvent.RELEASE,this);
      }
      
      public function clearBackground() : void {
         this.content.graphics.clear();
      }
      
      public function set bgColors(param1:Array) : void {
         if(!this.isPanel)
         {
            return;
         }
         this._bgColors = param1;
         var _loc2_:Matrix = new Matrix();
         _loc2_.createGradientBox(this.wide,this.high,Math.PI / 2,0,0);
         this.content.graphics.clear();
         this.content.graphics.beginGradientFill(GradientType.LINEAR,[this._bgColors[0],this._bgColors[1]],[1,1],[0,255],_loc2_);
         this.content.graphics.drawRoundRect(0,0,this.wide,this.high,10,10);
         this.content.graphics.endFill();
      }
      
      public function get bgColors() : Array {
         if(!this.isPanel)
         {
            return null;
         }
         return this._bgColors;
      }
      
      public function get realWide() : Number {
         if(this.wide > 0)
         {
            return this.wide;
         }
         return width;
      }
      
      public function get realHigh() : Number {
         if(this.high > 0)
         {
            return this.high;
         }
         return height;
      }
   }
}
