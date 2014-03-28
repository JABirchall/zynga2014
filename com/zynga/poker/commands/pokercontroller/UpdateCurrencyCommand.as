package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateCurrencyCommand extends PokerControllerCommand
   {
      
      public function UpdateCurrencyCommand(param1:String="", param2:Number=0, param3:Boolean=true) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_CURRENCY,
            {
               "type":param1,
               "points":param2,
               "isDelta":param3
            }));
      }
   }
}
