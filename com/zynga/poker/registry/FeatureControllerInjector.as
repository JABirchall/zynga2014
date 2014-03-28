package com.zynga.poker.registry
{
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.IUserModel;
   import com.zynga.poker.smartfox.controllers.ISmartfoxController;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.feature.FeatureController;
   
   public class FeatureControllerInjector extends Injector
   {
      
      public function FeatureControllerInjector() {
         super(FeatureController);
      }
      
      override protected function _inject(param1:*) : void {
         param1.externalInterface = _registry.getObject(IExternalCall);
         param1.commandDispatcher = PokerCommandDispatcher.getInstance();
         param1.pgData = _registry.getObject(PokerGlobalData);
         param1.userModel = _registry.getObject(IUserModel);
         param1.registry = _registry;
         param1.smartfoxController = _registry.getObject(ISmartfoxController);
         param1.configModel = _registry.getObject(ConfigModel);
      }
   }
}
