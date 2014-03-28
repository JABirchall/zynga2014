package com.zynga.poker.commands
{
   public class NavControllerCommand extends EventDispatcherCommand
   {
      
      public function NavControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_NAV_CONTROLLER,param1,param2,param3);
         _baseType = NavControllerCommand;
      }
   }
}
