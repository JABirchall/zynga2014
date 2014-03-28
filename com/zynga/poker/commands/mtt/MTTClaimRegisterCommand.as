package com.zynga.poker.commands.mtt
{
   import com.zynga.poker.commands.MTTControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class MTTClaimRegisterCommand extends MTTControllerCommand
   {
      
      public function MTTClaimRegisterCommand(param1:String) {
         super(new CommandEvent(CommandEvent.TYPE_MTT_CLAIM_REGISTER,{"id":param1}),null,null);
      }
   }
}
