package com.zynga.poker.popups.modules.tipTheDealer
{
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import flash.geom.Rectangle;
   
   public class DealerComment extends Sprite
   {
      
      public function DealerComment() {
         this.tippers = new Array();
         super();
         this.textField = new EmbeddedFontTextField();
         this.textField.x = 6;
         this.textField.y = 2;
         this.textField.width = 250;
         this.textField.wordWrap = true;
         this.textField.multiline = true;
         this.textField.fontAlign = "left";
         this.roundRect = new Sprite();
         this.roundRect.graphics.lineStyle(0);
         this.roundRect.graphics.beginFill(16711615);
         this.roundRect.graphics.drawRoundRect(0,0,100,20,12);
         this.roundRect.graphics.endFill();
         this.roundRect.scale9Grid = new Rectangle(6,6,88,8);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16711615);
         _loc1_.graphics.moveTo(this.roundRect.x + 4,this.roundRect.y + this.roundRect.height - 10);
         _loc1_.graphics.lineTo(this.roundRect.x + 4,this.roundRect.y + this.roundRect.height - 10);
         _loc1_.graphics.lineTo(this.roundRect.x + 10,this.roundRect.y + this.roundRect.height - 4);
         _loc1_.graphics.lineTo(this.roundRect.x - 3,this.roundRect.y + this.roundRect.height + 3);
         _loc1_.graphics.endFill();
         addChild(this.roundRect);
         addChild(this.textField);
         addChild(_loc1_);
         this.x = 405;
         this.y = 10;
         this.mouseEnabled = false;
      }
      
      private var textField:EmbeddedFontTextField;
      
      private var roundRect:Sprite;
      
      private var tippers:Array;
      
      public function reset() : void {
         this.tippers = new Array();
      }
      
      public function notEnoughChips() : void {
         this.textField.text = "Sorry, you need more chips!";
         this.updateTextBalloon();
      }
      
      public function congratulateUser(param1:String) : void {
         this.textField.text = LocaleManager.localize("flash.popup.tipTheDealer.congrats",{"comment":param1});
         this.updateTextBalloon();
      }
      
      public function pokerScoreReady(param1:String) : void {
         this.textField.text = LocaleManager.localize("popups.pokerScore.dealerMessage",{"name":param1});
         this.updateTextBalloon();
      }
      
      public function thankUser(param1:String) : void {
         if(this.tippers.indexOf(param1) < 0)
         {
            this.tippers.push(param1);
         }
         var _loc2_:Number = Math.min(this.tippers.length,9);
         var _loc3_:Object = {};
         var _loc4_:* = 1;
         while(_loc4_ < _loc2_ + 1)
         {
            _loc3_["name" + _loc4_] = this.tippers[_loc4_-1];
            _loc4_++;
         }
         this.textField.text = LocaleManager.localize("flash.popup.tipTheDealer.thankYou" + _loc2_,_loc3_);
         this.updateTextBalloon();
      }
      
      private function updateTextBalloon() : void {
         this.roundRect.width = this.textField.textWidth + 16;
         this.roundRect.height = this.textField.textHeight + 8;
      }
   }
}
