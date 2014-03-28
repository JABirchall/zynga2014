package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class HideFullScreenCommand extends PokerControllerCommand
   {
      
      public function HideFullScreenCommand() {
         super(new CommandEvent(CommandEvent.TYPE_HIDE_FULLSCREEN),null,null);
      }
   }
}
