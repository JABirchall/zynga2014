package com.zynga.poker.commands.lobbycontroller
{
   import com.zynga.poker.commands.LobbyControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowTournamentsAtSubtabCommand extends LobbyControllerCommand
   {
      
      public function ShowTournamentsAtSubtabCommand(param1:int=0) {
         super(new CommandEvent(CommandEvent.TYPE_OPEN_TOURNAMENTS_AT_SUBTAB,{"tab":param1}),null,null);
      }
   }
}
