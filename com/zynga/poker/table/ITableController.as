package com.zynga.poker.table
{
   import flash.events.IEventDispatcher;
   
   public interface ITableController extends IEventDispatcher
   {
      
      function autoSit(param1:Number=0) : void;
      
      function isSeated(param1:String="") : Boolean;
   }
}
