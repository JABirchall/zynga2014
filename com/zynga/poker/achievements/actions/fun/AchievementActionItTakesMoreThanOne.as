package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.selfcontained.module.ShowModuleCommand;
   
   public class AchievementActionItTakesMoreThanOne extends AchievementActionBase
   {
      
      public function AchievementActionItTakesMoreThanOne() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowModuleCommand("challenges",{"defaultTab":0}));
      }
   }
}
