package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowXPBoostToasterCommand extends NavControllerCommand
   {
      
      public function ShowXPBoostToasterCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_XPBOOST_TOASTER));
      }
   }
}
