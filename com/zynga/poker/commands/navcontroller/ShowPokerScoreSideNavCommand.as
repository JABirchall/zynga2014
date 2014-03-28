package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowPokerScoreSideNavCommand extends NavControllerCommand
   {
      
      public function ShowPokerScoreSideNavCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_POKER_SCORE_SIDENAV));
      }
   }
}
