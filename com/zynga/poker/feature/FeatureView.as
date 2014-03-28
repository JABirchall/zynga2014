package com.zynga.poker.feature
{
   import flash.display.Sprite;
   import com.zynga.performance.listeners.ListenerManager;
   
   public class FeatureView extends Sprite
   {
      
      public function FeatureView() {
         super();
      }
      
      protected var featureModel:FeatureModel;
      
      public final function init(param1:FeatureModel) : void {
         this.featureModel = param1;
         this._init();
         this._postInit();
      }
      
      protected function _init() : void {
      }
      
      protected function _postInit() : void {
      }
      
      public function dispose() : void {
         ListenerManager.removeAllListeners(this,true);
      }
   }
}
