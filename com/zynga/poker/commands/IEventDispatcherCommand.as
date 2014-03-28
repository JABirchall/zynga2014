package com.zynga.poker.commands
{
   import flash.events.IEventDispatcher;
   
   public interface IEventDispatcherCommand extends ICommand
   {
      
      function execute(param1:IEventDispatcher) : void;
   }
}
