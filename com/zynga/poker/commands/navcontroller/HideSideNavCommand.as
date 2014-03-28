package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class HideSideNavCommand extends NavControllerCommand
   {
      
      public function HideSideNavCommand() {
         super(new CommandEvent(CommandEvent.TYPE_HIDE_SIDENAV));
      }
   }
}
