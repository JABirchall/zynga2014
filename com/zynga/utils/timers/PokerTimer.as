package com.zynga.utils.timers
{
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import flash.events.TimerEvent;
   
   public class PokerTimer extends Object
   {
      
      public function PokerTimer(param1:Inner) {
         super();
         var param1:Inner = null;
         this._anchors = new Dictionary();
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer,false,0,true);
         this._timer.start();
      }
      
      private static var _instance:PokerTimer;
      
      public static function get instance() : PokerTimer {
         if(!_instance)
         {
            _instance = new PokerTimer(new Inner());
         }
         return _instance;
      }
      
      private var _timer:Timer;
      
      private var _anchors:Dictionary;
      
      public function set delay(param1:Number) : void {
         var _loc2_:PokerTimeAnchor = null;
         this._timer.delay = param1;
         for each (_loc2_ in this._anchors)
         {
            _loc2_.tickTime = param1;
         }
      }
      
      public function addAnchor(param1:Number, param2:Function, param3:Boolean=false) : void {
         if(!this._anchors[param2] || (param3))
         {
            this._anchors[param2] = new PokerTimeAnchor(param1,this._timer.delay,param2);
         }
      }
      
      public function removeAnchor(param1:Function) : void {
         if(this._anchors[param1])
         {
            delete this._anchors[[param1]];
         }
      }
      
      public function removeAllAnchors() : void {
         this._anchors = null;
         this._anchors = new Dictionary();
      }
      
      private function onTimer(param1:TimerEvent) : void {
         var _loc2_:PokerTimeAnchor = null;
         for each (_loc2_ in this._anchors)
         {
            _loc2_.update();
         }
      }
      
      public function resetAnchorTime(param1:Function) : void {
         if(this._anchors[param1])
         {
            this._anchors[param1].resetTime();
         }
      }
      
      public function pauseAnchor(param1:Function) : void {
         if(this._anchors[param1] != null)
         {
            this._anchors[param1].pause();
         }
      }
      
      public function pauseAndResetAnchor(param1:Function) : void {
         if(this._anchors[param1] != null)
         {
            this._anchors[param1].pause();
            this._anchors[param1].resetTime();
         }
      }
      
      public function resumeAnchor(param1:Function) : void {
         if(this._anchors[param1])
         {
            this._anchors[param1].resume();
         }
      }
      
      public function isAnchorPaused(param1:Function) : Boolean {
         if(this._anchors[param1])
         {
            return this._anchors[param1].isPaused;
         }
         return false;
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
