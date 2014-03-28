package com.zynga.poker.registry
{
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.feature.FeatureService;
   
   public class FeatureServiceInjector extends Injector
   {
      
      public function FeatureServiceInjector() {
         super(FeatureService);
      }
      
      override protected function _inject(param1:*) : void {
         param1.externalInterface = _registry.getObject(IExternalCall);
         param1.registry = _registry;
      }
   }
}
