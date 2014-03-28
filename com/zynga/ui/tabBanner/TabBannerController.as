package com.zynga.ui.tabBanner
{
   import flash.events.EventDispatcher;
   import flash.display.Sprite;
   import flash.display.DisplayObjectContainer;
   
   public class TabBannerController extends EventDispatcher
   {
      
      public function TabBannerController() {
         super();
      }
      
      private var _activeView:TabBanner;
      
      private var _model:TabBannerModel;
      
      private var _container:Sprite;
      
      public function get container() : Sprite {
         return this._container;
      }
      
      public function init(param1:DisplayObjectContainer) : void {
         this._activeView = null;
         this._model = new TabBannerModel();
         this._model.init(param1);
         this._container = new Sprite();
         this._model.masterContainer.addChild(this._container);
      }
      
      public function addView(param1:TabBanner, param2:String) : void {
         this.removeView(param2);
         this._model.attachedViews[param2] = param1;
         if(this._model.activeViewKey == param2)
         {
            this.setActiveView(param2);
         }
      }
      
      public function removeView(param1:String) : void {
         var _loc2_:TabBanner = this._model.attachedViews[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            this._model.attachedViews[param1] = null;
            _loc2_ = null;
         }
      }
      
      public function showView() : void {
         this._model.isActiveVisible = true;
         if(this._activeView != null)
         {
            this._activeView.visible = true;
         }
      }
      
      public function hideView() : void {
         this._model.isActiveVisible = false;
         if(this._activeView != null)
         {
            this._activeView.visible = false;
         }
      }
      
      private function onClose(param1:TabBannerEvent) : void {
         this.hideView();
      }
      
      private function onDisable(param1:TabBannerEvent) : void {
         this.unsetActiveView();
      }
      
      private function onZPWCRedirect(param1:TabBannerEvent) : void {
         this.hideView();
         dispatchEvent(param1);
      }
      
      public function setActiveView(param1:String) : void {
         if(this._model.activeViewKey != "")
         {
            this.unsetActiveView();
         }
         this._model.activeViewKey = param1;
         var _loc2_:TabBanner = this._model.attachedViews[param1];
         if(_loc2_ != null)
         {
            this._activeView = _loc2_;
            this._activeView.addEventListener(TabBannerEvent.CLOSE,this.onClose,false,0,true);
            this._activeView.addEventListener(TabBannerEvent.DISABLE,this.onDisable,false,0,true);
            this._activeView.addEventListener(TabBannerEvent.ZPWC_REDIRECT,this.onZPWCRedirect,false,0,true);
            this._container.addChild(this._activeView);
            if(this._model.isActiveVisible)
            {
               this.showView();
            }
            else
            {
               this.hideView();
            }
         }
      }
      
      public function unsetActiveView() : void {
         if(this._activeView != null)
         {
            this.hideView();
            if(this._activeView.hasEventListener(TabBannerEvent.CLOSE))
            {
               this._activeView.removeEventListener(TabBannerEvent.CLOSE,this.onClose);
            }
            if(this._activeView.hasEventListener(TabBannerEvent.DISABLE))
            {
               this._activeView.removeEventListener(TabBannerEvent.DISABLE,this.onDisable);
            }
            if(this._activeView.hasEventListener(TabBannerEvent.ZPWC_REDIRECT))
            {
               this._activeView.removeEventListener(TabBannerEvent.ZPWC_REDIRECT,this.onZPWCRedirect);
            }
            if(this._container.contains(this._activeView))
            {
               this._container.removeChild(this._activeView);
            }
            this._activeView = null;
            this._model.activeViewKey = "";
         }
      }
   }
}
