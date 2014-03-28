package com.zynga.poker.commands
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   
   public class EventDispatcherCommand extends Command implements IEventDispatcherCommand
   {
      
      public function EventDispatcherCommand(param1:int, param2:Object, param3:String, param4:Function) {
         super(param1,param2);
         this._handler = param4;
         this._responseType = param3;
         _baseType = EventDispatcherCommand;
      }
      
      protected var _dispatcher:IEventDispatcher;
      
      protected var _handler:Function;
      
      protected var _responseType:String;
      
      public function execute(param1:IEventDispatcher) : void {
         this._dispatcher = param1;
         if(this._handler != null)
         {
            this._dispatcher.addEventListener(this._responseType,this.onEventResponse);
         }
         this._dispatcher.dispatchEvent(_payload as Event);
      }
      
      private function onEventResponse(param1:Event) : void {
         this._dispatcher.removeEventListener(this._responseType,this.onEventResponse);
         if(this._handler != null)
         {
            this._handler(param1);
            this._handler = null;
         }
      }
   }
}
