package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ShowBuyPageCommand extends NavControllerCommand
   {
      
      public function ShowBuyPageCommand(param1:String="", param2:String="phpcallback", param3:String="gold") {
         var _loc4_:Object = 
            {
               "ref":param1,
               "entryPt":param2,
               "currency":param3
            };
         super(new CommandEvent(CommandEvent.TYPE_OPEN_BUY_PAGE,_loc4_));
      }
   }
}
