package com.greensock.loading
{
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import com.greensock.loading.core.LoaderCore;
   import com.greensock.events.LoaderEvent;
   import flash.events.Event;
   
   public class XMLLoader extends DataLoader
   {
      
      public function XMLLoader(param1:*, param2:Object=null) {
         super(param1,param2);
         _preferEstimatedBytesInAudit = true;
         _type = "XMLLoader";
         _loader.dataFormat = "text";
      }
      
      private static var _classActivated:Boolean;
      
      protected static var _varTypes:Object = 
         {
            "skipFailed":true,
            "skipPaused":true,
            "paused":false,
            "load":false,
            "noCache":false,
            "maxConnections":2,
            "autoPlay":false,
            "autoDispose":false,
            "smoothing":false,
            "estimatedBytes":1,
            "x":1,
            "y":1,
            "width":1,
            "height":1,
            "scaleX":1,
            "scaleY":1,
            "rotation":1,
            "alpha":1,
            "visible":true,
            "bgColor":0,
            "bgAlpha":0,
            "deblocking":1,
            "repeat":1,
            "checkPolicyFile":false,
            "centerRegistration":false,
            "bufferTime":5,
            "volume":1,
            "bufferMode":false,
            "estimatedDuration":200,
            "crop":false,
            "autoAdjustBuffer":true
         };
      
      protected static function _parseVars(param1:XML) : Object {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:ApplicationDomain = null;
         var _loc8_:XML = null;
         var _loc2_:Object = {};
         var _loc7_:XMLList = param1.attributes();
         for each (_loc8_ in _loc7_)
         {
            _loc3_ = _loc8_.name();
            _loc5_ = _loc8_.toString();
            if(_loc3_ != "url")
            {
               if(_loc3_ == "context")
               {
                  _loc2_.context = new LoaderContext(true,_loc5_ == "own"?ApplicationDomain.currentDomain:_loc5_ == "separate"?new ApplicationDomain():new ApplicationDomain(ApplicationDomain.currentDomain),!_isLocal?SecurityDomain.currentDomain:null);
               }
               else
               {
                  _loc4_ = typeof _varTypes[_loc3_];
                  if(_loc4_ == "boolean")
                  {
                     _loc2_[_loc3_] = Boolean((_loc5_ == "true") || (_loc5_ == "1"));
                  }
                  else
                  {
                     if(_loc4_ == "number")
                     {
                        _loc2_[_loc3_] = Number(_loc5_);
                     }
                     else
                     {
                        _loc2_[_loc3_] = _loc5_;
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public static function parseLoaders(param1:XML, param2:LoaderMax, param3:LoaderMax=null) : void {
         var _loc4_:LoaderCore = null;
         var _loc5_:LoaderMax = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Class = null;
         var _loc9_:* = 0;
         var _loc10_:XML = null;
         for each (_loc10_ in param1.children())
         {
            _loc6_ = String(_loc10_.name()).toLowerCase();
            if(_loc6_ == "loadermax")
            {
               _loc5_ = param2.append(new LoaderMax(_parseVars(_loc10_))) as LoaderMax;
               if(!(param3 == null) && (_loc5_.vars.load))
               {
                  param3.append(_loc5_);
               }
               parseLoaders(_loc10_,_loc5_,param3);
               if("replaceURLText"  in  _loc5_.vars)
               {
                  _loc7_ = _loc5_.vars.replaceURLText.split(",");
                  _loc9_ = 0;
                  while(_loc9_ < _loc7_.length)
                  {
                     _loc5_.replaceURLText(_loc7_[_loc9_],_loc7_[_loc9_ + 1],false);
                     _loc9_ = _loc9_ + 2;
                  }
               }
               if("prependURLs"  in  _loc5_.vars)
               {
                  _loc5_.prependURLs(_loc5_.vars.prependURLs,false);
               }
            }
            else
            {
               if(_loc6_  in  _types)
               {
                  _loc8_ = _types[_loc6_];
                  _loc4_ = param2.append(new _loc8_(_loc10_.@url,_parseVars(_loc10_)));
                  if(!(param3 == null) && (_loc4_.vars.load))
                  {
                     param3.append(_loc4_);
                  }
               }
               parseLoaders(_loc10_,param2,param3);
            }
         }
      }
      
      protected var _loadingQueue:LoaderMax;
      
      protected var _parsed:LoaderMax;
      
      protected var _initted:Boolean;
      
      override protected function _load() : void {
         if(!this._initted)
         {
            _prepRequest();
            _loader.load(_request);
         }
         else
         {
            if(this._loadingQueue != null)
            {
               this._changeQueueListeners(true);
               this._loadingQueue.load(false);
            }
         }
      }
      
      protected function _changeQueueListeners(param1:Boolean) : void {
         var _loc2_:String = null;
         if(this._loadingQueue != null)
         {
            if((param1) && !(this.vars.integrateProgress == false))
            {
               this._loadingQueue.addEventListener(LoaderEvent.COMPLETE,this._completeHandler,false,0,true);
               this._loadingQueue.addEventListener(LoaderEvent.PROGRESS,this._progressHandler,false,0,true);
               this._loadingQueue.addEventListener(LoaderEvent.FAIL,_failHandler,false,0,true);
               for (_loc2_ in _listenerTypes)
               {
                  if(!(_loc2_ == "onProgress") && !(_loc2_ == "onInit"))
                  {
                     this._loadingQueue.addEventListener(_listenerTypes[_loc2_],this._passThroughEvent,false,0,true);
                  }
               }
            }
            else
            {
               this._loadingQueue.removeEventListener(LoaderEvent.COMPLETE,this._completeHandler);
               this._loadingQueue.removeEventListener(LoaderEvent.PROGRESS,this._progressHandler);
               this._loadingQueue.removeEventListener(LoaderEvent.FAIL,_failHandler);
               for (_loc2_ in _listenerTypes)
               {
                  if(!(_loc2_ == "onProgress") && !(_loc2_ == "onInit"))
                  {
                     this._loadingQueue.removeEventListener(_listenerTypes[_loc2_],this._passThroughEvent);
                  }
               }
            }
         }
      }
      
      override protected function _dump(param1:int=0, param2:int=0, param3:Boolean=false) : void {
         if(this._loadingQueue != null)
         {
            this._changeQueueListeners(false);
            if(param1 == 0)
            {
               this._loadingQueue.cancel();
            }
            else
            {
               this._loadingQueue.dispose(Boolean(param1 == 3));
               this._loadingQueue = null;
            }
         }
         if(param1 >= 1)
         {
            if(this._parsed != null)
            {
               this._parsed.dispose(Boolean(param1 == 3));
               this._parsed = null;
            }
            this._initted = false;
         }
         _cacheIsDirty = true;
         var _loc4_:* = _content;
         super._dump(param1,param2,param3);
         if(param1 == 0)
         {
            _content = _loc4_;
         }
      }
      
      override protected function _calculateProgress() : void {
         _cachedBytesLoaded = _loader.bytesLoaded;
         _cachedBytesTotal = _loader.bytesTotal;
         if(_cachedBytesTotal < _cachedBytesLoaded || (this._initted))
         {
            _cachedBytesTotal = _cachedBytesLoaded;
         }
         var _loc1_:uint = uint(this.vars.estimatedBytes);
         if(this.vars.integrateProgress != false)
         {
            if(!(this._loadingQueue == null) && (uint(this.vars.estimatedBytes) < _cachedBytesLoaded || (this._loadingQueue.auditedSize)))
            {
               if(this._loadingQueue.status <= LoaderStatus.COMPLETED)
               {
                  _cachedBytesLoaded = _cachedBytesLoaded + this._loadingQueue.bytesLoaded;
                  _cachedBytesTotal = _cachedBytesTotal + this._loadingQueue.bytesTotal;
               }
            }
            else
            {
               if(uint(this.vars.estimatedBytes) > _cachedBytesLoaded && (!this._initted || !(this._loadingQueue == null) && this._loadingQueue.status <= LoaderStatus.COMPLETED && !this._loadingQueue.auditedSize))
               {
                  _cachedBytesTotal = uint(this.vars.estimatedBytes);
               }
            }
         }
         if(!this._initted && _cachedBytesLoaded == _cachedBytesTotal)
         {
            _cachedBytesLoaded = int(_cachedBytesLoaded * 0.99);
         }
         _cacheIsDirty = false;
      }
      
      public function getLoader(param1:String) : * {
         return this._parsed != null?this._parsed.getLoader(param1):null;
      }
      
      public function getContent(param1:String) : * {
         if(param1 == this.name || param1 == _url)
         {
            return _content;
         }
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null?_loc2_.content:null;
      }
      
      public function getChildren(param1:Boolean=false, param2:Boolean=false) : Array {
         return this._parsed != null?this._parsed.getChildren(param1,param2):[];
      }
      
      override protected function _progressHandler(param1:Event) : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
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
      
      override protected function _passThroughEvent(param1:Event) : void {
         if(param1.target != this._loadingQueue)
         {
            super._passThroughEvent(param1);
         }
      }
      
      override protected function _receiveDataHandler(param1:Event) : void {
         var event:Event = param1;
         try
         {
            _content = new XML(_loader.data);
         }
         catch(error:Error)
         {
            _content = _loader.data;
            _failHandler(new LoaderEvent(LoaderEvent.ERROR,this,error.message));
            return;
         }
         this._initted = true;
         this._loadingQueue = new LoaderMax({"name":this.name + "_Queue"});
         this._parsed = new LoaderMax(
            {
               "name":this.name + "_ParsedLoaders",
               "paused":true
            });
         parseLoaders(_content as XML,this._parsed,this._loadingQueue);
         if(this._parsed.numChildren == 0)
         {
            this._parsed.dispose(false);
            this._parsed = null;
         }
         if(this._loadingQueue.getChildren(true,true).length == 0)
         {
            this._loadingQueue.empty(false);
            this._loadingQueue.dispose(false);
            this._loadingQueue = null;
         }
         else
         {
            _cacheIsDirty = true;
            this._changeQueueListeners(true);
            this._loadingQueue.load(false);
         }
         dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         if(this._loadingQueue == null || this.vars.integrateProgress == false)
         {
            this._completeHandler(event);
         }
      }
      
      override protected function _completeHandler(param1:Event=null) : void {
         this._calculateProgress();
         if(this.progress == 1)
         {
            this._changeQueueListeners(false);
            super._completeHandler(param1);
         }
      }
      
      override public function get progress() : Number {
         return this.bytesTotal != 0?_cachedBytesLoaded / _cachedBytesTotal:_status == LoaderStatus.COMPLETED || (this._initted)?1:0;
      }
   }
}
