package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   
   public class AchievementActionHiLoPro extends AchievementActionBase
   {
      
      public function AchievementActionHiLoPro() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowBuyPageCommand("profile",""));
      }
   }
}
