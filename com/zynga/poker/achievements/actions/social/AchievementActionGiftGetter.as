package com.zynga.poker.achievements.actions.social
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.js.OpenZSCCommand;
   
   public class AchievementActionGiftGetter extends AchievementActionBase
   {
      
      public function AchievementActionGiftGetter() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new OpenZSCCommand());
      }
   }
}
