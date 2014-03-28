package com.zynga.poker.feature
{
   import flash.events.EventDispatcher;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.ICommandDispatcher;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.smartfox.controllers.ISmartfoxController;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.IUserModel;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedClassName;
   import com.zynga.performance.listeners.ListenerManager;
   import com.yahoo.astra.utils.DisplayObjectUtil;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.commands.pokercontroller.FireStatHitCommand;
   import com.zynga.poker.commands.ICommand;
   
   public class FeatureController extends EventDispatcher
   {
      
      public function FeatureController() {
         super();
      }
      
      private var _dependencyLoader:ModuleLoader;
      
      public var externalInterface:IExternalCall;
      
      public var commandDispatcher:ICommandDispatcher;
      
      public var registry:IClassRegistry;
      
      public var pgData:PokerGlobalData;
      
      public var smartfoxController:ISmartfoxController;
      
      public var configModel:ConfigModel;
      
      public var userModel:IUserModel;
      
      protected var _model:FeatureModel;
      
      protected var view:FeatureView;
      
      protected var _parentContainer:DisplayObjectContainer;
      
      public final function init(param1:DisplayObjectContainer) : void {
         this._parentContainer = param1;
         this._dependencyLoader = new ModuleLoader();
         this._dependencyLoader.registry = this.registry;
         this.preInit();
         this.loadDependencies();
      }
      
      protected function onDependenciesLoaded() : void {
         this._model = this.initModel();
         this.view = this.initView();
         this.addToParentContainer();
         this.addListeners();
         this.addSmartfoxListeners();
         this.postInit();
      }
      
      protected function initModel() : FeatureModel {
         throw new Error("ERROR: initModel of " + getQualifiedClassName(this) + " must be overridden by child class.");
      }
      
      protected function initView() : FeatureView {
         throw new Error("ERROR: initView of " + getQualifiedClassName(this) + " must be overridden by child class.");
      }
      
      public function addListeners() : void {
         if(this.view)
         {
            ListenerManager.addEventListener(this.view,FeatureEvent.TYPE_CLOSE,this.onFeatureClose);
         }
      }
      
      public function removeListeners() : void {
         if(this.view)
         {
            ListenerManager.removeAllListeners(this,true);
         }
      }
      
      protected function addSmartfoxListeners() : void {
      }
      
      protected function removeSmartfoxListeners() : void {
      }
      
      protected function preInit() : void {
      }
      
      protected function postInit() : void {
      }
      
      public function dispose() : void {
         dispatchEvent(new FeatureEvent(FeatureEvent.TYPE_DISPOSE));
         DisplayObjectUtil.removeFromParent(this.view);
         ListenerManager.removeAllListeners(this,true);
         this.removeListeners();
         this.removeSmartfoxListeners();
         if(this.view)
         {
            this.view.dispose();
         }
         this.view = null;
         if(this._model)
         {
            this._model.dispose();
         }
         this._model = null;
         if(this._dependencyLoader)
         {
            this._dependencyLoader.dispose();
            this._dependencyLoader = null;
         }
         this._parentContainer = null;
      }
      
      public function get parentContainer() : DisplayObjectContainer {
         return this._parentContainer;
      }
      
      public function set parentContainer(param1:DisplayObjectContainer) : void {
         if(param1)
         {
            this._parentContainer = param1;
            this.addToParentContainer();
         }
      }
      
      protected function addDependency(param1:String) : void {
         this._dependencyLoader.addDependency(param1);
      }
      
      private function loadDependencies() : void {
         this._dependencyLoader.load(this.onDependenciesLoaded);
      }
      
      protected function alignToParentContainer() : void {
         if(!this.view || !this._parentContainer)
         {
            return;
         }
         this.view.x = 0;
         this.view.y = 0;
      }
      
      protected function addToParentContainer() : void {
         if((this.view) && (this._parentContainer))
         {
            this.alignToParentContainer();
            this._parentContainer.addChild(this.view);
         }
      }
      
      protected function onFeatureClose(param1:FeatureEvent=null) : void {
         this.dispose();
      }
      
      protected function fireStat(param1:PokerStatHit) : void {
         this.dispatchCommand(new FireStatHitCommand(param1));
      }
      
      protected function dispatchCommand(param1:ICommand) : void {
         this.commandDispatcher.dispatchCommand(param1);
      }
   }
}
