package com.zynga.poker.commands.tablecontroller
{
   import com.zynga.poker.commands.TableControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateChickletPokerScoreCommand extends TableControllerCommand
   {
      
      public function UpdateChickletPokerScoreCommand(param1:Object) {
         super(new CommandEvent(CommandEvent.TYPE_TABLE_CHICKLET_UPDATE_POKER_SCORE,param1),null,null);
      }
   }
}
