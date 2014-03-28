package com.zynga.poker.commands.selfcontained
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.table.TableController;
   
   public class HideTableInviteCommand extends SelfContainedCommand
   {
      
      public function HideTableInviteCommand() {
         super();
      }
      
      override public function execute() : void {
         registry.getObject(TableController).hideInvite();
      }
   }
}
