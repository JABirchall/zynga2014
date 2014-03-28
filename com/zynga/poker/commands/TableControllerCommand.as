package com.zynga.poker.commands
{
   public class TableControllerCommand extends EventDispatcherCommand
   {
      
      public function TableControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_TABLE_CONTROLLER,param1,param2,param3);
         _baseType = TableControllerCommand;
      }
   }
}
