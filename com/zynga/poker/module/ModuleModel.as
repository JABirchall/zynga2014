package com.zynga.poker.module
{
   import com.zynga.poker.feature.FeatureModel;
   import flash.utils.Dictionary;
   
   public class ModuleModel extends FeatureModel
   {
      
      public function ModuleModel() {
         super();
      }
      
      private var _modules:Dictionary;
      
      private var _moduleDefinition:XML;
      
      private var _triggerEvents:Object;
      
      override public function init() : void {
         this._modules = new Dictionary();
         this._moduleDefinition = null;
         this._triggerEvents = new Object();
      }
      
      public function getModuleByID(param1:String) : ModuleConfig {
         var _loc2_:ModuleConfig = null;
         if(this._modules[param1] != null)
         {
            _loc2_ = this._modules[param1];
         }
         return _loc2_;
      }
      
      public function getModuleByURL(param1:String) : ModuleConfig {
         var _loc3_:ModuleConfig = null;
         var _loc2_:ModuleConfig = null;
         for each (_loc3_ in this._modules)
         {
            if((_loc3_.sourceURL) && param1.indexOf(_loc3_.sourceURL.replace("./","/")) >= 0)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function loadConfig(param1:XML) : void {
         var _loc3_:XML = null;
         var _loc4_:ModuleConfig = null;
         var _loc2_:XMLList = param1.child("popup");
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = new ModuleConfig(_loc3_);
            this._modules[_loc4_.id] = _loc4_;
            this.addTriggers(_loc3_,_loc4_);
         }
         this._moduleDefinition = param1;
      }
      
      private function addTriggers(param1:XML, param2:ModuleConfig) : void {
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         if(param1.child("triggers").length() > 0)
         {
            _loc3_ = param1.child("triggers").child("trigger");
            for each (_loc4_ in _loc3_)
            {
               _loc5_ = _loc4_.children().toXMLString().split(",");
               for each (_loc6_ in _loc5_)
               {
                  this._triggerEvents[_loc6_] = 
                     {
                        "id":param2.id,
                        "type":String(_loc4_.@type),
                        "name":_loc6_
                     };
               }
            }
         }
      }
      
      public function get triggerEvents() : Object {
         return this._triggerEvents;
      }
      
      public function getConfigForTrigger(param1:String) : ModuleConfig {
         var _loc2_:ModuleConfig = null;
         if(this._triggerEvents[param1])
         {
            _loc2_ = this.getModuleByID(this._triggerEvents[param1].id);
            return _loc2_;
         }
         return null;
      }
   }
}
