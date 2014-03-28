package com.greensock.loading.core
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.net.LocalConnection;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.system.LoaderContext;
   import com.greensock.loading.LoaderMax;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import flash.system.Capabilities;
   import flash.system.Security;
   import com.greensock.loading.LoaderStatus;
   import flash.events.ProgressEvent;
   import com.greensock.events.LoaderEvent;
   import flash.events.ErrorEvent;
   import com.greensock.loading.display.ContentDisplay;
   
   public class DisplayObjectLoader extends LoaderItem
   {
      
      public function DisplayObjectLoader(param1:*, param2:Object=null) {
         super(param1,param2);
         this._refreshLoader(false);
         if(LoaderMax.contentDisplayClass is Class)
         {
            this._sprite = new LoaderMax.contentDisplayClass(this);
            if(!this._sprite.hasOwnProperty("rawContent"))
            {
               throw new Error("LoaderMax.contentDisplayClass must be set to a class with a \'rawContent\' property, like com.greensock.loading.display.ContentDisplay");
            }
         }
         else
         {
            this._sprite = new ContentDisplay(this);
         }
      }
      
      protected static var _gcDispatcher:DisplayObject;
      
      protected static var _gcCycles:uint = 0;
      
      public static function forceGC(param1:DisplayObject, param2:uint=1) : void {
         if(_gcCycles < param2)
         {
            _gcCycles = param2;
            if(_gcDispatcher == null)
            {
               _gcDispatcher = param1;
               _gcDispatcher.addEventListener(Event.ENTER_FRAME,_forceGCHandler,false,0,true);
            }
         }
      }
      
      protected static function _forceGCHandler(param1:Event) : void {
         if(_gcCycles == 0)
         {
            _gcDispatcher.removeEventListener(Event.ENTER_FRAME,_forceGCHandler);
            _gcDispatcher = null;
         }
         else
         {
            _gcCycles--;
         }
         try
         {
            new LocalConnection().connect("FORCE_GC");
            new LocalConnection().connect("FORCE_GC");
         }
         catch(error:Error)
         {
         }
      }
      
      protected var _loader:Loader;
      
      protected var _sprite:Sprite;
      
      protected var _context:LoaderContext;
      
      protected var _initted:Boolean;
      
      protected var _stealthMode:Boolean;
      
      public function setContentDisplay(param1:Sprite) : void {
         this._sprite = param1;
      }
      
      override protected function _load() : void {
         _prepRequest();
         if(this.vars.context is LoaderContext)
         {
            this._context = this.vars.context;
         }
         else
         {
            if(this._context == null && !_isLocal)
            {
               this._context = LoaderMax.defaultContext != null?LoaderMax.defaultContext:new LoaderContext(true,new ApplicationDomain(ApplicationDomain.currentDomain),SecurityDomain.currentDomain);
            }
         }
         if(Capabilities.playerType != "Desktop")
         {
            Security.allowDomain(_url);
         }
         this._loader.load(_request,this._context);
      }
      
      protected function _refreshLoader(param1:Boolean=true) : void {
         if(this._loader != null)
         {
            if(_status == LoaderStatus.LOADING)
            {
               try
               {
                  this._loader.close();
               }
               catch(error:Error)
               {
               }
            }
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_progressHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_completeHandler);
            this._loader.contentLoaderInfo.removeEventListener("ioError",_failHandler);
            this._loader.contentLoaderInfo.removeEventListener("securityError",this._securityErrorHandler);
            this._loader.contentLoaderInfo.removeEventListener("httpStatus",_httpStatusHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this._initHandler);
            if(param1)
            {
               try
               {
                  if(this._loader.hasOwnProperty("unloadAndStop"))
                  {
                     (this._loader as Object).unloadAndStop();
                  }
                  else
                  {
                     this._loader.unload();
                  }
               }
               catch(error:Error)
               {
               }
            }
            if(param1)
            {
               forceGC(this._sprite,this.hasOwnProperty("getClass")?3:1);
            }
            else
            {
               forceGC(this._sprite,this.hasOwnProperty("getClass")?3:1);
            }
         }
         this._initted = false;
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_progressHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,_completeHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener("ioError",_failHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener("securityError",this._securityErrorHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener("httpStatus",_httpStatusHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(Event.INIT,this._initHandler,false,0,true);
      }
      
      override protected function _dump(param1:int=0, param2:int=0, param3:Boolean=false) : void {
         if(param1 == 1)
         {
            (this._sprite as Object).rawContent = null;
         }
         else
         {
            if(param1 == 2)
            {
               (this._sprite as Object).loader = null;
            }
            else
            {
               if(param1 == 3)
               {
                  (this._sprite as Object).dispose(false,false);
               }
            }
         }
         if(!this._stealthMode)
         {
            this._refreshLoader(Boolean(!(param1 == 2)));
         }
         super._dump(param1,param2,param3);
      }
      
      protected function _determineScriptAccess() : void {
         if(!_scriptAccessDenied)
         {
            if(!this._loader.contentLoaderInfo.childAllowsParent)
            {
               _scriptAccessDenied = true;
               dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,"Error #2123: Security sandbox violation: " + this + ". No policy files granted access."));
            }
         }
      }
      
      protected function _securityErrorHandler(param1:ErrorEvent) : void {
         if(!(this._context == null) && (this._context.checkPolicyFile) && !(this.vars.context is LoaderContext))
         {
            this._context = new LoaderContext(false);
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,param1.text));
            _errorHandler(param1);
            this._load();
         }
         else
         {
            _failHandler(param1);
         }
      }
      
      protected function _initHandler(param1:Event) : void {
         if(!this._initted)
         {
            this._initted = true;
            (this._sprite as Object).rawContent = _content as DisplayObject;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         }
      }
      
      override public function get content() : * {
         return this._sprite;
      }
      
      public function get rawContent() : * {
         return _content;
      }
   }
}
