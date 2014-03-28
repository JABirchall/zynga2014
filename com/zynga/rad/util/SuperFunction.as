package com.zynga.rad.util
{
   public class SuperFunction extends Object
   {
      
      public function SuperFunction() {
         super();
      }
      
      public static function create(param1:Object, param2:Function, ... rest) : Function {
         var obj:Object = param1;
         var func:Function = param2;
         var extraArgs:Array = rest;
         if(func == null)
         {
            return null;
         }
         return function(... rest):Object
         {
            return func.apply(obj != null?obj:func,rest.concat(extraArgs));
         };
      }
   }
}
