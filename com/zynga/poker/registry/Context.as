package com.zynga.poker.registry
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Context extends Object
   {
      
      public function Context() {
         super();
         this._mappings = new Dictionary();
      }
      
      private var _mappings:Dictionary;
      
      public function get mappings() : Dictionary {
         return this._mappings;
      }
      
      public function init() : void {
      }
      
      private function createInjectionMapping(param1:Class, param2:Class, param3:Boolean=true) : InjectionMapping {
         return new InjectionMapping(param1,param2,param3);
      }
      
      protected function addMapping(param1:Class, param2:Class, param3:Boolean=true) : void {
         var _loc4_:InjectionMapping = this.createInjectionMapping(param1,param2,param3);
         var param1:Class = _loc4_.typeClass;
         if(this._mappings[param1] != null)
         {
            throw new Error("ERROR: The typeClass " + getQualifiedClassName(param1) + " has already been mapped for the context " + _loc4_.isSingleton);
         }
         else
         {
            this._mappings[param1] = _loc4_;
            return;
         }
      }
   }
}
