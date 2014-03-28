package com.zynga.poker.commands.lobbycontroller
{
   import com.zynga.poker.commands.LobbyControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowLobbyBannerCommand extends LobbyControllerCommand
   {
      
      public function ShowLobbyBannerCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_LOBBY_BANNER));
      }
   }
}
