package com.zynga.ui.scroller
{
   import flash.display.MovieClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public class ScrollSystem extends MovieClip
   {
      
      public function ScrollSystem(param1:DisplayObjectContainer, param2:DisplayObject, param3:int, param4:int, param5:Object, param6:int=0, param7:int=0, param8:Boolean=true, param9:Boolean=true, param10:int=10, param11:int=40) {
         super();
         this.parents = param1;
         this.contents = param2;
         this.thisW = param3;
         this.thisH = param4;
         this.sPadX = param6;
         this.sPadY = param7;
         this.unitLine = param10;
         this.unitPage = param11;
         this.barSkin = param5;
         this.initMaskContent();
         this.initScrollBars(param8,param9);
         this.initBarListeners(param8,param9);
         this.fakeStage = new Sprite();
         this.fakeStage.graphics.beginFill(16711680,0.0);
         this.fakeStage.graphics.drawRect(-1000,-1000,2000,2000);
         this.fakeStage.graphics.endFill();
         if(this.parents.stage != null)
         {
            this.parents.stage.addEventListener(Event.MOUSE_LEAVE,this.killFakeStageV);
         }
         this.fakeStage.addEventListener(MouseEvent.MOUSE_OUT,this.killScrollEvents);
      }
      
      public var parents:DisplayObjectContainer;
      
      public var contents:DisplayObject;
      
      public var masker:Sprite;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var sPadX:int;
      
      public var sPadY:int;
      
      public var unitLine:int;
      
      public var unitPage:int;
      
      public var barV:ScrBarV;
      
      public var barH:ScrBarH;
      
      public var hasScrolledV:Boolean = false;
      
      public var hasScrolledH:Boolean = false;
      
      public var barSkin:Object;
      
      public var fakeStage:Sprite;
      
      public function initMaskContent() : void {
         this.masker = new Sprite();
         this.masker.graphics.beginFill(0,1);
         this.masker.graphics.drawRect(0,0,this.thisW,this.thisH);
         this.masker.graphics.endFill();
         addChild(this.masker);
         addChild(this.contents);
         this.contents.mask = this.masker;
      }
      
      public function initScrollBars(param1:Boolean, param2:Boolean) : void {
         if(param1)
         {
            this.barV = new ScrBarV(this.thisH,this.barSkin.trackV.width,this.barSkin.arrowUp as MovieClip,this.barSkin.arrowDown as MovieClip,this.barSkin.handleV as MovieClip,this.barSkin.trackV as MovieClip);
            this.barV.x = this.thisW + this.sPadX;
            addChild(this.barV);
         }
         if(param2)
         {
            this.barH = new ScrBarH(this.barSkin.trackH.height,this.thisW,this.barSkin.arrowLeft as MovieClip,this.barSkin.arrowRight as MovieClip,this.barSkin.handleH as MovieClip,this.barSkin.trackH as MovieClip);
            this.barH.y = this.thisH + this.sPadY;
            addChild(this.barH);
         }
         this.checkContentSize();
      }
      
      public function updater(param1:Boolean=true, param2:Boolean=true) : void {
         if(param1)
         {
            if(this.contents.height > this.thisH)
            {
               this.contents.y = this.thisH - this.contents.height;
            }
            if(this.barV != null)
            {
               this.barV.updateHandle(1);
            }
         }
         if(param2)
         {
            if(this.contents.width > this.thisW)
            {
               this.contents.x = this.thisW - this.contents.width;
            }
            if(this.barH != null)
            {
               this.barH.updateHandle(1);
            }
         }
         this.checkContentSize();
      }
      
      public function checkContentSize() : void {
         if(this.barV != null)
         {
            this.barV.setActivity(false);
         }
         if(this.barH != null)
         {
            this.barH.setActivity(false);
         }
         if(this.contents.height > this.thisH && !(this.barV == null))
         {
            this.barV.setActivity(true);
         }
         if(this.contents.width > this.thisW && !(this.barH == null))
         {
            this.barH.setActivity(true);
         }
      }
      
      public function initBarListeners(param1:Boolean, param2:Boolean) : void {
         if(param1)
         {
            this.barV.arrowUp.addEventListener(MouseEvent.CLICK,this.vArrowUp);
            this.barV.arrowDown.addEventListener(MouseEvent.CLICK,this.vArrowDown);
            this.barV.track.addEventListener(MouseEvent.CLICK,this.vTrack);
            this.barV.handle.addEventListener(MouseEvent.MOUSE_DOWN,this.vHandle);
            this.barV.useHandCursor = false;
         }
         if(param2)
         {
            this.barH.arrowLeft.addEventListener(MouseEvent.CLICK,this.hArrowUp);
            this.barH.arrowRight.addEventListener(MouseEvent.CLICK,this.hArrowDown);
            this.barH.track.addEventListener(MouseEvent.CLICK,this.hTrack);
            this.barH.handle.addEventListener(MouseEvent.MOUSE_DOWN,this.hHandle);
            this.barH.useHandCursor = false;
         }
      }
      
      public function updateSize(param1:int, param2:int) : void {
      }
      
      public function moveRequestV(param1:int) : void {
         var _loc2_:* = 0;
         if(!this.hasScrolledV)
         {
            this.hasScrolledV = true;
         }
         if(this.contents.height <= this.thisH)
         {
            _loc2_ = 0;
         }
         if(this.contents.height > this.thisH)
         {
            _loc2_ = this.thisH - this.contents.height;
         }
         var _loc3_:* = 0;
         var _loc4_:int = this.contents.y + param1;
         if(_loc4_ > _loc3_)
         {
            _loc4_ = _loc3_;
         }
         if(_loc4_ < _loc2_)
         {
            _loc4_ = _loc2_;
         }
         this.contents.y = _loc4_;
         var _loc5_:Number = Math.abs(this.contents.y) / Math.abs(_loc2_);
         this.barV.updateHandle(_loc5_);
      }
      
      public function vArrowUp(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            this.moveRequestV(this.unitLine);
         }
      }
      
      public function vArrowDown(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            this.moveRequestV(0 - this.unitLine);
         }
      }
      
      public function vTrack(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            if(this.barV.mouseY < this.barV.handle.y)
            {
               this.moveRequestV(this.unitPage);
            }
            if(this.barV.mouseY > this.barV.handle.y + this.barV.handle.height)
            {
               this.moveRequestV(0 - this.unitPage);
            }
         }
      }
      
      public function vHandle(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            if(!this.hasScrolledV)
            {
               this.hasScrolledV = true;
            }
            this.parents.addChild(this.fakeStage);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_MOVE,this.vSlideHandle);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_UP,this.killFakeStageV);
            this.fakeStage.useHandCursor = false;
         }
      }
      
      public function mouseLeaveStage(param1:Event) : void {
      }
      
      public function killFakeStageV(param1:Event) : void {
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE,this.vSlideHandle);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_UP,this.killFakeStageV);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_OUT,this.killFakeStageV);
         if(this.fakeStage.parent != null)
         {
            this.parents.removeChild(this.fakeStage);
         }
      }
      
      public function killScrollEvents(param1:MouseEvent) : void {
         this.killFakeStageV(null);
      }
      
      public function vSlideHandle(param1:MouseEvent) : void {
         var _loc2_:Number = this.barV.mouseY;
         if(_loc2_ < this.barV.arrowUp.height)
         {
            _loc2_ = this.barV.arrowUp.height;
         }
         if(_loc2_ > this.barV.height - this.barV.arrowDown.height - this.barV.handle.height)
         {
            _loc2_ = this.barV.height - this.barV.arrowDown.height - this.barV.handle.height;
         }
         this.barV.handle.y = _loc2_;
         var _loc3_:Number = this.getVertHandlePlace();
         this.vSlideContent(_loc3_);
      }
      
      public function getVertHandlePlace() : Number {
         var _loc1_:Number = (this.barV.handle.y - this.barV.arrowUp.height) / (this.barV.height - this.barV.arrowUp.height - this.barV.arrowDown.height - this.barV.handle.height);
         return _loc1_;
      }
      
      public function vSlideContent(param1:Number) : void {
         var _loc2_:Number = this.thisH - this.contents.height;
         var _loc3_:Number = Math.round(_loc2_ * param1);
         this.contents.y = _loc3_;
      }
      
      public function moveRequestH(param1:int) : void {
         var _loc2_:* = 0;
         if(!this.hasScrolledH)
         {
            this.hasScrolledH = true;
         }
         if(this.contents.width <= this.thisW)
         {
            _loc2_ = 0;
         }
         if(this.contents.width > this.thisW)
         {
            _loc2_ = this.thisW - this.contents.width;
         }
         var _loc3_:* = 0;
         var _loc4_:int = this.contents.x + param1;
         if(_loc4_ > _loc3_)
         {
            _loc4_ = _loc3_;
         }
         if(_loc4_ < _loc2_)
         {
            _loc4_ = _loc2_;
         }
         this.contents.x = _loc4_;
         var _loc5_:Number = Math.abs(this.contents.x) / Math.abs(_loc2_);
         this.barH.updateHandle(_loc5_);
      }
      
      public function hArrowUp(param1:MouseEvent) : void {
         if(this.barH.isActive)
         {
            this.moveRequestH(this.unitLine);
         }
      }
      
      public function hArrowDown(param1:MouseEvent) : void {
         if(this.barH.isActive)
         {
            this.moveRequestH(0 - this.unitLine);
         }
      }
      
      public function hTrack(param1:MouseEvent) : void {
         if(this.barH.isActive)
         {
            if(this.barH.mouseX < this.barH.handle.x)
            {
               this.moveRequestH(this.unitPage);
            }
            if(this.barH.mouseX > this.barH.handle.x + this.barH.handle.width)
            {
               this.moveRequestH(0 - this.unitPage);
            }
         }
      }
      
      public function hHandle(param1:MouseEvent) : void {
         if(this.barH.isActive)
         {
            if(!this.hasScrolledH)
            {
               this.hasScrolledH = true;
            }
            this.parents.addChild(this.fakeStage);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_MOVE,this.hSlideHandle);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_UP,this.killFakeStageH);
            this.fakeStage.useHandCursor = false;
         }
      }
      
      public function killFakeStageH(param1:MouseEvent) : void {
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE,this.hSlideHandle);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_UP,this.killFakeStageH);
         this.parents.removeChild(this.fakeStage);
      }
      
      public function hSlideHandle(param1:MouseEvent) : void {
         var _loc2_:int = this.barH.mouseX;
         if(_loc2_ < this.barH.arrowLeft.width)
         {
            _loc2_ = this.barH.arrowLeft.width;
         }
         if(_loc2_ > this.barH.width - this.barH.arrowRight.width - this.barH.handle.width)
         {
            _loc2_ = this.barH.width - this.barH.arrowRight.width - this.barH.handle.width;
         }
         this.barH.handle.x = _loc2_;
         var _loc3_:Number = this.getHorzHandlePlace();
         this.hSlideContent(_loc3_);
      }
      
      public function getHorzHandlePlace() : Number {
         var _loc1_:Number = (this.barH.handle.x - this.barH.arrowLeft.width) / (this.barH.width - this.barH.arrowLeft.width - this.barH.arrowRight.width - this.barH.handle.width);
         return _loc1_;
      }
      
      public function hSlideContent(param1:Number) : void {
         var _loc2_:Number = this.thisW - this.contents.width;
         var _loc3_:Number = Math.round(_loc2_ * param1);
         this.contents.x = _loc3_;
      }
   }
}
