package com.zynga.poker.module.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.display.DisplayObjectContainer;
   
   public interface IModuleController extends IEventDispatcher
   {
      
      function loadModule(param1:String, param2:Function=null) : void;
      
      function unloadModule(param1:String) : void;
      
      function displayModule(param1:String, param2:Object=null, param3:DisplayObjectContainer=null) : Boolean;
      
      function hideModule(param1:String) : void;
      
      function closeModule(param1:String) : void;
      
      function closingModule(param1:String) : void;
      
      function isModuleOpen(param1:String) : Boolean;
   }
}
