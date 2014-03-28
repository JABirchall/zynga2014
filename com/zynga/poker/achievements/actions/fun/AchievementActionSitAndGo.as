package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.lobbycontroller.ShowTournamentsAtSubtabCommand;
   import com.zynga.poker.lobby.TournamentSubTabs;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionSitAndGo extends AchievementActionBase
   {
      
      public function AchievementActionSitAndGo() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowTournamentsAtSubtabCommand(TournamentSubTabs.SITNGO));
      }
      
      override public function executeFromTable() : void {
         if(PokerGlobalData.instance.configModel.isFeatureEnabled("looseningAchievements"))
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand("Sit-N-Goer","Testing Sit-N-Goer"));
         }
         else
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Fun_SitAndGo"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.sitGo.body")));
         }
      }
   }
}
