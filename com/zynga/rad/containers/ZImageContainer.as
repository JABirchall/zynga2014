package com.zynga.rad.containers
{
   import flash.display.Loader;
   import com.yahoo.astra.utils.DisplayObjectUtil;
   import flash.system.LoaderContext;
   import flash.net.URLRequest;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.poker.PokerUser;
   import com.zynga.performance.listeners.ListenerManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public dynamic class ZImageContainer extends ZContainer
   {
      
      public function ZImageContainer() {
         super();
         this.init();
      }
      
      private var _picUrl:String;
      
      private var _maintainAspectRatio:Boolean = false;
      
      private var _preferredWidth:Number;
      
      private var _preferredHeight:Number;
      
      private var _loader:Loader;
      
      private function init() : void {
         this._preferredWidth = this.width;
         this._preferredHeight = this.height;
      }
      
      override public function destroy() : void {
         this.destroyLoader();
         this._picUrl = null;
         DisplayObjectUtil.removeAllChildren(this);
         super.destroy();
      }
      
      public function load(param1:String="") : void {
         var _loc2_:LoaderContext = null;
         var _loc3_:URLRequest = null;
         if(param1 != "")
         {
            this.picUrl = param1;
         }
         if(!(this.picUrl == null) && !(this.picUrl == ""))
         {
            this.createLoader();
            _loc2_ = new LoaderContext(true);
            _loc3_ = new URLRequest(this.picUrl);
            this._loader.load(_loc3_,_loc2_);
         }
      }
      
      private function createLoader() : void {
         this.destroyLoader();
         this._loader = new SafeImageLoader(PokerUser.DEFAULT_PIC_URL);
         ListenerManager.addOnceEventListener(this._loader.contentLoaderInfo,Event.COMPLETE,this.onLoadComplete);
         ListenerManager.addOnceEventListener(this._loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,this.onLoadFailure);
         ListenerManager.addOnceEventListener(this._loader.contentLoaderInfo,SecurityErrorEvent.SECURITY_ERROR,this.onLoadFailure);
      }
      
      private function destroyLoader() : void {
         if(this._loader)
         {
            ListenerManager.removeAllListeners(this._loader.contentLoaderInfo,true);
            this._loader.unload();
            this._loader = null;
         }
      }
      
      private function onLoadComplete(param1:Event) : void {
         var _loc3_:Bitmap = null;
         var _loc2_:DisplayObject = param1.target.content as DisplayObject;
         if(_loc2_)
         {
            _loc3_ = DisplayObjectUtil.getAsSmoothBitmap(_loc2_);
            if(this._maintainAspectRatio)
            {
               DisplayObjectUtil.resizeAndMaintainAspectRatio(_loc3_,this._preferredWidth,this._preferredHeight);
            }
            else
            {
               _loc3_.width = this._preferredWidth;
               _loc3_.height = this._preferredHeight;
            }
            _loc3_.alpha = 1;
            _loc3_.visible = true;
            addChild(_loc3_);
            this.destroyLoader();
         }
      }
      
      private function onLoadFailure(param1:Event) : void {
      }
      
      public function setDimensions(param1:Number, param2:Number) : void {
         this._preferredWidth = param1;
         this._preferredHeight = param2;
      }
      
      public function get maintainAspectRatio() : Boolean {
         return this._maintainAspectRatio;
      }
      
      public function set maintainAspectRatio(param1:Boolean) : void {
         this._maintainAspectRatio = param1;
      }
      
      public function get picUrl() : String {
         return this._picUrl;
      }
      
      public function set picUrl(param1:String) : void {
         this._picUrl = param1;
      }
   }
}
