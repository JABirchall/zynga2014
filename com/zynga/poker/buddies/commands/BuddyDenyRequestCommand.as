package com.zynga.poker.buddies.commands
{
   import com.zynga.poker.buddies.events.BuddyEvent;
   
   public class BuddyDenyRequestCommand extends BuddiesCommand
   {
      
      public function BuddyDenyRequestCommand(param1:String) {
         super(new BuddyEvent(BuddyEvent.DENY_REQUEST,param1));
      }
   }
}
