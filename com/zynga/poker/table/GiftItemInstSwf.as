package com.zynga.poker.table
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class GiftItemInstSwf extends MovieClip
   {
      
      public function GiftItemInstSwf(param1:MovieClip, param2:Boolean) {
         super();
         if(param1 == null)
         {
            return;
         }
         this.mmcGift = param1;
         addChild(this.mmcGift);
         if(param2)
         {
            this.CreateAnimateTimer();
         }
      }
      
      private var mmcGift:MovieClip = null;
      
      private var mAnimTimer_Play:Timer = null;
      
      private var mAnimTimer_Replay:Timer = null;
      
      public function Release() : void {
         this.ReleaseAnimateTimer();
         if(this.mmcGift == null)
         {
            return;
         }
         if(contains(this.mmcGift))
         {
            removeChild(this.mmcGift);
         }
         this.mmcGift = null;
      }
      
      public function Sleep() : void {
         this.ReleaseAnimateTimer();
      }
      
      public function Wake() : void {
         this.CreateAnimateTimer();
      }
      
      private function ReleaseAnimateTimer() : void {
         if(this.mAnimTimer_Play)
         {
            this.mAnimTimer_Play.stop();
            this.mAnimTimer_Play.removeEventListener(TimerEvent.TIMER,this.StopClip);
            this.mAnimTimer_Play = null;
         }
         if(this.mAnimTimer_Replay)
         {
            this.mAnimTimer_Replay.stop();
            this.mAnimTimer_Replay.removeEventListener(TimerEvent.TIMER,this.StopClip);
            this.mAnimTimer_Replay = null;
         }
      }
      
      private function CreateAnimateTimer() : void {
         this.ReleaseAnimateTimer();
         var _loc1_:Number = Math.round(Math.random() * 4000) + 4000;
         this.mAnimTimer_Play = new Timer(_loc1_,1);
         this.mAnimTimer_Play.addEventListener(TimerEvent.TIMER,this.StopClip);
         this.mAnimTimer_Play.start();
         var _loc2_:Number = Math.round(Math.random() * 15000) + 10000;
         this.mAnimTimer_Replay = new Timer(_loc2_,1);
         this.mAnimTimer_Replay.addEventListener(TimerEvent.TIMER,this.ReplayClip);
      }
      
      private function StopClip(param1:TimerEvent) : void {
         if((this.mmcGift) && (this.mmcGift.clip))
         {
            this.mmcGift.clip.stop();
         }
         if(this.mAnimTimer_Replay)
         {
            this.mAnimTimer_Replay.reset();
            this.mAnimTimer_Replay.delay = Math.round(Math.random() * 15000) + 10000;
            this.mAnimTimer_Replay.start();
         }
      }
      
      private function ReplayClip(param1:TimerEvent) : void {
         if((this.mmcGift) && (this.mmcGift.clip))
         {
            this.mmcGift.clip.play();
         }
         if(this.mAnimTimer_Play)
         {
            this.mAnimTimer_Play.reset();
            this.mAnimTimer_Play.delay = Math.round(Math.random() * 15000) + 10000;
            this.mAnimTimer_Play.start();
         }
      }
      
      public function animateGift(param1:String) : void {
         if(!this.mmcGift || !this.mmcGift.hasOwnProperty(param1))
         {
            return;
         }
         try
         {
            switch(param1)
            {
               case "win":
                  (this.mmcGift as Object).win();
                  break;
               case "bigWin":
                  (this.mmcGift as Object).bigWin();
                  break;
               case "lose":
                  (this.mmcGift as Object).lose();
                  break;
               case "knockedOff":
                  (this.mmcGift as Object).knockedOff();
                  break;
               case "allIn":
                  (this.mmcGift as Object).allIn();
                  break;
            }
            
         }
         catch(e:Error)
         {
         }
      }
   }
}
