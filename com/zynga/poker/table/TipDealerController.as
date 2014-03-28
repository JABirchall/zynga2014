package com.zynga.poker.table
{
   import flash.events.EventDispatcher;
   import flash.display.Sprite;
   import com.zynga.draw.ShinyButton;
   import flash.utils.Timer;
   import com.zynga.poker.popups.modules.tipTheDealer.DealerComment;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.events.MouseEvent;
   import fl.events.SliderEvent;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.TimerEvent;
   import caurina.transitions.Tweener;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.PokerClassProvider;
   
   public class TipDealerController extends EventDispatcher
   {
      
      public function TipDealerController(param1:DisplayObjectContainer, param2:String, param3:int) {
         super();
         if(param3)
         {
            this.blindMultiplier = param3;
         }
         this.tipContainer = new Sprite();
         this.tipContainer.mouseEnabled = false;
         this.buttonContainer = new Sprite();
         this.dealerComment = new DealerComment();
         this.tipContainer.addChild(this.dealerComment);
         this.dealerComment.alpha = 0;
         this.tipContainer.addChild(this.buttonContainer);
         param1.addChild(this.tipContainer);
         this.tipButton = new ShinyButton(LocaleManager.localize("flash.popup.tipTheDealer.buttonUp"),86,20,13,16777215,"blue");
         this.tipButton.x = 334;
         this.tipButton.y = 68;
         this.tipButton.alpha = 0;
         this.tipButton.visible = false;
         this.tipButton.addEventListener(MouseEvent.ROLL_OVER,this.onTipButtonMouseOver,false,0,true);
         this.tipButton.addEventListener(MouseEvent.ROLL_OUT,this.onTipButtonMouseOut,false,0,true);
         this.tipButton.addEventListener(MouseEvent.CLICK,this.onTipButtonClick,false,0,true);
         this.buttonContainer.addEventListener(MouseEvent.ROLL_OVER,this.onBtnContainerMouseOver,false,0,true);
         this.buttonContainer.addEventListener(MouseEvent.ROLL_OUT,this.onBtnContainerMouseOut,false,0,true);
         this.buttonContainer.addChild(this.tipButton);
         this.commentTimer = new Timer(1000,3);
         this.commentTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCommentTimerComplete,false,0,true);
         if(this.blindMultiplier == -1)
         {
            this.slider = PokerClassProvider.getObject("TipDealerSlider");
            this.slider.x = 334;
            this.slider.visible = false;
            this.slider.closeBtn.addEventListener(MouseEvent.CLICK,this.onSliderCloseButtonClicked,false,0,true);
            this.slider.raiseSlider.getChildAt(0).useHandCursor = true;
            this.slider.raiseSlider.getChildAt(1).useHandCursor = true;
            this.slider.raiseSlider.addEventListener(SliderEvent.CHANGE,this.onSliderChanged,false,0,true);
            this.slider.setChildIndex(this.slider.raiseSlider,this.slider.numChildren-1);
            this.sliderText = new EmbeddedFontTextField("","Main",14,1341232,"center");
            this.sliderText.mouseEnabled = false;
            this.sliderText.height = 25;
            this.slider.raisePopupSliderValueContainer.addChild(this.sliderText);
            this.buttonContainer.addChild(this.slider);
         }
         this.tipTimer = new Timer(1000,5);
         this.tipTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTipTimerComplete,false,0,true);
      }
      
      private static const TIP_MESSAGE_DEALER:String = "dealer";
      
      public var tipContainer:Sprite;
      
      private var buttonContainer:Sprite;
      
      private var tipButton:ShinyButton;
      
      private var tipTimer:Timer;
      
      private var commentTimer:Timer;
      
      private var dealerComment:DealerComment;
      
      private var smallBlind:Number;
      
      private var blindMultiplier:int = 1;
      
      private var tipAmount:Number;
      
      public var slider:MovieClip = null;
      
      private var sliderText:EmbeddedFontTextField;
      
      private var _commentSuppressed:Boolean = false;
      
      public function get tipAmountSmallBlind() : int {
         return this.blindMultiplier;
      }
      
      public function init(param1:Number, param2:Number) : void {
         this.smallBlind = param1;
         this.tipAmount = Math.ceil(Math.abs(this.blindMultiplier) * this.smallBlind);
         if(this.slider)
         {
            this.slider.visible = false;
            this.slider.raiseSlider.minimum = this.smallBlind;
            this.slider.raiseSlider.maximum = Math.min(40 * this.smallBlind,param2);
            this.slider.raiseSlider.snapInterval = this.smallBlind;
            this.slider.raiseSlider.value = this.slider.raiseSlider.minimum;
            this.sliderText.text = PokerCurrencyFormatter.numberToCurrency(this.tipAmount);
         }
         this.tipButton.visible = true;
         this.tipButton.alpha = 1;
         this.dealerComment.alpha = 0.0;
         this.dealerComment.reset();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Impression o:TipDealer:SB" + this.smallBlind + ":2011-11-18"));
         this.tipTimer.reset();
         this.tipTimer.start();
      }
      
      private function onSliderCloseButtonClicked(param1:MouseEvent) : void {
         this.slider.visible = false;
         this.tipTimer.start();
      }
      
      private function onSliderChanged(param1:SliderEvent) : void {
         this.tipAmount = this.slider.raiseSlider.value;
         this.sliderText.text = PokerCurrencyFormatter.numberToCurrency(this.tipAmount,false);
      }
      
      private function onTipButtonMouseOver(param1:MouseEvent) : void {
         this.tipButton.label = LocaleManager.localize("flash.popup.tipTheDealer.buttonOver",{"amount":PokerCurrencyFormatter.numberToCurrency(this.tipAmount,true,2,true,false)});
      }
      
      private function onTipButtonMouseOut(param1:MouseEvent) : void {
         this.tipButton.label = LocaleManager.localize("flash.popup.tipTheDealer.buttonUp");
      }
      
      private function onBtnContainerMouseOver(param1:MouseEvent) : void {
         this.tipTimer.stop();
      }
      
      private function onBtnContainerMouseOut(param1:MouseEvent) : void {
         this.tipTimer.start();
      }
      
      private function onTipButtonClick(param1:MouseEvent) : void {
         if((this.slider) && !this.slider.visible)
         {
            this.slider.visible = true;
            this.slider.alpha = 1;
         }
         else
         {
            if(this.slider)
            {
               this.slider.visible = false;
            }
            if(this.tipButton.alpha == 1)
            {
               dispatchEvent(new TVEvent(TVEvent.ON_TIP_DEALER_CLICK,this.tipAmount));
            }
            this.tipButton.alpha = 0;
            this.tipButton.visible = false;
         }
         if(this.tipTimer.running)
         {
            this.tipTimer.reset();
         }
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TipDealer:2011-11-18"));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Click o:TipDealer:SB" + this.smallBlind + ":2011-11-18"));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:TipDealerChipsSunk:2011-11-18","",this.tipAmount));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Click o:TipDealerChipsSunk:SB" + this.smallBlind + ":2011-11-18","",this.tipAmount));
      }
      
      private function onTipTimerComplete(param1:TimerEvent) : void {
         Tweener.addTween(this.tipButton,
            {
               "alpha":0,
               "time":1,
               "onComplete":this.onTipButtonInvis
            });
         if(this.slider)
         {
            Tweener.addTween(this.slider,
               {
                  "alpha":0,
                  "time":1
               });
         }
      }
      
      private function onTipButtonInvis() : void {
         this.tipButton.visible = false;
         this.tipButton.alpha = 1;
         if(this.slider)
         {
            this.slider.visible = false;
         }
      }
      
      public function showDealerCongrats(param1:String) : void {
         if(this._commentSuppressed)
         {
            return;
         }
         this.dealerComment.alpha = 1;
         this.dealerComment.congratulateUser(param1);
         this.commentTimer.reset();
         this.commentTimer.start();
      }
      
      public function showDealerThanks(param1:String) : void {
         if(this._commentSuppressed)
         {
            return;
         }
         this.dealerComment.alpha = 1;
         this.dealerComment.thankUser(param1);
         if(this.commentTimer.running)
         {
            this.commentTimer.repeatCount = this.commentTimer.repeatCount + 1;
         }
         else
         {
            this.commentTimer.reset();
            this.commentTimer.start();
         }
      }
      
      public function showNotEnoughChips() : void {
         if(this._commentSuppressed)
         {
            return;
         }
         this.dealerComment.alpha = 1;
         this.dealerComment.notEnoughChips();
         this.commentTimer.reset();
         this.commentTimer.start();
      }
      
      private function onCommentTimerComplete(param1:TimerEvent) : void {
         Tweener.addTween(this.dealerComment,
            {
               "alpha":0,
               "time":1
            });
      }
      
      public function set commentSuppressed(param1:Boolean) : void {
         this._commentSuppressed = param1;
      }
   }
}
