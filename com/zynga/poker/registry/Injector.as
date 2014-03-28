package com.zynga.poker.registry
{
   import flash.utils.getQualifiedClassName;
   
   public class Injector extends Object
   {
      
      public function Injector(param1:Class) {
         super();
         this._targetClass = param1;
      }
      
      private var _targetClass:Class;
      
      protected var _registry:IClassRegistry;
      
      public function set registry(param1:IClassRegistry) : void {
         this._registry = param1;
      }
      
      protected function canInject(param1:*) : Boolean {
         return param1 is this._targetClass;
      }
      
      public final function inject(param1:*) : void {
         if(!this.canInject(param1))
         {
            throw new Error("ERROR: " + getQualifiedClassName(this) + " cannot inject into " + getQualifiedClassName(param1));
         }
         else
         {
            this._inject(param1);
            return;
         }
      }
      
      protected function _inject(param1:*) : void {
      }
   }
}
