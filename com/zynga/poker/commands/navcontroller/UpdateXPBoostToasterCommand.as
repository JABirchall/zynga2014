package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateXPBoostToasterCommand extends NavControllerCommand
   {
      
      public function UpdateXPBoostToasterCommand(param1:Object) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_XPBOOST_TOASTER,param1));
      }
   }
}
