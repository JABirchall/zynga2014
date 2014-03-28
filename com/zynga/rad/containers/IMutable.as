package com.zynga.rad.containers
{
   import flash.display.DisplayObject;
   
   public interface IMutable
   {
      
      function removeItem(param1:DisplayObject) : void;
      
      function addItem(param1:DisplayObject, param2:int=-1) : void;
   }
}
