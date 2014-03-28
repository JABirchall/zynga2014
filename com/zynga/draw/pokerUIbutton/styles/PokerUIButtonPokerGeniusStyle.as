package com.zynga.draw.pokerUIbutton.styles
{
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import flash.text.TextFormat;
   import flash.display.DisplayObject;
   import com.zynga.geom.Size;
   import flash.display.MovieClip;
   
   public class PokerUIButtonPokerGeniusStyle extends PokerUIButtonStyle
   {
      
      public function PokerUIButtonPokerGeniusStyle() {
         super();
         buttonSize = new Size(this._defaultWidth,this._defaultHeight);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      private var _defaultWidth:Number = 50.0;
      
      private var _defaultHeight:Number = 20.0;
      
      override protected function setup() : void {
         if(labelTextFormat)
         {
            labelTextFormat = null;
         }
         labelTextFormat = new TextFormat("Main",14,16777215,true);
         labelTextFormat.align = "center";
         _labelTextField.embedFonts = true;
         _labelTextField.defaultTextFormat = labelTextFormat;
      }
      
      override public function set backing(param1:DisplayObject) : void {
         buttonSize = new Size(param1.width,param1.height);
         super.backing = param1;
      }
      
      override public function drawNormalState() : void {
         var _loc1_:MovieClip = null;
         if(parent)
         {
            _loc1_ = parent.getChildAt(0) as MovieClip;
         }
         if((_loc1_) && _loc1_.currentFrame <= 10)
         {
            _loc1_.gotoAndPlay("out");
         }
         super.drawNormalState();
      }
      
      override public function drawDownState() : void {
         super.drawDownState();
      }
      
      override public function drawUpState() : void {
         this.drawNormalState();
      }
      
      override public function drawOverState() : void {
         var _loc1_:MovieClip = null;
         if(parent)
         {
            _loc1_ = parent.getChildAt(0) as MovieClip;
         }
         if((_loc1_) && _loc1_.currentFrame <= 10)
         {
            _loc1_.gotoAndPlay("over");
         }
      }
   }
}
