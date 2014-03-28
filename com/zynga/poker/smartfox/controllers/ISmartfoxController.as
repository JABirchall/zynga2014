package com.zynga.poker.smartfox.controllers
{
   import flash.events.IEventDispatcher;
   import com.zynga.poker.smartfox.messages.SmartfoxRequest;
   
   public interface ISmartfoxController extends IEventDispatcher
   {
      
      function registerCallback(param1:String, param2:Function) : void;
      
      function removeCallback(param1:String, param2:Function) : void;
      
      function sendRequest(param1:SmartfoxRequest) : void;
      
      function connect(param1:String, param2:int, param3:String) : void;
      
      function disconnect(param1:Boolean=true) : void;
      
      function loginToZone(param1:String) : void;
      
      function leaveZone() : void;
   }
}
