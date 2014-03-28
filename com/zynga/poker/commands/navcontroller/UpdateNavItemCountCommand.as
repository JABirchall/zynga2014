package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateNavItemCountCommand extends NavControllerCommand
   {
      
      public function UpdateNavItemCountCommand(param1:String, param2:int) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_NAV_ITEM_COUNT,
            {
               "id":param1,
               "count":param2
            }));
      }
   }
}
