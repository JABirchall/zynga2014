package com.zynga.poker.feature
{
   import flash.events.EventDispatcher;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.registry.IClassRegistry;
   
   public class FeatureService extends EventDispatcher
   {
      
      public function FeatureService() {
         super();
      }
      
      public var externalInterface:IExternalCall;
      
      public var registry:IClassRegistry;
   }
}
