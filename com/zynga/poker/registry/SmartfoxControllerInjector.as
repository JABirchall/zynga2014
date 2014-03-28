package com.zynga.poker.registry
{
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.smartfox.controllers.SmartfoxController;
   
   public class SmartfoxControllerInjector extends Injector
   {
      
      public function SmartfoxControllerInjector() {
         super(SmartfoxController);
      }
      
      override protected function _inject(param1:*) : void {
         param1.commandDispatcher = PokerCommandDispatcher.getInstance();
         param1.configModel = _registry.getObject(ConfigModel);
         param1.pgData = _registry.getObject(PokerGlobalData);
         param1.registry = _registry;
      }
   }
}
