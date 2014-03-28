package com.zynga.poker.nav.assets
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import caurina.transitions.Tweener;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public class NavFTUE extends Sprite
   {
      
      public function NavFTUE() {
         super();
      }
      
      private var ftueOverlay:MovieClip;
      
      private var marketingArrow:MovieClip;
      
      private var marketingText:EmbeddedFontTextField;
      
      private var arrowAnimX1:Number;
      
      private var navItem:Sprite;
      
      private var textStrings:Array;
      
      private var _active:Boolean = true;
      
      public function init(param1:Object, param2:Boolean=false) : void {
         this.textStrings = param1.text;
         this.ftueOverlay = PokerClassProvider.getObject("FTUE_overlay_topnav");
         this.ftueOverlay.alpha = 0;
         addChild(this.ftueOverlay);
         Tweener.addTween(this.ftueOverlay,
            {
               "alpha":1,
               "delay":1,
               "time":1,
               "transition":"easeInExpo"
            });
         this.marketingArrow = PokerClassProvider.getObject("pokerGirlMarketingArrow");
         this.marketingText = new EmbeddedFontTextField(this.textStrings.shift(),"Main",12);
         this.marketingText.height = 50;
         this.marketingText.wordWrap = true;
         this.marketingText.multiline = true;
         this.marketingText.x = 135;
         this.marketingText.y = -this.marketingText.textHeight / 2;
         this.marketingText.width = 125;
         if(param2)
         {
            this.marketingArrow.scaleX = -1;
            this.marketingText.scaleX = -1;
            this.marketingText.x = 260;
         }
         this.marketingArrow.x = this.marketingArrow.scaleX * 50;
         this.marketingArrow.y = 25;
         this.marketingArrow.buttonMode = false;
         this.marketingArrow.useHandCursor = false;
         addChild(this.marketingArrow);
         this.marketingArrow.addChild(this.marketingText);
         this.arrowAnimX1 = this.marketingArrow.x;
         this.bounceArrowOut();
      }
      
      private function bounceArrowIn() : void {
         Tweener.addTween(this.marketingArrow,
            {
               "x":this.arrowAnimX1,
               "time":0.5,
               "onComplete":this.bounceArrowOut,
               "transition":"easeInOutSine"
            });
      }
      
      private function bounceArrowOut() : void {
         Tweener.addTween(this.marketingArrow,
            {
               "x":this.arrowAnimX1 + 25,
               "time":0.5,
               "onComplete":this.bounceArrowIn,
               "transition":"easeInOutSine"
            });
      }
      
      public function updateText() : void {
         var _loc1_:MovieClip = null;
         if(this.textStrings.length > 0)
         {
            this.marketingArrow.visible = true;
            this.marketingText.text = this.textStrings.shift();
            this.marketingText.y = -this.marketingText.textHeight / 2;
         }
         else
         {
            this.clearFTUE();
         }
         if(this.textStrings.length == 0)
         {
            Tweener.removeTweens(this.marketingArrow);
            this.marketingArrow.x = this.arrowAnimX1;
            _loc1_ = PokerClassProvider.getObject("FTUE_arrowCloseButton");
            _loc1_.x = 260;
            _loc1_.y = -18;
            this.marketingArrow.addChild(_loc1_);
            this.marketingArrow.addEventListener(MouseEvent.CLICK,this.clearFTUE,false,0,true);
            this.marketingArrow.buttonMode = true;
            this.marketingArrow.useHandCursor = true;
         }
      }
      
      public function hideFTUE() : void {
         Tweener.addTween(this.ftueOverlay,
            {
               "alpha":0.0,
               "time":0.5,
               "onComplete":function():void
               {
                  ftueOverlay.visible = false;
               }
            });
         this.marketingArrow.visible = false;
      }
      
      public function clearFTUE(param1:Event=null) : void {
         Tweener.removeTweens(this.marketingArrow);
         this.parent.removeChild(this);
         this._active = false;
      }
      
      public function get active() : Boolean {
         return this._active;
      }
   }
}
