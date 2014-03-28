package com.zynga.poker.commands.leaderboard
{
   import com.zynga.poker.commands.LeaderboardCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class SurfaceLeaderboardCommand extends LeaderboardCommand
   {
      
      public function SurfaceLeaderboardCommand(param1:Boolean) {
         super(new CommandEvent(CommandEvent.TYPE_SURFACE_LEADERBOARD,{"visible":param1}));
      }
   }
}
