package com.zynga.ui.scroller
{
   import flash.display.MovieClip;
   
   public class ScrBarV extends MovieClip
   {
      
      public function ScrBarV(param1:int, param2:int, param3:MovieClip, param4:MovieClip, param5:MovieClip, param6:MovieClip) {
         super();
         this.thisH = param1;
         this.thisW = param2;
         this.arrowUp = param3;
         this.arrowDown = param4;
         this.handle = param5;
         this.track = param6;
         this.initGfx();
         this.initHandCursor();
      }
      
      public var arrowUp:MovieClip;
      
      public var arrowDown:MovieClip;
      
      public var handle:MovieClip;
      
      public var track:MovieClip;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var trackH:int;
      
      public var isActive:Boolean;
      
      public function initGfx() : void {
         addChild(this.arrowUp);
         addChild(this.arrowDown);
         this.arrowDown.y = this.thisH;
         addChild(this.track);
         this.track.height = this.thisH - this.arrowUp.height - this.arrowDown.height;
         this.track.y = this.arrowUp.height;
         addChild(this.handle);
         this.handle.y = this.arrowUp.height;
         this.trackH = this.thisH - this.arrowUp.height - this.arrowDown.height;
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
         this.handle.y = Math.round((this.trackH - this.handle.height) * param1) + this.arrowUp.height;
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
