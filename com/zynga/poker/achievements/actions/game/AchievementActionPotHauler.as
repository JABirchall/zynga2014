package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionPotHauler extends AchievementActionBase
   {
      
      public function AchievementActionPotHauler() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_PotHauler"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.potHaul.body")));
      }
   }
}
