package com.zynga.ui.scroller
{
   import flash.display.MovieClip;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public class TextScrollSystem extends MovieClip
   {
      
      public function TextScrollSystem(param1:DisplayObjectContainer, param2:TextField, param3:int, param4:int, param5:Object, param6:int=0, param7:int=0, param8:Boolean=true, param9:Boolean=true, param10:int=10, param11:int=1) {
         super();
         this.parents = param1;
         this.contents = param2;
         this.thisW = param3;
         this.thisH = param4;
         this.sPadX = param6;
         this.sPadY = param7;
         this.unitLine = param11;
         this.unitPage = param10;
         this.barSkin = param5;
         this.initMaskContent();
         this.initScrollBars(param8,param9);
         this.initBarListeners(param8,param9);
         this.fakeStage = new Sprite();
         this.fakeStage.graphics.beginFill(16711680,0.0);
         this.fakeStage.graphics.drawRect(-1000,-1000,2000,2000);
         this.fakeStage.graphics.endFill();
      }
      
      public var parents:DisplayObjectContainer;
      
      public var contents:TextField;
      
      public var masker:Sprite;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var sPadX:int;
      
      public var sPadY:int;
      
      public var unitLine:int;
      
      public var unitPage:int;
      
      public var barV:ScrBarV;
      
      public var barH:ScrBarH;
      
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
            this.barV = new ScrBarV(this.thisH,this.barSkin.trackV.width,this.barSkin.arrowUp,this.barSkin.arrowDown,this.barSkin.handleV,this.barSkin.trackV);
            this.barV.x = this.thisW + this.sPadX;
            this.barV.updateHandle(1);
            addChild(this.barV);
         }
         if(param2)
         {
            this.barH = new ScrBarH(this.barSkin.trackH.height,this.thisW,this.barSkin.arrowLeft,this.barSkin.arrowRight,this.barSkin.handleH,this.barSkin.trackH);
            this.barH.y = this.thisH + this.sPadY;
            addChild(this.barH);
         }
         this.checkContentSize();
      }
      
      public function updater(param1:Boolean=false, param2:Boolean=false) : void {
         if(param1)
         {
            if(this.contents.maxScrollV > 1)
            {
               this.contents.scrollV = this.contents.maxScrollV;
            }
         }
         if(param2)
         {
            if(this.contents.maxScrollH > 1)
            {
               this.contents.scrollV = this.contents.maxScrollV;
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
         if(this.contents.maxScrollV > 1 && !(this.barV == null))
         {
            this.barV.setActivity(true);
         }
         if(this.contents.maxScrollH > 1 && !(this.barH == null))
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
         }
      }
      
      public function moveRequestV(param1:int) : void {
         var _loc2_:* = 1;
         var _loc3_:int = this.contents.maxScrollV;
         var _loc4_:int = this.contents.scrollV + param1;
         if(_loc4_ > _loc3_)
         {
            _loc4_ = _loc3_;
         }
         if(_loc4_ < _loc2_)
         {
            _loc4_ = _loc2_;
         }
         this.bMouseDown = true;
         this.contents.scrollV = _loc4_;
         var _loc5_:Number = Math.abs(this.contents.scrollV-1) / Math.abs(this.contents.maxScrollV-1);
         this.barV.updateHandle(_loc5_);
         this.bMouseDown = false;
      }
      
      public function vArrowUp(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            this.moveRequestV(0 - this.unitLine);
         }
      }
      
      public function vArrowDown(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            this.moveRequestV(this.unitLine);
         }
      }
      
      public function vTrack(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            if(this.barV.mouseY < this.barV.handle.y)
            {
               this.moveRequestV(0 - this.unitPage);
            }
            if(this.barV.mouseY > this.barV.handle.y + this.barV.handle.height)
            {
               this.moveRequestV(this.unitPage);
            }
         }
      }
      
      public var bMouseDown:Boolean = false;
      
      public function vHandle(param1:MouseEvent) : void {
         if(this.barV.isActive)
         {
            this.bMouseDown = true;
            this.parents.addChild(this.fakeStage);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_MOVE,this.vSlideHandle);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_UP,this.killFakeStageV);
            this.fakeStage.addEventListener(MouseEvent.MOUSE_OUT,this.killFakeStageV);
            this.fakeStage.addEventListener(Event.MOUSE_LEAVE,this.killFakeStageV);
         }
      }
      
      public function vHandleUp(param1:MouseEvent) : void {
         this.bMouseDown = false;
      }
      
      public function killFakeStageV(param1:MouseEvent) : void {
         this.bMouseDown = false;
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE,this.vSlideHandle);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_UP,this.killFakeStageV);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_OUT,this.killFakeStageV);
         this.parents.removeChild(this.fakeStage);
      }
      
      public function vSlideHandle(param1:MouseEvent) : void {
         var _loc2_:int = this.barV.mouseY;
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
         var _loc3_:* = NaN;
         var _loc2_:Number = this.contents.maxScrollV-1;
         if(_loc2_ < 1)
         {
            _loc3_ = Math.round(param1);
         }
         else
         {
            _loc3_ = Math.round(_loc2_ * param1);
         }
         this.contents.scrollV = _loc3_ + 1;
      }
      
      public function vAdjustHandle(param1:Boolean) : void {
         var _loc2_:* = NaN;
         if(param1)
         {
            this.barV.updateHandle(1);
         }
         else
         {
            if(!param1)
            {
               _loc2_ = Math.abs(this.contents.scrollV-1) / Math.abs(this.contents.maxScrollV-1);
               this.barV.updateHandle(_loc2_);
            }
         }
      }
   }
}
