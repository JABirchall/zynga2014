package com.zynga.poker.commonUI.commands
{
   import com.zynga.poker.commonUI.events.CommonVEvent;
   
   public class CommonUIInviteFriendsCommand extends CommonUICommand
   {
      
      public function CommonUIInviteFriendsCommand() {
         super(new CommonVEvent(CommonVEvent.INVITE_FRIENDS));
      }
   }
}
