package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.geom.Size;
   import com.zynga.draw.CasinoSprite;
   import com.zynga.draw.ComplexColorContainer;
   import flash.geom.Point;
   import com.cartogrammar.drawing.CubicBezier;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   import flash.display.GradientType;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   
   public class PokerUIButtonGenericCloseStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonGenericCloseStyle() {
         this.kDefaultButtonSize = new Size(20,20);
         this.kNormalColors = new Array([13448501,8782338]);
         this.kNormalAlphas = new Array([1,1]);
         this.kNormalRatios = new Array([0,255]);
         this.kNormalRotations = new Array([90]);
         this.kOverColors = new Array([16777215,12303291]);
         this.kOverAlphas = new Array([1,1]);
         this.kOverRatios = new Array([0,255]);
         this.kOverRotations = new Array([90]);
         this.kIconSize = new Size(9,9);
         this.kIconNormalColors = new Array([16777215]);
         this.kIconOverColors = new Array([9113606]);
         this._adjustedIconSize = this.kIconSize;
         super();
         buttonSize = this.kDefaultButtonSize;
      }
      
      private const kDefaultButtonSize:Size;
      
      private const kNormalColors:Array;
      
      private const kNormalAlphas:Array;
      
      private const kNormalRatios:Array;
      
      private const kNormalRotations:Array;
      
      private const kOverColors:Array;
      
      private const kOverAlphas:Array;
      
      private const kOverRatios:Array;
      
      private const kOverRotations:Array;
      
      private const kIconSize:Size;
      
      private const kIconStrokeThickness:Number = 3.4;
      
      private const kIconNormalColors:Array;
      
      private const kIconOverColors:Array;
      
      private const kCornerRadius:Number = 8.0;
      
      private var _highlight:CasinoSprite;
      
      private var _highlightMask:CasinoSprite;
      
      private var _adjustedCornerRadius:Number = 8.0;
      
      private var _adjustedIconSize:Size;
      
      private var _adjustedIconStrokeThickness:Number = 3.4;
      
      override protected function setup() : void {
         if(_normalColor)
         {
            _normalColor = null;
         }
         _normalColor = new ComplexColorContainer();
         _normalColor.alphas = this.kNormalAlphas[_colorSet];
         _normalColor.colors = this.kNormalColors[_colorSet];
         _normalColor.ratios = this.kNormalRatios[_colorSet];
         _normalColor.rotation = this.kNormalRotations[_colorSet];
         _normalColor.width = buttonSize.width;
         _normalColor.height = buttonSize.height;
         if(_overColor)
         {
            _overColor = null;
         }
         _overColor = new ComplexColorContainer();
         _overColor.alphas = this.kOverAlphas[_colorSet];
         _overColor.colors = this.kOverColors[_colorSet];
         _overColor.ratios = this.kOverRatios[_colorSet];
         _overColor.rotation = this.kOverRotations[_colorSet];
         _overColor.width = buttonSize.width;
         _overColor.height = buttonSize.height;
         var _loc1_:Number = Math.sqrt(buttonSize.width * buttonSize.height) / Math.sqrt(this.kDefaultButtonSize.width * this.kDefaultButtonSize.height) * 1;
         this._adjustedCornerRadius = this.kCornerRadius * _loc1_;
         this._adjustedIconSize = new Size(this.kIconSize.width * _loc1_,this.kIconSize.height * _loc1_);
         this._adjustedIconStrokeThickness = this.kIconStrokeThickness * _loc1_;
      }
      
      private function drawHighlight() : void {
         if(this._highlight)
         {
            if(this._highlightMask)
            {
               this._highlight.mask = null;
               if(contains(this._highlightMask))
               {
                  removeChild(this._highlightMask);
               }
               this._highlightMask = null;
            }
            if(contains(this._highlight))
            {
               removeChild(this._highlight);
            }
            this._highlight = null;
         }
         this._highlight = new CasinoSprite();
         this._highlightMask = new CasinoSprite();
         this._highlight.graphics.clear();
         this._highlight.graphics.beginFill(16777215,0.2);
         this._highlight.graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
         this._highlight.graphics.endFill();
         this._highlightMask.graphics.clear();
         this._highlightMask.graphics.beginFill(0,1);
         this._highlightMask.graphics.lineTo(0.0,buttonSize.width * 0.55);
         var _loc1_:Point = new Point(0.0,buttonSize.height * 0.55);
         var _loc2_:Point = new Point(0.0,buttonSize.height * 0.33);
         var _loc3_:Point = new Point(buttonSize.width * 0.66,buttonSize.height * 0.33);
         var _loc4_:Point = new Point(buttonSize.width,buttonSize.height * 0.33);
         CubicBezier.drawCurve(this._highlightMask.graphics,_loc1_,_loc2_,_loc3_,_loc4_);
         this._highlightMask.graphics.lineTo(buttonSize.width,0.0);
         this._highlightMask.graphics.lineTo(0.0,0.0);
         this._highlightMask.graphics.endFill();
         this._highlight.mask = this._highlightMask;
         addChildren([this._highlight,this._highlightMask]);
      }
      
      private function drawIcon(param1:Boolean) : void {
         var _loc2_:Array = this.kIconNormalColors;
         if(param1)
         {
            _loc2_ = this.kIconOverColors;
         }
         graphics.lineStyle(this._adjustedIconStrokeThickness,_loc2_[_colorSet],1,false,LineScaleMode.NONE,CapsStyle.NONE,JointStyle.MITER);
         var _loc3_:Number = (buttonSize.width - this._adjustedIconSize.width) / 2;
         var _loc4_:Number = (buttonSize.height - this._adjustedIconSize.height) / 2;
         graphics.moveTo(_loc3_,_loc4_);
         graphics.lineTo(_loc3_ + this._adjustedIconSize.width,_loc4_ + this._adjustedIconSize.height);
         graphics.moveTo(_loc3_ + this._adjustedIconSize.width,_loc4_);
         graphics.lineTo(_loc3_,_loc4_ + this._adjustedIconSize.height);
         graphics.endFill();
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         filters = null;
         graphics.beginGradientFill(GradientType.LINEAR,_normalColor.colors,_normalColor.alphas,_normalColor.ratios,_normalColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this._adjustedCornerRadius,this._adjustedCornerRadius);
         graphics.endFill();
         this.drawHighlight();
         this.drawIcon(false);
         filters = [new GlowFilter(6625792,1,5,5,1,BitmapFilterQuality.LOW,true),new DropShadowFilter(1,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_overColor.colors,_overColor.alphas,_overColor.ratios,_overColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this._adjustedCornerRadius,this._adjustedCornerRadius);
         graphics.endFill();
         this.drawHighlight();
         this.drawIcon(true);
         filters = [new GlowFilter(6250335,1,5,5,1,BitmapFilterQuality.LOW,true),new DropShadowFilter(1,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
         super.drawOverState();
      }
      
      override public function drawDownState() : void {
         this.drawNormalState();
         super.drawDownState();
      }
      
      override public function drawUpState() : void {
         this.drawOverState();
         super.drawUpState();
      }
   }
}
