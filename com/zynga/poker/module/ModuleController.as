package com.zynga.poker.module
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.module.interfaces.IModuleController;
   import com.zynga.poker.events.JSEvent;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.poker.feature.FeatureModule;
   import com.zynga.poker.commands.selfcontained.module.LoadModuleCommand;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.load.LoadManager;
   import com.greensock.events.LoaderEvent;
   import com.zynga.poker.module.interfaces.IPokerModule;
   import flash.display.DisplayObjectContainer;
   
   public class ModuleController extends FeatureController implements IModuleController
   {
      
      public function ModuleController() {
         this._loadingStrategies = new Object();
         this._messageQueue = new Object();
         this._triggerListeners = new Object();
         this._openModules = new Object();
         super();
      }
      
      private var _moduleModel:ModuleModel;
      
      private var _basePath:String;
      
      private var _loadingStrategies:Object;
      
      private var _messageQueue:Object;
      
      private var _triggerListeners:Object;
      
      private var _openModules:Object;
      
      private const JSCALLBACK:String = "js";
      
      private const SFXCALLBACK:String = "sfx";
      
      private const FLASHCALLBACK:String = "flash";
      
      override protected function preInit() : void {
         this.initLoadingStrategies();
         this.initTriggerListeners();
      }
      
      override protected function postInit() : void {
         this._basePath = configModel.getStringForFeatureConfig("core","basePath");
         externalInterface.call("ZY.App.Flash.Events.handleFlashEvent",JSEvent.MODULE_CONTROLLER_READY);
      }
      
      override protected function initModel() : FeatureModel {
         var _loc1_:PokerGlobalData = registry.getObject(PokerGlobalData);
         this._moduleModel = new ModuleModel();
         this._moduleModel.init();
         this._moduleModel.loadConfig(_loc1_.xmlPopups);
         return this._moduleModel;
      }
      
      override public function addListeners() : void {
         super.addListeners();
         this.addTriggerListeners();
      }
      
      override public function removeListeners() : void {
         super.removeListeners();
         this.removeTriggerListeners();
      }
      
      private function addTriggerListeners() : void {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc1_:IPokerConnectionManager = registry.getObject(IPokerConnectionManager);
         _loc1_.addEventListener(ProtocolEvent.onMessage,this.onSFXMessage);
         for each (_loc2_ in this._moduleModel.triggerEvents)
         {
            _loc3_ = _loc2_.type;
            _loc4_ = this._triggerListeners[_loc3_];
            if(_loc4_ != null)
            {
               _loc5_ = this.buildFunction(_loc2_.name);
               _loc4_.call(this,_loc2_.name,_loc5_);
            }
         }
      }
      
      private function buildFunction(param1:String) : Function {
         var name:String = param1;
         return function(... rest):void
         {
            triggerModule(name,rest);
         };
      }
      
      private function removeTriggerListeners() : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:IPokerConnectionManager = registry.getObject(IPokerConnectionManager);
         _loc1_.removeEventListener(ProtocolEvent.onMessage,this.onSFXMessage);
         for (_loc2_ in this._moduleModel.triggerEvents)
         {
            _loc3_ = this._moduleModel[_loc2_].type;
            if(_loc3_ == this.JSCALLBACK)
            {
               externalInterface.removeCallback(_loc2_);
            }
         }
      }
      
      private function triggerModule(param1:String, param2:Array) : void {
         var _loc4_:FeatureModule = null;
         var _loc5_:Array = null;
         var _loc3_:ModuleConfig = this._moduleModel.getConfigForTrigger(param1);
         if(!(_loc3_ == null) && _loc3_.moduleClass == "FeatureModule")
         {
            if(_loc3_.isLoaded)
            {
               _loc4_ = _loc3_.module as FeatureModule;
               _loc4_.triggerMessage(param1,param2);
            }
            else
            {
               _loc5_ = this._messageQueue[_loc3_.id];
               if(_loc5_ == null)
               {
                  _loc5_ = new Array();
                  this._messageQueue[_loc3_.id] = _loc5_;
               }
               _loc5_.push(
                  {
                     "trigger":param1,
                     "args":param2
                  });
               dispatchCommand(new LoadModuleCommand(_loc3_.id,this.onTriggeredModuleLoaded));
            }
         }
      }
      
      private function onTriggeredModuleLoaded(param1:ModuleEvent) : void {
         var _loc5_:Object = null;
         var _loc2_:ModuleConfig = this._moduleModel.getModuleByID(param1.id);
         var _loc3_:Array = this._messageQueue[_loc2_.id];
         if(_loc3_ == null || _loc3_.length < 1)
         {
            return;
         }
         var _loc4_:FeatureModule = _loc2_.module as FeatureModule;
         if(this._openModules[_loc2_.id] == null)
         {
            this.displayModule(_loc2_.id);
         }
         for each (_loc5_ in _loc3_)
         {
            _loc4_.triggerMessage(_loc5_.trigger,_loc5_.args);
         }
         delete this._messageQueue[[_loc2_.id]];
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      private function initLoadingStrategies() : void {
         this._loadingStrategies["FeatureModule"] = this.loadFeatureModule;
         this._loadingStrategies["AssetModule"] = this.loadAssetModule;
      }
      
      private function initTriggerListeners() : void {
         this._triggerListeners[this.JSCALLBACK] = this.addJSCallback;
         this._triggerListeners[this.SFXCALLBACK] = this.addSFXCallback;
         this._triggerListeners[this.FLASHCALLBACK] = this.addFlashCallback;
      }
      
      private function addJSCallback(param1:String, param2:Function) : void {
         externalInterface.addCallback(param1,param2);
      }
      
      private function addSFXCallback(param1:String, param2:Function) : void {
      }
      
      private function addFlashCallback(param1:String, param2:Function) : void {
      }
      
      private function onSFXMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         var _loc3_:ModuleConfig = this._moduleModel.getConfigForTrigger(_loc2_.type);
         if(_loc3_ != null)
         {
            this.triggerModule(_loc2_.type,[_loc2_]);
         }
      }
      
      public function loadModule(param1:String, param2:Function=null) : void {
         var _loc4_:Object = null;
         var _loc3_:ModuleConfig = this._moduleModel.getModuleByID(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.isLoaded)
            {
               dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_LOADED_EVENT,_loc3_.module));
            }
            else
            {
               if(this._basePath)
               {
                  _loc4_ = 
                     {
                        "onComplete":this.onModuleLoadComplete,
                        "onError":this.onModuleLoadFail
                     };
                  if(param2 != null)
                  {
                     _loc4_.onProgress = param2;
                  }
                  LoadManager.load(this._basePath + _loc3_.sourceURL,_loc4_);
               }
            }
         }
      }
      
      public function unloadModule(param1:String) : void {
         var _loc2_:ModuleConfig = this._moduleModel.getModuleByID(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isLoaded)
            {
               _loc2_.module = null;
            }
         }
      }
      
      private function onModuleLoadComplete(param1:LoaderEvent) : void {
         var _loc3_:Function = null;
         var _loc4_:IPokerModule = null;
         var _loc2_:ModuleConfig = this._moduleModel.getModuleByURL(param1.data.url);
         if(_loc2_)
         {
            _loc3_ = this._loadingStrategies[_loc2_.moduleClass];
            if(!(_loc3_ == null) && !_loc2_.isLoaded)
            {
               _loc4_ = _loc3_.call(this,_loc2_,param1.data.content.rawContent);
               _loc4_.moduleID = _loc2_.id;
               _loc2_.module = _loc4_;
               dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_LOADED_EVENT,_loc4_));
            }
         }
      }
      
      private function onModuleLoadFail(param1:LoaderEvent) : void {
         dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_LOADFAILED_EVENT));
      }
      
      private function loadFeatureModule(param1:ModuleConfig, param2:*) : IPokerModule {
         var _loc3_:FeatureModule = param2 as FeatureModule;
         _loc3_.registry = registry;
         if(this._openModules[param1.id] != null)
         {
            _loc3_.init(parentContainer);
         }
         return _loc3_;
      }
      
      private function loadAssetModule(param1:ModuleConfig, param2:*) : IPokerModule {
         var _loc3_:AssetModule = param2 as AssetModule;
         return _loc3_;
      }
      
      public function displayModule(param1:String, param2:Object=null, param3:DisplayObjectContainer=null) : Boolean {
         var _loc5_:FeatureModule = null;
         var _loc6_:FeatureModule = null;
         var _loc7_:Object = null;
         var _loc4_:ModuleConfig = this._moduleModel.getModuleByID(param1);
         if(!_loc4_.isLoaded)
         {
            return false;
         }
         if(this._openModules[param1] != null)
         {
            _loc5_ = this._openModules[param1].module as FeatureModule;
            if(_loc5_.isShowing())
            {
               return false;
            }
            _loc5_.showModule();
            return false;
         }
         if(_loc4_.moduleClass == "FeatureModule")
         {
            if(param2 != null)
            {
               _loc7_ = configModel.getFeatureConfig(param1);
               _loc7_["payload"] = param2;
            }
            dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_WILLOPEN_EVENT,_loc4_.module));
            _loc6_ = _loc4_.module as FeatureModule;
            _loc6_.init(param3 !== null?param3:parentContainer);
            this._openModules[param1] = _loc4_;
         }
         return true;
      }
      
      public function hideModule(param1:String) : void {
         var _loc2_:FeatureModule = null;
         if(this._openModules[param1] != null)
         {
            _loc2_ = this._openModules[param1].module as FeatureModule;
            _loc2_.hideModule();
         }
      }
      
      public function closingModule(param1:String) : void {
         var _loc2_:ModuleConfig = this._moduleModel.getModuleByID(param1);
         if(_loc2_)
         {
            dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_WILLCLOSE_EVENT,_loc2_.module));
         }
         else
         {
            dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_WILLCLOSE_EVENT));
         }
      }
      
      public function closeModule(param1:String) : void {
         var _loc2_:ModuleConfig = this._moduleModel.getModuleByID(param1);
         if(_loc2_)
         {
            dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_CLOSED_EVENT,_loc2_.module));
         }
         else
         {
            dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_CLOSED_EVENT));
         }
         if((_loc2_) && (_loc2_.shouldUnload))
         {
            this.unloadModule(param1);
         }
         delete this._openModules[[param1]];
      }
      
      public function isModuleOpen(param1:String) : Boolean {
         return !(this._openModules[param1] == null);
      }
   }
}
