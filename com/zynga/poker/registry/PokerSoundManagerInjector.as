package com.zynga.poker.registry
{
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.PokerSoundManager;
   
   public class PokerSoundManagerInjector extends Injector
   {
      
      public function PokerSoundManagerInjector() {
         super(PokerSoundManager);
      }
      
      override protected function _inject(param1:*) : void {
         param1.externalInterface = _registry.getObject(IExternalCall);
      }
   }
}
