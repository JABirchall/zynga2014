package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.CommandEvent;
   
   public class UpdateCollectionsInfoCommand extends PokerControllerCommand
   {
      
      public function UpdateCollectionsInfoCommand(param1:Object) {
         super(new CommandEvent(CommandEvent.TYPE_UPDATE_COLLECTIONS_INFO,param1),null,null);
      }
   }
}
