package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class InitUnluckyHandCommand extends NavControllerCommand
   {
      
      public function InitUnluckyHandCommand() {
         super(new CommandEvent(CommandEvent.TYPE_INIT_UNLUCKY_HAND_COUPON));
      }
   }
}
