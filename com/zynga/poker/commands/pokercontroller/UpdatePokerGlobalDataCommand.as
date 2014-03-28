package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdatePokerGlobalDataCommand extends PokerControllerCommand
   {
      
      public function UpdatePokerGlobalDataCommand(param1:String, param2:Object) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_POKER_GLOBAL_DATA,
            {
               "name":param1,
               "value":param2
            }),null,null);
      }
   }
}
