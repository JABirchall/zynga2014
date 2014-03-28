package com.zynga.poker.commonUI.commands
{
   import com.zynga.poker.commonUI.events.JoinUserEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   
   public class CommonUIJoinUserCommand extends CommonUICommand
   {
      
      public function CommonUIJoinUserCommand(param1:Object, param2:String="zlive") {
         super(new JoinUserEvent(CommonVEvent.JOIN_USER,param1,param2));
      }
   }
}
