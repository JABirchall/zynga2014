package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.Sprite;
   import flash.display.GradientType;
   import flash.geom.Point;
   import com.cartogrammar.drawing.CubicBezier;
   import com.zynga.geom.Size;
   
   public class PokerUIButtonShinyStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonShinyStyle() {
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
      }
      
      private var _highlightColors:ComplexColorContainer;
      
      private var _highlight:Sprite;
      
      private var _highlightMask:Sprite;
      
      private var _defaultWidth:Number = 182.0;
      
      private var _defaultHeight:Number = 25.0;
      
      override protected function setup() : void {
         if(_normalColor)
         {
            _normalColor = null;
         }
         _normalColor = new ComplexColorContainer();
         _normalColor.width = buttonSize.width;
         _normalColor.height = buttonSize.height;
         _normalColor.alphas = [1,1,1,1,1];
         _normalColor.colors = [1740046,1405196,1071115,1003530,267269];
         _normalColor.ratios = [0,90,200,250,255];
         _normalColor.rotation = 90;
         if(_overColor)
         {
            _overColor = null;
         }
         _overColor = new ComplexColorContainer();
         _overColor.width = buttonSize.width;
         _overColor.height = buttonSize.height;
         _overColor.alphas = [1,1];
         _overColor.colors = [2342679,1740305];
         _overColor.ratios = [0,255];
         _overColor.rotation = 90;
         if(this._highlightColors)
         {
            this._highlightColors = null;
         }
         this._highlightColors = new ComplexColorContainer();
         this._highlightColors.width = buttonSize.width;
         this._highlightColors.height = buttonSize.height;
         this._highlightColors.alphas = [0.2,0.2];
         this._highlightColors.colors = [16777215,16777215];
         this._highlightColors.ratios = [0,127];
         this._highlightColors.rotation = 90;
         if(this._highlight)
         {
            this._highlight.mask = null;
            if(contains(this._highlight))
            {
               removeChild(this._highlight);
            }
            this._highlight = null;
         }
         this._highlight = new Sprite();
         this._highlight.graphics.beginGradientFill(GradientType.LINEAR,this._highlightColors.colors,this._highlightColors.alphas,this._highlightColors.ratios,this._highlightColors.matrix);
         this._highlight.graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
         this._highlight.graphics.endFill();
         if(this._highlightMask)
         {
            if(contains(this._highlightMask))
            {
               removeChild(this._highlightMask);
            }
            this._highlightMask = null;
         }
         this._highlightMask = new Sprite();
         this._highlightMask.graphics.beginFill(0,1);
         this._highlightMask.graphics.lineTo(0,buttonSize.height * 0.55);
         var _loc1_:Point = new Point(0,buttonSize.height * 0.55);
         var _loc2_:Point = new Point(0,buttonSize.height * 0.33);
         var _loc3_:Point = new Point(buttonSize.width * 0.66,buttonSize.height * 0.33);
         var _loc4_:Point = new Point(buttonSize.width,buttonSize.height * 0.33);
         CubicBezier.drawCurve(this._highlightMask.graphics,_loc1_,_loc2_,_loc3_,_loc4_);
         this._highlightMask.graphics.lineTo(buttonSize.width,0.0);
         this._highlightMask.graphics.lineTo(0.0,0.0);
         this._highlightMask.graphics.endFill();
         this._highlight.mask = this._highlightMask;
         addChild(this._highlight);
         addChild(this._highlightMask);
         if(labelTextFormat)
         {
            labelTextFormat.align = "center";
         }
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_normalColor.colors,_normalColor.alphas,_normalColor.ratios,_normalColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,7,7);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_overColor.colors,_overColor.alphas,_overColor.ratios,_overColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,7,7);
         graphics.endFill();
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
