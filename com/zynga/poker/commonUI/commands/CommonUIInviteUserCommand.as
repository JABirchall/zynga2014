package com.zynga.poker.commonUI.commands
{
   import com.zynga.poker.commonUI.events.InviteUserEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   
   public class CommonUIInviteUserCommand extends CommonUICommand
   {
      
      public function CommonUIInviteUserCommand(param1:Object, param2:String="zlive") {
         super(new InviteUserEvent(CommonVEvent.INVITE_USER,param1,param2));
      }
   }
}
