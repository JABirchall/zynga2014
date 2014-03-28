package com.zynga.poker.commands.selfcontained.casino
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.IPokerConnectionManager;
   
   public class ChangeServerCommand extends SelfContainedCommand
   {
      
      public function ChangeServerCommand(param1:String, param2:int, param3:Boolean, param4:Boolean) {
         super(
            {
               "newServerId":param1,
               "newRoomId":param2,
               "joiningContact":param3,
               "joiningShootout":param4
            },null);
      }
      
      override public function execute() : void {
         var _loc1_:PokerGlobalData = registry.getObject(PokerGlobalData);
         var _loc2_:IPokerConnectionManager = registry.getObject(IPokerConnectionManager);
         _loc1_.newServerId = payload.newServerId;
         _loc1_.nNewRoomId = payload.newRoomId;
         _loc1_.joiningContact = payload.joiningContact;
         _loc1_.joiningShootout = payload.joiningShootout;
         _loc2_.disconnect();
      }
   }
}
