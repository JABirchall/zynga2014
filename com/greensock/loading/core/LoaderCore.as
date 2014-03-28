package com.greensock.loading.core
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.greensock.loading.LoaderMax;
   import flash.utils.getTimer;
   import com.greensock.loading.LoaderStatus;
   import com.greensock.events.LoaderEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.display.DisplayObject;
   import flash.net.LocalConnection;
   import flash.system.Capabilities;
   
   public class LoaderCore extends EventDispatcher
   {
      
      public function LoaderCore(param1:Object=null) {
         var _loc2_:String = null;
         super();
         this.vars = param1 != null?param1:{};
         if(this.vars.isGSVars)
         {
            this.vars = this.vars.vars;
         }
         this.name = !(this.vars.name == undefined) && !(String(this.vars.name) == "")?this.vars.name:"loader" + _loaderCount++;
         this._cachedBytesLoaded = 0;
         this._cachedBytesTotal = uint(this.vars.estimatedBytes) != 0?uint(this.vars.estimatedBytes):LoaderMax.defaultEstimatedBytes;
         this.autoDispose = Boolean(this.vars.autoDispose == true);
         this._status = this.vars.paused == true?LoaderStatus.PAUSED:LoaderStatus.READY;
         this._auditedSize = Boolean((!(uint(this.vars.estimatedBytes) == 0)) && (!(this.vars.auditSize == true)));
         this._rootLoader = this.vars.requireWithRoot is DisplayObject?_rootLookup[this.vars.requireWithRoot]:_globalRootLoader;
         if(_globalRootLoader == null)
         {
            if(this.vars.__isRoot == true)
            {
               return;
            }
            _globalRootLoader = this._rootLoader = new LoaderMax(
               {
                  "name":"root",
                  "__isRoot":true
               });
            _isLocal = Boolean((new LocalConnection().domain == "localhost") || (Capabilities.playerType == "Desktop"));
         }
         if(this._rootLoader)
         {
            this._rootLoader.append(this);
         }
         else
         {
            _rootLookup[this.vars.requireWithRoot] = this._rootLoader = new LoaderMax();
            this._rootLoader.name = "subloaded_swf_" + this.vars.requireWithRoot.loaderInfo.url;
            this._rootLoader.append(this);
         }
         for (_loc2_ in _listenerTypes)
         {
            if(_loc2_  in  this.vars && this.vars[_loc2_] is Function)
            {
               this.addEventListener(_listenerTypes[_loc2_],this.vars[_loc2_],false,0,true);
            }
         }
      }
      
      public static const version:Number = 1.7;
      
      protected static var _loaderCount:uint = 0;
      
      protected static var _rootLookup:Dictionary = new Dictionary(false);
      
      protected static var _isLocal:Boolean;
      
      protected static var _globalRootLoader:LoaderMax;
      
      protected static var _listenerTypes:Object = 
         {
            "onOpen":"open",
            "onInit":"init",
            "onComplete":"complete",
            "onProgress":"progress",
            "onCancel":"cancel",
            "onFail":"fail",
            "onError":"error",
            "onSecurityError":"securityError",
            "onHTTPStatus":"httpStatus",
            "onIOError":"ioError",
            "onScriptAccessDenied":"scriptAccessDenied",
            "onChildOpen":"childOpen",
            "onChildCancel":"childCancel",
            "onChildComplete":"childComplete",
            "onChildProgress":"childProgress",
            "onChildFail":"childFail"
         };
      
      protected static var _types:Object = {};
      
      protected static var _extensions:Object = {};
      
      protected static function _activateClass(param1:String, param2:Class, param3:String) : Boolean {
         _types[param1.toLowerCase()] = param2;
         var _loc4_:Array = param3.split(",");
         var _loc5_:int = _loc4_.length;
         while(--_loc5_ > -1)
         {
            _extensions[_loc4_[_loc5_]] = param2;
         }
         return true;
      }
      
      protected var _cachedBytesLoaded:uint;
      
      protected var _cachedBytesTotal:uint;
      
      protected var _status:int;
      
      protected var _prePauseStatus:int;
      
      protected var _dispatchProgress:Boolean;
      
      protected var _rootLoader:LoaderMax;
      
      protected var _cacheIsDirty:Boolean;
      
      protected var _auditedSize:Boolean;
      
      protected var _dispatchChildProgress:Boolean;
      
      protected var _type:String;
      
      protected var _time:uint;
      
      protected var _content;
      
      public var vars:Object;
      
      public var name:String;
      
      public var autoDispose:Boolean;
      
      public function load(param1:Boolean=false) : void {
         var _loc2_:uint = getTimer();
         if(this.status == LoaderStatus.PAUSED)
         {
            this._status = this._prePauseStatus <= LoaderStatus.LOADING?LoaderStatus.READY:this._prePauseStatus;
            if(this._status == LoaderStatus.READY && this is LoaderMax)
            {
               _loc2_ = _loc2_ - this._time;
            }
         }
         if((param1) || this._status == LoaderStatus.FAILED)
         {
            this._dump(1,LoaderStatus.READY);
         }
         if(this._status == LoaderStatus.READY)
         {
            this._status = LoaderStatus.LOADING;
            this._time = _loc2_;
            this._load();
            if(this.progress < 1)
            {
               dispatchEvent(new LoaderEvent(LoaderEvent.OPEN,this));
            }
         }
         else
         {
            if(this._status == LoaderStatus.COMPLETED)
            {
               this._completeHandler(null);
            }
         }
      }
      
      protected function _load() : void {
      }
      
      public function pause() : void {
         this.paused = true;
      }
      
      public function resume() : void {
         this.paused = false;
         this.load(false);
      }
      
      public function cancel() : void {
         if(this._status == LoaderStatus.LOADING)
         {
            this._dump(0,LoaderStatus.READY);
         }
      }
      
      protected function _dump(param1:int=0, param2:int=0, param3:Boolean=false) : void {
         var _loc5_:String = null;
         this._content = null;
         var _loc4_:Boolean = Boolean(this._status == LoaderStatus.LOADING);
         if(this._status == LoaderStatus.PAUSED && !(param2 == LoaderStatus.PAUSED) && !(param2 == LoaderStatus.FAILED))
         {
            this._prePauseStatus = param2;
         }
         else
         {
            if(this._status != LoaderStatus.DISPOSED)
            {
               this._status = param2;
            }
         }
         if(_loc4_)
         {
            this._time = getTimer() - this._time;
         }
         if((this._dispatchProgress) && !param3 && !(this._status == LoaderStatus.DISPOSED))
         {
            if(this is LoaderMax)
            {
               this._calculateProgress();
            }
            else
            {
               this._cachedBytesLoaded = 0;
            }
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
         if((_loc4_) && !param3)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL,this));
         }
         if(param2 == LoaderStatus.DISPOSED)
         {
            if(!param3)
            {
               dispatchEvent(new Event("dispose"));
            }
            for (_loc5_ in _listenerTypes)
            {
               if(_loc5_  in  this.vars && this.vars[_loc5_] is Function)
               {
                  this.removeEventListener(_listenerTypes[_loc5_],this.vars[_loc5_]);
               }
            }
         }
      }
      
      public function unload() : void {
         this._dump(1,LoaderStatus.READY);
      }
      
      public function dispose(param1:Boolean=false) : void {
         this._dump(param1?3:2,LoaderStatus.DISPOSED);
      }
      
      public function prioritize(param1:Boolean=true) : void {
         dispatchEvent(new Event("prioritize"));
         if((param1) && !(this._status == LoaderStatus.COMPLETED) && !(this._status == LoaderStatus.LOADING))
         {
            this.load(false);
         }
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         if(param1 == LoaderEvent.PROGRESS)
         {
            this._dispatchProgress = true;
         }
         else
         {
            if(param1 == LoaderEvent.CHILD_PROGRESS && this is LoaderMax)
            {
               this._dispatchChildProgress = true;
            }
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function _calculateProgress() : void {
      }
      
      public function auditSize() : void {
      }
      
      override public function toString() : String {
         return this._type + " \'" + this.name + "\'" + (this is LoaderItem?" (" + (this as LoaderItem).url + ")":"");
      }
      
      protected function _progressHandler(param1:Event) : void {
         if(param1 is ProgressEvent)
         {
            this._cachedBytesLoaded = (param1 as ProgressEvent).bytesLoaded;
            this._cachedBytesTotal = (param1 as ProgressEvent).bytesTotal;
            if(!this._auditedSize)
            {
               this._auditedSize = true;
               dispatchEvent(new Event("auditedSize"));
            }
         }
         if((this._dispatchProgress) && this._status == LoaderStatus.LOADING && !(this._cachedBytesLoaded == this._cachedBytesTotal))
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
      }
      
      protected function _completeHandler(param1:Event=null) : void {
         this._cachedBytesLoaded = this._cachedBytesTotal;
         if(this._status != LoaderStatus.COMPLETED)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
            this._status = LoaderStatus.COMPLETED;
            this._time = getTimer() - this._time;
         }
         dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE,this));
         if(this.autoDispose)
         {
            this.dispose();
         }
      }
      
      protected function _errorHandler(param1:Event) : void {
         var _loc2_:Object = param1 is LoaderEvent && (this.hasOwnProperty("getChildren"))?param1.target:this;
         var _loc3_:String = (param1 as Object).text;
         if(!(param1.type == LoaderEvent.ERROR) && (this.hasEventListener(param1.type)))
         {
            dispatchEvent(new LoaderEvent(param1.type,_loc2_,_loc3_));
         }
         if(this.hasEventListener(LoaderEvent.ERROR))
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.ERROR,_loc2_,this.toString() + " > " + _loc3_));
         }
      }
      
      protected function _failHandler(param1:Event) : void {
         this._dump(0,LoaderStatus.FAILED);
         this._errorHandler(param1);
         dispatchEvent(new LoaderEvent(LoaderEvent.FAIL,param1 is LoaderEvent && (this.hasOwnProperty("getChildren"))?param1.target:this,this.toString() + " > " + (param1 as Object).text));
      }
      
      protected function _passThroughEvent(param1:Event) : void {
         var _loc2_:String = param1.type;
         var _loc3_:Object = this;
         if(this.hasOwnProperty("getChildren"))
         {
            if(param1 is LoaderEvent)
            {
               _loc3_ = param1.target;
            }
            if(_loc2_ == "complete")
            {
               _loc2_ = "childComplete";
            }
            else
            {
               if(_loc2_ == "open")
               {
                  _loc2_ = "childOpen";
               }
               else
               {
                  if(_loc2_ == "cancel")
                  {
                     _loc2_ = "childCancel";
                  }
                  else
                  {
                     if(_loc2_ == "fail")
                     {
                        _loc2_ = "childFail";
                     }
                  }
               }
            }
         }
         if(this.hasEventListener(_loc2_))
         {
            dispatchEvent(new LoaderEvent(_loc2_,_loc3_,param1.hasOwnProperty("text")?(param1 as Object).text:""));
         }
      }
      
      public function get paused() : Boolean {
         return Boolean(this._status == LoaderStatus.PAUSED);
      }
      
      public function set paused(param1:Boolean) : void {
         if((param1) && !(this._status == LoaderStatus.PAUSED))
         {
            this._prePauseStatus = this._status;
            if(this._status == LoaderStatus.LOADING)
            {
               this._dump(0,LoaderStatus.PAUSED);
            }
         }
         else
         {
            if(!param1 && this._status == LoaderStatus.PAUSED)
            {
               if(this._prePauseStatus == LoaderStatus.LOADING)
               {
                  this.load(false);
               }
               else
               {
                  this._status = (this._prePauseStatus) || (LoaderStatus.READY);
               }
            }
         }
      }
      
      public function get status() : int {
         return this._status;
      }
      
      public function get bytesLoaded() : uint {
         if(this._cacheIsDirty)
         {
            this._calculateProgress();
         }
         return this._cachedBytesLoaded;
      }
      
      public function get bytesTotal() : uint {
         if(this._cacheIsDirty)
         {
            this._calculateProgress();
         }
         return this._cachedBytesTotal;
      }
      
      public function get progress() : Number {
         return this.bytesTotal != 0?this._cachedBytesLoaded / this._cachedBytesTotal:this._status == LoaderStatus.COMPLETED?1:0;
      }
      
      public function get rootLoader() : LoaderMax {
         return this._rootLoader;
      }
      
      public function get content() : * {
         return this._content;
      }
      
      public function get auditedSize() : Boolean {
         return this._auditedSize;
      }
      
      public function get loadTime() : Number {
         if(this._status == LoaderStatus.READY)
         {
            return 0;
         }
         if(this._status == LoaderStatus.LOADING)
         {
            return (getTimer() - this._time) / 1000;
         }
         return this._time / 1000;
      }
   }
}
