package com.zynga.poker.registry
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.console.ConsoleManager;
   import com.zynga.poker.registry.console.ConsoleManagerInjector;
   import com.zynga.poker.console.ConsoleCommands;
   import com.zynga.poker.registry.console.ConsoleCommandsInjector;
   import com.zynga.poker.PokerSoundManager;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.zoom.handlers.PokerZoomMessageHandler;
   import com.zynga.poker.commonUI.CommonUIController;
   import com.zynga.poker.registry.injectors.CommonUIInjector;
   import com.zynga.poker.feature.FeatureService;
   import com.zynga.poker.smartfox.controllers.SmartfoxController;
   import flash.utils.Dictionary;
   
   public class InjectionFactory extends Object
   {
      
      public function InjectionFactory(param1:Inner) {
         super();
         if(param1 == null)
         {
            throw new Error("InjectionFactory class cannot be instantiated");
         }
         else
         {
            return;
         }
      }
      
      private static var _instance:InjectionFactory;
      
      public static function getInstance() : InjectionFactory {
         if(_instance == null)
         {
            _instance = new InjectionFactory(new Inner());
            _instance.addMapping(FeatureController,FeatureControllerInjector);
            _instance.addMapping(FeatureModel,FeatureModelInjector);
            _instance.addMapping(ConsoleManager,ConsoleManagerInjector);
            _instance.addMapping(ConsoleCommands,ConsoleCommandsInjector);
            _instance.addMapping(PokerSoundManager,PokerSoundManagerInjector);
            _instance.addMapping(ConfigModel,ConfigModelInjector);
            _instance.addMapping(PokerZoomMessageHandler,PokerZoomMessageHandlerInjector);
            _instance.addMapping(CommonUIController,CommonUIInjector);
            _instance.addMapping(FeatureService,FeatureServiceInjector);
            _instance.addMapping(SmartfoxController,SmartfoxControllerInjector);
         }
         return _instance;
      }
      
      private var _mappings:Dictionary;
      
      public var registry:IClassRegistry;
      
      public function addMapping(param1:Class, param2:Class) : void {
         if(this._mappings == null)
         {
            this._mappings = new Dictionary();
         }
         this._mappings[param1] = param2;
      }
      
      public function getInjector(param1:*) : Injector {
         var _loc2_:Object = null;
         var _loc3_:Class = null;
         var _loc4_:Injector = null;
         for (_loc2_ in this._mappings)
         {
            _loc3_ = _loc2_ as Class;
            if(param1 is _loc3_)
            {
               _loc4_ = new this._mappings[_loc3_]();
               _loc4_.registry = this.registry;
               return _loc4_;
            }
         }
         return null;
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
