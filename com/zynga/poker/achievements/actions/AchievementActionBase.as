package com.zynga.poker.achievements.actions
{
   public class AchievementActionBase extends Object implements IAchievementAction
   {
      
      public function AchievementActionBase() {
         super();
      }
      
      public function executeFromLobby() : void {
      }
      
      public function executeFromTable() : void {
         this.executeFromLobby();
      }
   }
}
