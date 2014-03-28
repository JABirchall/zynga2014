package com.zynga.rad.interfaces
{
   public interface ILocalizer
   {
      
      function get localeCode() : String;
      
      function translate(param1:String, param2:String, param3:Object=null) : String;
   }
}
