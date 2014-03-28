package com.zynga.poker
{
   import flash.events.IEventDispatcher;
   import com.zynga.poker.commands.ICommand;
   
   public interface ICommandDispatcher extends IEventDispatcher
   {
      
      function dispatchCommand(param1:ICommand) : void;
      
      function addDispatcherForType(param1:Class, param2:IEventDispatcher) : void;
   }
}
