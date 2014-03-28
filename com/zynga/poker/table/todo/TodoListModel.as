package com.zynga.poker.table.todo
{
   import com.zynga.poker.feature.FeatureModel;
   import __AS3__.vec.Vector;
   import flash.utils.Dictionary;
   
   public class TodoListModel extends FeatureModel
   {
      
      public function TodoListModel() {
         super();
      }
      
      private var _enabledIconModels:Vector.<TodoIconModel>;
      
      private var _disabledIconModels:Vector.<TodoIconModel>;
      
      private var _modelMap:Dictionary;
      
      private var _maxViewableIcons:int;
      
      public function get maxViewableIcons() : int {
         return this._maxViewableIcons;
      }
      
      private var _initialized:Boolean = false;
      
      override public function init() : void {
         if(!this._initialized)
         {
            this._maxViewableIcons = configModel.getIntForFeatureConfig("todoList","maxViewableIcons");
            this._enabledIconModels = new Vector.<TodoIconModel>();
            this._disabledIconModels = new Vector.<TodoIconModel>();
            this._modelMap = new Dictionary(true);
            if(!configModel.getBooleanForFeatureConfig("featureCleanup","isTodoDisabled"))
            {
               this.populate(configModel.getArrayForFeatureConfig("todoList","items"));
            }
            this._initialized = true;
         }
      }
      
      public function deleteItem(param1:String) : void {
         var _loc2_:* = 0;
         if(this._modelMap[param1])
         {
            _loc2_ = this._enabledIconModels.indexOf(this.getIconModelByName(param1));
            if(_loc2_ >= 0)
            {
               this._disabledIconModels.push(this._enabledIconModels.splice(_loc2_,1).shift());
            }
         }
      }
      
      public function addItem(param1:String) : void {
         var _loc2_:* = 0;
         if(!configModel.getBooleanForFeatureConfig("featureCleanup","isTodoDisabled"))
         {
            if(this._modelMap[param1])
            {
               _loc2_ = this._disabledIconModels.indexOf(this.getIconModelByName(param1));
               if(_loc2_ >= 0)
               {
                  this._enabledIconModels.push(this._disabledIconModels.splice(_loc2_,1).shift());
               }
            }
         }
      }
      
      public function iconToTop(param1:String) : void {
         var _loc2_:int = this.getIndexByName(param1);
         if(_loc2_ >= 0)
         {
            this._enabledIconModels.push(this._enabledIconModels.splice(_loc2_,1).shift());
         }
      }
      
      public function getIconModelByIndex(param1:int) : TodoIconModel {
         if(param1 >= 0 && param1 < this.numEnabledIcons)
         {
            return this._enabledIconModels[param1];
         }
         return null;
      }
      
      public function getIconModelByName(param1:String) : TodoIconModel {
         return this._modelMap[param1] as TodoIconModel;
      }
      
      public function getIndexByName(param1:String) : int {
         return this._enabledIconModels.indexOf(this.getIconModelByName(param1));
      }
      
      public function get numEnabledIcons() : int {
         return this._enabledIconModels != null?this._enabledIconModels.length:0;
      }
      
      public function updateIconCount(param1:String, param2:int) : void {
         if((this._modelMap) && (this._modelMap[param1]))
         {
            (this._modelMap[param1] as TodoIconModel).populate({"count":param2});
         }
      }
      
      private function populate(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:TodoIconModel = null;
         var _loc4_:String = null;
         for each (_loc2_ in param1)
         {
            _loc4_ = _loc2_["name"];
            if(!this._modelMap[_loc4_])
            {
               _loc3_ = new TodoIconModel();
               _loc3_.init();
               this._modelMap[_loc4_] = _loc3_;
            }
            this._modelMap[_loc4_].populate(_loc2_);
            if(this._modelMap[_loc4_].startDisabled)
            {
               this._disabledIconModels.push(_loc3_);
            }
            else
            {
               this._enabledIconModels.push(_loc3_);
            }
         }
      }
   }
}
