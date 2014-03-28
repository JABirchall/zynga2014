package com.zynga.poker.commands.mtt
{
   import com.zynga.poker.commands.ZPWCControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ZPWCShowRegistrationCommand extends ZPWCControllerCommand
   {
      
      public function ZPWCShowRegistrationCommand(param1:Number) {
         super(new CommandEvent(CommandEvent.TYPE_ZPWC_REGISTER_TOURNAMENT,{"tournamentID":param1}));
      }
   }
}
