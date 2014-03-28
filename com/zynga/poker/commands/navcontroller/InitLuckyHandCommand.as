package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class InitLuckyHandCommand extends NavControllerCommand
   {
      
      public function InitLuckyHandCommand() {
         super(new CommandEvent(CommandEvent.TYPE_INIT_LUCKY_HAND_COUPON));
      }
   }
}
