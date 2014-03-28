package com.zynga.poker.table
{
   import flash.events.EventDispatcher;
   import flash.utils.Timer;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import com.zynga.poker.table.events.controller.TableAdControllerEvent;
   import com.zynga.poker.table.tableads.validators.TableAdValidator;
   import caurina.transitions.Tweener;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.MovieClip;
   import com.zynga.load.LoadManager;
   import flash.geom.Rectangle;
   import flash.events.MouseEvent;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.table.events.TVEvent;
   
   public class TableAdController extends EventDispatcher
   {
      
      public function TableAdController() {
         super();
         this.adContainer = new Sprite();
         this.adContainer.x = 245;
         this.adContainer.y = 370;
      }
      
      public static const VALIDATOR_TYPE_HSM_REV_PROMO:String = "HSMRevPromo";
      
      private static const AD_IMPRESSION_STAT_SAMPLING_INTERVAL:int = 10;
      
      private var _adCategories:Array;
      
      private var _adFrequency:Number = 0;
      
      private var _spectatorTimer:Timer;
      
      private var _currentAd:Object;
      
      private var _newAd:Object;
      
      private var _isSpectator:Boolean;
      
      private var _lastTimeStamp:Number = 0;
      
      private var _maxWeight:int = 0;
      
      private var _adTooltip:Tooltip;
      
      public var adContainer:Sprite;
      
      public function setAds(param1:Object=null, param2:Number=0, param3:Number=120) : void {
         var _loc4_:Object = null;
         this._adFrequency = param2;
         this._spectatorTimer = new Timer(param3 * 1000,1);
         this._spectatorTimer.addEventListener(TimerEvent.TIMER,this.onAdDelayTimer,false,0,true);
         this._adCategories = new Array();
         for each (_loc4_ in param1)
         {
            this._adCategories.push(new TableAdCategory(_loc4_.weight,_loc4_.categoryName,_loc4_.ads));
            this._maxWeight = this._maxWeight + _loc4_.weight;
         }
      }
      
      public function get initialized() : Boolean {
         return Boolean(this._adCategories);
      }
      
      public function showAd(param1:Boolean=false) : void {
         var _loc2_:Number = new Date().time;
         this._isSpectator = param1;
         if(param1)
         {
            if((this._spectatorTimer.running) && this._spectatorTimer.currentCount < 1)
            {
               this.renderAd();
               return;
            }
            this._spectatorTimer.reset();
            this._spectatorTimer.start();
         }
         else
         {
            this._spectatorTimer.stop();
            if(_loc2_ < this._lastTimeStamp + this._adFrequency * 1000)
            {
               this.renderAd();
               return;
            }
         }
         this._lastTimeStamp = _loc2_;
         this._newAd = this.getAd(param1);
         if(!(this._newAd == null) && !(this._newAd.validator == null))
         {
            addEventListener(TableAdControllerEvent.GET_AD_VALIDATOR_COMPLETE,this.onGetAdValidatorComplete,false,0,true);
            dispatchEvent(new TableAdControllerEvent(TableAdControllerEvent.GET_AD_VALIDATOR,this._newAd.validator));
         }
         else
         {
            this.showNewAd();
         }
      }
      
      private function onGetAdValidatorComplete(param1:TableAdControllerEvent) : void {
         var _loc2_:* = true;
         var _loc3_:TableAdValidator = param1.params as TableAdValidator;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.validate();
         }
         if(_loc2_)
         {
            this.showNewAd();
         }
         removeEventListener(TableAdControllerEvent.GET_AD_VALIDATOR_COMPLETE,this.onGetAdValidatorComplete);
      }
      
      private function showNewAd() : void {
         if((this._newAd) && !(this._currentAd == this._newAd))
         {
            this._currentAd = this._newAd;
            if(this._isSpectator)
            {
               Tweener.addTween(this.adContainer,
                  {
                     "alpha":0,
                     "time":0.5,
                     "transition":"easeInSine",
                     "onComplete":this.renderAd
                  });
            }
            else
            {
               this.renderAd();
            }
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Impression o:BetAd_" + this._currentAd.name + ":2011-07-11","",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_AGNOSTIC,AD_IMPRESSION_STAT_SAMPLING_INTERVAL));
         }
      }
      
      public function stopAds() : void {
         this.clearAd();
         if(this._spectatorTimer)
         {
            this._spectatorTimer.stop();
         }
      }
      
      private function onAdDelayTimer(param1:TimerEvent) : void {
         this.showAd(true);
      }
      
      private function getAd(param1:Boolean=false) : Object {
         var _loc4_:TableAdCategory = null;
         var _loc2_:int = Math.floor(Math.random() * this._maxWeight);
         var _loc3_:* = 0;
         while(_loc3_ < this._adCategories.length)
         {
            _loc4_ = this._adCategories[_loc3_];
            if(_loc2_ < _loc4_.weight)
            {
               return _loc4_.getRandomAd(param1);
            }
            _loc2_ = _loc2_ - _loc4_.weight;
            _loc3_++;
         }
         return null;
      }
      
      private function renderAd() : void {
         var _loc2_:Object = null;
         var _loc3_:EmbeddedFontTextField = null;
         var _loc4_:Object = null;
         var _loc5_:Sprite = null;
         if(!this._currentAd)
         {
            return;
         }
         this.clearAd();
         var _loc1_:MovieClip = this.adContainer.getChildByName("content") as MovieClip;
         if(this._currentAd.imageURL)
         {
            LoadManager.load(this._currentAd.imageURL,{"container":_loc1_});
         }
         if(this._currentAd.textFields)
         {
            for each (_loc2_ in this._currentAd.textFields)
            {
               _loc3_ = new EmbeddedFontTextField(_loc2_.text);
               _loc3_.sizeToFitInRect(new Rectangle(0.0,0.0,_loc3_.textWidth + 10,_loc3_.textHeight));
               _loc3_.width = _loc3_.textWidth + 10;
               _loc3_.x = _loc2_.x;
               _loc3_.y = _loc2_.y;
               _loc1_.addChild(_loc3_);
            }
         }
         if(this._currentAd.button)
         {
            if(this._currentAd.button is Array)
            {
               for each (_loc4_ in this._currentAd.button)
               {
                  this.addButton(_loc4_,_loc1_);
               }
            }
            else
            {
               this.addButton(this._currentAd.button,_loc1_);
            }
         }
         if(this._currentAd.tooltip)
         {
            _loc5_ = new Sprite();
            _loc5_.graphics.beginFill(0,0.0);
            _loc5_.graphics.drawRect(0,0,this._currentAd.tooltip.w,this._currentAd.tooltip.h);
            _loc5_.graphics.endFill();
            _loc5_.x = this._currentAd.tooltip.x;
            _loc5_.y = this._currentAd.tooltip.y;
            _loc5_.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false,0,true);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip,false,0,true);
            _loc1_.addChild(_loc5_);
         }
         Tweener.addTween(this.adContainer,
            {
               "alpha":1,
               "time":0.5,
               "transition":"easeInSine"
            });
      }
      
      private function addButton(param1:Object, param2:Sprite) : void {
         var _loc4_:Sprite = null;
         var _loc3_:Object = new Object();
         _loc3_.jsFunction = param1.jsFunction;
         _loc3_.flFunction = param1.flFunction;
         _loc3_.jsArgs = param1.jsArgs;
         _loc3_.flArgs = param1.flArgs;
         _loc3_.popup = param1.popup;
         _loc3_.isTransparent = param1.isTransparent;
         if(param1.isTransparent)
         {
            _loc4_ = new TransparentButton(param1.w,param1.h,_loc3_);
         }
         else
         {
            _loc4_ = new ShinyButton(param1.label,param1.w,param1.h,14,uint(param1.fontColor),param1.color,"Main",false,5,3,0,0,null,"left",false,null,null,_loc3_);
         }
         _loc4_.addEventListener(MouseEvent.CLICK,this.onAdButtonClick,false,0,true);
         param2.addChild(_loc4_);
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
      }
      
      private function showTooltip(param1:MouseEvent) : void {
         if(this._currentAd == null || this._currentAd.tooltip == null)
         {
            return;
         }
         this.addEventListener(TableAdControllerEvent.GET_AD_TOOLTIP_COMPLETE,this.onGetAdTooltipComplete,false,0,true);
         this.dispatchEvent(new TableAdControllerEvent(TableAdControllerEvent.GET_AD_TOOLTIP,this._currentAd.tooltip));
      }
      
      private function onGetAdTooltipComplete(param1:TableAdControllerEvent) : void {
         var _loc2_:MovieClip = this.adContainer.getChildByName("content") as MovieClip;
         var _loc3_:Number = this._currentAd.tooltip.x + this._currentAd.tooltip.w / 2;
         var _loc4_:String = String(param1.params.resolvedText);
         this._adTooltip = new Tooltip(_loc2_.width - _loc3_,_loc4_,"","",16777215,true);
         this._adTooltip.alpha = 0;
         _loc2_.addChild(this._adTooltip);
         var _loc5_:Number = this._currentAd.tooltip.y - this._adTooltip.height;
         this._adTooltip.x = _loc3_;
         this._adTooltip.y = _loc5_;
         Tweener.addTween(this._adTooltip,
            {
               "alpha":1,
               "time":0.25,
               "delay":0,
               "transition":"easeInSine"
            });
      }
      
      private function hideTooltip(param1:MouseEvent) : void {
         var _loc2_:MovieClip = this.adContainer.getChildByName("content") as MovieClip;
         if(!(this._adTooltip == null) && (_loc2_.contains(this._adTooltip)))
         {
            if(Tweener.isTweening(this._adTooltip))
            {
               Tweener.removeTweens(this._adTooltip);
            }
            this._adTooltip.visible = false;
            _loc2_.removeChild(this._adTooltip);
            this._adTooltip = null;
         }
      }
      
      private function clearAd() : void {
         var _loc1_:MovieClip = this.adContainer.getChildByName("content") as MovieClip;
         if(_loc1_)
         {
            this.adContainer.removeChild(_loc1_);
         }
         _loc1_ = new MovieClip();
         _loc1_.name = "content";
         this.adContainer.addChild(_loc1_);
      }
      
      private function onAdButtonClick(param1:MouseEvent) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:BetAd_" + this._currentAd.name + ":2011-07-11"));
         dispatchEvent(new TVEvent(TVEvent.ON_TABLE_AD_BUTTON_CLICK,param1.currentTarget.getFunctionObject()));
      }
   }
}
import flash.display.Sprite;

class TransparentButton extends Sprite
{
   
   function TransparentButton(param1:Number, param2:Number, param3:Object) {
      super();
      this._params = param3;
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,param1,param2);
      graphics.endFill();
      buttonMode = true;
   }
   
   private var _params:Object;
   
   public function getFunctionObject() : Object {
      return this._params;
   }
}
