package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowLeaderboardSurfacingCommand extends NavControllerCommand
   {
      
      public function ShowLeaderboardSurfacingCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_LEADERBOARD_SURFACING));
      }
   }
}
