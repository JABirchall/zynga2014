package com.zynga.ui.tabBanner
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public class TabBanner extends MovieClip
   {
      
      public function TabBanner(param1:Object=null) {
         super();
         this._config = param1;
         this.init();
      }
      
      public static const ZPWC:String = "zpwc";
      
      protected var _close:Sprite;
      
      protected var _config:Object;
      
      protected function init() : void {
         this.initView();
         this.initListeners();
      }
      
      protected function initView() : void {
         this._close = null;
      }
      
      protected function initListeners() : void {
         if(this._close != null)
         {
            this._close.addEventListener(MouseEvent.CLICK,this.onCloseClicked);
         }
         addEventListener(MouseEvent.CLICK,this.onRedirectClicked);
      }
      
      protected function onCloseClicked(param1:Event) : void {
         dispatchEvent(new TabBannerEvent(TabBannerEvent.CLOSE));
      }
      
      protected function onRedirectClicked(param1:MouseEvent) : void {
      }
   }
}
