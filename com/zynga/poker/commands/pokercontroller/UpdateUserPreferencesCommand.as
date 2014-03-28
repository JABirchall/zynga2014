package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateUserPreferencesCommand extends PokerControllerCommand
   {
      
      public function UpdateUserPreferencesCommand(param1:String, param2:Object) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_USER_PREFERENCES,
            {
               "key":param1,
               "value":param2
            }));
      }
   }
}
