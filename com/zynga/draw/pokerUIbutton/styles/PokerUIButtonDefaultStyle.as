package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.draw.ComplexColorContainer;
   import flash.text.TextFormat;
   import flash.display.GradientType;
   import com.zynga.geom.Size;
   
   public class PokerUIButtonDefaultStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonDefaultStyle() {
         this._normalColors = new Array([5636883,5636883,2359559],[7259502,3648557,2648587,2315008],[9961472,9961472]);
         this._overColors = new Array([8586003,3473671],[7259502,4047666,2648587,3175168],[16711680,16711680]);
         this._normalAlphas = new Array([1,1,1],[1,1,1,1],[1,1]);
         this._overAlphas = new Array([1,1],[1,1,1,1],[1,1]);
         this._normalRatios = new Array([80,90,250],[5,15,240,250],[0,255]);
         this._overRatios = new Array([90,250],[5,15,240,250],[0,255]);
         this._normalRotations = new Array(90,90,90);
         this._overRotations = new Array(90,90,90);
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
      }
      
      public static const COLOR_GREEN:int = 1;
      
      public static const COLOR_FLAT_RED:int = 2;
      
      private var _normalColors:Array;
      
      private var _overColors:Array;
      
      private var _normalAlphas:Array;
      
      private var _overAlphas:Array;
      
      private var _normalRatios:Array;
      
      private var _overRatios:Array;
      
      private var _normalRotations:Array;
      
      private var _overRotations:Array;
      
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
         _normalColor.alphas = this._normalAlphas[_colorSet];
         _normalColor.colors = this._normalColors[_colorSet];
         _normalColor.ratios = this._normalRatios[_colorSet];
         _normalColor.rotation = this._normalRotations[_colorSet];
         if(_overColor)
         {
            _overColor = null;
         }
         _overColor = new ComplexColorContainer();
         _overColor.width = buttonSize.width;
         _overColor.height = buttonSize.height;
         _overColor.alphas = this._overAlphas[_colorSet];
         _overColor.colors = this._overColors[_colorSet];
         _overColor.ratios = this._overRatios[_colorSet];
         _overColor.rotation = this._overRotations[_colorSet];
         if(labelTextFormat)
         {
            labelTextFormat = null;
         }
         labelTextFormat = new TextFormat("Main",14,16777215);
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
