package com.zynga.poker.buddies.commands
{
   import com.zynga.poker.buddies.events.BuddyEvent;
   
   public class BuddyAcceptRequestCommand extends BuddiesCommand
   {
      
      public function BuddyAcceptRequestCommand(param1:String, param2:String) {
         super(new BuddyEvent(BuddyEvent.ACCEPT_REQUEST,param1,param2));
      }
   }
}
