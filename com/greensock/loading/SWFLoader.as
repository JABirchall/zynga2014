package com.greensock.loading
{
   import com.greensock.loading.core.DisplayObjectLoader;
   import com.greensock.events.LoaderEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObjectContainer;
   import com.greensock.loading.core.LoaderCore;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import flash.media.SoundTransform;
   
   public class SWFLoader extends DisplayObjectLoader
   {
      
      public function SWFLoader(param1:*, param2:Object=null) {
         super(param1,param2);
         _preferEstimatedBytesInAudit = true;
         _type = "SWFLoader";
      }
      
      private static var _classActivated:Boolean;
      
      protected var _queue:LoaderMax;
      
      protected var _hasRSL:Boolean;
      
      protected var _rslAddedCount:uint;
      
      protected var _loaderCompleted:Boolean;
      
      override protected function _load() : void {
         if(_stealthMode)
         {
            _stealthMode = false;
         }
         else
         {
            if(!_initted)
            {
               super._load();
            }
            else
            {
               if(this._queue != null)
               {
                  this._changeQueueListeners(true);
                  this._queue.load(false);
               }
            }
         }
      }
      
      override protected function _refreshLoader(param1:Boolean=true) : void {
         super._refreshLoader(param1);
         this._loaderCompleted = false;
      }
      
      protected function _changeQueueListeners(param1:Boolean) : void {
         var _loc2_:String = null;
         if(this._queue != null)
         {
            if((param1) && !(this.vars.integrateProgress == false))
            {
               this._queue.addEventListener(LoaderEvent.COMPLETE,this._completeHandler,false,0,true);
               this._queue.addEventListener(LoaderEvent.PROGRESS,this._progressHandler,false,0,true);
               this._queue.addEventListener(LoaderEvent.FAIL,_failHandler,false,0,true);
               for (_loc2_ in _listenerTypes)
               {
                  if(!(_loc2_ == "onProgress") && !(_loc2_ == "onInit"))
                  {
                     this._queue.addEventListener(_listenerTypes[_loc2_],this._passThroughEvent,false,0,true);
                  }
               }
            }
            else
            {
               this._queue.removeEventListener(LoaderEvent.COMPLETE,this._completeHandler);
               this._queue.removeEventListener(LoaderEvent.PROGRESS,this._progressHandler);
               this._queue.removeEventListener(LoaderEvent.FAIL,_failHandler);
               for (_loc2_ in _listenerTypes)
               {
                  if(!(_loc2_ == "onProgress") && !(_loc2_ == "onInit"))
                  {
                     this._queue.removeEventListener(_listenerTypes[_loc2_],this._passThroughEvent);
                  }
               }
            }
         }
      }
      
      override protected function _dump(param1:int=0, param2:int=0, param3:Boolean=false) : void {
         var _loc4_:* = undefined;
         if(_status == LoaderStatus.LOADING && !_initted)
         {
            _stealthMode = true;
            super._dump(param1,param2,param3);
            return;
         }
         if((_initted) && !_scriptAccessDenied && !(param1 == 2))
         {
            this._stopMovieClips(_loader.content);
            if(_loader.content  in  _rootLookup)
            {
               this._queue = LoaderMax(_rootLookup[_loader.content]);
               this._changeQueueListeners(false);
               if(param1 == 1)
               {
                  this._queue.cancel();
               }
               else
               {
                  if(param1 == 1)
                  {
                     this._queue.unload();
                  }
                  this._queue.dispose();
               }
            }
         }
         if(_stealthMode)
         {
            try
            {
               _loader.close();
            }
            catch(error:Error)
            {
            }
         }
         _stealthMode = this._hasRSL = false;
         _cacheIsDirty = true;
         if(param1 >= 1)
         {
            this._queue = null;
            _initted = this._loaderCompleted = false;
            super._dump(param1,param2,param3);
         }
         else
         {
            _loc4_ = _content;
            super._dump(param1,param2,param3);
            _content = _loc4_;
         }
      }
      
      protected function _stopMovieClips(param1:DisplayObject) : void {
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stop();
         var _loc3_:int = _loc2_.numChildren;
         while(--_loc3_ > -1)
         {
            this._stopMovieClips(_loc2_.getChildAt(_loc3_));
         }
      }
      
      override protected function _determineScriptAccess() : void {
         var mc:DisplayObject = null;
         try
         {
            mc = _loader.content;
         }
         catch(error:Error)
         {
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,error.message));
            return;
         }
         if(_loader.content is AVM1Movie)
         {
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,"AVM1Movie denies script access"));
         }
      }
      
      override protected function _calculateProgress() : void {
         _cachedBytesLoaded = _stealthMode?0:_loader.contentLoaderInfo.bytesLoaded;
         _cachedBytesTotal = _loader.contentLoaderInfo.bytesTotal;
         if(_cachedBytesTotal < _cachedBytesLoaded || (this._loaderCompleted))
         {
            _cachedBytesTotal = _cachedBytesLoaded;
         }
         if(this.vars.integrateProgress != false)
         {
            if(!(this._queue == null) && (uint(this.vars.estimatedBytes) < _cachedBytesLoaded || (this._queue.auditedSize)))
            {
               if(this._queue.status <= LoaderStatus.COMPLETED)
               {
                  _cachedBytesLoaded = _cachedBytesLoaded + this._queue.bytesLoaded;
                  _cachedBytesTotal = _cachedBytesTotal + this._queue.bytesTotal;
               }
            }
            else
            {
               if(uint(this.vars.estimatedBytes) > _cachedBytesLoaded && (!_initted || !(this._queue == null) && this._queue.status <= LoaderStatus.COMPLETED && !this._queue.auditedSize))
               {
                  _cachedBytesTotal = uint(this.vars.estimatedBytes);
               }
            }
         }
         if((this._hasRSL) && _content == null || !_initted && _cachedBytesLoaded == _cachedBytesTotal)
         {
            _cachedBytesLoaded = int(_cachedBytesLoaded * 0.99);
         }
         _cacheIsDirty = false;
      }
      
      protected function _checkRequiredLoaders() : void {
         if(this._queue == null && !(this.vars.integrateProgress == false) && !_scriptAccessDenied && !(_content == null))
         {
            this._queue = _rootLookup[_content];
            if(this._queue != null)
            {
               this._changeQueueListeners(true);
               this._queue.load(false);
               _cacheIsDirty = true;
            }
         }
      }
      
      public function getClass(param1:String) : Class {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         if(_content == null || (_scriptAccessDenied))
         {
            return null;
         }
         var _loc2_:Object = _content.loaderInfo.applicationDomain.getDefinition(param1);
         if(_loc2_ != null)
         {
            return _loc2_ as Class;
         }
         if(this._queue != null)
         {
            _loc3_ = this._queue.getChildren(true,true);
            _loc4_ = _loc3_.length;
            while(--_loc4_ > -1)
            {
               if(_loc3_[_loc4_] is SWFLoader)
               {
                  _loc2_ = (_loc3_[_loc4_] as SWFLoader).getClass(param1);
                  if(_loc2_ != null)
                  {
                     return _loc2_ as Class;
                  }
               }
            }
         }
         return null;
      }
      
      public function getSWFChild(param1:String) : DisplayObject {
         return !_scriptAccessDenied && _content is DisplayObjectContainer?DisplayObjectContainer(_content).getChildByName(param1):null;
      }
      
      public function getLoader(param1:String) : * {
         return this._queue != null?this._queue.getLoader(param1):null;
      }
      
      public function getContent(param1:String) : * {
         if(param1 == this.name || param1 == _url)
         {
            return this.content;
         }
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null?_loc2_.content:null;
      }
      
      public function getChildren(param1:Boolean=false, param2:Boolean=false) : Array {
         return this._queue != null?this._queue.getChildren(param1,param2):[];
      }
      
      override protected function _initHandler(param1:Event) : void {
         var _loc2_:DisplayObject = null;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(_stealthMode)
         {
            _initted = true;
            this._dump(1,_status,true);
            return;
         }
         this._hasRSL = false;
         try
         {
            _loc2_ = _loader.content;
            _loc3_ = getQualifiedClassName(_loc2_);
            if(_loc3_.substr(-13) == "__Preloader__")
            {
               _loc4_ = _loc2_["__rslPreloader"];
               if(_loc4_ != null)
               {
                  _loc3_ = getQualifiedClassName(_loc4_);
                  if(_loc3_ == "fl.rsl::RSLPreloader")
                  {
                     this._hasRSL = true;
                     this._rslAddedCount = 0;
                     _loc2_.addEventListener(Event.ADDED,this._rslAddedHandler);
                  }
               }
            }
         }
         catch(error:Error)
         {
         }
         if(!this._hasRSL)
         {
            this._init();
         }
      }
      
      protected function _init() : void {
         var _loc1_:SoundTransform = null;
         this._determineScriptAccess();
         if(!_scriptAccessDenied)
         {
            if(!this._hasRSL)
            {
               _content = _loader.content;
            }
            if(_content != null)
            {
               if(this.vars.autoPlay == false && _content is MovieClip)
               {
                  _loc1_ = _content.soundTransform;
                  _loc1_.volume = 0;
                  _content.soundTransform = _loc1_;
                  _content.stop();
               }
               this._checkRequiredLoaders();
            }
         }
         else
         {
            _content = _loader;
         }
         super._initHandler(null);
      }
      
      protected function _rslAddedHandler(param1:Event) : void {
         if(param1.target is DisplayObject && param1.currentTarget is DisplayObjectContainer && param1.target.parent == param1.currentTarget)
         {
            this._rslAddedCount++;
         }
         if(this._rslAddedCount > 1)
         {
            param1.currentTarget.removeEventListener(Event.ADDED,this._rslAddedHandler);
            if(_status == LoaderStatus.LOADING)
            {
               _content = param1.target;
               this._init();
               this._calculateProgress();
               dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
               this._completeHandler(null);
            }
         }
      }
      
      override protected function _passThroughEvent(param1:Event) : void {
         if(param1.target != this._queue)
         {
            super._passThroughEvent(param1);
         }
      }
      
      override protected function _progressHandler(param1:Event) : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_status == LoaderStatus.LOADING)
         {
            if(this._queue == null && (_initted))
            {
               this._checkRequiredLoaders();
            }
            if(_dispatchProgress)
            {
               _loc2_ = _cachedBytesLoaded;
               _loc3_ = _cachedBytesTotal;
               this._calculateProgress();
               if(!(_cachedBytesLoaded == _cachedBytesTotal) && (!(_loc2_ == _cachedBytesLoaded) || !(_loc3_ == _cachedBytesTotal)))
               {
                  dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
               }
            }
            else
            {
               _cacheIsDirty = true;
            }
         }
      }
      
      override protected function _completeHandler(param1:Event=null) : void {
         var _loc2_:SoundTransform = null;
         this._loaderCompleted = true;
         this._checkRequiredLoaders();
         this._calculateProgress();
         if(this.progress == 1)
         {
            if(!_scriptAccessDenied && this.vars.autoPlay == false && _content is MovieClip)
            {
               _loc2_ = _content.soundTransform;
               _loc2_.volume = 1;
               _content.soundTransform = _loc2_;
            }
            this._changeQueueListeners(false);
            super._determineScriptAccess();
            super._completeHandler(param1);
         }
      }
   }
}
