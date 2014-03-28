package com.zynga.poker.buddies.commands
{
   import com.zynga.poker.commands.EventDispatcherCommand;
   import com.zynga.poker.commands.CommandType;
   
   public class BuddiesCommand extends EventDispatcherCommand
   {
      
      public function BuddiesCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_BUDDIES_CONTROLLER,param1,param2,param3);
         _baseType = BuddiesCommand;
      }
   }
}
