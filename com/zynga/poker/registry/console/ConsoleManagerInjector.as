package com.zynga.poker.registry.console
{
   import com.zynga.poker.registry.Injector;
   import com.zynga.poker.console.ConsoleManager;
   
   public class ConsoleManagerInjector extends Injector
   {
      
      public function ConsoleManagerInjector() {
         super(ConsoleManager);
      }
      
      override protected function _inject(param1:*) : void {
         param1.registry = _registry;
      }
   }
}
