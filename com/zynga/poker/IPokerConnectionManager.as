package com.zynga.poker
{
   import flash.events.IEventDispatcher;
   
   public interface IPokerConnectionManager extends IEventDispatcher
   {
      
      function sendMessage(param1:Object) : void;
      
      function disconnect() : void;
   }
}
