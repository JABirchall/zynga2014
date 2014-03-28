package com.zynga.utils.timers
{
   public class PokerTimeAnchor extends Object
   {
      
      public function PokerTimeAnchor(param1:Number, param2:Number, param3:Function) {
         super();
         this._interval = param1;
         this._currTick = 0;
         this._tickTime = param2;
         this._callback = param3;
         this._isPaused = false;
      }
      
      private var _interval:Number;
      
      private var _currTick:Number;
      
      private var _tickTime:Number;
      
      public function set tickTime(param1:Number) : void {
         this._tickTime = param1;
      }
      
      private var _callback:Function;
      
      public function get callback() : Function {
         return this._callback;
      }
      
      private var _isPaused:Boolean;
      
      public function get isPaused() : Boolean {
         return this._isPaused;
      }
      
      public function update() : void {
         if(this._isPaused == true)
         {
            return;
         }
         this._currTick = this._currTick + this._tickTime;
         if(this._currTick >= this._interval)
         {
            this._callback();
            this._currTick = 0;
         }
      }
      
      public function resetTime() : void {
         this._currTick = 0;
      }
      
      public function pause() : void {
         this._isPaused = true;
      }
      
      public function resume() : void {
         this._isPaused = false;
      }
   }
}
