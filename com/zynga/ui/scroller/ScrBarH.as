package com.zynga.ui.scroller
{
   import flash.display.MovieClip;
   
   public class ScrBarH extends MovieClip
   {
      
      public function ScrBarH(param1:int, param2:int, param3:MovieClip, param4:MovieClip, param5:MovieClip, param6:MovieClip) {
         super();
         this.thisH = param1;
         this.thisW = param2;
         this.arrowLeft = param3;
         this.arrowRight = param4;
         this.handle = param5;
         this.track = param6;
         this.initGfx();
         this.initHandCursor();
      }
      
      public var arrowLeft:MovieClip;
      
      public var arrowRight:MovieClip;
      
      public var handle:MovieClip;
      
      public var track:MovieClip;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var trackW:int;
      
      public var bVert:Boolean;
      
      public var isActive:Boolean;
      
      public function initGfx() : void {
         addChild(this.arrowLeft);
         addChild(this.arrowRight);
         this.arrowRight.x = this.thisW;
         addChild(this.track);
         this.track.height = this.thisH;
         this.track.width = this.thisW - this.arrowLeft.width - this.arrowRight.width;
         this.track.x = this.arrowLeft.width;
         addChild(this.handle);
         this.handle.x = this.arrowLeft.width;
         this.trackW = this.thisW - this.arrowLeft.width - this.arrowRight.width;
      }
      
      public function initHandCursor() : void {
         var _loc2_:MovieClip = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_) as MovieClip;
            _loc2_.buttonMode = true;
            this.useHandCursor = true;
            _loc1_++;
         }
      }
      
      public function updateHandle(param1:Number) : void {
         this.handle.x = Math.round((this.trackW - this.handle.width) * param1) + this.arrowLeft.width;
      }
      
      public function setActivity(param1:Boolean) : void {
         this.isActive = param1;
         this.handle.visible = this.isActive;
         if(this.isActive)
         {
            this.alpha = 1;
         }
         if(!this.isActive)
         {
            this.alpha = 0.5;
         }
      }
   }
}
