package com.zynga.poker.commands
{
   public class SkipTablesControllerCommand extends EventDispatcherCommand
   {
      
      public function SkipTablesControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_SKIP_TABLES_CONTROLLER,param1,param2,param3);
         _baseType = SkipTablesControllerCommand;
      }
   }
}
