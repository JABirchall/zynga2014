package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateNavTimerCommand extends NavControllerCommand
   {
      
      public function UpdateNavTimerCommand(param1:String, param2:Number) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_NAV_TIMER,
            {
               "id":param1,
               "time":param2
            }));
      }
   }
}
