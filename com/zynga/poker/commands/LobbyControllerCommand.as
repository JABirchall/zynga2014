package com.zynga.poker.commands
{
   public class LobbyControllerCommand extends EventDispatcherCommand
   {
      
      public function LobbyControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_LOBBY_CONTROLLER,param1,param2,param3);
         _baseType = LobbyControllerCommand;
      }
   }
}
