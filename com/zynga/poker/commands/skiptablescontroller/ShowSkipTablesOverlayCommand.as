package com.zynga.poker.commands.skiptablescontroller
{
   import com.zynga.poker.commands.SkipTablesControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowSkipTablesOverlayCommand extends SkipTablesControllerCommand
   {
      
      public function ShowSkipTablesOverlayCommand(param1:Boolean=true) {
         super(new CommandEvent(CommandEvent.TYPE_SHOW_SKIP_TABLES_OVERLAY,{"show":param1}));
      }
   }
}
