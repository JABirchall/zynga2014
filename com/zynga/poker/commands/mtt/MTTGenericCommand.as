package com.zynga.poker.commands.mtt
{
   import com.zynga.poker.commands.MTTControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class MTTGenericCommand extends MTTControllerCommand
   {
      
      public function MTTGenericCommand(param1:String) {
         super(new CommandEvent(param1));
      }
   }
}
