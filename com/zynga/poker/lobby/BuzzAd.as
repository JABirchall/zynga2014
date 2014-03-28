package com.zynga.poker.lobby
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.events.URLEvent;
   import flash.events.Event;
   import com.adobe.serialization.json.JSON;
   import flash.events.MouseEvent;
   import com.zynga.poker.lobby.events.LVEvent;
   import com.zynga.poker.lobby.events.view.BuzzAdEvent;
   import flash.events.TimerEvent;
   import caurina.transitions.Tweener;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   
   public class BuzzAd extends MovieClip
   {
      
      public function BuzzAd(param1:String) {
         var _loc3_:EmbeddedFontTextField = null;
         super();
         this.buzzAd = PokerClassProvider.getObject("BuzzAd");
         addChild(this.buzzAd);
         var _loc2_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.buzzBox.previousButton"),"Main",12,16777215);
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.x = -8;
         _loc2_.y = -9;
         this.buzzAd.previousButton.addChild(_loc2_);
         this.buzzAd.previousButton.buttonMode = true;
         this.buzzAd.previousButton.mouseChildren = false;
         _loc3_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.buzzBox.nextButton"),"Main",12,16777215,"right");
         _loc3_.autoSize = TextFieldAutoSize.RIGHT;
         _loc3_.x = Math.round(-_loc3_.width + 8);
         _loc3_.y = -9;
         this.buzzAd.nextButton.addChild(_loc3_);
         this.buzzAd.nextButton.buttonMode = true;
         this.buzzAd.nextButton.mouseChildren = false;
         this._slidesShownDictionary = new Dictionary();
         this.loadBuzzAd(param1);
      }
      
      private var buzzAd:MovieClip;
      
      private var slides:Array;
      
      private var totalSlides:Number = 0;
      
      private var currentSlideIndex:Number = 0;
      
      private var defaultSlideDuration:Number = 3;
      
      private var fadeDuration:Number = 0.5;
      
      private var slideDurationTimer:Timer;
      
      private var _slidesShownDictionary:Dictionary;
      
      private function getSlideByIndex(param1:Number) : BuzzSlide {
         var _loc2_:BuzzSlide = null;
         if((this.slides) && param1 < this.slides.length)
         {
            _loc2_ = this.slides[param1];
         }
         return _loc2_;
      }
      
      private function loadBuzzAd(param1:String) : void {
         var _loc2_:LoadUrlVars = new LoadUrlVars();
         _loc2_.addEventListener(URLEvent.onLoaded,this.onBuzzAdLoaded);
         _loc2_.loadURL(param1,{},"POST");
      }
      
      private function onBuzzAdLoaded(param1:Event) : void {
         var _loc2_:Object = null;
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc5_:BuzzSlide = null;
         if(param1.target != null)
         {
            try
            {
               parent.getChildByName("buzzBoxBk").visible = true;
               _loc2_ = com.adobe.serialization.json.JSON.decode(unescape(param1.target.data));
               this.defaultSlideDuration = Number(_loc2_["uSecSlideOnScreen"]);
               this.fadeDuration = Number(_loc2_["uSecFadeSlide"]);
               this.currentSlideIndex = 0;
               this.totalSlides = _loc2_["aAds"].length;
               if(this.totalSlides > 1)
               {
                  this.buzzAd.previousButton.addEventListener(MouseEvent.CLICK,this.onPreviousButtonClick);
                  this.buzzAd.nextButton.addEventListener(MouseEvent.CLICK,this.onNextButtonClick);
               }
               else
               {
                  this.buzzAd.previousButton.visible = false;
                  this.buzzAd.nextButton.visible = false;
               }
               this.slides = new Array();
               _loc3_ = 0;
               while(_loc3_ < _loc2_["aAds"].length)
               {
                  _loc4_ = _loc2_["aAds"][_loc3_];
                  _loc5_ = new BuzzSlide(_loc4_["sImageUrl"],_loc4_["sLinkUrl"],_loc4_["sUrlTarget"],Number(_loc4_["uSecOnScreen"]));
                  _loc5_.slideID = _loc4_["trackStr"];
                  _loc5_.addEventListener(MouseEvent.CLICK,this.onSlideClick);
                  this.slides.push(_loc5_);
                  if(_loc3_ == 0)
                  {
                     this.buzzAd.mcContainer.addChild(_loc5_);
                     if(!this._slidesShownDictionary[_loc5_.slideID])
                     {
                        dispatchEvent(new LVEvent(LVEvent.BUZZ_AD_IMPRESSION,{"slideId":_loc5_.slideID}));
                        this._slidesShownDictionary[_loc5_.slideID] = 1;
                     }
                  }
                  else
                  {
                     if(_loc3_ == this.totalSlides-1)
                     {
                        _loc5_.addEventListener(Event.COMPLETE,this.onLastSlideComplete);
                     }
                  }
                  _loc3_++;
               }
            }
            catch(err:Error)
            {
            }
         }
         if(param1.target != null)
         {
            return;
         }
      }
      
      private function onLastSlideComplete(param1:Event) : void {
         this.startSlideDurationTimer();
      }
      
      private function onSlideClick(param1:MouseEvent) : void {
         var _loc2_:BuzzSlide = param1.target as BuzzSlide;
         if(_loc2_)
         {
            if(_loc2_.linkUrl)
            {
               dispatchEvent(new BuzzAdEvent(LVEvent.BUZZ_AD_CLICK,_loc2_.linkUrl,_loc2_.linkTarget));
            }
         }
      }
      
      private function onPreviousButtonClick(param1:MouseEvent) : void {
         this.showPreviousSlide();
      }
      
      private function onNextButtonClick(param1:MouseEvent) : void {
         this.showNextSlide();
      }
      
      private function showPreviousSlide() : void {
         var _loc1_:BuzzSlide = this.getSlideByIndex(this.currentSlideIndex);
         var _loc2_:Number = this.currentSlideIndex-1;
         if(_loc2_ < 0)
         {
            _loc2_ = this.totalSlides-1;
         }
         var _loc3_:BuzzSlide = this.getSlideByIndex(_loc2_);
         this.fadeSlides(_loc1_,_loc3_);
         this.currentSlideIndex = _loc2_;
      }
      
      private function showNextSlide() : void {
         var _loc1_:BuzzSlide = this.getSlideByIndex(this.currentSlideIndex);
         var _loc2_:Number = this.currentSlideIndex + 1;
         if(_loc2_ >= this.totalSlides)
         {
            _loc2_ = 0;
         }
         var _loc3_:BuzzSlide = this.getSlideByIndex(_loc2_);
         this.fadeSlides(_loc1_,_loc3_);
         this.currentSlideIndex = _loc2_;
      }
      
      private function startSlideDurationTimer() : void {
         var _loc1_:Number = this.defaultSlideDuration;
         var _loc2_:BuzzSlide = this.getSlideByIndex(this.currentSlideIndex);
         if(_loc2_)
         {
            _loc1_ = _loc2_.duration;
         }
         if(this.slideDurationTimer == null)
         {
            this.slideDurationTimer = new Timer(_loc1_ * 1000,1);
            this.slideDurationTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSlideDurationTimerComplete);
         }
         else
         {
            this.slideDurationTimer.reset();
            this.slideDurationTimer.delay = _loc1_ * 1000;
         }
         this.slideDurationTimer.start();
      }
      
      private function stopSlideDurationTimer() : void {
         if(this.slideDurationTimer != null)
         {
            this.slideDurationTimer.reset();
         }
      }
      
      private function onSlideDurationTimerComplete(param1:TimerEvent) : void {
         this.showNextSlide();
      }
      
      private function fadeSlides(param1:BuzzSlide, param2:BuzzSlide) : void {
         this.stopSlideDurationTimer();
         Tweener.addTween(param1,
            {
               "alpha":0,
               "time":this.fadeDuration,
               "onComplete":this.onSlideFadeOutComplete,
               "onCompleteParams":[param1]
            });
         param2.alpha = 0;
         this.buzzAd.mcContainer.addChild(param2);
         if(!this._slidesShownDictionary[param2.slideID])
         {
            dispatchEvent(new LVEvent(LVEvent.BUZZ_AD_IMPRESSION,{"slideId":param2.slideID}));
            this._slidesShownDictionary[param2.slideID] = 1;
         }
         Tweener.addTween(param2,
            {
               "alpha":1,
               "time":this.fadeDuration,
               "onComplete":this.onSlideFadeInComplete,
               "onCompleteParams":[param2]
            });
      }
      
      private function onSlideFadeOutComplete(param1:BuzzSlide) : void {
         if((param1) && (this.buzzAd.mcContainer.contains(param1)))
         {
            this.buzzAd.mcContainer.removeChild(param1);
         }
      }
      
      private function onSlideFadeInComplete(param1:BuzzSlide) : void {
         this.startSlideDurationTimer();
      }
   }
}
