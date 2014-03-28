package com.zynga.poker.commands
{
   public class ZPWCControllerCommand extends EventDispatcherCommand
   {
      
      public function ZPWCControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_ZPWC_CONTROLLER,param1,param2,param3);
         _baseType = MTTControllerCommand;
      }
   }
}
