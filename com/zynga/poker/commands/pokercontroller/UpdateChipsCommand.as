package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateChipsCommand extends PokerControllerCommand
   {
      
      public function UpdateChipsCommand(param1:Number=0, param2:Boolean=true, param3:Boolean=false) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_CHIPS,
            {
               "points":param1,
               "isDelta":param2,
               "updateOffTableDisplays":param3
            }));
      }
   }
}
