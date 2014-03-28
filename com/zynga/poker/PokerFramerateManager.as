package com.zynga.poker
{
   import flash.events.Event;
   import flash.utils.getTimer;
   import flash.display.MovieClip;
   
   public class PokerFramerateManager extends Object
   {
      
      public function PokerFramerateManager(param1:MovieClip, param2:Number, param3:Number=30) {
         this.droppedFramesMilestones = new Array(100,200,300);
         super();
         var _loc4_:* = true;
         _loc4_ = Boolean((param2 + 79) % 100 == 0);
         if((_loc4_) && param3 > 0)
         {
            this.recordingIntervalRate = param3;
            this.lastTime = getTimer();
            param1.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      public static const STATUS_LOADING:String = "Loading";
      
      public static const STATUS_LOBBY:String = "Lobby";
      
      public static const STATUS_TABLE:String = "Table";
      
      public static const STATUS_TRANSITION:String = "Transition";
      
      private var FRAME_RATE:Number = 31;
      
      private var droppedFramesMilestones:Array;
      
      private var recordingIntervalRate:Number = 30;
      
      private var status:String = "Loading";
      
      private var statusChangeWhileCapturing:Boolean = false;
      
      private var hasGameLoaded:Boolean = false;
      
      private var framesEntered:Number = 0;
      
      private var lastTime:Number = 0;
      
      public function setStatus(param1:String) : void {
         this.statusChangeWhileCapturing = true;
         this.status = param1;
      }
      
      public function set frameRate(param1:Number) : void {
         this.FRAME_RATE = param1;
      }
      
      public function get frameRate() : Number {
         return this.FRAME_RATE;
      }
      
      public function gameLoaded() : void {
         this.hasGameLoaded = true;
      }
      
      private function determineDroppedFrames() : void {
         var _loc3_:String = null;
         var _loc1_:Number = this.FRAME_RATE * this.recordingIntervalRate - this.framesEntered;
         var _loc2_:String = this.status;
         if(this.statusChangeWhileCapturing)
         {
            _loc2_ = STATUS_TRANSITION;
         }
         else
         {
            if(!this.hasGameLoaded)
            {
               _loc2_ = STATUS_LOADING;
            }
         }
         for (_loc3_ in this.droppedFramesMilestones)
         {
            if(_loc1_ >= this.droppedFramesMilestones[_loc3_])
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:DroppedFrames:" + _loc2_ + ":" + this.droppedFramesMilestones[_loc3_] + ":2010-08-10"));
            }
         }
         this.statusChangeWhileCapturing = false;
      }
      
      private function onEnterFrame(param1:Event) : void {
         this.framesEntered++;
         var _loc2_:Number = getTimer();
         if(_loc2_ - this.lastTime >= this.recordingIntervalRate * 1000)
         {
            this.determineDroppedFrames();
            this.lastTime = _loc2_;
            this.framesEntered = 0;
         }
      }
   }
}
