package com.zynga.poker.achievements.actions.social
{
   import com.zynga.poker.achievements.actions.AchievementActionBase;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.js.RequestTwoMFSCommand;
   
   public class AchievementActionYouAreAGoodFriend extends AchievementActionBase
   {
      
      public function AchievementActionYouAreAGoodFriend() {
         super();
      }
      
      override public function executeFromLobby() : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new RequestTwoMFSCommand());
      }
   }
}
