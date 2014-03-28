package com.zynga.poker.commonUI
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.zynga.poker.commonUI.notifs.InviteNotif;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.commonUI.notifs.RealTimeInviteNotif;
   import com.zynga.poker.commonUI.notifs.JoinedTableNotif;
   import com.zynga.poker.commonUI.events.CloseNotifEvent;
   import caurina.transitions.Tweener;
   import com.zynga.poker.commonUI.notifs.BaseNotif;
   import flash.events.TimerEvent;
   
   public class Notifications extends MovieClip
   {
      
      public function Notifications() {
         super();
         this.invitenotifs = new Array();
         this.joinednotifs = new Array();
         this.displaynotifs = new Array();
         this._rtInviteNotifs = new Array();
         this._rtBuddyNotifsDisplayed = new Dictionary();
      }
      
      private const kMaxRTInvites:int = 1;
      
      private var invitenotifs:Array;
      
      private var joinednotifs:Array;
      
      private var displaynotifs:Array;
      
      private var _rtInviteNotifs:Array;
      
      private var inLobby:Boolean = true;
      
      private var pgData:Object;
      
      private var _rtBuddyNotifsDisplayed:Dictionary;
      
      private var _rtBuddyNotifTimer:Timer;
      
      public function addInviteNotif(param1:Object) : void {
         var _loc3_:InviteNotif = null;
         var _loc4_:InviteNotif = null;
         var _loc2_:* = false;
         for each (_loc3_ in this.invitenotifs)
         {
            if(this.pgData != null)
            {
               if(param1["room_id"] == _loc3_.data["room_id"] && param1["server_id"] == _loc3_.data["server_id"])
               {
                  _loc2_ = true;
               }
            }
            if(_loc3_.zid == param1["uid"])
            {
               _loc2_ = true;
            }
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc4_ = new InviteNotif(param1,this.inLobby);
            _loc4_.addEventListener(CommonVEvent.CLOSE_NOTIF,this.inviteClosed);
            this.invitenotifs.push(_loc4_);
            addChild(_loc4_);
            this.redrawNotifs();
         }
      }
      
      public function addRTInviteNotif(param1:Object, param2:Boolean) : void {
         var _loc3_:RealTimeInviteNotif = null;
         if(!param2)
         {
            if(!this.inLobby && !this._rtBuddyNotifsDisplayed[param1["uid"]])
            {
               this._rtBuddyNotifsDisplayed[param1["uid"]] = true;
               _loc3_ = new RealTimeInviteNotif(param1,this.inLobby);
               _loc3_.expandDirection = RealTimeInviteNotif.EXPAND_UPWARD;
               _loc3_.shouldWaitForCallToExpand = true;
               _loc3_.addEventListener(CommonVEvent.CLOSE_NOTIF,this.onRTNotifInviteClosed);
               _loc3_.alpha = 1;
               this._rtInviteNotifs.push(_loc3_);
               if(!this._rtBuddyNotifTimer)
               {
                  this.redrawRTNotifs();
               }
            }
         }
         else
         {
            this._rtBuddyNotifsDisplayed[param1["uid"]] = true;
         }
      }
      
      public function addJoinedNotif(param1:Object) : void {
         var _loc3_:JoinedTableNotif = null;
         var _loc4_:JoinedTableNotif = null;
         var _loc2_:* = false;
         for each (_loc3_ in this.joinednotifs)
         {
            if(_loc3_.zid == param1["uid"])
            {
               _loc2_ = true;
            }
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc4_ = new JoinedTableNotif(param1);
            _loc4_.addEventListener(CommonVEvent.CLOSE_NOTIF,this.joinedClosed);
            this.joinednotifs.push(_loc4_);
            addChild(_loc4_);
            this.redrawNotifs();
         }
      }
      
      private function removeInviteNotif(param1:InviteNotif) : void {
         var _loc3_:InviteNotif = null;
         var _loc2_:InviteNotif = param1;
         for each (_loc3_ in this.invitenotifs)
         {
            if(_loc3_ == _loc2_)
            {
               this.invitenotifs.splice(this.invitenotifs.indexOf(_loc3_),1);
               _loc3_.removeEventListener(CommonVEvent.CLOSE_NOTIF,this.inviteClosed);
               dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE,param1));
               this.fadeOutNotif(_loc3_);
            }
         }
         this.redrawNotifs();
      }
      
      private function removeJoinNotif(param1:JoinedTableNotif) : void {
         var _loc3_:JoinedTableNotif = null;
         var _loc2_:JoinedTableNotif = param1;
         for each (_loc3_ in this.joinednotifs)
         {
            if(_loc3_ == _loc2_)
            {
               this.joinednotifs.splice(this.joinednotifs.indexOf(_loc3_),1);
               _loc3_.removeEventListener(CommonVEvent.CLOSE_NOTIF,this.joinedClosed);
               this.fadeOutNotif(_loc3_);
            }
         }
         this.redrawNotifs();
      }
      
      private function inviteClosed(param1:CloseNotifEvent) : void {
         var _loc2_:InviteNotif = null;
         for each (_loc2_ in this.invitenotifs)
         {
            if(_loc2_ == param1.notif)
            {
               this.invitenotifs.splice(this.invitenotifs.indexOf(_loc2_),1);
               this.fadeOutNotif(_loc2_);
            }
         }
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE,param1.notif));
         this.redrawNotifs();
      }
      
      private function onRTNotifInviteClosed(param1:CloseNotifEvent) : void {
         var evt:CloseNotifEvent = param1;
         this.stopRTBuddyNotifTimer();
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE,evt.notif));
         if(Tweener.isTweening(evt.notif))
         {
            Tweener.removeTweens(evt.notif);
         }
         Tweener.addTween(evt.notif,
            {
               "alpha":0.0,
               "time":0.25,
               "transition":"easeOutSine",
               "onComplete":function(param1:RealTimeInviteNotif):void
               {
                  param1.removeEventListener(CommonVEvent.CLOSE_NOTIF,onRTNotifInviteClosed);
                  removeChild(param1);
                  redrawRTNotifs();
               },
               "onCompleteParams":[evt.notif]
            });
      }
      
      private function joinedClosed(param1:CloseNotifEvent) : void {
         var _loc2_:JoinedTableNotif = null;
         for each (_loc2_ in this.joinednotifs)
         {
            if(_loc2_ == param1.notif)
            {
               this.joinednotifs.splice(this.joinednotifs.indexOf(_loc2_),1);
               this.fadeOutNotif(_loc2_);
            }
         }
         this.redrawNotifs();
      }
      
      private function fadeOutNotif(param1:BaseNotif) : void {
         var target:BaseNotif = param1;
         Tweener.addTween(target,
            {
               "alpha":0,
               "time":0.25,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  this.parent.removeChild(this);
                  Tweener.removeTweens(this);
               }
            });
      }
      
      public function updateNotifButtons(param1:String) : void {
         var _loc2_:InviteNotif = null;
         switch(param1)
         {
            case "lobby":
               this.inLobby = true;
               for each (_loc2_ in this.invitenotifs)
               {
                  _loc2_.hideInvite();
               }
               this.destroyAllRTNotifs();
               break;
            case "table":
               this.inLobby = false;
               for each (_loc2_ in this.invitenotifs)
               {
                  _loc2_.showInvite();
               }
               break;
         }
         
      }
      
      private function redrawNotifs() : void {
         this.displaynotifs = new Array();
         var _loc1_:* = 0;
         while(_loc1_ < this.invitenotifs.length)
         {
            this.displaynotifs[_loc1_] = this.invitenotifs[_loc1_];
            if(this.invitenotifs[_loc1_].alpha == 0)
            {
               Tweener.addTween(this.invitenotifs[_loc1_],
                  {
                     "alpha":1,
                     "time":0.25,
                     "delay":0.5,
                     "transition":"easeOutSine"
                  });
               dispatchEvent(new CommonVEvent(CommonVEvent.INVITENOTIF_DISPLAYED));
               Tweener.addTween(this.invitenotifs[_loc1_],
                  {
                     "alpha":0,
                     "time":0.25,
                     "delay":10,
                     "transition":"easeOutSine",
                     "onComplete":this.removeInviteNotif,
                     "onCompleteParams":[this.invitenotifs[_loc1_]]
                  });
            }
            this.displaynotifs[_loc1_].x = -4;
            _loc1_++;
         }
         var _loc2_:* = 0;
         var _loc3_:int = this.displaynotifs.length;
         while(this.displaynotifs.length < 3 && _loc2_ < this.joinednotifs.length)
         {
            if(this.joinednotifs[_loc2_] != null)
            {
               this.displaynotifs[_loc3_ + _loc2_] = this.joinednotifs[_loc2_];
               if(this.joinednotifs[_loc2_].alpha == 0)
               {
                  Tweener.addTween(this.joinednotifs[_loc2_],
                     {
                        "alpha":1,
                        "time":0.25,
                        "delay":0.5,
                        "transition":"easeOutSine"
                     });
                  Tweener.addTween(this.joinednotifs[_loc2_],
                     {
                        "alpha":0,
                        "time":0.25,
                        "delay":10,
                        "transition":"easeOutSine",
                        "onComplete":this.removeJoinNotif,
                        "onCompleteParams":[this.joinednotifs[_loc2_]]
                     });
               }
            }
            _loc2_++;
         }
         if(this.displaynotifs[0] != null)
         {
            Tweener.addTween(this.displaynotifs[0],
               {
                  "y":388,
                  "time":0.25,
                  "delay":0.1,
                  "transition":"easeOutSine"
               });
         }
         if(this.displaynotifs[1] != null)
         {
            Tweener.addTween(this.displaynotifs[1],
               {
                  "y":358,
                  "time":0.25,
                  "delay":0.1,
                  "transition":"easeOutSine"
               });
         }
         if(this.displaynotifs[2] != null)
         {
            Tweener.addTween(this.displaynotifs[2],
               {
                  "y":328,
                  "time":0.25,
                  "delay":0.1,
                  "transition":"easeOutSine"
               });
         }
      }
      
      private function redrawRTNotifs() : void {
         var notif:RealTimeInviteNotif = null;
         var completionBlock:Function = null;
         var i:int = 0;
         var appHeight:Number = 570;
         var targetY:Number = 0.0;
         notif = null;
         i = 0;
         while(i < numChildren)
         {
            if(getChildAt(i) is RealTimeInviteNotif)
            {
               notif = getChildAt(i) as RealTimeInviteNotif;
               if((notif) && (notif.data.isRT))
               {
                  break;
               }
            }
            notif = null;
            i++;
         }
         if(notif)
         {
            targetY = appHeight;
            if(Tweener.isTweening(notif))
            {
               Tweener.removeTweens(notif);
            }
            Tweener.addTween(notif,
               {
                  "y":targetY,
                  "time":0.5,
                  "transition":"easeOutSine",
                  "onComplete":function(param1:RealTimeInviteNotif):void
                  {
                     param1.removeEventListener(CommonVEvent.CLOSE_NOTIF,onRTNotifInviteClosed);
                     dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE,param1));
                     if(contains(param1))
                     {
                        removeChild(param1);
                     }
                     redrawRTNotifs();
                  },
                  "onCompleteParams":[notif]
               });
         }
         else
         {
            if(!this._rtInviteNotifs.length)
            {
               return;
            }
            notif = this._rtInviteNotifs.shift() as RealTimeInviteNotif;
            completionBlock = function():void
            {
               notif.performSizeAnimation();
            };
            if(notif)
            {
               notif.x = -4;
               notif.y = appHeight;
               targetY = appHeight - 140;
               if(!contains(notif))
               {
                  addChild(notif);
                  dispatchEvent(new CommonVEvent(CommonVEvent.REALTIMENOTIF_DISPLAYED));
               }
               if(Tweener.isTweening(notif))
               {
                  Tweener.removeTweens(notif);
               }
               Tweener.addTween(notif,
                  {
                     "y":targetY,
                     "time":0.5,
                     "transition":"easeOutSine",
                     "onComplete":completionBlock
                  });
               this.startRTBuddyNotifTimer();
            }
         }
      }
      
      private function startRTBuddyNotifTimer() : void {
         if(!this._rtBuddyNotifTimer)
         {
            this._rtBuddyNotifTimer = new Timer(1000,10);
            this._rtBuddyNotifTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRTBuddyNotifTimerComplete);
         }
         this._rtBuddyNotifTimer.reset();
         this._rtBuddyNotifTimer.start();
      }
      
      private function stopRTBuddyNotifTimer() : void {
         if(this._rtBuddyNotifTimer)
         {
            this._rtBuddyNotifTimer.stop();
            this._rtBuddyNotifTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRTBuddyNotifTimerComplete);
            this._rtBuddyNotifTimer = null;
         }
      }
      
      private function onRTBuddyNotifTimerComplete(param1:TimerEvent) : void {
         this.stopRTBuddyNotifTimer();
         this.redrawRTNotifs();
      }
      
      private function destroyAllRTNotifs() : void {
         var _loc2_:RealTimeInviteNotif = null;
         this.stopRTBuddyNotifTimer();
         var _loc1_:* = 0;
         _loc1_ = 0;
         while(_loc1_ < this._rtInviteNotifs.length)
         {
            if(Tweener.isTweening(this._rtInviteNotifs[_loc1_]))
            {
               Tweener.removeTweens(this._rtInviteNotifs[_loc1_]);
            }
            if(contains(this._rtInviteNotifs[_loc1_]))
            {
               removeChild(this._rtInviteNotifs[_loc1_]);
            }
            else
            {
               this._rtInviteNotifs[_loc1_].cleanUp(null);
            }
            this._rtInviteNotifs[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = numChildren-1;
         while(_loc1_ > -1)
         {
            _loc2_ = null;
            if(getChildAt(_loc1_) is RealTimeInviteNotif)
            {
               _loc2_ = getChildAt(_loc1_) as RealTimeInviteNotif;
               removeChild(_loc2_);
               _loc2_.cleanUp(null);
            }
            _loc1_--;
         }
         this._rtInviteNotifs = new Array();
      }
      
      public function init(param1:Object) : void {
         this.pgData = param1;
      }
   }
}
