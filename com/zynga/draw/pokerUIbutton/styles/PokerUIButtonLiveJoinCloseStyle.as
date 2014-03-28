package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import flash.display.Sprite;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.GradientType;
   
   public class PokerUIButtonLiveJoinCloseStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonLiveJoinCloseStyle() {
         super();
      }
      
      private var _closeIcon:Sprite;
      
      private var _defaultWidth:Number;
      
      private var _defaultHeight:Number;
      
      override protected function setup() : void {
         buttonSize.width = 12;
         buttonSize.height = 12;
         _normalColor = new ComplexColorContainer();
         _normalColor.width = buttonSize.width;
         _normalColor.height = buttonSize.height;
         _normalColor.alphas = [1,1];
         _normalColor.colors = [6513251,6513251];
         _normalColor.ratios = [0,255];
         _normalColor.rotation = 90;
         _overColor = new ComplexColorContainer();
         _overColor.width = buttonSize.width;
         _overColor.height = buttonSize.height;
         _overColor.alphas = [0.75,0.75];
         _overColor.colors = [16777215,16777215];
         _overColor.ratios = [0,255];
         _overColor.rotation = 90;
         this._closeIcon = new Sprite();
         this._closeIcon.graphics.lineStyle(1,16777215,1);
         this._closeIcon.graphics.moveTo(0.0,0.0);
         this._closeIcon.graphics.lineTo(5,7);
         this._closeIcon.graphics.moveTo(5,0.0);
         this._closeIcon.graphics.lineTo(0.0,7);
         this._closeIcon.x = (buttonSize.width - this._closeIcon.width) / 2;
         this._closeIcon.y = (buttonSize.height - this._closeIcon.height) / 2;
         addChild(this._closeIcon);
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
