package com.zynga.poker
{
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.zynga.poker.protocol.SHeartBeatRes;
   
   public class PokerHeartBeat extends Object
   {
      
      public function PokerHeartBeat(param1:String, param2:int, param3:PokerController, param4:PokerConnectionManager) {
         super();
         this._id = param1;
         this._delay = param2;
         this.pControl = param3;
         this.pcmConnect = param4;
         this._beatTimer = new Timer(this._delay,1);
         this._beatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBeatTimerComplete,false,0,true);
         this._beatTimer.start();
      }
      
      private var pControl:PokerController;
      
      private var pcmConnect:PokerConnectionManager;
      
      private var _id:String;
      
      private var _delay:int;
      
      private var _beatTimer:Timer;
      
      public function get id() : String {
         return this._id;
      }
      
      private function onBeatTimerComplete(param1:TimerEvent) : void {
         this.pcmConnect.sendMessage(new SHeartBeatRes("SHeartBeatRes",this._id));
         this.destroy();
      }
      
      private function destroy() : void {
         this._id = null;
         this._delay = NaN;
         this._beatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBeatTimerComplete);
         this._beatTimer = null;
         this.pControl.killHeartBeat(this);
      }
   }
}
