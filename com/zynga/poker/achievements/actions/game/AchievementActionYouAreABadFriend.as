package com.zynga.poker.achievements.actions.game
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionYouAreABadFriend extends AchievementActionBase
   {
      
      public function AchievementActionYouAreABadFriend() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Game_YouAreABadFriend"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.badFriend.body")));
      }
   }
}
