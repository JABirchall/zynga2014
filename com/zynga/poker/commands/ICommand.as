package com.zynga.poker.commands
{
   import com.zynga.poker.ConfigModel;
   
   public interface ICommand
   {
      
      function get payload() : Object;
      
      function get type() : int;
      
      function get baseType() : Class;
      
      function set configModel(param1:ConfigModel) : void;
   }
}
