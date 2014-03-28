package com.zynga.poker.commands
{
   public class PopupControllerCommand extends EventDispatcherCommand
   {
      
      public function PopupControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_POPUP_CONTROLLER,param1,param2,param3);
         _baseType = PopupControllerCommand;
      }
   }
}
