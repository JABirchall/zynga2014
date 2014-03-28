package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import flash.text.TextFormat;
   
   public class PokerUIButtonRequest2MFSActionStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonRequest2MFSActionStyle() {
         this._normalColors = [[4039754,24329],[15263976,12237498],[7434609,4079166]];
         this._overColors = this._normalColors;
         super();
      }
      
      public static const COLOR_GREEN:int = COLOR_DEFAULT;
      
      public static const COLOR_SILVER:int = 1;
      
      public static const COLOR_GRAY:int = 2;
      
      private var _normalColors:Array;
      
      private var _overColors:Array;
      
      private var _cornerRadius:Number = 14.0;
      
      override protected function setup() : void {
         if(labelTextFormat)
         {
            labelTextFormat = null;
         }
         labelTextFormat = new TextFormat("MainSemi",14,16777215);
      }
      
      override public function drawNormalState() : void {
         graphics.clear();
         graphics.beginFill(this._normalColors[_colorSet][0],1);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this._cornerRadius,this._cornerRadius);
         graphics.beginFill(this._normalColors[_colorSet][1],1);
         graphics.drawRoundRectComplex(1,buttonSize.height / 2,buttonSize.width - 2,buttonSize.height / 2-1,0.0,0.0,this._cornerRadius / 2,this._cornerRadius / 2);
         graphics.endFill();
         super.drawNormalState();
      }
      
      override public function drawOverState() : void {
         graphics.clear();
         graphics.beginFill(this._overColors[_colorSet][0],1);
         graphics.drawRoundRect(0.0,0.0,buttonSize.width,buttonSize.height,this._cornerRadius,this._cornerRadius);
         graphics.beginFill(this._overColors[_colorSet][1],1);
         graphics.drawRoundRectComplex(1,buttonSize.height / 2,buttonSize.width - 2,buttonSize.height / 2-1,0.0,0.0,this._cornerRadius / 2,this._cornerRadius / 2);
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
