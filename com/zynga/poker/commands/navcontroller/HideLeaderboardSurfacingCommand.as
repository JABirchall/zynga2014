package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class HideLeaderboardSurfacingCommand extends NavControllerCommand
   {
      
      public function HideLeaderboardSurfacingCommand() {
         super(new CommandEvent(CommandEvent.TYPE_HIDE_LEADERBOARD_SURFACING));
      }
   }
}
