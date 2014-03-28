package com.zynga.poker.table.shouts.views.common
{
   import flash.events.IEventDispatcher;
   
   public interface IShoutView extends IEventDispatcher
   {
      
      function open() : void;
      
      function init() : void;
      
      function close() : void;
      
      function destroy() : void;
      
      function get type() : int;
      
      function get timeout() : int;
      
      function get ready() : Boolean;
      
      function set ready(param1:Boolean) : void;
   }
}
