package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import com.zynga.draw.ComplexColorContainer;
   import flash.text.TextFormat;
   import com.zynga.geom.Size;
   
   public class PokerUIButtonSmallRectangleStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonSmallRectangleStyle() {
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
      }
      
      private var _strokeColor:Number;
      
      private var _strokeWidth:Number;
      
      private var _defaultWidth:Number = 82.0;
      
      private var _defaultHeight:Number = 19.0;
      
      override protected function setup() : void {
         _normalColor = new ComplexColorContainer();
         _normalColor.colors = [0];
         _overColor = new ComplexColorContainer();
         _overColor.colors = [2368548];
         this._strokeColor = 5636883;
         this._strokeWidth = 1;
         labelTextFormat = new TextFormat("MainSemi",10,16777215);
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         graphics.lineStyle(this._strokeWidth,this._strokeColor);
         graphics.beginFill(_normalColor.colors[0],1);
         graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.lineStyle(this._strokeWidth,this._strokeColor);
         graphics.beginFill(_overColor.colors[0],1);
         graphics.drawRect(0.0,0.0,buttonSize.width,buttonSize.height);
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
