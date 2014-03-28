package com.zynga.poker.feature
{
   import flash.utils.Dictionary;
   import com.zynga.poker.module.interfaces.IModuleController;
   
   public class FeatureModuleController extends FeatureController
   {
      
      public function FeatureModuleController() {
         this._triggerResponses = new Dictionary();
         super();
      }
      
      private var _moduleID:String = null;
      
      private var _triggerResponses:Dictionary;
      
      override protected function alignToParentContainer() : void {
         if(!view || !_parentContainer)
         {
            return;
         }
         view.x = 50;
         view.y = 60;
      }
      
      override protected function onFeatureClose(param1:FeatureEvent=null) : void {
         this._triggerResponses = null;
         var _loc2_:IModuleController = registry.getObject(IModuleController);
         _loc2_.closingModule(this._moduleID);
         _loc2_.closeModule(this._moduleID);
         this.dispose();
      }
      
      override public function addListeners() : void {
         super.addListeners();
         this.addTriggers();
      }
      
      protected function addTriggers() : void {
      }
      
      protected final function addTriggerResponse(param1:String, param2:Function) : void {
         this._triggerResponses[param1] = param2;
      }
      
      protected final function removeTriggerResponse(param1:String) : void {
         delete this._triggerResponses[[param1]];
      }
      
      protected function triggerShouldDisplayModule(param1:String) : Boolean {
         return true;
      }
      
      public final function triggerMessage(param1:String, param2:Array) : void {
         if(param1 == null)
         {
         }
         var _loc3_:Function = this._triggerResponses[param1];
         if(_loc3_ != null)
         {
            if(!(parentContainer == null) && (parentContainer.contains(this.view)) && !this.triggerShouldDisplayModule(param1))
            {
               parentContainer.removeChild(this.view);
            }
            _loc3_.apply(this,param2);
         }
      }
      
      public function get moduleID() : String {
         return this._moduleID;
      }
      
      public function set moduleID(param1:String) : void {
         this._moduleID = param1;
      }
      
      public function hideModule() : void {
         if((_parentContainer) && (_parentContainer.contains(view)))
         {
            _parentContainer.removeChild(view);
         }
      }
      
      public function showModule() : void {
         if(!(_parentContainer === null) && _parentContainer.contains(view) === false)
         {
            _parentContainer.addChild(view);
         }
      }
      
      public function isShowing() : Boolean {
         return !(_parentContainer == null) && !(view == null) && (_parentContainer.contains(view));
      }
   }
}
