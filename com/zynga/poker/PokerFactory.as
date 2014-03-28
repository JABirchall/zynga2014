package com.zynga.poker
{
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   
   public class PokerFactory extends MovieClip
   {
      
      public function PokerFactory() {
         super();
         this.init();
      }
      
      private var pokerLoader:PokerLoader;
      
      private var loadingComplete:Boolean = false;
      
      private var pokerMainAppLoaded:Boolean = false;
      
      private function init() : void {
         PokerClassProvider.pokerAppDomain = ApplicationDomain.currentDomain;
         this.pokerLoader = new PokerLoader(this);
         addChild(this.pokerLoader);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
      }
      
      private function onEnterFrame(param1:Event) : void {
         if(framesLoaded == totalFrames)
         {
            if(!this.pokerMainAppLoaded)
            {
               this.pokerMainAppLoaded = true;
            }
            if(this.loadingComplete)
            {
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this.pokerLoader.startPokerControllerForReal();
               PokerStageManager.init(this.stage);
            }
         }
      }
      
      public function markLoadComplete() : void {
         this.loadingComplete = true;
      }
   }
}
