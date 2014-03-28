package com.zynga.poker.registry
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.io.ExternalCall;
   
   public class PokerClassRegistry extends Object implements IClassRegistry
   {
      
      public function PokerClassRegistry() {
         this._objectCache = new Dictionary();
         super();
         InjectionFactory.getInstance().registry = this;
      }
      
      private var _mappings:Dictionary;
      
      private var _objectCache:Dictionary;
      
      public function addMappings(param1:Dictionary) : void {
         this._mappings = param1;
      }
      
      public function getObject(param1:Class) : * {
         var _loc2_:* = undefined;
         var _loc3_:InjectionMapping = null;
         var _loc4_:Class = null;
         var _loc5_:String = null;
         if(this._mappings != null)
         {
            _loc3_ = this._mappings[param1];
         }
         if(_loc3_ != null)
         {
            if(_loc3_.isSingleton)
            {
               _loc2_ = this._objectCache[param1];
            }
            if(!_loc3_.isSingleton || _loc2_ == null)
            {
               _loc4_ = _loc3_.instanceClass;
               _loc5_ = getQualifiedClassName(_loc4_);
               if(_loc5_ == getQualifiedClassName(PokerGlobalData))
               {
                  _loc2_ = PokerGlobalData.instance;
               }
               else
               {
                  if(_loc5_ == getQualifiedClassName(ExternalCall))
                  {
                     _loc2_ = ExternalCall.getInstance();
                  }
                  else
                  {
                     _loc2_ = new _loc4_();
                     _loc2_ = this.inject(_loc2_);
                  }
               }
               if(_loc3_.isSingleton)
               {
                  this._objectCache[param1] = _loc2_;
               }
               return _loc2_;
            }
         }
         else
         {
            _loc2_ = new param1();
            this.inject(_loc2_);
         }
         return _loc2_;
      }
      
      private function inject(param1:*) : * {
         var _loc2_:Injector = InjectionFactory.getInstance().getInjector(param1);
         if(_loc2_ != null)
         {
            _loc2_.inject(param1);
         }
         return param1;
      }
   }
}
