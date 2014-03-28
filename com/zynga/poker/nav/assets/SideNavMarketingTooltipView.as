package com.zynga.poker.nav.assets
{
   import com.zynga.draw.CasinoSprite;
   import com.zynga.geom.Size;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import flash.geom.Point;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.GradientType;
   
   public class SideNavMarketingTooltipView extends CasinoSprite
   {
      
      public function SideNavMarketingTooltipView(param1:Boolean=true) {
         this.DEFAULT_SIZE = new Size(172,48);
         this.ARROW_SIZE = new Size(11,24);
         this._baseColors = new Array(12633034,16316921);
         this._baseAlphas = new Array(1,1);
         this._baseRatios = new Array(5,250);
         super();
         this._arrowOnLeft = param1;
         this.setup();
      }
      
      private const DEFAULT_SIZE:Size;
      
      private const ARROW_SIZE:Size;
      
      private const FLIP_CONTENTS_X_OFFSET:int = 2;
      
      private var _baseColors:Array;
      
      private var _baseAlphas:Array;
      
      private var _baseRatios:Array;
      
      private var _strokeColor:Number = 1657986;
      
      private var _strokeWidth:Number = 2.0;
      
      private var _cornerRadius:Number = 4.0;
      
      private var _base:CasinoSprite;
      
      private var _closeButton:PokerUIButton;
      
      private var _labelField:EmbeddedFontTextField;
      
      private var _arrowOnLeft:Boolean = true;
      
      private function setup() : void {
         this._labelField = new EmbeddedFontTextField("BLANK","Main",12,2449333,TextFormatAlign.CENTER);
         this._labelField.autoSize = TextFieldAutoSize.CENTER;
         this._labelField.multiline = true;
         this._labelField.wordWrap = true;
         this.drawBase();
         this._closeButton = new PokerUIButton();
         this._closeButton.style = PokerUIButton.BUTTONSTYLE_GENERICCLOSE;
         this._closeButton.buttonSize = new Size(14,14);
         if(this._arrowOnLeft === true)
         {
            this._closeButton.position = new Point(this._base.maxX - (this._closeButton.width + 6),4);
            this._labelField.x = this.ARROW_SIZE.width;
         }
         else
         {
            this._closeButton.position = new Point(-this.ARROW_SIZE.width - (this._closeButton.width + 6) + this.FLIP_CONTENTS_X_OFFSET,4);
            this._labelField.x = -this.DEFAULT_SIZE.width - this.ARROW_SIZE.width + this.FLIP_CONTENTS_X_OFFSET;
         }
         this._labelField.y = this._base.midY - this._labelField.height / 2;
         addChildren([this._labelField,this._closeButton]);
      }
      
      private function drawBase() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc1_:ComplexColorContainer = new ComplexColorContainer();
         _loc1_.width = this.DEFAULT_SIZE.width;
         _loc1_.height = this.DEFAULT_SIZE.height;
         _loc1_.colors = this._baseColors;
         _loc1_.alphas = this._baseAlphas;
         _loc1_.ratios = this._baseRatios;
         _loc1_.rotation = -90;
         if(this._labelField)
         {
            this._labelField.width = _loc1_.width - (this.ARROW_SIZE.width + 8);
            if(this._labelField.width > this.DEFAULT_SIZE.width - 8)
            {
               _loc1_.width = this._labelField.width + 8;
            }
            if(this._labelField.height > this.DEFAULT_SIZE.height + 8)
            {
               _loc1_.height = this._labelField.height + 8;
            }
         }
         if(!this._base)
         {
            this._base = new CasinoSprite();
         }
         this._base.graphics.clear();
         this._base.graphics.lineStyle(2,this._strokeColor,1);
         this._base.graphics.beginGradientFill(GradientType.LINEAR,_loc1_.colors,_loc1_.alphas,_loc1_.ratios,_loc1_.matrix);
         if(this._arrowOnLeft)
         {
            _loc2_ = this.ARROW_SIZE.width;
            _loc3_ = this.ARROW_SIZE.width-1;
            this._base.graphics.drawRoundRect(_loc3_,0.0,_loc1_.width,_loc1_.height,this._cornerRadius,this._cornerRadius);
         }
         else
         {
            _loc2_ = -this.ARROW_SIZE.width;
            _loc3_ = -this.ARROW_SIZE.width + 1;
            this._base.graphics.drawRoundRect(_loc3_ - _loc1_.width,0.0,_loc1_.width,_loc1_.height,this._cornerRadius,this._cornerRadius);
         }
         this._base.graphics.endFill();
         var _loc4_:Number = _loc1_.height / 2;
         this._base.graphics.beginGradientFill(GradientType.LINEAR,_loc1_.colors,_loc1_.alphas,_loc1_.ratios,_loc1_.matrix);
         this._base.graphics.moveTo(0.0,_loc4_);
         this._base.graphics.lineTo(_loc3_,_loc4_ - (this.ARROW_SIZE.height-1) / 2);
         this._base.graphics.lineStyle(2,this._strokeColor,0.0);
         this._base.graphics.lineTo(_loc2_,_loc4_ - this.ARROW_SIZE.height / 2);
         this._base.graphics.lineTo(_loc2_,_loc4_ + this.ARROW_SIZE.height / 2);
         this._base.graphics.lineTo(_loc3_,_loc4_ + (this.ARROW_SIZE.height-1) / 2);
         this._base.graphics.lineStyle(2,this._strokeColor,1);
         this._base.graphics.lineTo(0.0,_loc4_);
         this._base.graphics.endFill();
         if(!contains(this._base))
         {
            addChildAt(this._base,0);
         }
      }
      
      public function get base() : CasinoSprite {
         return this._base;
      }
      
      public function get closeButton() : PokerUIButton {
         return this._closeButton;
      }
      
      public function set labelText(param1:String) : void {
         this._labelField.text = param1;
         this._labelField.autoSize = TextFieldAutoSize.CENTER;
         this.drawBase();
         if(this._arrowOnLeft === true)
         {
            this._closeButton.position = new Point(this._base.maxX - (this._closeButton.width + 6),4);
            this._labelField.x = this.ARROW_SIZE.width;
         }
         else
         {
            this._closeButton.position = new Point(-this.ARROW_SIZE.width - (this._closeButton.width + 6) + this.FLIP_CONTENTS_X_OFFSET,4);
            this._labelField.x = -this.DEFAULT_SIZE.width - this.ARROW_SIZE.width + this.FLIP_CONTENTS_X_OFFSET;
         }
         this._labelField.y = this._base.midY - this._labelField.height / 2;
      }
      
      public function get labelText() : String {
         return this._labelField.text;
      }
   }
}
