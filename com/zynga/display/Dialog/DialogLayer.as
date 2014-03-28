package com.zynga.display.Dialog
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class DialogLayer extends Sprite
   {
      
      public function DialogLayer(param1:Number, param2:Number, param3:MovieClip=null, param4:Function=null, param5:Function=null, param6:Boolean=false) {
         super();
         this.stack = new Array();
         this.wide = param1;
         this.high = param2;
         this.showAction = param4;
         this.hideAction = param5;
         this.hideBack = param6;
         if(param3)
         {
            this.bgpanel = PokerClassProvider.getObject(PokerClassProvider.getClassName(param3));
            this.bgpanel.width = param1;
            this.bgpanel.height = param2;
            this.bgpanel.visible = false;
            this.bgpanel.alpha = 0;
            addChild(this.bgpanel);
         }
         DialogEvent.disp.addEventListener(DialogEvent.ACTIVE,this.onActive);
         DialogEvent.disp.addEventListener(DialogEvent.ISOLATE,this.onIsolate);
         DialogEvent.disp.addEventListener(DialogEvent.RELEASE,this.onReleaser);
         DialogEvent.disp.addEventListener(DialogEvent.CLOSED,this.onClosed);
         DialogEvent.disp.addEventListener(DialogEvent.CLOSE,this.onClose);
         DialogEvent.disp.addEventListener(DialogEvent.OPEN,this.onOpen);
         DialogEvent.disp.addEventListener(DialogEvent.ALONE,this.onAlone);
      }
      
      private var stack:Array;
      
      private var top:DialogBox;
      
      private var bgpanel:MovieClip = null;
      
      private var wide:Number;
      
      private var high:Number;
      
      private var locked:Boolean = false;
      
      public var showAction:Function;
      
      public var hideAction:Function;
      
      public var hideBack:Boolean;
      
      public function add(param1:DialogBox) : void {
         this.stack.push(param1);
         param1.layer = this;
         param1.hide(null,true);
         param1.init();
         this.top = param1;
         param1.x = this.wide / 2 - param1.realWide / 2;
         param1.y = this.high / 2 - param1.realHigh / 2;
      }
      
      public function prioritize(param1:DialogBox) : void {
         if(!this.locked && param1.parent == this)
         {
            if(this.bgpanel != null)
            {
               setChildIndex(param1,1);
            }
            else
            {
               setChildIndex(param1,0);
            }
            this.top = param1;
         }
      }
      
      public function isolate(param1:DialogBox) : void {
         var _loc2_:DialogBox = null;
         this.release();
         this.locked = true;
         for each (_loc2_ in this.stack)
         {
            if(_loc2_ != param1)
            {
               _loc2_.disable();
            }
         }
      }
      
      public function release() : void {
         var _loc1_:DialogBox = null;
         this.locked = false;
         for each (_loc1_ in this.stack)
         {
            _loc1_.enable();
         }
      }
      
      public function alone(param1:DialogBox) : void {
         var _loc2_:DialogBox = null;
         for each (_loc2_ in this.stack)
         {
            _loc2_.enable();
            if(_loc2_ != param1)
            {
               _loc2_.hide(null,false);
            }
         }
      }
      
      private function anyActive() : void {
         var _loc2_:DialogBox = null;
         var _loc1_:* = false;
         for each (_loc2_ in this.stack)
         {
            if(_loc2_.shown == true)
            {
               _loc1_ = true;
            }
         }
         if(this.bgpanel != null)
         {
            if(_loc1_)
            {
               this.bgpanel.visible = true;
               if(!(this.showAction == null) && !this.hideBack)
               {
                  this.showAction(this.bgpanel);
               }
            }
            else
            {
               if(!(this.hideAction == null) && !this.hideBack)
               {
                  this.hideAction(this.bgpanel);
               }
               else
               {
                  this.bgpanel.visible = false;
               }
            }
         }
      }
      
      private function isPresent(param1:DialogBox) : Boolean {
         var _loc2_:DialogBox = null;
         for each (_loc2_ in this.stack)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onActive(param1:DialogEvent) : void {
         if(this.isPresent(param1.data))
         {
            this.prioritize(param1.data);
         }
      }
      
      private function onIsolate(param1:DialogEvent) : void {
         if(this.isPresent(param1.data))
         {
            this.isolate(param1.data);
         }
      }
      
      private function onReleaser(param1:DialogEvent) : void {
         if(this.isPresent(param1.data))
         {
            this.release();
         }
      }
      
      private function onOpen(param1:DialogEvent) : void {
         if(this.isPresent(param1.data))
         {
            this.anyActive();
         }
         this.prioritize(param1.data);
         if(param1.data.modal)
         {
            this.isolate(param1.data);
         }
      }
      
      private function onClosed(param1:DialogEvent) : void {
         if(this.isPresent(param1.data))
         {
            this.anyActive();
         }
         this.release();
      }
      
      private function onClose(param1:DialogEvent) : void {
         param1.data.hide();
      }
      
      private function onAlone(param1:DialogEvent) : void {
         this.alone(param1.data);
      }
   }
}
