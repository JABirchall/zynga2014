package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class OpenProfileAtTabCommand extends PokerControllerCommand
   {
      
      public function OpenProfileAtTabCommand(param1:String="Overview", param2:String="", param3:String="", param4:String="") {
         var _loc5_:Object = 
            {
               "zid":param2,
               "tab":param1,
               "playerName":param3,
               "source":param4
            };
         super(new CommandEvent(CommandEvent.TYPE_OPEN_PROFILE_AT_TAB,_loc5_));
      }
   }
}
