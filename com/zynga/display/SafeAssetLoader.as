package com.zynga.display
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import com.zynga.poker.SSLMigration;
   
   public class SafeAssetLoader extends Loader
   {
      
      public function SafeAssetLoader(param1:String="", param2:String="", param3:Number=0) {
         this.supportedContent = ["image/jpeg","image/gif","image/png","application/x-shockwave-flash"];
         super();
         this.defaultUrl = param1?param1:DEFAULT_PROFILE_IMAGE_URL;
         this.defaultUrl = SSLMigration.getSecureURL(this.defaultUrl);
         this.trackString = param2?param2:"";
         this.timeout = param3;
         this.isInitialLoad = true;
         this.shouldAttemptFallbackURL = false;
         this.hasAttemptedFallbackURL = false;
      }
      
      public static const DOMAIN_WHITELIST:Array = new Array(
         {
            "domain":".facebook.com",
            "allowQuerystring":false
         },
         {
            "domain":".fbcdn.net",
            "allowQuerystring":false
         },
         {
            "domain":".poker.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":".casino.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":"zlive.s3.amazonaws.com",
            "allowQuerystring":false
         },
         {
            "domain":"iphone.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":"proxy.poker.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":".static.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":".zlive.zynga.com",
            "allowQuerystring":false
         },
         {
            "domain":"graph.facebook.com",
            "allowQuerystring":true
         },
         {
            "domain":new RegExp("^lh[0-9].googleusercontent.com$"),
            "allowQuerystring":true
         },
         {
            "domain":"zynga1-a.akamaihd.net",
            "allowQuerystring":false
         },
         {
            "domain":"fbcdn-profile-a.akamaihd.net",
            "allowQuerystring":false
         },
         {
            "domain":"media.zynga.com",
            "allowQuerystring":false
         });
      
      public static const EXTERNAL_SANDBOX_IMAGES:Array = ["http://static.ak.fbcdn.net/pics/q_silhouette.gif","http://static.ak.facebook.com//pics/q_default.gif","http://static.ak.facebook.com/pics/d_default.gif"];
      
      public static const DEFAULT_PROFILE_IMAGE_URL:String = "http://statics.poker.static.zynga.com/poker/img/zSilhouette100.png";
      
      public static const STAGE_INITIAL:String = "Initial";
      
      public static const STAGE_ALTERNATE:String = "Alternate";
      
      public static const STAGE_DEFAULT:String = "Default";
      
      public static const STAGE_UNKNOWN:String = "Unknown";
      
      protected static const STAT_SAMPLING_INTERVAL:Number = 30;
      
      public static const FIRE_AUDITING_STATS:Boolean = false;
      
      public static function checkValidUrl(param1:String) : Boolean {
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:Object = null;
         var _loc2_:RegExp = new RegExp("^https?:\\/\\/([\\w\\.-]+)(\\/[^\\?]*(\\?)?.*)?$","i");
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_[1];
            _loc5_ = Boolean(_loc3_[3]);
            _loc6_ = false;
            for each (_loc7_ in DOMAIN_WHITELIST)
            {
               if(_loc7_.domain is RegExp && _loc4_.search(_loc7_.domain) >= 0 || !(_loc7_.domain is RegExp) && _loc4_.substring(_loc4_.length - _loc7_.domain.length) == _loc7_.domain)
               {
                  _loc6_ = !_loc5_ || (_loc5_) && (_loc7_.allowQuerystring)?true:false;
               }
            }
            return _loc6_;
         }
         return false;
      }
      
      protected var supportedContent:Array;
      
      protected var request:URLRequest;
      
      protected var context:LoaderContext;
      
      protected var defaultUrl:String;
      
      protected var trackString:String;
      
      protected var timeout:Number;
      
      protected var currentStage:String = "Unknown";
      
      protected var isInitialLoad:Boolean;
      
      protected var shouldLoadDefaultContent:Boolean = false;
      
      protected var shouldAttemptFallbackURL:Boolean;
      
      protected var hasAttemptedFallbackURL:Boolean;
      
      private var fallbackUrl:String = "";
      
      protected var timeoutTimer:Timer;
      
      public function set fallbackURL(param1:String) : void {
         if(this.fallbackUrl != param1)
         {
            this.fallbackUrl = param1;
            if(this.fallbackUrl != "")
            {
               if(SafeAssetLoader.checkValidUrl(this.fallbackUrl))
               {
                  this.shouldAttemptFallbackURL = true;
               }
               else
               {
                  this.shouldAttemptFallbackURL = false;
                  this.fallbackUrl = "";
               }
            }
            this.hasAttemptedFallbackURL = false;
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext=null) : void {
         this.unloadContent();
         if(this.isInitialLoad)
         {
            this.isInitialLoad = false;
            this.currentStage = STAGE_INITIAL;
         }
         if(param1 == null || !param1.url)
         {
            this.loadDefaultImage();
            return;
         }
         if(EXTERNAL_SANDBOX_IMAGES.indexOf(param1.url) > -1)
         {
            param1.url = this.defaultUrl;
         }
         if(!this.doLoad(param1,param2))
         {
            this.loadDefaultImage();
         }
      }
      
      protected function doLoad(param1:URLRequest, param2:LoaderContext) : Boolean {
         var _loc3_:* = false;
         this.context = param2 == null?new LoaderContext():param2;
         if(SafeAssetLoader.checkValidUrl(param1.url))
         {
            this.request = param1;
            this.addEventListeners();
            this.context.checkPolicyFile = true;
            super.load(this.request,this.context);
            _loc3_ = this.timeout > 0;
            if(_loc3_)
            {
               if(this.timeoutTimer == null)
               {
                  this.timeoutTimer = new Timer(this.timeout,1);
                  this.timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout,false,0,true);
               }
               this.timeoutTimer.reset();
               this.timeoutTimer.start();
            }
            return true;
         }
         return false;
      }
      
      public function dispose() : void {
         this.removeEventListeners();
         this.stopTimer();
         this.timeoutTimer = null;
         try
         {
            close();
         }
         catch(e:Error)
         {
         }
         this.unloadContent();
      }
      
      protected function stopTimer() : void {
         if(this.timeoutTimer != null)
         {
            this.timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
            if(this.timeoutTimer.running)
            {
               this.timeoutTimer.stop();
            }
         }
      }
      
      public function addEventListeners() : void {
         if(this.contentLoaderInfo)
         {
            this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
            this.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      public function removeEventListeners() : void {
         if(this.contentLoaderInfo)
         {
            this.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
            this.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
      }
      
      protected function checkValidContent() : Boolean {
         var _loc1_:String = null;
         for each (_loc1_ in this.supportedContent)
         {
            if(this.contentLoaderInfo.contentType == _loc1_)
            {
               return true;
            }
         }
         this.unloadContent();
         this.loadDefaultImage();
         return false;
      }
      
      protected function onTimeout(param1:TimerEvent) : void {
         this.removeEventListeners();
         try
         {
            close();
         }
         catch(e:Error)
         {
         }
         this.unloadContent();
         this.performFallbackRoutine();
      }
      
      private function onComplete(param1:Event) : void {
         this.stopTimer();
         if(!this.contentLoaderInfo.contentType)
         {
            return;
         }
         if(!this.checkValidContent())
         {
            param1.stopImmediatePropagation();
         }
         else
         {
            this.request = null;
            this.context = null;
         }
         this.removeEventListeners();
      }
      
      private function onProgress(param1:ProgressEvent) : void {
         if(!this.contentLoaderInfo.contentType)
         {
            return;
         }
         if(!this.checkValidContent())
         {
            param1.stopImmediatePropagation();
            this.close();
         }
      }
      
      protected function performFallbackRoutine() : void {
         if(this.shouldLoadDefaultContent)
         {
            if((!this.hasAttemptedFallbackURL && this.shouldAttemptFallbackURL) && (this.fallbackUrl) && !(this.fallbackUrl == ""))
            {
               this.hasAttemptedFallbackURL = true;
               this.shouldAttemptFallbackURL = false;
               this.currentStage = STAGE_ALTERNATE;
               this.load(new URLRequest(this.fallbackUrl));
               return;
            }
            this.currentStage = STAGE_DEFAULT;
            this.loadDefaultImage();
         }
      }
      
      protected function loadDefaultImage() : void {
         if(this.shouldLoadDefaultContent)
         {
            this.removeEventListeners();
            this.timeout = 0;
            if(this.timeoutTimer != null)
            {
               this.timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
            }
            if(this.request == null || !(this.request.url == this.defaultUrl))
            {
               this.load(new URLRequest(this.defaultUrl),this.context);
            }
         }
      }
      
      public function unloadContent() : void {
         unloadAndStop();
         this.request = null;
         this.context = null;
      }
   }
}
