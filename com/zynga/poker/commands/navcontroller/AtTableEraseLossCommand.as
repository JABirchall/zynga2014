package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class AtTableEraseLossCommand extends NavControllerCommand
   {
      
      public function AtTableEraseLossCommand(param1:String) {
         super(new CommandEvent(param1));
      }
      
      public static const BUY_ATTABLEERASELOSS_COUPON:String = "BUY_ATTABLEERASELOSS_COUPON";
      
      public static const SHOW_ATTABLEERASELOSS_SIDENAV:String = "SHOW_ATTABLEERASELOSS_SIDENAV";
   }
}
