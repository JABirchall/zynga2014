package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionMovingOnUpGold extends AchievementActionBase
   {
      
      public function AchievementActionMovingOnUpGold() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_MovingOnUpGold"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.movinUp.gold.body")));
      }
   }
}
