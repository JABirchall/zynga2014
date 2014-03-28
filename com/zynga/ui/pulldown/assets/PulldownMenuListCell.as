package com.zynga.ui.pulldown.assets
{
   import flash.display.Sprite;
   import flash.utils.Timer;
   import com.zynga.text.HtmlTextBox;
   import flash.text.TextFormat;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import com.zynga.events.UIComponentEvent;
   import flash.text.TextFormatAlign;
   
   public class PulldownMenuListCell extends Sprite
   {
      
      public function PulldownMenuListCell(param1:String, param2:*, param3:DisplayObject=null) {
         this.buttonObj = new Sprite();
         this.buttonObjLabelFormat = new TextFormat("MainLight",11,this.BUTTON_LABEL_NORMAL_COLOR,null,null,null,null,null,TextFormatAlign.LEFT);
         super();
         this._label = param1;
         this._value = param2;
         this.icon = param3;
         this.setup();
         this.enableListeners();
      }
      
      public static const DEFAULT_WIDTH:Number = 100;
      
      public static const DEFAULT_HEIGHT:Number = 18;
      
      private const BUTTON_NORMAL_COLOR:int = 2171169;
      
      private const BUTTON_OVER_COLOR:int = 14175;
      
      private const BUTTON_LABEL_NORMAL_COLOR:int = 16777215;
      
      private const BUTTON_LABEL_OVER_COLOR:int = 16777215;
      
      private const LABEL_LEFT_MARGIN:Number = 4.0;
      
      private const BLINK_INTERVAL:int = 100;
      
      private const BLINK_REPEAT:int = 1;
      
      private var blinkTimer:Timer;
      
      private var _label:String;
      
      private var _value;
      
      private var _isLocked:Boolean = false;
      
      private var _width:Number = 100.0;
      
      private var _height:Number = 18.0;
      
      private var buttonObj:Sprite;
      
      private var buttonObjLabel:HtmlTextBox;
      
      private var buttonObjLabelFormat:TextFormat;
      
      private var icon:DisplayObject;
      
      public var isSelected:Boolean = false;
      
      private function setup() : void {
         this.buttonObjLabel = new HtmlTextBox(this.buttonObjLabelFormat.font,this._label,int(this.buttonObjLabelFormat.size),int(this.buttonObjLabelFormat.color),this.buttonObjLabelFormat.align,true,false);
         this.buttonObjLabel.tf.setTextFormat(this.buttonObjLabelFormat);
         this.draw();
         addChild(this.buttonObj);
      }
      
      public function enableListeners() : void {
         this.buttonObj.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.buttonObj.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         this.buttonObj.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      public function disableListeners() : void {
         this.buttonObj.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.buttonObj.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         this.buttonObj.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      private function draw(param1:Boolean=false) : void {
         try
         {
            this.buttonObj.removeChild(this.buttonObjLabel);
         }
         catch(e:Error)
         {
         }
         this.buttonObj.graphics.clear();
         this.buttonObj.graphics.beginFill(param1?this.BUTTON_OVER_COLOR:this.BUTTON_NORMAL_COLOR,1);
         this.buttonObj.graphics.drawRect(0.0,0.0,this._width,this._height + 1);
         this.buttonObj.graphics.endFill();
         this.buttonObjLabelFormat.color = param1?this.BUTTON_LABEL_OVER_COLOR:this.BUTTON_LABEL_NORMAL_COLOR;
         this.buttonObjLabel.tf.setTextFormat(this.buttonObjLabelFormat);
         this.buttonObjLabel.x = this.LABEL_LEFT_MARGIN;
         this.buttonObjLabel.y = this._height / 2;
         if(this.icon)
         {
            this.icon.x = this._width - (this.icon.width + 20);
            this.icon.y = (this._height - this.icon.height) / 2;
            this.buttonObj.addChild(this.icon);
         }
         this.buttonObj.addChild(this.buttonObjLabel);
      }
      
      public function setSize(param1:Number, param2:Number) : void {
         this._width = param1;
         this._height = param2;
         this.draw();
      }
      
      public function get label() : String {
         return this._label;
      }
      
      public function get value() : * {
         return this._value;
      }
      
      override public function get height() : Number {
         return this._height;
      }
      
      public function blink() : void {
         if(!this.blinkTimer)
         {
            this.blinkTimer = new Timer(this.BLINK_INTERVAL,this.BLINK_REPEAT);
            this.blinkTimer.addEventListener(TimerEvent.TIMER,this.onBlinkTimerTick);
            this.blinkTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBlinkComplete);
            this.blinkTimer.start();
            return;
         }
      }
      
      public function refresh(param1:Boolean=false) : void {
         this.draw(param1);
      }
      
      private function onBlinkTimerTick(param1:TimerEvent) : void {
         if(param1.currentTarget.currentCount % 2 == 0)
         {
            this.draw(true);
         }
         else
         {
            this.draw();
         }
      }
      
      private function onBlinkComplete(param1:TimerEvent) : void {
         this.blinkTimer.removeEventListener(TimerEvent.TIMER,this.onBlinkTimerTick);
         this.blinkTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBlinkComplete);
         this.blinkTimer = null;
         dispatchEvent(new UIComponentEvent(UIComponentEvent.ON_UICOMPONENT_COMPLETE,this._value));
      }
      
      private function onMouseClick(param1:MouseEvent) : void {
         this.isSelected = true;
         dispatchEvent(new UIComponentEvent(UIComponentEvent.ON_UICOMPONENT_CLICK,this._value));
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.draw(true);
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.draw();
      }
      
      public function destroy() : void {
         if(this.icon)
         {
            this.buttonObj.removeChild(this.icon);
         }
         try
         {
            this.buttonObj.removeChild(this.buttonObjLabel);
         }
         catch(e:Error)
         {
         }
         removeChild(this.buttonObj);
         try
         {
            this.blinkTimer.removeEventListener(TimerEvent.TIMER,this.onBlinkTimerTick);
            this.blinkTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBlinkComplete);
         }
         catch(e:Error)
         {
         }
         this.disableListeners();
         this.icon = null;
         this.blinkTimer = null;
         this.buttonObjLabel = null;
         this.buttonObj = null;
      }
   }
}
