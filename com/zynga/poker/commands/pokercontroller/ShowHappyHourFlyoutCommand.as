package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowHappyHourFlyoutCommand extends PokerControllerCommand
   {
      
      public function ShowHappyHourFlyoutCommand(param1:String, param2:Boolean) {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_HAPPY_HOUR_FLYOUT,
            {
               "type":param1,
               "isMarketing":param2
            }));
      }
   }
}
