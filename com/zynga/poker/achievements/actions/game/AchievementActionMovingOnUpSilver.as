package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionMovingOnUpSilver extends AchievementActionBase
   {
      
      public function AchievementActionMovingOnUpSilver() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_MovingOnUpSilver"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.movinUp.silver.body")));
      }
   }
}
