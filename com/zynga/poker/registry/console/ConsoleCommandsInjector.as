package com.zynga.poker.registry.console
{
   import com.zynga.poker.registry.Injector;
   import com.zynga.poker.IPokerController;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.IUserModel;
   import com.zynga.poker.console.ConsoleCommands;
   
   public class ConsoleCommandsInjector extends Injector
   {
      
      public function ConsoleCommandsInjector() {
         super(ConsoleCommands);
      }
      
      override protected function _inject(param1:*) : void {
         param1.registry = _registry;
         param1.pokerController = _registry.getObject(IPokerController);
         param1.popupController = _registry.getObject(IPopupController);
         param1.userModel = _registry.getObject(IUserModel);
      }
   }
}
