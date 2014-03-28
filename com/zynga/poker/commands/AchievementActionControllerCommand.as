package com.zynga.poker.commands
{
   public class AchievementActionControllerCommand extends EventDispatcherCommand
   {
      
      public function AchievementActionControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_ACHIEVEMENT_ACTION_CONTROLLER,param1,param2,param3);
         _baseType = AchievementActionControllerCommand;
      }
   }
}
