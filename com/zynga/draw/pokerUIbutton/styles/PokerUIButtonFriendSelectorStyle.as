package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.geom.Size;
   import com.zynga.draw.ComplexColorContainer;
   import flash.text.TextFormat;
   import flash.display.GradientType;
   
   public class PokerUIButtonFriendSelectorStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonFriendSelectorStyle() {
         this.kDefaultButtonSize = new Size(182,25);
         this.kNormalColors = new Array([1347612,25099],[3575757,1658486]);
         this.kNormalAlphas = new Array([1,1],[1,1]);
         this.kNormalRatios = new Array([60,255],[60,255]);
         this.kNormalOverlayColors = new Array(3580738,5217488);
         this.kOverColors = new Array([1549857,98063],[4170467,2188439]);
         this.kOverAlphas = new Array([1,1],[1,1]);
         this.kOverRatios = new Array([60,255],[60,255]);
         this.kOverOverlayColors = new Array(4242766,5811686);
         super();
         buttonSize = this.kDefaultButtonSize;
      }
      
      public static const COLOR_LIGHTBLUE:int = 1;
      
      private const kDefaultButtonSize:Size;
      
      private const kNormalColors:Array;
      
      private const kNormalAlphas:Array;
      
      private const kNormalRatios:Array;
      
      private const kNormalRotation:Number = 90.0;
      
      private const kNormalOverlayColors:Array;
      
      private const kNormalOverlayAlpha:Number = 1.0;
      
      private const kOverColors:Array;
      
      private const kOverAlphas:Array;
      
      private const kOverRatios:Array;
      
      private const kOverRotation:Number = 90.0;
      
      private const kOverOverlayColors:Array;
      
      private const kOverOverlayAlpha:Number = 1.0;
      
      private const kCornerRadius:Number = 4.0;
      
      override protected function setup() : void {
         if(_normalColor)
         {
            _normalColor = null;
         }
         _normalColor = new ComplexColorContainer();
         _normalColor.width = buttonSize.width;
         _normalColor.height = buttonSize.height;
         _normalColor.alphas = this.kNormalAlphas[_colorSet];
         _normalColor.colors = this.kNormalColors[_colorSet];
         _normalColor.ratios = this.kNormalRatios[_colorSet];
         _normalColor.rotation = this.kNormalRotation;
         if(_overColor)
         {
            _overColor = null;
         }
         _overColor = new ComplexColorContainer();
         _overColor.width = buttonSize.width;
         _overColor.height = buttonSize.height;
         _overColor.alphas = this.kOverAlphas[_colorSet];
         _overColor.colors = this.kOverColors[_colorSet];
         _overColor.ratios = this.kOverRatios[_colorSet];
         _overColor.rotation = this.kOverRotation;
         if(labelTextFormat)
         {
            labelTextFormat = null;
         }
         labelTextFormat = new TextFormat("MainSemi",12,16777215);
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_normalColor.colors,_normalColor.alphas,_normalColor.ratios,_normalColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this.kCornerRadius,this.kCornerRadius);
         graphics.endFill();
         graphics.beginFill(this.kNormalOverlayColors[_colorSet],this.kNormalOverlayAlpha);
         graphics.drawRoundRectComplex(0.0,0.0,buttonSize.width,buttonSize.height / 2,this.kCornerRadius,this.kCornerRadius,0.0,0.0);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_overColor.colors,_overColor.alphas,_overColor.ratios,_overColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this.kCornerRadius,this.kCornerRadius);
         graphics.endFill();
         graphics.beginFill(this.kOverOverlayColors[_colorSet],this.kOverOverlayAlpha);
         graphics.drawRoundRectComplex(0.0,0.0,buttonSize.width,buttonSize.height / 2,this.kCornerRadius,this.kCornerRadius,0.0,0.0);
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
