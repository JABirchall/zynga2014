package com.zynga.io
{
   import flash.external.ExternalInterface;
   
   public class ExternalCall extends Object implements IExternalCall
   {
      
      public function ExternalCall(param1:Inner) {
         super();
         if(param1 == null)
         {
            throw new Error("ExternalCall class cannot be instantiated");
         }
         else
         {
            this._isAvailable = ExternalInterface.available;
            return;
         }
      }
      
      private static var _instance:ExternalCall;
      
      public static function getInstance() : ExternalCall {
         if(_instance == null)
         {
            _instance = new ExternalCall(new Inner());
         }
         return _instance;
      }
      
      private var _isAvailable:Boolean;
      
      public function get available() : Boolean {
         return this._isAvailable;
      }
      
      public function addCallback(param1:String, param2:Function) : void {
         var methodName:String = param1;
         var callback:Function = param2;
         if(!this._isAvailable || !methodName || callback == null)
         {
            return;
         }
         try
         {
            ExternalInterface.addCallback(methodName,callback);
         }
         catch(e:Error)
         {
            throw e;
         }
      }
      
      public function removeCallback(param1:String) : void {
         this.addCallback(param1,null);
      }
      
      public function call(param1:String, ... rest) : * {
         var jsArgs:Array = null;
         var methodName:String = param1;
         var args:Array = rest;
         if(!this._isAvailable || !methodName)
         {
            return;
         }
         try
         {
            jsArgs = [methodName];
            jsArgs.push.apply(null,args);
            return ExternalInterface.call.apply(null,jsArgs);
         }
         catch(e:Error)
         {
            throw e;
         }
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
