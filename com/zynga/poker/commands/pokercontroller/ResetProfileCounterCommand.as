package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ResetProfileCounterCommand extends PokerControllerCommand
   {
      
      public function ResetProfileCounterCommand(param1:String) {
         super(new CommandEvent(CommandEvent.TYPE_RESET_PROFILE_COUNTER,param1),null,null);
      }
      
      public static const COLLECTIONS:String = "collections";
      
      public static const ACHIEVEMENTS:String = "achievements";
   }
}
