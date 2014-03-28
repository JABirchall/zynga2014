package com.zynga.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public interface IFeatureModuleController extends IEventDispatcher
   {
      
      function init(param1:DisplayObjectContainer, ... rest) : void;
      
      function onHandleEvent(param1:Event) : void;
   }
}
