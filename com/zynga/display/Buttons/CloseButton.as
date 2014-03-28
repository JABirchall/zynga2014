package com.zynga.display.Buttons
{
   import flash.display.Sprite;
   import com.zynga.draw.ComplexColorContainer;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.display.GradientType;
   import flash.geom.Point;
   import com.cartogrammar.drawing.CubicBezier;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   
   public class CloseButton extends Sprite
   {
      
      public function CloseButton() {
         this.buttonHighlight = new Sprite();
         this.buttonHighlightMask = new Sprite();
         super();
         this.setup();
         this.setupListeners();
      }
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_OVER:int = 1;
      
      public static const STATE_DISABLED:int = 2;
      
      private const WIDTH:Number = 20.0;
      
      private const HEIGHT:Number = 20.0;
      
      private const ICON_STROKE_SIZE:Number = 3.4;
      
      private const ICON_WIDTH:Number = 9.0;
      
      private const ICON_HEIGHT:Number = 9.0;
      
      private const ICON_COLOR_NORMAL:int = 16777215;
      
      private const ICON_COLOR_OVER:int = 9113606;
      
      private const ICON_COLOR_DISABLED:int = 6908265;
      
      private var normalColors:ComplexColorContainer;
      
      private var overColors:ComplexColorContainer;
      
      private var disabledColors:ComplexColorContainer;
      
      private var buttonHighlight:Sprite;
      
      private var buttonHighlightMask:Sprite;
      
      private var _enabled:Boolean = true;
      
      private function setup() : void {
         this.normalColors = new ComplexColorContainer(
            {
               "colors":[13448501,8782338],
               "alphas":[1,1],
               "ratios":[0,255],
               "width":this.WIDTH,
               "height":this.HEIGHT,
               "rotation":90
            });
         this.overColors = this.normalColors.clone();
         this.overColors.colors = [16777215,12303291];
         this.disabledColors = this.normalColors.clone();
         this.disabledColors.colors = [13421772,8882055];
         buttonMode = true;
         this.draw(STATE_NORMAL);
      }
      
      private function setupListeners() : void {
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeListeners() : void {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function set enabled(param1:Boolean) : void {
         this._enabled = param1;
         if(!this._enabled)
         {
            buttonMode = false;
            this.removeListeners();
            this.draw(STATE_DISABLED);
         }
         else
         {
            buttonMode = true;
            this.setupListeners();
            this.draw(STATE_NORMAL);
         }
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      private function draw(param1:int) : void {
         var _loc2_:ComplexColorContainer = null;
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         try
         {
            this.buttonHighlight.mask = null;
            removeChild(this.buttonHighlight);
            removeChild(this.buttonHighlightMask);
         }
         catch(e:Error)
         {
         }
         switch(param1)
         {
            case STATE_NORMAL:
               _loc2_ = this.normalColors;
               _loc3_ = this.ICON_COLOR_NORMAL;
               _loc4_ = [new GlowFilter(6625792,1,5,5,1,BitmapFilterQuality.LOW,true),new DropShadowFilter(1,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
               break;
            case STATE_OVER:
               _loc2_ = this.overColors;
               _loc3_ = this.ICON_COLOR_OVER;
               _loc4_ = [new GlowFilter(6250335,1,5,5,1,BitmapFilterQuality.LOW,true),new DropShadowFilter(1,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
               break;
            case STATE_DISABLED:
               _loc2_ = this.disabledColors;
               _loc3_ = this.ICON_COLOR_DISABLED;
               _loc4_ = [new GlowFilter(6118749,1,5,5,1,BitmapFilterQuality.LOW,true),new DropShadowFilter(1,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
               break;
         }
         
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_loc2_.colors,_loc2_.alphas,_loc2_.ratios,_loc2_.matrix);
         graphics.drawRoundRect(0.0,0.0,this.WIDTH,this.HEIGHT,8,8);
         this.buttonHighlight.graphics.clear();
         this.buttonHighlight.graphics.beginFill(16777215,0.2);
         this.buttonHighlight.graphics.drawRect(0.0,0.0,this.WIDTH,this.HEIGHT);
         this.buttonHighlight.graphics.endFill();
         this.buttonHighlightMask.graphics.clear();
         this.buttonHighlightMask.graphics.beginFill(0,1);
         this.buttonHighlightMask.graphics.lineTo(0,this.HEIGHT * 0.55);
         var _loc5_:Point = new Point(0,this.HEIGHT * 0.55);
         var _loc6_:Point = new Point(0,this.HEIGHT * 0.33);
         var _loc7_:Point = new Point(this.WIDTH * 0.66,this.HEIGHT * 0.33);
         var _loc8_:Point = new Point(this.WIDTH,this.HEIGHT * 0.33);
         CubicBezier.drawCurve(this.buttonHighlightMask.graphics,_loc5_,_loc6_,_loc7_,_loc8_);
         this.buttonHighlightMask.graphics.lineTo(this.WIDTH,0);
         this.buttonHighlightMask.graphics.lineTo(0,0);
         this.buttonHighlightMask.graphics.endFill();
         this.buttonHighlight.mask = this.buttonHighlightMask;
         addChild(this.buttonHighlight);
         addChild(this.buttonHighlightMask);
         graphics.lineStyle(this.ICON_STROKE_SIZE,_loc3_,1,false,LineScaleMode.NONE,CapsStyle.NONE,JointStyle.MITER);
         var _loc9_:Number = (this.WIDTH - this.ICON_WIDTH) / 2;
         var _loc10_:Number = (this.HEIGHT - this.ICON_HEIGHT) / 2;
         graphics.moveTo(_loc9_,_loc10_);
         graphics.lineTo(_loc9_ + this.ICON_WIDTH,_loc10_ + this.ICON_HEIGHT);
         graphics.moveTo(_loc9_ + this.ICON_WIDTH,_loc10_);
         graphics.lineTo(_loc9_,_loc10_ + this.ICON_HEIGHT);
         graphics.endFill();
         filters = _loc4_;
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.draw(STATE_OVER);
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.draw(STATE_NORMAL);
      }
   }
}
