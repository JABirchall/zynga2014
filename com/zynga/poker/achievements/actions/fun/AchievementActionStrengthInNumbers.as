package com.zynga.poker.achievements.actions.fun
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.ShowErrorPopupCommand;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.commands.tablecontroller.ShowHSMPromoCommand;
   
   public class AchievementActionStrengthInNumbers extends AchievementActionBase
   {
      
      public function AchievementActionStrengthInNumbers() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowErrorPopupCommand(LocaleManager.localize("flash.popups.profile.achievements.name.Fun_StrengthInNumbers"),LocaleManager.localize("flash.popups.profile.achievements.clickActions.hsm.body")));
      }
      
      override public function executeFromTable() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowHSMPromoCommand());
      }
   }
}
