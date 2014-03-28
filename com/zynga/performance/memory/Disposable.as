package com.zynga.performance.memory
{
   import flash.events.EventDispatcher;
   import com.zynga.performance.listeners.ListenerManager;
   
   public class Disposable extends EventDispatcher implements IDisposable
   {
      
      public function Disposable() {
         super();
      }
      
      public function dispose() : void {
         ListenerManager.removeAllListeners(this);
      }
   }
}
