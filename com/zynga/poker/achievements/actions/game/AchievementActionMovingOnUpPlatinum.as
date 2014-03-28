package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionMovingOnUpPlatinum extends AchievementActionBase
   {
      
      public function AchievementActionMovingOnUpPlatinum() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_MovingOnUpPlatinum"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.movinUp.platinum.body")));
      }
   }
}
