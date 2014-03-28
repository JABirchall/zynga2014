package com.zynga.ui.lobbyBanner
{
   import com.zynga.poker.feature.FeatureView;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LobbyBanner extends FeatureView
   {
      
      public function LobbyBanner() {
         super();
      }
      
      public static const MTT:String = "mtt";
      
      protected var _model:LobbyBannerModel;
      
      protected var _close:Sprite;
      
      protected var _type:String;
      
      public function get type() : String {
         return this._type;
      }
      
      protected var _bannerConfig:Object;
      
      override protected function _init() : void {
         this._model = featureModel as LobbyBannerModel;
         this._bannerConfig = this._model.getConfigForAd(this._type);
         this.initUI();
         this.initListeners();
      }
      
      protected function initUI() : void {
         x = 300;
         y = 10;
         this._close = null;
      }
      
      protected function initListeners() : void {
         if(this._close != null)
         {
            this._close.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
         }
         addEventListener(MouseEvent.CLICK,this.onActionClick,false,0,true);
      }
      
      override public function dispose() : void {
         if(this._close != null)
         {
            this._close.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
            if(contains(this._close))
            {
               removeChild(this._close);
            }
            this._close = null;
         }
         removeEventListener(MouseEvent.CLICK,this.onActionClick);
         super.dispose();
      }
      
      protected function onCloseClick(param1:MouseEvent) : void {
         dispatchEvent(new LobbyBannerEvent(LobbyBannerEvent.TYPE_CLOSE,"",this._type));
      }
      
      protected function onActionClick(param1:MouseEvent) : void {
      }
   }
}
