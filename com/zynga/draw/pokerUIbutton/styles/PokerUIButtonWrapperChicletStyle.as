package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.draw.ComplexColorContainer;
   import flash.text.TextFormat;
   import flash.display.GradientType;
   import com.zynga.geom.Size;
   
   public class PokerUIButtonWrapperChicletStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonWrapperChicletStyle() {
         this._normalColors = new Array([8509035,679953],[3909855,480634]);
         this._overColors = new Array([8509035,679953],[3909855,480634]);
         this._normalAlphas = new Array([0.75,0.75],[0.75,0.75]);
         this._overAlphas = new Array([0.75,0.75],[0.75,0.75]);
         this._normalRatios = new Array([0,255],[0,255]);
         this._overRatios = new Array([0,255],[0,255]);
         this._normalRotations = new Array(90,90);
         this._overRotations = new Array(90,90);
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
      }
      
      public static const COLOR_GREEN:int = 0;
      
      public static const COLOR_BLUE:int = 1;
      
      private var _normalColors:Array;
      
      private var _overColors:Array;
      
      private var _normalAlphas:Array;
      
      private var _overAlphas:Array;
      
      private var _normalRatios:Array;
      
      private var _overRatios:Array;
      
      private var _normalRotations:Array;
      
      private var _overRotations:Array;
      
      private var _defaultWidth:Number = 110.0;
      
      private var _defaultHeight:Number = 38.0;
      
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
         labelTextFormat = new TextFormat("Main",30,16777215);
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_normalColor.colors,_normalColor.alphas,_normalColor.ratios,_normalColor.matrix);
         graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_overColor.colors,_overColor.alphas,_overColor.ratios,_overColor.matrix);
         graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
         graphics.endFill();
         super.drawOverState();
      }
      
      override public function drawDownState() : void {
         this.drawNormalState();
         super.drawDownState();
      }
      
      override public function drawUpState() : void {
         super.drawUpState();
      }
   }
}
