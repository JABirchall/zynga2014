package com.zynga.poker
{
   import flash.utils.Dictionary;
   
   public class ConfigModel extends Object
   {
      
      public function ConfigModel() {
         this._featureConfigCache = new Dictionary();
         super();
      }
      
      private var _featureConfigCache:Dictionary;
      
      public var configService:IConfigService;
      
      private function loadConfigForFeature(param1:String) : * {
         if(this.configService == null)
         {
            return;
         }
         return this.configService.loadConfigForFeature(param1);
      }
      
      public function getFeatureConfig(param1:String) : Object {
         var _loc2_:Object = null;
         if(this._featureConfigCache[param1] == null)
         {
            _loc2_ = this.loadConfigForFeature(param1);
            if(!(_loc2_ == null) && (_loc2_.enabled))
            {
               this._featureConfigCache[param1] = _loc2_;
            }
            else
            {
               this._featureConfigCache[param1] = false;
               _loc2_ = null;
            }
         }
         else
         {
            if(this._featureConfigCache[param1] === false)
            {
               return null;
            }
            _loc2_ = this._featureConfigCache[param1];
         }
         return _loc2_;
      }
      
      public function getBooleanForFeatureConfig(param1:String, param2:String) : Boolean {
         return this.getTypedPropertyForFeatureConfig(param1,param2,Boolean,false);
      }
      
      public function getIntForFeatureConfig(param1:String, param2:String, param3:int=0) : int {
         return this.getTypedPropertyForFeatureConfig(param1,param2,int,param3);
      }
      
      public function getStringForFeatureConfig(param1:String, param2:String, param3:String=null) : String {
         return this.getTypedPropertyForFeatureConfig(param1,param2,String,param3);
      }
      
      public function getNumberForFeatureConfig(param1:String, param2:String) : Number {
         return this.getTypedPropertyForFeatureConfig(param1,param2,Number,null);
      }
      
      public function getArrayForFeatureConfig(param1:String, param2:String) : Array {
         return this.getTypedPropertyForFeatureConfig(param1,param2,Array,null);
      }
      
      private function getTypedPropertyForFeatureConfig(param1:String, param2:String, param3:Class, param4:*) : * {
         var _loc5_:Object = this.getFeatureConfig(param1);
         var _loc6_:* = param4;
         if(!(_loc5_ == null) && !(_loc5_[param2] as param3 == null))
         {
            _loc6_ = _loc5_[param2];
         }
         return _loc6_ as param3;
      }
      
      public function isFeatureEnabled(param1:String) : Boolean {
         var _loc2_:Object = this.getFeatureConfig(param1);
         return !(_loc2_ == null) && (_loc2_.enabled);
      }
   }
}
