package com.zynga.poker
{
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.zynga.io.ExternalCall;
   
   public class PokerLoadMilestone extends Object
   {
      
      public function PokerLoadMilestone() {
         super();
      }
      
      private static var loadHeartbeatTimer:Timer;
      
      private static var loadHeartbeatDelay:Number = 2;
      
      private static var loadHeartbeatMax:Number = 150;
      
      private static var loadHeartbeatTickCount:Number = 0;
      
      private static var loadThrottle:Number = 100;
      
      private static var loadHearthbeatThrottle:Number = 1000;
      
      private static var canLoadMilestone:Boolean = false;
      
      private static var canLoadHeartbeatMilestone:Boolean = false;
      
      private static var hasInit:Boolean = false;
      
      public static function init(param1:Number) : void {
         if(hasInit)
         {
            return;
         }
         var _loc2_:Number = param1 + 79;
         canLoadMilestone = Boolean(_loc2_ % loadThrottle == 0);
         if(canLoadMilestone)
         {
            canLoadHeartbeatMilestone = Boolean(_loc2_ % loadHearthbeatThrottle == 0);
         }
         hasInit = true;
      }
      
      public static function startClientHeartbeat() : void {
         if(!canLoadHeartbeatMilestone)
         {
            return;
         }
         loadHeartbeatTimer = new Timer(Math.round(loadHeartbeatDelay * 1000));
         loadHeartbeatTimer.addEventListener(TimerEvent.TIMER,onLoadHeartbeatTimer);
         loadHeartbeatTimer.start();
      }
      
      public static function stopClientHeartbeat() : void {
         if(loadHeartbeatTimer != null)
         {
            loadHeartbeatTimer.stop();
         }
         sendLoadMilestone("client_complete");
      }
      
      private static function onLoadHeartbeatTimer(param1:Object) : void {
         _loc2_.loadHeartbeatTickCount = loadHeartbeatTickCount+1;
         sendLoadMilestone("client_heartbeat",loadHeartbeatTickCount+1);
         if(loadHeartbeatTickCount > loadHeartbeatMax)
         {
            loadHeartbeatTimer.stop();
         }
      }
      
      public static function sendLoadMilestone(param1:String, param2:Object=null) : void {
         if(!canLoadMilestone)
         {
            return;
         }
         ExternalCall.getInstance().call("LoadManager.sendMilestone(\'" + param1 + "\', " + param2 + ")");
      }
   }
}
