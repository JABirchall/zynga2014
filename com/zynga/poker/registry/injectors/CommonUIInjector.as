package com.zynga.poker.registry.injectors
{
   import com.zynga.poker.registry.Injector;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.IUserModel;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.friends.interfaces.INotifController;
   import com.zynga.poker.commonUI.CommonUIController;
   
   public class CommonUIInjector extends Injector
   {
      
      public function CommonUIInjector() {
         super(CommonUIController);
      }
      
      override protected function _inject(param1:*) : void {
         param1.externalInterface = _registry.getObject(IExternalCall);
         param1.commandDispatcher = PokerCommandDispatcher.getInstance();
         param1.pgData = _registry.getObject(PokerGlobalData);
         param1.userModel = _registry.getObject(IUserModel);
         param1.registry = _registry;
         param1.configModel = _registry.getObject(ConfigModel);
         param1.notifController = _registry.getObject(INotifController);
      }
   }
}
