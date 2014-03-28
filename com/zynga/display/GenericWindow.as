package com.zynga.display
{
   import flash.display.Sprite;
   import com.zynga.draw.ComplexColorContainer;
   import com.zynga.display.Buttons.CloseButton;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   import flash.display.GradientType;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.display.DisplayObject;
   
   public class GenericWindow extends Sprite
   {
      
      public function GenericWindow() {
         super();
         this._colors = new ComplexColorContainer(
            {
               "colors":[16777215,16777215],
               "alphas":[1,1],
               "ratios":[0,255],
               "width":this.DEFAULT_WIDTH,
               "height":this.DEFAULT_HEIGHT
            });
         this.setup();
      }
      
      private const DEFAULT_WIDTH:Number = 320.0;
      
      private const DEFAULT_HEIGHT:Number = 240.0;
      
      private var box:Sprite;
      
      private var _colors:ComplexColorContainer;
      
      private var _strokeSize:Number = 0.0;
      
      private var _strokeColor:int = 0;
      
      private var closeButton:CloseButton;
      
      private var _content:Sprite;
      
      private function setup() : void {
         this.draw();
      }
      
      private function draw() : void {
         try
         {
            this.removeListeners();
            removeChild(this.closeButton);
            removeChild(this._content);
            removeChild(this.box);
         }
         catch(e:Error)
         {
         }
         if(!this._content)
         {
            this._content = new Sprite();
         }
         else
         {
            this._colors.width = this._content.width;
            this._colors.height = this._content.height;
         }
         if(!this.box)
         {
            this.box = new Sprite();
         }
         this.box.graphics.clear();
         if(this._strokeSize)
         {
            this.box.graphics.lineStyle(this._strokeSize,this._strokeColor,1,false,LineScaleMode.NONE,CapsStyle.NONE,JointStyle.MITER);
         }
         this.box.graphics.beginGradientFill(GradientType.LINEAR,this._colors.colors,this._colors.alphas,this._colors.ratios,this._colors.matrix);
         this.box.graphics.drawRoundRect(0.0,0.0,this._colors.width,this._colors.height,8,8);
         this.box.graphics.endFill();
         this.box.filters = [new GlowFilter(0,1,7,7,1,BitmapFilterQuality.HIGH)];
         if(!this.closeButton)
         {
            this.closeButton = new CloseButton();
         }
         this.closeButton.x = this.box.width - this.closeButton.width - (4 + this.strokeSize);
         this.closeButton.y = 4;
         addChild(this.box);
         addChild(this._content);
         addChild(this.closeButton);
         this.setupListeners();
      }
      
      private function setupListeners() : void {
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
         this._colors.addEventListener(Event.CHANGE,this.onChange);
      }
      
      private function removeListeners() : void {
         this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
         this._colors.removeEventListener(Event.CHANGE,this.onChange);
      }
      
      public function set strokeSize(param1:Number) : void {
         this._strokeSize = param1;
      }
      
      public function get strokeSize() : Number {
         return this._strokeSize;
      }
      
      public function set strokeColor(param1:int) : void {
         this._strokeColor = param1;
      }
      
      public function get strokeColor() : int {
         return this._strokeColor;
      }
      
      public function set content(param1:DisplayObject) : void {
         try
         {
            if(this._content.getChildAt(0))
            {
               this._content.removeChildAt(0);
            }
         }
         catch(e:Error)
         {
         }
         if(param1)
         {
            this._content.addChildAt(param1,0);
            this.draw();
            dispatchEvent(new Event(Event.RENDER));
         }
      }
      
      public function get content() : DisplayObject {
         try
         {
            if(this._content.getChildAt(0))
            {
               return this._content.getChildAt(0);
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function get colors() : ComplexColorContainer {
         return this._colors;
      }
      
      public function hideCloseButton() : void {
         this.closeButton.visible = false;
      }
      
      private function onCloseButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onChange(param1:Event) : void {
         this.draw();
      }
   }
}
