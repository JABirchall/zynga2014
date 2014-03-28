package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class FireZTrackMilestoneHitCommand extends PokerControllerCommand
   {
      
      public function FireZTrackMilestoneHitCommand(param1:String, param2:String) {
         super(new CommandEvent(CommandEvent.TYPE_FIRE_ZTRACK_MILESTONE_HIT,
            {
               "key":param1,
               "value":param2
            }),null,null);
      }
   }
}
