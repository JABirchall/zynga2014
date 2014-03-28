package com.zynga.poker.commands
{
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.protocol.ProtocolEvent;
   
   public class SmartfoxCommand extends Command
   {
      
      public function SmartfoxCommand(param1:Object) {
         this._callbacks = {};
         super(CommandType.TYPE_SMARTFOX,param1);
         _baseType = SmartfoxCommand;
      }
      
      protected var _dispatcher:IPokerConnectionManager;
      
      private var _callbacks:Object;
      
      protected function addCallback(param1:String, param2:Function) : void {
         this._callbacks[param1] = param2;
      }
      
      public function execute(param1:IPokerConnectionManager) : void {
         this._dispatcher = param1;
         this._dispatcher.addEventListener(ProtocolEvent.onMessage,this.onProtocolMessage);
         this._dispatcher.sendMessage(_payload);
      }
      
      protected function onProtocolMessage(param1:ProtocolEvent) : void {
         var _loc2_:Object = param1.msg;
         var _loc3_:String = _loc2_.type;
         if(this._callbacks[_loc3_] != null)
         {
            this._dispatcher.removeEventListener(ProtocolEvent.onMessage,this.onProtocolMessage);
            this._callbacks[_loc3_](_loc2_);
            this._callbacks = null;
         }
      }
   }
}
