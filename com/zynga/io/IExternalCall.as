package com.zynga.io
{
   public interface IExternalCall
   {
      
      function get available() : Boolean;
      
      function addCallback(param1:String, param2:Function) : void;
      
      function removeCallback(param1:String) : void;
      
      function call(param1:String, ... rest) : *;
   }
}
