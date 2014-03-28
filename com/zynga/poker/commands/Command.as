package com.zynga.poker.commands
{
   import com.zynga.poker.ConfigModel;
   
   public class Command extends Object implements ICommand
   {
      
      public function Command(param1:int, param2:Object) {
         super();
         this._type = param1;
         this._payload = param2;
         this._baseType = Command;
      }
      
      protected var _payload:Object;
      
      protected var _type:int;
      
      protected var _baseType:Class;
      
      protected var _configModel:ConfigModel;
      
      public function set configModel(param1:ConfigModel) : void {
         this._configModel = param1;
      }
      
      public function get payload() : Object {
         return this._payload;
      }
      
      public function get type() : int {
         return this._type;
      }
      
      public function get baseType() : Class {
         return this._baseType;
      }
   }
}
