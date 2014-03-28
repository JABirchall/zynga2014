package com.zynga.poker.commands
{
   public class MinigameControllerCommand extends EventDispatcherCommand
   {
      
      public function MinigameControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_MINIGAME_CONTROLLER,param1,param2,param3);
         _baseType = MinigameControllerCommand;
      }
   }
}
