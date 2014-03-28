package com.zynga.poker.commands
{
   public class LeaderboardCommand extends EventDispatcherCommand
   {
      
      public function LeaderboardCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_LEADERBOARD,param1,param2,param3);
         _baseType = LeaderboardCommand;
      }
   }
}
