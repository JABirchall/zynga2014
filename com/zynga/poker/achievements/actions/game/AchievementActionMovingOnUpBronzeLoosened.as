package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionMovingOnUpBronzeLoosened extends AchievementActionBase
   {
      
      public function AchievementActionMovingOnUpBronzeLoosened() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_MovingOnUpBronze"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.movinUp.bronze_loose.body")));
      }
   }
}
