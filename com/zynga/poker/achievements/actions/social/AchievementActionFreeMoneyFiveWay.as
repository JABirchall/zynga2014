package com.zynga.poker.achievements.actions.social
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowLuckyBonusCommand;
   
   public class AchievementActionFreeMoneyFiveWay extends AchievementActionBase
   {
      
      public function AchievementActionFreeMoneyFiveWay() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowLuckyBonusCommand());
      }
   }
}
