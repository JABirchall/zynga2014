package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import flash.display.Sprite;
   import com.zynga.draw.ComplexColorContainer;
   import flash.text.TextFormat;
   import flash.display.MovieClip;
   import flash.display.GradientType;
   import com.zynga.geom.Size;
   
   public class PokerUIButtonLuckyBonusStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonLuckyBonusStyle() {
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
      }
      
      private var _highlight:Sprite;
      
      private var _highlightMask:Sprite;
      
      private var _defaultWidth:Number = 182.0;
      
      private var _defaultHeight:Number = 54.0;
      
      override protected function setup() : void {
         _normalColor = new ComplexColorContainer();
         _normalColor.width = buttonSize.width;
         _normalColor.height = buttonSize.height;
         _normalColor.alphas = [0.0];
         _normalColor.colors = [0];
         _normalColor.rotation = 90;
         _downColor = new ComplexColorContainer();
         _downColor.width = buttonSize.width;
         _downColor.height = buttonSize.height;
         _downColor.alphas = [1,1,1];
         _downColor.colors = [1127689,1662219,1258763];
         _downColor.ratios = [0,166,255];
         _downColor.rotation = 90;
         _grayOutColor = new ComplexColorContainer();
         _grayOutColor.width = buttonSize.width;
         _grayOutColor.height = buttonSize.height;
         _grayOutColor.alphas = [1,1,1,1,1];
         _grayOutColor.colors = [5856588,10924453,5856589,3486000,8555386];
         _grayOutColor.ratios = [0,38,77,166,255];
         _grayOutColor.rotation = 90;
         if(labelTextFormat)
         {
            labelTextFormat = null;
         }
         labelTextFormat = new TextFormat("Main",22,16777215,true);
         _labelTextField.embedFonts = true;
         _labelTextField.defaultTextFormat = labelTextFormat;
         labelTextFormat.align = "center";
      }
      
      override public function drawNormalState() : void {
         if(_useGrayOut)
         {
            this.drawGrayOutState();
            return;
         }
         if((parent) && parent.getChildAt(0) is MovieClip)
         {
            parent.getChildAt(0).visible = true;
         }
         graphics.clear();
         graphics.beginFill(_normalColor.colors[0],_normalColor.alphas[0]);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,7,7);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawDownState() : void {
         if(_useGrayOut)
         {
            this.drawGrayOutState();
            return;
         }
         if((parent) && parent.getChildAt(0) is MovieClip)
         {
            parent.getChildAt(0).visible = false;
         }
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_downColor.colors,_downColor.alphas,_downColor.ratios,_downColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,7,7);
         graphics.endFill();
         super.drawDownState();
      }
      
      override public function drawUpState() : void {
         this.drawNormalState();
      }
      
      override public function drawOverState() : void {
         this.drawNormalState();
      }
      
      public function drawGrayOutState() : void {
         if((parent) && parent.getChildAt(0) is MovieClip)
         {
            parent.getChildAt(0).visible = false;
         }
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,_grayOutColor.colors,_grayOutColor.alphas,_grayOutColor.ratios,_grayOutColor.matrix);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,7,7);
         graphics.endFill();
         super.drawDownState();
      }
      
      override public function set grayOut(param1:Boolean) : void {
         super.grayOut = param1;
         if(_useGrayOut)
         {
            this.drawGrayOutState();
         }
         else
         {
            this.drawNormalState();
         }
      }
   }
}
