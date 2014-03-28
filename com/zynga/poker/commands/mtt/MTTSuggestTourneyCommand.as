package com.zynga.poker.commands.mtt
{
   import com.zynga.poker.commands.MTTControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class MTTSuggestTourneyCommand extends MTTControllerCommand
   {
      
      public function MTTSuggestTourneyCommand() {
         super(new CommandEvent(CommandEvent.TYPE_MTT_PLAY_NOW));
      }
   }
}
