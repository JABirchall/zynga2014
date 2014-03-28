package com.zynga.poker.feature
{
   import flash.display.Sprite;
   import com.zynga.poker.module.interfaces.IPokerModule;
   import com.zynga.poker.registry.IClassRegistry;
   import flash.display.DisplayObjectContainer;
   import com.zynga.performance.listeners.ListenerManager;
   
   public class FeatureModule extends Sprite implements IPokerModule
   {
      
      public function FeatureModule(param1:Class) {
         super();
         this._featureControllerClass = param1;
      }
      
      protected var _featureController:FeatureModuleController;
      
      private var _featureControllerClass:Class;
      
      protected var _registry:IClassRegistry;
      
      private var _id:String;
      
      public function set registry(param1:IClassRegistry) : void {
         this._registry = param1;
      }
      
      public final function init(param1:DisplayObjectContainer) : void {
         if(this._registry != null)
         {
            this._featureController = this._registry.getObject(this._featureControllerClass);
            if(this._featureController != null)
            {
               this._featureController.moduleID = this._id;
               this._featureController.init(param1);
            }
         }
      }
      
      public function addListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         if(this._featureController != null)
         {
            ListenerManager.addEventListener(this._featureController,param1,param2,param4);
         }
      }
      
      public function hasListener(param1:String) : Boolean {
         if(this._featureController != null)
         {
            return this._featureController.hasEventListener(param1);
         }
         return false;
      }
      
      public function removeListener(param1:String, param2:Function, param3:Boolean=false) : void {
         if(this._featureController != null)
         {
            ListenerManager.removeEventListener(this._featureController,param1,param2);
         }
      }
      
      public function dispose() : void {
         if(this._featureController != null)
         {
            this._featureController.dispose();
            this._featureController = null;
         }
      }
      
      public function triggerMessage(param1:String, param2:Array) : void {
         if(this._featureController == null)
         {
            return;
         }
         this._featureController.triggerMessage(param1,param2);
      }
      
      public function get moduleID() : String {
         return this._id;
      }
      
      public function set moduleID(param1:String) : void {
         this._id = param1;
      }
      
      public function hideModule() : void {
         if(this._featureController != null)
         {
            this._featureController.hideModule();
         }
      }
      
      public function showModule() : void {
         if(this._featureController != null)
         {
            this._featureController.showModule();
         }
      }
      
      public function isShowing() : Boolean {
         return !(this._featureController == null) && (this._featureController.isShowing());
      }
      
      public function getControllerClass() : Class {
         return this._featureControllerClass;
      }
   }
}
