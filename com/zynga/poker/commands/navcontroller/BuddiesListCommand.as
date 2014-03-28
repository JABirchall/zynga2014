package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.nav.events.NVEvent;
   import com.zynga.poker.events.CommandEvent;
   
   public class BuddiesListCommand extends NavControllerCommand
   {
      
      public function BuddiesListCommand(param1:String) {
         super(new CommandEvent(param1));
      }
      
      public static const HIDE_BUDDIES_DROPDOWN:String = NVEvent.HIDE_BUDDIES_DROPDOWN;
      
      public static const SHOW_BUDDIES_DROPDOWN:String = NVEvent.SHOW_BUDDIES_DROPDOWN;
      
      public static const TOGGLE_BUDDIES_DROPDOWN:String = NVEvent.TOGGLE_BUDDIES_DROPDOWN;
   }
}
