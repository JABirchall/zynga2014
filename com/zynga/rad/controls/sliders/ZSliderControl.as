package com.zynga.rad.controls.sliders
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.scrollbars.BaseScrollBar;
   import com.zynga.rad.buttons.ZButton;
   import flash.utils.Timer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.display.DisplayObject;
   
   public dynamic class ZSliderControl extends BaseUI
   {
      
      public function ZSliderControl() {
         super();
         assert(!(this.scrollBar == null),"Slider must include a scrollBar");
         this.init();
      }
      
      private static const BUTTON_HOLD_THRESHOLD:Number = 500;
      
      private static const DEFAULT_MIN_VALUE:Number = 0.0;
      
      private static const DEFAULT_MAX_VALUE:Number = 100.0;
      
      public var scrollBar:BaseScrollBar;
      
      public var minusButton:ZButton;
      
      public var plusButton:ZButton;
      
      protected var _minValue:Number = 0.0;
      
      protected var _maxValue:Number = 100.0;
      
      private var _value:Number = 0.0;
      
      private var _step:Number = 1.0;
      
      private var _delta:Number = 0.0;
      
      private var _buttonTimer:Timer;
      
      private function init() : void {
         this.value = this._minValue;
         this.scrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
      }
      
      override public function destroy() : void {
         if(this.scrollBar)
         {
            this.scrollBar.removeEventListener(Event.CHANGE,this.onScrollBarChange);
            this.scrollBar.destroy();
            this.scrollBar = null;
         }
         if(this.minusButton)
         {
            this.minusButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlButtonDown);
            this.minusButton.removeEventListener(MouseEvent.MOUSE_UP,this.onControlButtonUp);
            this.minusButton = null;
         }
         if(this.plusButton)
         {
            this.plusButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlButtonDown);
            this.plusButton.removeEventListener(MouseEvent.MOUSE_UP,this.onControlButtonUp);
            this.plusButton = null;
         }
         this.stopButtonPressTimer();
         super.destroy();
      }
      
      public function setControlButtons(param1:ZButton, param2:ZButton) : void {
         this.minusButton = param1;
         this.plusButton = param2;
         if(param1)
         {
            param1.mouseChildren = false;
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlButtonDown,false,0,true);
            param1.addEventListener(MouseEvent.MOUSE_UP,this.onControlButtonUp,false,0,true);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.onControlButtonUp,false,0,true);
         }
         if(param2)
         {
            param2.mouseChildren = false;
            param2.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlButtonDown,false,0,true);
            param2.addEventListener(MouseEvent.MOUSE_UP,this.onControlButtonUp,false,0,true);
            param2.addEventListener(MouseEvent.MOUSE_OUT,this.onControlButtonUp,false,0,true);
         }
      }
      
      public function set value(param1:Number) : void {
         var param1:Number = Math.round(param1 / this.step) * this.step;
         if(param1 == this.value)
         {
            return;
         }
         if(rtl == BaseUI.BIDI_RTL)
         {
            param1 = this._maxValue - param1;
         }
         this._value = this.clamp(param1,this._minValue,this._maxValue);
         this.updateSliderButtonPosition();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get value() : Number {
         if(rtl == BaseUI.BIDI_RTL)
         {
            return this._maxValue - this._value;
         }
         return this._value;
      }
      
      public function set step(param1:Number) : void {
         this._step = param1;
      }
      
      public function get step() : Number {
         if(rtl == BaseUI.BIDI_RTL)
         {
            return this._step * -1;
         }
         return this._step;
      }
      
      public function set minValue(param1:Number) : void {
         this._minValue = param1;
         this.updateSliderButtonPosition();
      }
      
      public function get minValue() : Number {
         return this._minValue;
      }
      
      public function set maxValue(param1:Number) : void {
         this._maxValue = param1;
         this.updateSliderButtonPosition();
      }
      
      public function get maxValue() : Number {
         return this._maxValue;
      }
      
      protected function clamp(param1:Number, param2:Number, param3:Number) : Number {
         var param1:Number = Math.max(param2,param1);
         param1 = Math.min(param1,param3);
         return param1;
      }
      
      protected function updateSliderButtonPosition() : void {
         this.scrollBar.position = (this.value - this._minValue) / (this.maxValue - this._minValue);
      }
      
      private function stopButtonPressTimer() : void {
         if(this._buttonTimer)
         {
            this._buttonTimer.removeEventListener(TimerEvent.TIMER,this.onControlButtonHold);
            this._buttonTimer.stop();
            this._buttonTimer = null;
         }
      }
      
      private function onScrollBarChange(param1:Event) : void {
         this.value = (this._maxValue - this._minValue) * this.scrollBar.position + this._minValue;
      }
      
      private function onControlButtonUpdate(param1:Event) : void {
         this.value = this.value + this._delta;
      }
      
      private function onControlButtonHold(param1:Event) : void {
         this.stopButtonPressTimer();
         addEventListener(Event.ENTER_FRAME,this.onControlButtonUpdate);
      }
      
      private function onControlButtonDown(param1:Event) : void {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_)
         {
            if(_loc2_ == this.minusButton)
            {
               this._delta = this.getNegativeDelta();
            }
            else
            {
               this._delta = this.getPositiveDelta();
            }
         }
         this.value = this.value + this._delta;
         this.stopButtonPressTimer();
         this._buttonTimer = new Timer(BUTTON_HOLD_THRESHOLD);
         this._buttonTimer.addEventListener(TimerEvent.TIMER,this.onControlButtonHold,false,0,true);
         this._buttonTimer.start();
      }
      
      protected function getNegativeDelta() : Number {
         return -this.step;
      }
      
      protected function getPositiveDelta() : Number {
         return this.step;
      }
      
      private function onControlButtonUp(param1:Event) : void {
         this._delta = 0.0;
         this.stopButtonPressTimer();
         removeEventListener(Event.ENTER_FRAME,this.onControlButtonUpdate);
      }
   }
}
