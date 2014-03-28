package com.zynga.poker.feature
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.popups.Popup;
   import flash.events.Event;
   
   public class ModuleLoader extends EventDispatcher
   {
      
      public function ModuleLoader(param1:String=null) {
         super();
         this._moduleId = param1;
         this.init();
      }
      
      public var registry:IClassRegistry;
      
      private var _moduleId:String;
      
      private var _dependencies:Array;
      
      private var _dependenciesLoaded:Array;
      
      private var _numDependenciesLoaded:int;
      
      private var _callback:Function;
      
      private function init() : void {
         this._numDependenciesLoaded = 0;
         this._dependencies = [];
         this._dependenciesLoaded = [];
      }
      
      private function buildDependencyList() : void {
         var _loc1_:IPopupController = null;
         var _loc2_:Popup = null;
         var _loc3_:String = null;
         if(this._moduleId)
         {
            _loc1_ = this.registry.getObject(IPopupController);
            _loc2_ = _loc1_.getPopupConfigByID(this._moduleId);
            if(_loc2_.moduleDependencies)
            {
               for each (_loc3_ in _loc2_.moduleDependencies)
               {
                  this.addDependency(_loc3_);
               }
            }
            this.detectCircularDependencies();
         }
      }
      
      private function detectCircularDependencies() : void {
      }
      
      public function load(param1:Function=null) : void {
         var _loc2_:IPopupController = null;
         var _loc3_:String = null;
         var _loc4_:Popup = null;
         this.buildDependencyList();
         this._callback = param1;
         if(this.numDependencies > 0)
         {
            _loc2_ = this.registry.getObject(IPopupController);
            for each (_loc3_ in this._dependencies)
            {
               _loc4_ = _loc2_.getPopupConfigByID(_loc3_,true,this.onDependencyLoaded,_loc3_);
               if(_loc4_.hasModule)
               {
                  if(_loc4_.module != null)
                  {
                     this.onDependencyLoaded(_loc3_);
                  }
               }
               else
               {
                  this.onDependencyLoaded(_loc3_);
               }
            }
         }
         else
         {
            this.onDependenciesLoaded();
         }
      }
      
      private function onDependencyLoaded(param1:String) : void {
         if(!this._dependenciesLoaded[param1])
         {
            this._dependenciesLoaded[param1] = true;
            this._numDependenciesLoaded++;
         }
         if(this._numDependenciesLoaded >= this.numDependencies)
         {
            this.onDependenciesLoaded();
         }
      }
      
      private function onDependenciesLoaded() : void {
         if(this._callback != null)
         {
            this._callback.apply();
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function addDependency(param1:String) : void {
         var _loc2_:IPopupController = null;
         var _loc3_:Popup = null;
         if(!this.hasDependency(param1))
         {
            _loc2_ = this.registry.getObject(IPopupController);
            _loc3_ = _loc2_.getPopupConfigByID(param1);
            if((_loc3_) && !_loc3_.module)
            {
               this._dependencies.push(param1);
            }
         }
      }
      
      public function hasDependency(param1:String) : Boolean {
         return !(this._dependencies.indexOf(param1) == -1);
      }
      
      public function get numDependencies() : int {
         if(!this._dependencies)
         {
            return 0;
         }
         return this._dependencies.length;
      }
      
      public function dispose() : void {
         this._dependencies.length = 0;
         this._dependencies = null;
         this._dependenciesLoaded.length = 0;
         this._dependencies = null;
         this._moduleId = null;
         this._callback = null;
      }
   }
}
