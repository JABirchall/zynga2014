package com.zynga.interfaces
{
   import flash.display.DisplayObjectContainer;
   
   public interface IMTTController extends IFeatureModuleController
   {
      
      function getViewByKey(param1:String) : DisplayObjectContainer;
      
      function set friendZids(param1:Array) : void;
   }
}
