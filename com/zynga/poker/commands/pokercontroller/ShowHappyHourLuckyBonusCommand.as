package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowHappyHourLuckyBonusCommand extends PokerControllerCommand
   {
      
      public function ShowHappyHourLuckyBonusCommand(param1:Boolean, param2:Boolean=false) {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_HAPPY_HOUR_LUCKY_BONUS,
            {
               "shouldShow":param1,
               "showRegularLB":param2
            }));
      }
   }
}
