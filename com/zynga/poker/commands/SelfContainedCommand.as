package com.zynga.poker.commands
{
   import com.zynga.poker.registry.IClassRegistry;
   
   public class SelfContainedCommand extends Command
   {
      
      public function SelfContainedCommand(param1:Object=null, param2:Function=null) {
         super(-1,param1);
         this._handler = param2;
         _baseType = SelfContainedCommand;
      }
      
      protected var _handler:Function;
      
      protected var _responseType:String;
      
      public var registry:IClassRegistry;
      
      public function execute() : void {
      }
   }
}
