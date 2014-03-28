package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowSideNavCommand extends NavControllerCommand
   {
      
      public function ShowSideNavCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_SIDENAV));
      }
   }
}
