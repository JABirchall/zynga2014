package com.zynga.poker.commands.selfcontained
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.lobby.LobbyController;
   
   public class CheckLobbyTimerCommand extends SelfContainedCommand
   {
      
      public function CheckLobbyTimerCommand() {
         super();
      }
      
      override public function execute() : void {
         registry.getObject(LobbyController).checkLobbyTimerAndDoHitForStat();
      }
   }
}
