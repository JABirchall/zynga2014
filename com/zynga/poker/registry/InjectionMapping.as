package com.zynga.poker.registry
{
   public class InjectionMapping extends Object
   {
      
      public function InjectionMapping(param1:Class, param2:Class, param3:Boolean=true) {
         super();
         this._isSingleton = param3;
         this._instanceClass = param2;
         this._typeClass = param1;
      }
      
      private var _isSingleton:Boolean = true;
      
      public function get isSingleton() : Boolean {
         return this._isSingleton;
      }
      
      private var _instanceClass:Class;
      
      public function get instanceClass() : Class {
         return this._instanceClass;
      }
      
      private var _typeClass:Class;
      
      public function get typeClass() : Class {
         return this._typeClass;
      }
   }
}
