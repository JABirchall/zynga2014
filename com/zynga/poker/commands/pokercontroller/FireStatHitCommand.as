package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.events.CommandEvent;
   
   public class FireStatHitCommand extends PokerControllerCommand
   {
      
      public function FireStatHitCommand(param1:PokerStatHit) {
         super(new CommandEvent(CommandEvent.TYPE_FIRE_STAT_HIT,param1),null,null);
      }
   }
}
