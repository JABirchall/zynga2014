package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.OpenProfileAtTabCommand;
   import com.zynga.poker.popups.modules.profile.ProfilePanelTab;
   
   public class AchievementActionTheDiceManCometh extends AchievementActionBase
   {
      
      public function AchievementActionTheDiceManCometh() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new OpenProfileAtTabCommand(ProfilePanelTab.COLLECTIONS));
      }
   }
}
