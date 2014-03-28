package com.zynga.poker.commands
{
   public class PokerControllerCommand extends EventDispatcherCommand
   {
      
      public function PokerControllerCommand(param1:Object, param2:String=null, param3:Function=null) {
         super(CommandType.TYPE_POKER_CONTROLLER,param1,param2,param3);
         _baseType = PokerControllerCommand;
      }
   }
}
