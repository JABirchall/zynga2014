package com.zynga.poker.commands.tablecontroller
{
   import com.zynga.poker.commands.TableControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowHSMPromoCommand extends TableControllerCommand
   {
      
      public function ShowHSMPromoCommand() {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_HSM_PROMO),null,null);
      }
   }
}
