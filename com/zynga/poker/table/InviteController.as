package com.zynga.poker.table
{
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.asset.InviteInbox;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import caurina.transitions.Tweener;
   import com.zynga.math.*;
   import com.zynga.poker.PokerClassProvider;
   
   public class InviteController extends Object
   {
      
      public function InviteController(param1:TableView, param2:DisplayObjectContainer, param3:int=325, param4:int=510) {
         super();
         this.mt = param1;
         this._aCoords = this.mt.ptModel.tableLayout.getChickletLayout();
         this.cont = param2;
         this._inbX = param3;
         this._inbY = param4;
         this.initInviteInbox();
      }
      
      private var mt:TableView;
      
      private var cont:DisplayObjectContainer;
      
      private var _inbox:InviteInbox;
      
      private var _inbCount:int;
      
      private var _inbX:int;
      
      private var _inbY:int;
      
      private var _aCoords:Array;
      
      private var _envCont:Sprite;
      
      private var _hitter:MovieClip;
      
      private function hitterActive(param1:Boolean) : void {
         if(param1)
         {
            this.mt.addChild(this.cont);
         }
         this._inbox.count.text = this._inbCount.toString();
         this._inbox.visible = param1;
         this._hitter.visible = param1;
         this._hitter.mouseEnabled = param1;
      }
      
      private function initInviteInbox() : void {
         this._inbCount = this.mt.getPendingInviteCount();
         this._inbox = new InviteInbox(this._inbCount);
         this._inbox.x = this._inbX;
         this._inbox.y = this._inbY;
         this._inbox.visible = false;
         this.cont.addChild(this._inbox);
         this._envCont = new Sprite();
         this.cont.addChild(this._envCont);
         this._hitter = new MovieClip();
         this._hitter.graphics.beginFill(16711680,0);
         this._hitter.graphics.drawRect((0 - this._inbox.width) / 2,(0 - this._inbox.height) / 2,this._inbox.width,this._inbox.height);
         this._hitter.graphics.endFill();
         this._hitter.x = this._inbox.x;
         this._hitter.y = this._inbox.y;
         this._hitter.useHandCursor = true;
         this._hitter.buttonMode = true;
         this.cont.addChild(this._hitter);
         this._hitter.addEventListener(MouseEvent.ROLL_OVER,this.envOver);
         this._hitter.addEventListener(MouseEvent.ROLL_OUT,this.envOut);
         this._hitter.addEventListener(MouseEvent.CLICK,this.invitePopup);
         this.checkInbox();
      }
      
      public function checkInbox() : void {
         this._inbCount = this.mt.getPendingInviteCount();
         this._inbox.count.text = this._inbCount.toString();
         if(this._inbCount > 0)
         {
            this.hitterActive(true);
         }
         if(this._inbCount < 1)
         {
            this.hitterActive(false);
         }
      }
      
      private function envOver(param1:MouseEvent) : void {
         Tweener.addTween(this._inbox,
            {
               "scaleX":1.25,
               "scaleY":1.25,
               "time":0.25,
               "transition":"easeOutBack"
            });
      }
      
      private function envOut(param1:MouseEvent) : void {
         Tweener.addTween(this._inbox,
            {
               "scaleX":1,
               "scaleY":1,
               "time":0.2,
               "transition":"easeOutSine"
            });
      }
      
      private function invitePopup(param1:MouseEvent) : void {
         this.mt.onInvitePressed();
         this.updateInboxCount(0);
      }
      
      public function updateInboxCount(param1:int) : void {
         this._inbCount = param1;
         this._inbox.count.text = this._inbCount.toString();
         if(this._inbCount > 0)
         {
            this.hitterActive(true);
         }
         if(this._inbCount < 1)
         {
            this.hitterActive(false);
         }
      }
      
      public function sendBI(param1:int, param2:int, param3:Boolean) : void {
         var toX:int = 0;
         var toY:int = 0;
         var env:MovieClip = null;
         var handleEnv:Function = null;
         var killEnv:Function = null;
         var fromSit:int = param1;
         var toSit:int = param2;
         var bToYou:Boolean = param3;
         handleEnv = function():void
         {
            if(!bToYou)
            {
               Tweener.addTween(env,
                  {
                     "alpha":0,
                     "time":0.2,
                     "transition":"easeInSine"
                  });
               Tweener.addTween(env,
                  {
                     "scaleX":0.5,
                     "scaleY":0.5,
                     "time":0.2,
                     "transition":"easeInSine",
                     "onComplete":killEnv,
                     "onCompleteParams":[env]
                  });
            }
            else
            {
               if(bToYou)
               {
                  Tweener.addTween(env,
                     {
                        "x":_inbX,
                        "y":_inbY,
                        "time":1,
                        "transition":"easeInOutSine"
                     });
                  Tweener.addTween(env,
                     {
                        "alpha":0,
                        "time":0.2,
                        "delay":1,
                        "transition":"easeInSine"
                     });
                  Tweener.addTween(env,
                     {
                        "scaleX":0.5,
                        "scaleY":0.5,
                        "time":0.2,
                        "delay":1,
                        "transition":"easeInSine",
                        "onComplete":killEnv,
                        "onCompleteParams":[env]
                     });
               }
            }
         };
         killEnv = function(param1:MovieClip):void
         {
            checkInbox();
            _envCont.removeChild(param1);
            var param1:MovieClip = null;
         };
         var fromX:int = this._aCoords[fromSit].x;
         var fromY:int = this._aCoords[fromSit].y;
         toX = this._aCoords[toSit].x;
         toY = this._aCoords[toSit].y;
         env = PokerClassProvider.getObject("InviteEnv");
         env.scaleX = env.scaleY = env.alpha = 0.5;
         env.x = fromX;
         env.y = fromY;
         env.mouseEnabled = false;
         this._envCont.addChild(env);
         Tweener.addTween(env,
            {
               "x":toX,
               "y":toY,
               "time":1.5,
               "transition":"easeInOutSine",
               "onComplete":handleEnv
            });
         Tweener.addTween(env,
            {
               "alpha":1,
               "time":0.2,
               "transition":"easeInSine"
            });
         Tweener.addTween(env,
            {
               "scaleX":1.25,
               "scaleY":1.25,
               "time":0.2,
               "transition":"easeInSine"
            });
      }
      
      public function clearInvites() : void {
         if((this._hitter) && (this.cont.contains(this._hitter)))
         {
            this.cont.removeChild(this._hitter);
            this._hitter = null;
         }
         if((this._inbox) && (this.cont.contains(this._inbox)))
         {
            this.cont.removeChild(this._inbox);
            this._inbox = null;
         }
         if((this._envCont) && (this.cont.contains(this._envCont)))
         {
            this.cont.removeChild(this._envCont);
            this._envCont = null;
         }
      }
   }
}
