package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.lobbycontroller.ShowTournamentsAtSubtabCommand;
   import com.zynga.poker.lobby.TournamentSubTabs;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   
   public class AchievementActionPowerPlayer extends AchievementActionBase
   {
      
      public function AchievementActionPowerPlayer() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowTournamentsAtSubtabCommand(TournamentSubTabs.POWER));
      }
      
      override public function executeFromTable() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Fun_PowerPlayer"),LocaleManager.localize("flash.popups.profile.achievements.table.powerPlayer")));
      }
   }
}
