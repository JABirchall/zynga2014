package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class HideLeaderboardFlyoutCommand extends NavControllerCommand
   {
      
      public function HideLeaderboardFlyoutCommand() {
         super(new CommandEvent(CommandEvent.TYPE_HIDE_LEADERBOARD_FLYOUT));
      }
   }
}
