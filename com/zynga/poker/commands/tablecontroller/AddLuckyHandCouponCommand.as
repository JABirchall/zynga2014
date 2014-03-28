package com.zynga.poker.commands.tablecontroller
{
   import com.zynga.poker.commands.TableControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class AddLuckyHandCouponCommand extends TableControllerCommand
   {
      
      public function AddLuckyHandCouponCommand(param1:Object) {
         super(new CommandEvent(CommandEvent.TYPE_ADD_LUCKY_HAND_COUPON,param1),null,null);
      }
   }
}
