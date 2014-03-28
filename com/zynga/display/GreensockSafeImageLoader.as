package com.zynga.display
{
   import com.greensock.loading.ImageLoader;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.IOErrorEvent;
   import flash.events.Event;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class GreensockSafeImageLoader extends ImageLoader
   {
      
      public function GreensockSafeImageLoader(param1:*, param2:Object=null) {
         super(param1,param2);
         this._trackString = (param2.trackString) && !(param2.trackString == "")?param2.trackString:"";
         this._timeout = (param2.timeout) && param2.timeout > 0?param2.timeout:0;
         if((param2.fallbackURL) && !(param2.fallbackURL == ""))
         {
            this._fallbackUrl = param2.fallbackURL;
            this._shouldAttemptFallbackURL = true;
         }
         else
         {
            this._shouldAttemptFallbackURL = false;
            this._fallbackUrl = "";
         }
         this._hasAttemptedFallbackURL = false;
      }
      
      protected static const STAT_IMAGE_LOAD_ATTEMPTED:String = "ImageLoadAttempted";
      
      protected static const STAT_IMAGE_LOAD_FAILED:String = "ImageLoadFailed";
      
      protected static const STAT_IMAGE_LOAD_FAILED_TIMEOUT:String = "ImageLoadFailedTimeout";
      
      protected static const STAT_IMAGE_LOAD_SUCCEEDED:String = "ImageLoadSucceeded";
      
      protected static const STAGE_INITIAL:String = "Initial";
      
      protected static const STAGE_ALTERNATE:String = "Alternate";
      
      protected static const STAGE_DEFAULT:String = "Default";
      
      protected static const STAGE_UNKNOWN:String = "Unknown";
      
      protected static const IMAGE_STAT_SAMPLING_INTERVAL:Number = 30;
      
      private var _shouldAttemptFallbackURL:Boolean;
      
      private var _hasAttemptedFallbackURL:Boolean;
      
      private var _isInitialLoad:Boolean = true;
      
      private var _fallbackUrl:String = "";
      
      private var _trackString:String = "";
      
      private var _currentStage:String = "Unknown";
      
      private var _timeout:Number = 0;
      
      private var _timeoutTimer:Timer;
      
      override public function dispose(param1:Boolean=false) : void {
         this.stopTimer();
         this._timeoutTimer = null;
         super.dispose(param1);
      }
      
      override protected function _load() : void {
         if(this._isInitialLoad)
         {
            this._isInitialLoad = false;
            this._currentStage = STAGE_INITIAL;
         }
         this.doHitForStat(this._currentStage,STAT_IMAGE_LOAD_ATTEMPTED);
         super._load();
         var _loc1_:* = this._timeout > 0;
         if(_loc1_)
         {
            if(this._timeoutTimer == null)
            {
               this._timeoutTimer = new Timer(this._timeout,1);
               this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this._onTimeout,false,0,true);
            }
            this._timeoutTimer.reset();
            this._timeoutTimer.start();
         }
      }
      
      protected function _onTimeout(param1:TimerEvent) : void {
         unload();
         this.doHitForStat(this._currentStage,STAT_IMAGE_LOAD_FAILED_TIMEOUT);
         this.performFallbackRoutine(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"Image Load Timeout"));
      }
      
      override protected function _initHandler(param1:Event) : void {
         this.stopTimer();
         switch(_loader.contentLoaderInfo.contentType)
         {
            case "image/jpeg":
            case "image/gif":
            case "image/png":
               this.doHitForStat(this._currentStage,STAT_IMAGE_LOAD_SUCCEEDED);
               super._initHandler(param1);
               return;
            case "application/x-shockwave-flash":
            default:
               param1.stopImmediatePropagation();
               unload();
               this._loadDefaultImage();
               return;
         }
         
      }
      
      override protected function _failHandler(param1:Event) : void {
         this.doHitForStat(this._currentStage,STAT_IMAGE_LOAD_FAILED);
         this.performFallbackRoutine(param1);
      }
      
      protected function _loadDefaultImage() : Boolean {
         this._timeout = 0;
         if(this._timeoutTimer != null)
         {
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this._onTimeout);
         }
         if(!(this.vars.alternateURL == undefined) && !(this.vars.alternateURL == "") && !_skipAlternateURL)
         {
            _skipAlternateURL = true;
            _url = "temp" + Math.random();
            this.url = this.vars.alternateURL;
            return true;
         }
         return false;
      }
      
      protected function performFallbackRoutine(param1:Event) : void {
         if((!this._hasAttemptedFallbackURL && this._shouldAttemptFallbackURL) && (this._fallbackUrl) && !(this._fallbackUrl == ""))
         {
            this._hasAttemptedFallbackURL = true;
            this._shouldAttemptFallbackURL = false;
            this._currentStage = STAGE_ALTERNATE;
            this.url = this._fallbackUrl;
            _errorHandler(param1);
            return;
         }
         this._currentStage = STAGE_DEFAULT;
         var _loc2_:Boolean = this._loadDefaultImage();
         if(!_loc2_)
         {
            super._failHandler(param1);
         }
         else
         {
            _errorHandler(param1);
         }
      }
      
      protected function doHitForStat(param1:String, param2:String) : void {
         var _loc3_:String = param1 + param2;
         if(!(this._trackString == null) && !(this._trackString == ""))
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,this._trackString.replace("%ACTION%",_loc3_),"",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_AGNOSTIC,IMAGE_STAT_SAMPLING_INTERVAL));
         }
      }
      
      protected function stopTimer() : void {
         if(this._timeoutTimer != null)
         {
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this._onTimeout);
            if(this._timeoutTimer.running)
            {
               this._timeoutTimer.stop();
            }
         }
      }
   }
}
