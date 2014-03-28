package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import caurina.transitions.Tweener;
   import flash.events.TimerEvent;
   import com.zynga.poker.table.events.view.TVEPlaySound;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.PokerClassProvider;
   
   public class Clock extends MovieClip
   {
      
      public function Clock() {
         super();
         this.assets = PokerClassProvider.getObject("clockAssets");
         this.assets.visible = false;
         addChild(this.assets);
      }
      
      public var isCounting:Boolean = false;
      
      public var bRemindSound:Boolean;
      
      public var bHurrySound:Boolean;
      
      public var curSit:Number = 0;
      
      public var initialTimeLeft:Number;
      
      public var timeLeft:Number;
      
      public var timer:Timer;
      
      public var degreesPerSecond:Number;
      
      private var assets:MovieClip;
      
      public function initClock() : void {
         this.assets.ring_green_left.visible = false;
         this.assets.ring_green_right.visible = false;
         this.assets.ring_yellow.visible = false;
         this.assets.ring_red.visible = false;
         this.assets.ring_green_right.mask = null;
         this.assets.ring_red.mask = null;
         this.assets.ring_yellow.mask = null;
      }
      
      public function startCount(param1:Number, param2:int, param3:Number=0) : void {
         this.resetClock();
         this.width = 40;
         this.height = 40;
         Tweener.addTween(this,
            {
               "scaleX":1.1,
               "scaleY":1.1,
               "time":0.2,
               "transition":"easeOutQuad"
            });
         this.visible = true;
         this.assets.visible = true;
         this.assets.ring_green_right.visible = true;
         this.assets.ring_green_left.visible = true;
         this.assets.ring_yellow.visible = false;
         this.assets.ring_red.visible = false;
         this.assets.ring_green_right.mask = this.assets.timerMask;
         this.isCounting = true;
         this.bRemindSound = false;
         this.bHurrySound = false;
         var _loc4_:Number = 2;
         this.timeLeft = param1 - param3 - _loc4_;
         this.assets.timerMask.rotation = 0;
         this.initialTimeLeft = this.timeLeft;
         this.curSit = param2;
         if(this.timeLeft > 0)
         {
            Tweener.addTween(this.assets.timerMask,
               {
                  "rotation":360,
                  "time":this.timeLeft,
                  "transition":"linear",
                  "onUpdate":this.setMask
               });
            this.timer = new Timer(1000,this.timeLeft);
            this.timer.addEventListener(TimerEvent.TIMER,this.countDown);
            this.timer.start();
         }
      }
      
      private function countDown(param1:TimerEvent) : void {
         if(this.timeLeft == 12)
         {
            dispatchEvent(new TVEPlaySound(TVEvent.PLAY_SOUND_ONCE,"PlayRemindSound",this.curSit));
         }
         if(this.timeLeft == 4)
         {
            dispatchEvent(new TVEPlaySound(TVEvent.PLAY_SOUND_ONCE,"playHurrySound",this.curSit));
         }
         this.timeLeft--;
      }
      
      private function setMask() : void {
         if(this.assets.timerMask.rotation == 0)
         {
            this.assets.ring_red.visible = false;
         }
         if(this.assets.timerMask.rotation >= -90 && this.assets.timerMask.rotation < 0)
         {
            this.assets.ring_red.mask = this.assets.timerMask;
            this.assets.ring_yellow.visible = false;
            this.assets.ring_yellow.mask = null;
            this.assets.ring_red.visible = true;
            this.assets.ring_green_left.visible = false;
            this.assets.ring_green_right.visible = false;
            this.assets.ring_green_right.mask = null;
         }
         if(this.assets.timerMask.rotation >= -180 && this.assets.timerMask.rotation < -90)
         {
            this.assets.ring_yellow.mask = this.assets.timerMask;
            this.assets.ring_yellow.visible = true;
            this.assets.ring_green_left.visible = false;
            this.assets.ring_green_right.visible = false;
            this.assets.ring_green_right.mask = null;
            this.assets.ring_red.visible = false;
         }
      }
      
      public function stopCount() : void {
         Tweener.addTween(this,
            {
               "width":40,
               "height":40,
               "time":0.2,
               "transition":"easeInQuad"
            });
         Tweener.removeTweens(this.assets.timerMask);
         this.assets.timerMask.rotation = 0;
         this.assets.ring_green_left.visible = false;
         this.assets.ring_green_right.visible = false;
         this.assets.ring_yellow.visible = false;
         this.assets.ring_red.visible = false;
         this.assets.ring_green_right.mask = null;
         this.assets.ring_red.mask = null;
         this.assets.ring_yellow.mask = null;
         this.assets.visible = false;
         this.visible = false;
      }
      
      public function resetClock() : void {
         this.initialTimeLeft = this.timeLeft = 0;
         if(this.timer != null)
         {
            this.timer.stop();
            this.timer = null;
            this.timeLeft = 0;
            Tweener.removeTweens(this.assets.timerMask);
            this.assets.timerMask.rotation = 0;
            this.assets.ring_green_left.visible = false;
            this.assets.ring_green_right.visible = false;
            this.assets.ring_yellow.visible = false;
            this.assets.ring_red.visible = false;
            this.assets.ring_green_right.mask = null;
            this.assets.ring_red.mask = null;
            this.assets.ring_yellow.mask = null;
         }
      }
   }
}
