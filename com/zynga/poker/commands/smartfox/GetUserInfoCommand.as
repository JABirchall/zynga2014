package com.zynga.poker.commands.smartfox
{
   import com.zynga.poker.commands.SmartfoxCommand;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.protocol.ProtocolEvent;
   import com.zynga.poker.protocol.SGetUserInfo;
   
   public class GetUserInfoCommand extends SmartfoxCommand
   {
      
      public function GetUserInfoCommand() {
         var _loc1_:SGetUserInfo = new SGetUserInfo("SGetUserInfo","casino_gold","xp");
         super(_loc1_);
      }
      
      override public function execute(param1:IPokerConnectionManager) : void {
         var _loc2_:Object = _payload;
         if(_configModel.isFeatureEnabled("hsm"))
         {
            _loc2_.reqParams["rake"] = 1;
         }
         _dispatcher = param1;
         _dispatcher.addEventListener(ProtocolEvent.onMessage,onProtocolMessage);
         _dispatcher.sendMessage(_loc2_);
      }
   }
}
