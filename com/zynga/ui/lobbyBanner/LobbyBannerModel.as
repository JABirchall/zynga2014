package com.zynga.ui.lobbyBanner
{
   import com.zynga.poker.feature.FeatureModel;
   import flash.utils.Dictionary;
   
   public class LobbyBannerModel extends FeatureModel
   {
      
      public function LobbyBannerModel() {
         super();
      }
      
      private var _viewList:Dictionary;
      
      public function get viewList() : Dictionary {
         return this._viewList;
      }
      
      private var _isVisible:Boolean;
      
      public function get isVisible() : Boolean {
         return this._isVisible;
      }
      
      public function set isVisible(param1:Boolean) : void {
         this._isVisible = param1;
      }
      
      private var _activeViewKey:String;
      
      public function get activeViewKey() : String {
         return this._activeViewKey;
      }
      
      public function set activeViewKey(param1:String) : void {
         this._activeViewKey = param1;
      }
      
      private var _hasImpression:Boolean;
      
      public function get hasImpression() : Boolean {
         return this._hasImpression;
      }
      
      public function set hasImpression(param1:Boolean) : void {
         this._hasImpression = param1;
      }
      
      private var _adConfig:Dictionary;
      
      override public function init() : void {
         var _loc3_:String = null;
         this._viewList = new Dictionary();
         this._adConfig = new Dictionary();
         this._isVisible = false;
         this._hasImpression = false;
         this._activeViewKey = "";
         var _loc1_:Object = configModel.getFeatureConfig("lobbyBanner");
         var _loc2_:Object = _loc1_.enabledAds;
         for (_loc3_ in _loc2_)
         {
            this._adConfig[_loc2_[_loc3_].type] = _loc2_[_loc3_];
         }
      }
      
      public function canAdEnable(param1:String) : Boolean {
         return !(this._adConfig[param1] == null);
      }
      
      public function isAdEnabled(param1:String) : Boolean {
         if(this._adConfig[param1])
         {
            return this._adConfig[param1].enabled == true;
         }
         return false;
      }
      
      public function disableAd(param1:String) : void {
         if(this._adConfig[param1])
         {
            this._adConfig[param1].enabled = false;
         }
      }
      
      public function enableAd(param1:String) : void {
         if(this._adConfig[param1])
         {
            this._adConfig[param1].enabled = true;
         }
      }
      
      public function getConfigForAd(param1:String) : Object {
         return this._adConfig[param1];
      }
   }
}
