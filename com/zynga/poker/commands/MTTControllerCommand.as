package com.zynga.poker.commands
{
   public class MTTControllerCommand extends EventDispatcherCommand
   {
      
      public function MTTControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_MTT_CONTROLLER,param1,param2,param3);
         _baseType = MTTControllerCommand;
      }
   }
}
