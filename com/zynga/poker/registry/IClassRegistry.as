package com.zynga.poker.registry
{
   import flash.utils.Dictionary;
   
   public interface IClassRegistry
   {
      
      function addMappings(param1:Dictionary) : void;
      
      function getObject(param1:Class) : *;
   }
}
