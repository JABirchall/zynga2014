package com.zynga.poker.commands.mtt
{
   import com.zynga.poker.commands.ZPWCControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class ZPWCGenericCommand extends ZPWCControllerCommand
   {
      
      public function ZPWCGenericCommand(param1:String) {
         super(new CommandEvent(param1));
      }
   }
}
