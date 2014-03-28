package com.zynga.poker.commands
{
   import com.zynga.io.IExternalCall;
   
   public class JSCommand extends Command
   {
      
      public function JSCommand(param1:String, ... rest) {
         super(CommandType.TYPE_JAVASCRIPT,rest);
         this.methodName = param1;
         _baseType = JSCommand;
      }
      
      protected var methodName:String;
      
      private var _callbackMethodName:String;
      
      private var _callbackHandler:Function;
      
      private var _externalInterface:IExternalCall;
      
      protected function addCallback(param1:String, param2:Function) : void {
         this._callbackMethodName = param1;
         this._callbackHandler = param2;
      }
      
      public function get callback() : Function {
         return this._callbackHandler;
      }
      
      public function execute(param1:IExternalCall) : void {
         var externalInterface:IExternalCall = param1;
         this._externalInterface = externalInterface;
         var args:Array = null;
         if(payload != null)
         {
            args = payload as Array;
         }
         if(args == null)
         {
            args = [];
         }
         if((this._callbackMethodName) && !(this._callbackHandler == null))
         {
            externalInterface.addCallback(this._callbackMethodName,this.onCallbackResponse);
         }
         args.unshift(this.methodName);
         try
         {
            externalInterface.call.apply(null,args);
         }
         catch(e:Error)
         {
            if((_callbackMethodName) && !(_callbackHandler == null))
            {
               externalInterface.removeCallback(_callbackMethodName);
            }
            throw e;
         }
      }
      
      private function onCallbackResponse(param1:Object) : void {
         if(this._callbackMethodName)
         {
            this._externalInterface.removeCallback(this._callbackMethodName);
         }
         if(this._callbackHandler != null)
         {
            this._callbackHandler(param1);
         }
         this._externalInterface = null;
         this._callbackMethodName = null;
         this._callbackHandler = null;
      }
   }
}
