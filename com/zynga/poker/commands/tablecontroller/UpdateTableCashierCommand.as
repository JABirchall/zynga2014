package com.zynga.poker.commands.tablecontroller
{
   import com.zynga.poker.commands.TableControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateTableCashierCommand extends TableControllerCommand
   {
      
      public function UpdateTableCashierCommand(param1:Number) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_TABLE_CASHIER,param1));
      }
   }
}
