package com.zynga.poker.commonUI.commands
{
   import com.zynga.poker.commands.EventDispatcherCommand;
   import com.zynga.poker.commands.CommandType;
   
   public class CommonUICommand extends EventDispatcherCommand
   {
      
      public function CommonUICommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_COMMON_UI_CONTROLLER,param1,param2,param3);
         _baseType = CommonUICommand;
      }
   }
}
