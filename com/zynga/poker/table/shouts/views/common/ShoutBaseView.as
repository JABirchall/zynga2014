package com.zynga.poker.table.shouts.views.common
{
   import flash.display.Sprite;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.display.Buttons.CloseButton;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import com.zynga.poker.table.shouts.ShoutControllerEvent;
   import caurina.transitions.Tweener;
   import com.zynga.poker.PokerGlobalData;
   
   public class ShoutBaseView extends Sprite implements IShoutView
   {
      
      public function ShoutBaseView(param1:int, param2:int=0) {
         super();
         this.bgContainer = new Sprite();
         this.shoutContainer = new Sprite();
         addChild(this.bgContainer);
         addChild(this.shoutContainer);
         this.ready = false;
         this._shoutType = param1;
         this._shoutTimeout = param2;
         this.shoutBorderPadding = 8;
         this.backgroundImageUrl = PokerGlobalData.instance.staticUrlPrefix + "img/shouts/shout-bg.jpg";
      }
      
      public static const SHOUT_HEIGHT:Number = 189;
      
      public static const STAGE_HEIGHT:Number = 570;
      
      protected var shoutBorderPadding:Number;
      
      protected var backgroundImageUrl:String;
      
      private var _backgroundLoader:SafeImageLoader;
      
      protected var _closeButton:CloseButton;
      
      private var _isReady:Boolean;
      
      private var _shoutType:int;
      
      private var _shoutTimeout:int;
      
      protected var bgContainer:Sprite;
      
      protected var shoutContainer:Sprite;
      
      public function init() : void {
         this._backgroundLoader = new SafeImageLoader();
         this._backgroundLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBackgroundComplete,false,0,true);
         this.loadBackground();
      }
      
      protected function loadBackground() : void {
         this._backgroundLoader.load(new URLRequest(this.backgroundImageUrl));
      }
      
      private function onBackgroundComplete(param1:Event=null) : void {
         this._backgroundLoader.removeEventListener(Event.COMPLETE,this.onBackgroundComplete);
         var _loc2_:Bitmap = Bitmap(this._backgroundLoader.content);
         this.bgContainer.addChild(_loc2_);
         this.addCloseButton();
         this.createForegroundAssets();
      }
      
      protected function addCloseButton() : void {
         this._closeButton = new CloseButton();
         this._closeButton.x = this.width - this._closeButton.width - this.shoutBorderPadding;
         this._closeButton.y = this.shoutBorderPadding;
         addChild(this._closeButton);
         this._closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
      }
      
      protected function createForegroundAssets() : void {
         this.assetsComplete();
      }
      
      protected function assetsComplete() : void {
         dispatchEvent(new ShoutControllerEvent(ShoutControllerEvent.EVENT_ASSETS_LOADED));
      }
      
      protected function onCloseClick(param1:MouseEvent) : void {
         this._closeButton.removeEventListener(MouseEvent.CLICK,this.close);
         dispatchEvent(new ShoutControllerEvent(ShoutControllerEvent.EVENT_USER_CLOSED));
         this.close();
      }
      
      public function close() : void {
         this.y = STAGE_HEIGHT - SHOUT_HEIGHT;
         this.x = 0;
         Tweener.addTween(this,
            {
               "y":STAGE_HEIGHT,
               "time":1,
               "onComplete":this.onCloseComplete
            });
      }
      
      protected function onCloseComplete() : void {
         dispatchEvent(new ShoutControllerEvent(ShoutControllerEvent.EVENT_SHOUT_OFFSCREEN));
      }
      
      public function destroy() : void {
         this._closeButton = null;
         this._backgroundLoader = null;
      }
      
      public function open() : void {
         this.y = STAGE_HEIGHT;
         this.x = 0;
         Tweener.addTween(this,
            {
               "y":STAGE_HEIGHT - SHOUT_HEIGHT,
               "time":1
            });
      }
      
      public function get type() : int {
         return this._shoutType;
      }
      
      public function get timeout() : int {
         return this._shoutTimeout;
      }
      
      public function get ready() : Boolean {
         return this._isReady;
      }
      
      public function set ready(param1:Boolean) : void {
         this._isReady = param1;
      }
   }
}
