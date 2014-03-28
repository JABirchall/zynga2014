package com.zynga.poker.commands.navcontroller
{
   import com.zynga.poker.commands.NavControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class DisplayGiftShopCommand extends NavControllerCommand
   {
      
      public function DisplayGiftShopCommand() {
         super(new CommandEvent(CommandEvent.TYPE_DISPLAY_GIFT_SHOP));
      }
   }
}
