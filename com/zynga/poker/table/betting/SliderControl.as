package com.zynga.poker.table.betting
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import com.zynga.poker.table.asset.chips.ChipCalc;
   import caurina.transitions.Tweener;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.text.TextFormat;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import com.zynga.poker.PokerStageManager;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldType;
   
   public class SliderControl extends MovieClip
   {
      
      public function SliderControl() {
         super();
         this.gfx = PokerClassProvider.getObject("BetSliderGfx");
         this.gfx.x = 8;
         this.gfx.y = 0;
         addChild(this.gfx);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.bold = true;
         this.betDisplay = new EmbeddedFontTextField();
         this.betDisplay.defaultTextFormat = _loc1_;
         this.betDisplay.fontAlign = TextFormatAlign.RIGHT;
         this.betDisplay.fontName = "Arial";
         this.betDisplay.fontSize = 13;
         this.betDisplay.y = -35;
         this.betDisplay.width = 136;
         this.betDisplay.height = 20;
         this.betDisplay.multiline = false;
         this.betDisplay.selectable = false;
         this.betDisplay.type = TextFieldType.DYNAMIC;
         addChild(this.betDisplay);
         this.betHitter = PokerClassProvider.getObject("BetInputHitter");
         this.betHitter.y = -36;
         addChild(this.betHitter);
         var _loc2_:TextFormat = new TextFormat("Arial",13,0);
         _loc2_.bold = true;
         _loc2_.align = TextFormatAlign.RIGHT;
         this.betInput = new TextField();
         this.betInput.defaultTextFormat = _loc2_;
         this.betInput.y = -35;
         this.betInput.width = 136;
         this.betInput.height = 20;
         this.betInput.multiline = false;
         this.betInput.type = TextFieldType.INPUT;
         this.betInput.maxChars = 13;
         this.betInput.selectable = true;
         addChild(this.betInput);
         if(BetButtonSize.isMaxButtonSize())
         {
            this.betDisplay.x = 121;
            this.betHitter.x = 121;
            this.betInput.x = 121;
         }
         else
         {
            this.betDisplay.x = 91;
            this.betHitter.x = 91;
            this.betInput.x = 91;
         }
         this.handle = PokerClassProvider.getObject("BetSliderHandle");
         this.handle.x = 14;
         this.handle.y = 2;
         addChild(this.handle);
         this.hitter = PokerClassProvider.getObject("BetSliderHitter");
         this.hitter.x = 8;
         this.hitter.y = -8;
         addChild(this.hitter);
         this.hitter.alpha = 0;
         this.betHitter.alpha = 0;
         this.betInput.visible = false;
         this.betDisplay.visible = true;
         this.hitter.buttonMode = true;
         this.hitter.useHandCursor = true;
      }
      
      public var theSlideX:Number = 0;
      
      public var slideMinX:Number = 14;
      
      public var slideMaxX:Number = 121;
      
      public var maxValue:Number;
      
      public var minValue:Number;
      
      public var callValue:Number;
      
      public var blindValue:Number;
      
      public var rangeValue:Number;
      
      public var chipDenomination:Number;
      
      public var betAmount:Number;
      
      public var hitter:MovieClip;
      
      public var adjMinus:BetButton;
      
      public var adjPlus:BetButton;
      
      public var betInput:TextField;
      
      public var betDisplay:EmbeddedFontTextField;
      
      public var handle:MovieClip;
      
      public var gfx:MovieClip;
      
      public var betHitter:MovieClip;
      
      public var raiseAction:Function;
      
      public var bSliderHit:Boolean = false;
      
      private var _parentRef:DisplayObjectContainer;
      
      private var fakeStage:Sprite;
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Number, param5:DisplayObjectContainer) : void {
         var _loc7_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:MovieClip = null;
         var _loc11_:Sprite = null;
         var _loc12_:Object = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Sprite = null;
         var _loc15_:Object = null;
         var _loc16_:* = NaN;
         if(!this.adjMinus)
         {
            _loc10_ = PokerClassProvider.getObject("MinusBtnGfx");
            _loc11_ = new Sprite();
            _loc11_.addChild(_loc10_);
            _loc12_ = new Object();
            _loc12_.gfx = _loc11_;
            _loc12_.theX = 0;
            _loc12_.theY = 0;
            _loc13_ = PokerClassProvider.getObject("PlusBtnGfx");
            _loc14_ = new Sprite();
            _loc14_.addChild(_loc13_);
            _loc15_ = new Object();
            _loc15_.gfx = _loc14_;
            _loc15_.theX = 0;
            _loc15_.theY = 0;
            this.adjMinus = new BetButton(null,"small","",_loc12_,16,0,16,0);
            this.adjPlus = new BetButton(null,"small","",_loc15_,16,0,16,0);
            this.adjMinus.addEventListener(MouseEvent.MOUSE_UP,this.adjMinus.onMouseUp);
            this.adjPlus.addEventListener(MouseEvent.MOUSE_UP,this.adjPlus.onMouseUp);
            this.adjMinus.x = -8;
            this.adjMinus.y = -6;
            this.adjPlus.y = -6;
            addChild(this.adjMinus);
            addChild(this.adjPlus);
         }
         this.adjPlus.x = 127;
         this.hitter.width = 119;
         this.gfx.width = 127;
         this.maxValue = param2;
         this.minValue = param1;
         this.rangeValue = param2 - param1;
         this.callValue = param4;
         this.blindValue = param3;
         var _loc6_:Number = param2 / 100;
         var _loc8_:Number = NaN;
         for each (_loc9_ in ChipCalc.denominations)
         {
            _loc16_ = Math.abs(_loc9_ - _loc6_);
            if((isNaN(_loc8_)) || _loc16_ < _loc8_)
            {
               _loc7_ = _loc9_;
               _loc8_ = _loc16_;
            }
         }
         this.chipDenomination = _loc7_;
         this.initSliderListeners(true);
         this.initBettingInput(true);
         this.initAdjButtons(true);
         this.updateText(param1);
         this._parentRef = param5;
         if(!this.fakeStage)
         {
            this.fakeStage = new Sprite();
            this.fakeStage.graphics.beginFill(16711680,0.0);
            this.fakeStage.graphics.drawRect(-1000,-1000,2000,2000);
            this.fakeStage.graphics.endFill();
         }
      }
      
      public function adjustFill(param1:int=-1) : void {
         var _loc6_:* = NaN;
         var _loc2_:Number = this.mouseX;
         var _loc3_:Number = this.handle.x;
         if(param1 > -1)
         {
            _loc6_ = (param1 - this.minValue) / this.rangeValue;
            _loc2_ = _loc6_ * (this.slideMaxX - this.slideMinX) + this.slideMinX;
         }
         if(_loc2_ < this.slideMinX)
         {
            _loc2_ = this.slideMinX;
         }
         else
         {
            if(_loc2_ > this.slideMaxX || this.rangeValue == 0)
            {
               _loc2_ = this.slideMaxX;
            }
         }
         var _loc4_:Number = _loc2_ / 100;
         var _loc5_:Number = Math.abs(_loc2_ - _loc3_) / 350;
         Tweener.addTween(this.handle,
            {
               "x":_loc2_,
               "time":_loc5_,
               "transition":"easeOutSine",
               "onStart":this.updatePosition,
               "onUpdate":this.updatePosition,
               "onComplete":this.updatePosition,
               "onCompleteParams":[param1]
            });
      }
      
      private function initSliderListeners(param1:Boolean) : void {
         if(param1)
         {
            this.hitter.addEventListener(MouseEvent.MOUSE_DOWN,this.onHitterPressed);
            this.hitter.addEventListener(MouseEvent.MOUSE_UP,this.onHitterReleased);
         }
         else
         {
            if(!param1)
            {
               this.hitter.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHitterPressed);
               this.hitter.removeEventListener(MouseEvent.MOUSE_UP,this.onHitterReleased);
            }
         }
      }
      
      private function onHitterPressed(param1:MouseEvent) : void {
         this.bSliderHit = true;
         this.hitter.addEventListener(Event.ENTER_FRAME,this.onHitterFrame);
         this.fakeStage.addEventListener(MouseEvent.MOUSE_UP,this.onHitterReleased);
         this.fakeStage.addEventListener(MouseEvent.MOUSE_OUT,this.onHitterReleased);
         this._parentRef.addChild(this.fakeStage as DisplayObject);
      }
      
      private function onHitterReleased(param1:MouseEvent=null) : void {
         this._parentRef.removeChild(this.fakeStage as DisplayObject);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_UP,this.onHitterReleased);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitterReleased);
         this.bSliderHit = false;
         this.hitter.removeEventListener(Event.ENTER_FRAME,this.onHitterFrame);
      }
      
      private function onHitterFrame(param1:Event) : void {
         this.adjustFill();
      }
      
      private function updatePosition(param1:int=-1) : void {
         var _loc2_:* = NaN;
         var _loc5_:* = NaN;
         var _loc3_:Number = this.handle.x;
         if(_loc3_ == this.slideMaxX)
         {
            _loc2_ = this.maxValue;
         }
         else
         {
            if(_loc3_ == this.slideMinX)
            {
               _loc2_ = this.minValue;
            }
            else
            {
               _loc5_ = (_loc3_ - this.slideMinX) / (this.slideMaxX - this.slideMinX);
               _loc2_ = _loc5_ * this.rangeValue + this.minValue;
               _loc2_ = Math.round(_loc2_ / this.chipDenomination) * this.chipDenomination;
            }
         }
         if(param1 > 0)
         {
            _loc2_ = param1;
         }
         if(_loc2_ > this.maxValue)
         {
            _loc2_ = this.maxValue;
         }
         if(_loc2_ < this.minValue)
         {
            _loc2_ = this.minValue;
         }
         this.betAmount = _loc2_;
         var _loc4_:String = PokerCurrencyFormatter.numberToCurrency(_loc2_,false);
         this.updateBetDisplay(_loc4_);
         this.updateBetInput(this.betAmount);
      }
      
      private function updateText(param1:Number) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:String = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         if(param1 < this.minValue)
         {
            _loc2_ = this.minValue;
         }
         else
         {
            if(param1 > this.maxValue)
            {
               _loc2_ = this.maxValue;
            }
            else
            {
               _loc2_ = param1;
            }
         }
         if(this.maxValue != this.minValue)
         {
            _loc5_ = (_loc2_ - this.minValue) / this.rangeValue;
            this.handle.x = Math.round(_loc5_ * (this.slideMaxX - this.slideMinX)) + this.slideMinX;
            _loc6_ = Math.round(_loc5_ * this.rangeValue);
            _loc3_ = _loc6_ + this.minValue;
            if(_loc3_ < 0 || (isNaN(_loc3_)))
            {
               _loc3_ = 0;
            }
            this.betAmount = _loc3_;
            _loc4_ = PokerCurrencyFormatter.numberToCurrency(_loc3_,false);
            this.updateBetDisplay(_loc4_);
            this.updateBetInput(this.betAmount);
         }
         else
         {
            this.initSliderListeners(false);
            this.initBettingInput(false);
            this.initAdjButtons(false);
            this.handle.x = this.slideMaxX;
            _loc3_ = this.maxValue;
            this.betAmount = _loc3_;
            _loc4_ = PokerCurrencyFormatter.numberToCurrency(_loc3_,false);
            this.updateBetDisplay(_loc4_);
            this.updateBetInput(this.betAmount);
         }
      }
      
      private function updateBetInput(param1:Number) : void {
         this.betInput.text = param1.toString();
         this.betInput.setSelection(0,this.betInput.length);
      }
      
      private function updateBetDisplay(param1:String) : void {
         var _loc2_:String = param1;
         this.betDisplay.text = _loc2_;
         var _loc3_:TextFormat = new TextFormat();
         if(_loc2_.length > 12)
         {
            _loc3_.size = 10;
            this.betDisplay.y = -34;
         }
         else
         {
            if(_loc2_.length < 12)
            {
               _loc3_.size = 12;
               this.betDisplay.y = -35;
            }
         }
         this.betDisplay.setTextFormat(_loc3_);
      }
      
      public function initBettingInput(param1:Boolean) : void {
         this.betInput.restrict = "0-9";
         this.betHitter.removeEventListener(MouseEvent.MOUSE_UP,this.onBetHitterRelease);
         this.betInput.removeEventListener(FocusEvent.FOCUS_IN,this.setBIFocus);
         this.betInput.removeEventListener(FocusEvent.FOCUS_OUT,this.killBIFocus);
         this.betInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.isEntered);
         this.betHitter.visible = true;
         this.betDisplay.visible = true;
         this.betInput.visible = false;
         this.betInput.setSelection(0,this.betInput.length);
         if(param1)
         {
            this.betHitter.addEventListener(MouseEvent.MOUSE_UP,this.onBetHitterRelease);
            this.betInput.addEventListener(FocusEvent.FOCUS_IN,this.setBIFocus);
            this.betInput.addEventListener(FocusEvent.FOCUS_OUT,this.killBIFocus);
         }
      }
      
      public function onBetHitterRelease(param1:MouseEvent) : void {
         if(PokerStageManager.isFullScreenMode())
         {
            PokerStageManager.hideFullScreenMode();
         }
         this.betHitter.visible = false;
         this.betDisplay.visible = false;
         this.betInput.restrict = "0-9";
         this.betInput.visible = true;
         this.betInput.stage.focus = this.betInput;
      }
      
      private function setBIFocus(param1:FocusEvent) : void {
         if(this.betAmount < 0 || (isNaN(this.betAmount)))
         {
            this.betAmount = 0;
         }
         this.betInput.text = Number(this.betAmount).toString();
         this.betInput.setSelection(0,this.betInput.length);
         this.betInput.addEventListener(KeyboardEvent.KEY_DOWN,this.isEntered);
      }
      
      private function isEntered(param1:KeyboardEvent) : void {
         if(param1.keyCode == 13)
         {
            this.processInput(true);
         }
      }
      
      private function processInput(param1:Boolean) : void {
         this.betInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.isEntered);
         var _loc2_:Number = Number(this.betInput.text);
         if(_loc2_ > this.maxValue)
         {
            _loc2_ = this.maxValue;
         }
         else
         {
            if(_loc2_ < this.minValue)
            {
               _loc2_ = this.minValue;
            }
         }
         this.killBIFocus();
         if(param1)
         {
            this.raiseAction();
         }
      }
      
      public function killBIFocus(param1:FocusEvent=null) : void {
         this.betInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.isEntered);
         this.betHitter.visible = true;
         this.betDisplay.visible = true;
         this.betInput.setSelection(0,this.betInput.length);
         this.betInput.visible = false;
         var _loc2_:Number = Number(this.betInput.text);
         this.betAmount = _loc2_;
         var _loc3_:String = PokerCurrencyFormatter.numberToCurrency(this.betAmount,false);
         this.updateText(this.betAmount);
      }
      
      private function manualAdjust(param1:String) : void {
         if(param1.toString() == "plus")
         {
            this.betAmount = this.betAmount + this.blindValue;
            this.updateText(this.betAmount);
         }
         else
         {
            if(param1.toString() == "minus")
            {
               this.betAmount = this.betAmount - this.blindValue;
               this.updateText(this.betAmount);
            }
         }
      }
      
      public function initAdjButtons(param1:Boolean) : void {
         if(param1)
         {
            this.adjMinus.addEventListener(MouseEvent.CLICK,this.onAdjMinusDown);
            this.adjPlus.addEventListener(MouseEvent.CLICK,this.onAdjPlusDown);
         }
         else
         {
            if(!param1)
            {
               this.adjMinus.removeEventListener(MouseEvent.CLICK,this.onAdjMinusDown);
               this.adjPlus.removeEventListener(MouseEvent.CLICK,this.onAdjPlusDown);
            }
         }
      }
      
      public function onAdjMinusDown(param1:MouseEvent) : void {
         this.manualAdjust("minus");
      }
      
      public function onAdjPlusDown(param1:MouseEvent) : void {
         this.manualAdjust("plus");
      }
      
      public function returnMinReq() : Boolean {
         var _loc1_:* = false;
         if(this.betAmount < this.minValue)
         {
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function setToMin() : void {
         this.betAmount = this.minValue;
         var _loc1_:String = PokerCurrencyFormatter.numberToCurrency(this.betAmount,false);
         this.updateBetDisplay(_loc1_);
         this.updateBetInput(this.betAmount);
      }
   }
}
