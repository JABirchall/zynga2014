package com.zynga.poker.lobby.asset
{
   import com.zynga.draw.CasinoSprite;
   import com.zynga.geom.Size;
   import flash.utils.Timer;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.GradientType;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import caurina.transitions.Tweener;
   import com.zynga.poker.lobby.events.view.LobbyAdContainerEvent;
   import flash.events.TimerEvent;
   
   public class LobbyAdContainer extends CasinoSprite
   {
      
      public function LobbyAdContainer() {
         this.DEFAULT_SIZE = new Size(233,148);
         super();
         this._size = this.DEFAULT_SIZE;
         this.setup();
      }
      
      private const DEFAULT_SIZE:Size;
      
      private const DEFAULT_CYCLE_INTERVAL:Number = 5.0;
      
      private const DEFAULT_TRANSITION_INTERVAL:Number = 0.5;
      
      private var _urlInfoObject:Object;
      
      private var _currentAdKey:String;
      
      private var _adQueue:Array;
      
      private var _adCanvas:CasinoSprite;
      
      private var _adsLoadingCount:int;
      
      private var _cycleTimer:Timer;
      
      private var _cycleInterval:Number;
      
      private var _transitionInterval:Number;
      
      private var _canCycleAds:Boolean;
      
      private var _size:Size;
      
      private function setup() : void {
         this._canCycleAds = false;
         this._transitionInterval = this.DEFAULT_TRANSITION_INTERVAL;
         this._adsLoadingCount = 0;
         this._cycleInterval = this.DEFAULT_CYCLE_INTERVAL;
         var _loc1_:ComplexColorContainer = new ComplexColorContainer();
         _loc1_.alphas = [1,1];
         _loc1_.colors = [4802889,0];
         _loc1_.ratios = [0,255];
         _loc1_.width = this._size.width;
         _loc1_.height = this._size.height;
         _loc1_.rotation = 90;
         graphics.beginGradientFill(GradientType.LINEAR,_loc1_.colors,_loc1_.alphas,_loc1_.ratios,_loc1_.matrix);
         graphics.drawRect(0.0,0.0,_loc1_.width,_loc1_.height);
         graphics.endFill();
         this._adCanvas = new CasinoSprite();
         addChild(this._adCanvas);
      }
      
      public function set urlInfoObject(param1:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function get urlInfoObject() : Object {
         return this._urlInfoObject;
      }
      
      override public function set visible(param1:Boolean) : void {
         super.visible = param1;
         if(visible)
         {
            this.displayAdAtIndex(0);
         }
         else
         {
            this.stopAdCycle();
            if(Tweener.isTweening(this.getAdForKey(this._currentAdKey)))
            {
               Tweener.removeTweens(this.getAdForKey(this._currentAdKey));
            }
            if(contains(this.getAdForKey(this._currentAdKey)))
            {
               this._adCanvas.removeChild(this.getAdForKey(this._currentAdKey));
            }
            this._currentAdKey = "";
         }
      }
      
      public function get adCount() : int {
         if(this._adQueue)
         {
            return this._adQueue.length;
         }
         return 0;
      }
      
      public function getAdForKey(param1:String) : CasinoSprite {
         var _loc2_:int = this.getIndexOfAdKeyInArray(param1,this._adQueue);
         if(_loc2_ != -1)
         {
            return this._adQueue[_loc2_]["value"];
         }
         return null;
      }
      
      private function getIndexOfAdKeyInArray(param1:String, param2:Array) : int {
         var _loc3_:* = 0;
         if((param2) && (param1))
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_]["key"] == param1)
               {
                  return _loc3_;
               }
               _loc3_++;
            }
         }
         return -1;
      }
      
      public function removeAdWithKey(param1:String) : void {
         var _loc2_:* = false;
         var _loc3_:* = 0;
         if(this.getAdForKey(param1))
         {
            _loc2_ = visible;
            if(visible)
            {
               this.visible = false;
            }
            _loc3_ = this.getIndexOfAdKeyInArray(param1,this._adQueue);
            if(_loc3_ != -1)
            {
               this._adQueue[_loc3_]["value"].removeAllChildren();
               delete this._adQueue[[_loc3_]];
               this._adQueue.splice(_loc3_,1);
            }
            if((_loc2_) && (this.adCount))
            {
               this.visible = true;
            }
         }
      }
      
      public function get containerSize() : Size {
         return this._size;
      }
      
      public function set containerSize(param1:Size) : void {
         this._size = param1;
      }
      
      public function set cycleInterval(param1:Number) : void {
         this._cycleInterval = param1;
         if((this._canCycleAds) && (this._cycleTimer))
         {
            if(this._cycleTimer.running)
            {
               this.stopAdCycle();
               this.startAdCycle();
            }
         }
      }
      
      public function get cycleInterval() : Number {
         return this._cycleInterval;
      }
      
      public function set transitionInterval(param1:Number) : void {
         this._transitionInterval = param1;
      }
      
      public function get transitionInterval() : Number {
         return this._transitionInterval;
      }
      
      public function set canCycleAds(param1:Boolean) : void {
         this._canCycleAds = param1;
         if(this._canCycleAds)
         {
            if(this._adsLoadingCount == 0)
            {
               this.startAdCycle();
            }
         }
         else
         {
            this.stopAdCycle();
         }
      }
      
      public function get canCycleAds() : Boolean {
         return this._canCycleAds;
      }
      
      private function allAdsLoaded() : void {
         this.displayAdAtIndex(0);
      }
      
      private function displayAdAtIndex(param1:int) : void {
         var outgoingAdKey:String = null;
         var inIndex:int = param1;
         if(!this._adQueue || !this.adCount)
         {
            return;
         }
         outgoingAdKey = "";
         if((this._currentAdKey) && !(this._currentAdKey == ""))
         {
            outgoingAdKey = this._currentAdKey;
            dispatchEvent(new LobbyAdContainerEvent(LobbyAdContainerEvent.ON_AD_PRE_REMOVE,outgoingAdKey));
         }
         this._currentAdKey = this._adQueue[inIndex]["key"];
         dispatchEvent(new LobbyAdContainerEvent(LobbyAdContainerEvent.ON_AD_PRE_DISPLAY,this._currentAdKey));
         this._adQueue[inIndex]["value"].alpha = 0.0;
         Tweener.addTween(this._adQueue[inIndex]["value"],
            {
               "alpha":1,
               "time":this._transitionInterval,
               "transition":"linear",
               "onStart":function():void
               {
                  _adCanvas.addChild(_adQueue[inIndex]["value"]);
               },
               "onComplete":function():void
               {
                  dispatchEvent(new LobbyAdContainerEvent(LobbyAdContainerEvent.ON_AD_DISPLAY,_currentAdKey));
                  if((outgoingAdKey) && !(outgoingAdKey == ""))
                  {
                     _adCanvas.removeChild(getAdForKey(outgoingAdKey));
                     dispatchEvent(new LobbyAdContainerEvent(LobbyAdContainerEvent.ON_AD_REMOVE,outgoingAdKey));
                  }
                  if(adCount > 1 && (_canCycleAds))
                  {
                     startAdCycle();
                  }
               }
            });
      }
      
      private function startAdCycle() : void {
         if(!this._cycleTimer)
         {
            this._cycleTimer = new Timer(this._cycleInterval * 1000,1);
            this._cycleTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCycleTimerComplete,false,0,true);
         }
         if(!this._cycleTimer.running)
         {
            this._cycleTimer.reset();
            this._cycleTimer.start();
         }
      }
      
      private function stopAdCycle() : void {
         if(this._cycleTimer)
         {
            this._cycleTimer.stop();
            if(this._cycleTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
            {
               this._cycleTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCycleTimerComplete);
            }
            this._cycleTimer = null;
         }
      }
      
      private function onCycleTimerComplete(param1:TimerEvent) : void {
         this.stopAdCycle();
         var _loc2_:int = this.getIndexOfAdKeyInArray(this._currentAdKey,this._adQueue);
         if(!(_loc2_ == -1) && _loc2_ < this.adCount-1)
         {
            this.displayAdAtIndex(_loc2_ + 1);
         }
         else
         {
            this.displayAdAtIndex(0);
         }
      }
      
      private function onAdLoaderComplete(param1:Event) : void {
         if(--this._adsLoadingCount == 0)
         {
            this.allAdsLoaded();
         }
      }
   }
}
