package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowLuckyBonusCommand extends PokerControllerCommand
   {
      
      public function ShowLuckyBonusCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_LUCKY_BONUS),null,null);
      }
   }
}
