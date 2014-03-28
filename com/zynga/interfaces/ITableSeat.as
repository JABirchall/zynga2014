package com.zynga.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface ITableSeat extends IEventDispatcher
   {
      
      function init(param1:int, param2:Point) : void;
      
      function showSeat(param1:Boolean) : void;
      
      function get seatNumber() : int;
      
      function set position(param1:Point) : void;
   }
}
