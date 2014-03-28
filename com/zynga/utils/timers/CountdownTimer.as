package com.zynga.utils.timers
{
   import com.zynga.text.EmbeddedFontTextField;
   import flash.events.Event;
   import com.zynga.locale.LocaleManager;
   
   public class CountdownTimer extends EmbeddedFontTextField
   {
      
      public function CountdownTimer(param1:Number, param2:Number=0, param3:int=-1, param4:String="Main", param5:int=11, param6:uint=0, param7:String="", param8:Boolean=false) {
         this._totalSeconds = Math.round(param1);
         this._endSeconds = Math.round(param2);
         this._increment = param3;
         super(this.getTimeString(),param4,param5,param6,param7,param8);
      }
      
      public static const TIMER_COMPLETE:String = "pokerTimerComplete";
      
      private var _totalSeconds:Number;
      
      private var _endSeconds:Number;
      
      private var _increment:int;
      
      private var _running:Boolean;
      
      public function start() : void {
         PokerTimer.instance.addAnchor(1000,this.onTick);
         this._running = true;
      }
      
      private function onTick() : void {
         this._totalSeconds = this._totalSeconds + this._increment;
         this.text = this.getTimeString();
         if(this._increment < 0 && this._totalSeconds <= this._endSeconds || this._increment > 0 && this._totalSeconds >= this._endSeconds)
         {
            this.complete();
         }
      }
      
      private function complete() : void {
         this._running = false;
         dispatchEvent(new Event(TIMER_COMPLETE));
         PokerTimer.instance.removeAnchor(this.onTick);
      }
      
      private function getTimeString() : String {
         var _loc1_:String = null;
         var _loc2_:* = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this._totalSeconds > 86400 && (this._running))
         {
            _loc2_ = int(this._totalSeconds / 86400);
            if(_loc2_ == 1)
            {
               if(this._increment > 0)
               {
                  _loc1_ = LocaleManager.localize("flash.global.time.day");
               }
               else
               {
                  _loc1_ = LocaleManager.localize("flash.global.time.tomorrow");
               }
            }
            else
            {
               _loc1_ = LocaleManager.localize("flash.global.time.days",{"x":_loc2_});
            }
         }
         else
         {
            _loc3_ = this.zeroPad(Math.max(int(this._totalSeconds / 60 / 60),0));
            _loc4_ = this.zeroPad(Math.max(int(this._totalSeconds / 60 - Number(_loc3_) * 60),0));
            _loc5_ = this.zeroPad(Math.max(int(this._totalSeconds - Number(_loc3_) * 60 * 60 - Number(_loc4_) * 60),0));
            _loc1_ = _loc3_ + ":" + _loc4_ + ":" + _loc5_;
         }
         return _loc1_;
      }
      
      private function zeroPad(param1:Number, param2:int=2) : String {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      public function destroy() : void {
         this._running = false;
         PokerTimer.instance.removeAnchor(this.onTick);
      }
   }
}
