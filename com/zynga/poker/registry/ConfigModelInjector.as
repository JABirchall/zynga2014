package com.zynga.poker.registry
{
   import com.zynga.poker.IConfigService;
   import com.zynga.poker.ConfigModel;
   
   public class ConfigModelInjector extends Injector
   {
      
      public function ConfigModelInjector() {
         super(ConfigModel);
      }
      
      override protected function _inject(param1:*) : void {
         param1.configService = _registry.getObject(IConfigService);
      }
   }
}
