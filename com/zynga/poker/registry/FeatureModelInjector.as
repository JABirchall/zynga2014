package com.zynga.poker.registry
{
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.feature.FeatureModel;
   
   public class FeatureModelInjector extends Injector
   {
      
      public function FeatureModelInjector() {
         super(FeatureModel);
      }
      
      override protected function _inject(param1:*) : void {
         param1.pgData = _registry.getObject(PokerGlobalData);
         param1.configModel = _registry.getObject(ConfigModel);
      }
   }
}
