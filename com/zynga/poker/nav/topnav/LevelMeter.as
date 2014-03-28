package com.zynga.poker.nav.topnav
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import com.zynga.draw.ComplexBox;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.text.HtmlTextBox;
   import flash.utils.Timer;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   import flash.display.GradientType;
   import com.greensock.TweenLite;
   import caurina.transitions.Tweener;
   import com.zynga.poker.nav.events.NVEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.UnlockComponentsLevel;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class LevelMeter extends MovieClip
   {
      
      public function LevelMeter(param1:Boolean=false) {
         this.cont = new Sprite();
         this.xpNewLevelAnimationBackdropTextX = this.xpNewLevelAnimationTextX + 0.5;
         this.xpNewLevelAnimationBackdropTextY = this.xpNewLevelAnimationTextY + 0.5;
         this.xpBarColors = 
            {
               "first":5215760,
               "second":4764162,
               "last":5492736
            };
         super();
         this._zpwcEnabled = param1;
         addChild(this.cont);
         this.xpLeveler = PokerClassProvider.getObject("XPLevelInformation");
         this.initAssets();
         this.cont.addChild(this.xpLeveler);
      }
      
      public var cont:Sprite;
      
      public var bg:ComplexBox;
      
      public var currentLevel:int = -1;
      
      public var currentPercentage:Number = 0.01;
      
      public var xpLeveler:MovieClip;
      
      public var xpLevelUpAnimation:MovieClip;
      
      public var levelUpWithBonusAnimation:MovieClip;
      
      public var currentXP:Number;
      
      public var oldXP:Number = 0;
      
      public var xpLevelEnd:Number;
      
      public var oldXPLevelEnd:Number = 0;
      
      public var xpTitle:String;
      
      public var deltaXP:Number;
      
      public var nextUnlock:Number;
      
      public var xpTotalText:EmbeddedFontTextField;
      
      public var levelLabel:EmbeddedFontTextField;
      
      public var levelNumText:EmbeddedFontTextField;
      
      public var pokerNameText:EmbeddedFontTextField;
      
      public var xpNewLevelText:HtmlTextBox;
      
      public var xpNewLevelTextBackDrop:HtmlTextBox;
      
      private var xpAnimationTimer:Timer;
      
      public var tooltip:Sprite;
      
      public var xpBar:Sprite;
      
      public var xpBarBar:Sprite;
      
      public var xpBarOverlay:Sprite;
      
      public var xpBarTooltip:Tooltip;
      
      public var xpNewLevelAnimationTextX:Number = 16.5;
      
      public var xpNewLevelAnimationTextY:Number = 11.7;
      
      private var xpLevelUpOffset:Number = -195;
      
      public var xpNewLevelAnimationBackdropTextX:Number;
      
      public var xpNewLevelAnimationBackdropTextY:Number;
      
      public var userLeveled:Boolean = false;
      
      public var xpBarColors:Object;
      
      private var unlockTooltipAnimation:MovieClip;
      
      private var unlockLevelInfoAnimation:MovieClip;
      
      private var unlockTooltipShowedUp:Boolean = false;
      
      private var _zpwcEnabled:Boolean = false;
      
      private var _isUserXPBoosting:Boolean = false;
      
      private function initAssets() : void {
         var _loc1_:Number = 1;
         if(this._zpwcEnabled)
         {
            this.xpLeveler.xpBarClip.width = 75;
            _loc1_ = 1.7;
         }
         var _loc2_:Number = _loc1_ * this.xpLeveler.xpBarClip.width;
         var _loc3_:Number = this.xpLeveler.xpBarClip.height;
         this.xpBar = new Sprite();
         this.xpBar.x = 0;
         this.xpBar.y = 0;
         this.xpBar.scaleX = 0;
         this.xpLeveler.xpBarClip.addChild(this.xpBar);
         this.xpBarBar = new Sprite();
         this.xpBarBar.graphics.beginFill(this.xpBarColors.first,1);
         this.xpBarBar.graphics.drawRect(0,0,_loc2_ + 1,_loc3_ + 1);
         this.xpBarBar.graphics.endFill();
         this.xpBar.addChild(this.xpBarBar);
         this.xpBarOverlay = new Sprite();
         this.xpBarOverlay.graphics.beginFill(16777215,0.3);
         this.xpBarOverlay.graphics.drawRect(0,0,_loc2_,_loc3_);
         this.xpBarOverlay.graphics.endFill();
         this.xpBar.addChild(this.xpBarOverlay);
         this.xpTotalText = new EmbeddedFontTextField("","MainCondensed",13,16777215,"right");
         this.xpTotalText.name = "lblLevelMeterXPTotal";
         if(!this._zpwcEnabled)
         {
            this.xpTotalText.width = 130;
            this.xpTotalText.height = 20;
            this.xpTotalText.y = 5;
            this.xpTotalText.x = 43;
            this.xpLeveler.addChild(this.xpTotalText);
         }
         this.levelNumText = new EmbeddedFontTextField(" ","MainCondensed",24,16777215,"center");
         this.levelNumText.name = "lblLevelMeterLevelNum";
         this.levelNumText.x = 20 - Math.round(this.levelNumText.width / 2);
         this.levelNumText.autoSize = TextFieldAutoSize.LEFT;
         this.levelNumText.y = 9;
         this.xpLeveler.addChild(this.levelNumText);
         this.levelLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.nav.top.levelLabel"),"Calibri",11,13421772,"center");
         this.levelLabel.autoSize = TextFieldAutoSize.LEFT;
         this.levelLabel.x = 20 - Math.round(this.levelLabel.width / 2);
         this.levelLabel.y = this.levelNumText.y + Math.round(this.levelNumText.height - this.levelNumText.textHeight) - this.levelLabel.textHeight;
         this.levelLabel.mouseEnabled = false;
         this.xpLeveler.addChild(this.levelLabel);
         this.pokerNameText = new EmbeddedFontTextField("","MainCondensed",14,16777215,"left");
         this.pokerNameText.name = "lblLevelMeterLevelLabel";
         this.pokerNameText.autoSize = TextFieldAutoSize.LEFT;
         this.pokerNameText.x = 40;
         this.pokerNameText.y = 4;
         this.xpLeveler.addChild(this.pokerNameText);
      }
      
      public function drawXPBoostActiveBar() : void {
         this.xpBarBar.graphics.beginGradientFill(GradientType.LINEAR,[11832608,14329120],[1,1],[0,255]);
         this.xpBarBar.graphics.drawRect(0,0,this.xpBarBar.width,this.xpBarBar.height);
         this.xpBarBar.graphics.endFill();
      }
      
      public function removeXPBoostActiveBar() : void {
         this.updateXPUI();
      }
      
      public function setXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void {
         this.oldXP = this.currentXP;
         this.oldXPLevelEnd = this.xpLevelEnd;
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(isNaN(param2))
         {
            param2 = 0;
         }
         if(isNaN(param3))
         {
            param3 = 0;
         }
         if(isNaN(param5))
         {
            param5 = 0;
         }
         if(param3 > this.currentLevel && !(this.currentLevel == -1))
         {
            this.userLeveled = true;
         }
         this.currentXP = param1;
         this.deltaXP = param2;
         this.currentLevel = param3;
         this.xpTitle = param4;
         this.xpLevelEnd = param5;
         if(this.userLeveled)
         {
            this.handleNewLevel(param3,param4);
         }
         this.updateXPUI();
         this.resetFlags();
      }
      
      public function updateNextUnlockLevel(param1:Number) : void {
         if(isNaN(param1))
         {
            param1 = 0;
         }
         this.nextUnlock = param1;
         this.updateTooltipText();
      }
      
      private function resetFlags() : void {
         this.userLeveled = false;
      }
      
      private function changeXPBarColor(param1:uint) : void {
         this.xpBarBar.graphics.beginFill(param1,1);
         this.xpBarBar.graphics.drawRect(0,0,this.xpBarBar.width,this.xpBarBar.height);
         this.xpBarBar.graphics.endFill();
      }
      
      private function updateTooltipText() : void {
         if(this.xpBarTooltip != null)
         {
            this.xpBarTooltip.body = this.getTooltipText();
         }
      }
      
      private function getTooltipText() : String {
         var _loc1_:String = LocaleManager.localize("flash.nav.top.xpTooltipBody");
         if(this.nextUnlock > 0)
         {
            _loc1_ = _loc1_ + ("" + LocaleManager.localize("flash.nav.top.xpTooltipNextUnlock",{"level":this.nextUnlock}));
         }
         return _loc1_;
      }
      
      public function hideElements(param1:Number=0, param2:Number=0) : void {
         TweenLite.killTweensOf(this.xpBarBar);
         TweenLite.killTweensOf(this.xpLeveler);
         TweenLite.to(this.xpBarBar,param1,
            {
               "alpha":0,
               "delay":param2
            });
         TweenLite.to(this.xpLeveler,param1,
            {
               "alpha":0,
               "delay":param2
            });
      }
      
      public function showElements(param1:Number=0, param2:Number=0) : void {
         TweenLite.killTweensOf(this.xpBarBar);
         TweenLite.killTweensOf(this.xpLeveler);
         TweenLite.to(this.xpBarBar,param1,
            {
               "alpha":1,
               "delay":param2
            });
         TweenLite.to(this.xpLeveler,param1,
            {
               "alpha":1,
               "delay":param2
            });
      }
      
      public function showToolTip() : void {
         var _loc1_:String = LocaleManager.localize("flash.nav.top.xpTooltipTitle");
         if(this.xpBarTooltip == null)
         {
            this.xpBarTooltip = new Tooltip(250,this.getTooltipText(),_loc1_);
            if(this._zpwcEnabled)
            {
               this.xpBarTooltip.y = 40;
               this.addChild(this.xpBarTooltip);
            }
            else
            {
               this.xpBarTooltip.y = 50;
               this.addChild(this.xpBarTooltip);
            }
         }
         if(this._zpwcEnabled)
         {
            _loc1_ = _loc1_ + (" (" + this.xpTotalText.text + ")");
            this.xpBarTooltip.title = _loc1_;
         }
         this.xpBarTooltip.alpha = 0;
         this.xpBarTooltip.visible = true;
         Tweener.addTween(this.xpBarTooltip,
            {
               "alpha":1,
               "time":0.5,
               "transition":"easeInSine"
            });
         this.updateTooltipText();
      }
      
      public function hideToolTip() : void {
         if(this.xpBarTooltip)
         {
            this.xpBarTooltip.visible = false;
         }
      }
      
      public function handleNewLevel(param1:Number, param2:String) : void {
         this.handleNewLevelWithoutButton(param1,param2);
      }
      
      private function handleNewLevelWithoutButton(param1:Number, param2:String) : void {
         var _loc3_:* = NaN;
         this.performTitleChange(param2);
         if(!this.xpLevelUpAnimation)
         {
            dispatchEvent(new NVEvent(NVEvent.PLAYING_LEVELUP_ANIMATION));
            this.xpLevelUpAnimation = PokerClassProvider.getObject("XPLevelUpAnimation");
            this.xpLevelUpAnimation.x = this.xpLevelUpOffset;
            this.cont.addChild(this.xpLevelUpAnimation);
            this.xpNewLevelTextBackDrop = new HtmlTextBox("MainCondensed",String(param1),13,0,"center");
            this.xpNewLevelTextBackDrop.x = this.xpNewLevelAnimationBackdropTextX;
            this.xpNewLevelTextBackDrop.y = this.xpNewLevelAnimationBackdropTextY;
            this.xpLevelUpAnimation.levelNum.addChild(this.xpNewLevelTextBackDrop);
            this.xpNewLevelText = new HtmlTextBox("MainCondensed",String(param1),13,16706236,"center");
            this.xpNewLevelText.x = this.xpNewLevelAnimationTextX;
            this.xpNewLevelText.y = this.xpNewLevelAnimationTextY;
            this.xpLevelUpAnimation.levelNum.addChild(this.xpNewLevelText);
            this.addLevelAnimation();
            this.xpLevelUpAnimation.unlockAnimationContainer.visible = false;
            if(UnlockComponentsLevel.shootout > 0)
            {
               this.updateXPLevelUpAnimation(param1);
            }
         }
         else
         {
            this.xpNewLevelText.updateText(String(param1));
            this.xpNewLevelTextBackDrop.updateText(String(param1));
         }
         if(param1 < 10)
         {
            _loc3_ = 1.3;
            this.xpNewLevelTextBackDrop.x = this.xpNewLevelAnimationBackdropTextX + _loc3_;
            this.xpNewLevelText.x = this.xpNewLevelAnimationTextX + _loc3_;
         }
         this.xpLevelUpAnimation.addEventListener(Event.ENTER_FRAME,this.onXPLevelUpAnimationEnterFrame);
         this.xpLevelUpAnimation.gotoAndPlay(2);
      }
      
      private function addLevelAnimation() : void {
         var _loc1_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.nav.top.levelAnimation"),"Main",30,16777215,"center");
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         var _loc2_:DropShadowFilter = new DropShadowFilter();
         _loc2_.strength = 0;
         _loc1_.filters = [_loc2_];
         var _loc3_:Sprite = PokerClassProvider.getObject("levelMaskSprite");
         _loc3_.cacheAsBitmap = true;
         this.xpLevelUpAnimation.levelMc.addChild(_loc3_);
         _loc3_.x = -3;
         _loc1_.fitInWidth(_loc3_.width);
         var _loc4_:Sprite = new Sprite();
         _loc4_.addChild(_loc1_);
         _loc4_.cacheAsBitmap = true;
         this.xpLevelUpAnimation.levelMc.addChild(_loc4_);
         _loc4_.x = _loc3_.x + (_loc3_.width - _loc1_.textWidth * _loc1_.scaleX) / 2;
         _loc4_.y = _loc3_.y + (_loc3_.height - _loc1_.textHeight * _loc1_.scaleY) / 2;
         _loc3_.mask = _loc4_;
      }
      
      private function onXPLevelUpAnimationWithButtonEnterFrame(param1:Event) : void {
         dispatchEvent(new NVEvent(NVEvent.STOP_LEVELUP_ANIMATION));
         if(this.cont.contains(this.levelUpWithBonusAnimation))
         {
            this.cont.removeChild(this.levelUpWithBonusAnimation);
         }
         this.cont.graphics.clear();
         this.levelUpWithBonusAnimation = null;
         this.updateXPBarAnimation(this.currentLevel);
      }
      
      private function onXPLevelUpAnimationEnterFrame(param1:Event) : void {
         if(this.xpLevelUpAnimation.currentFrame == 1)
         {
            dispatchEvent(new NVEvent(NVEvent.STOP_LEVELUP_ANIMATION));
            this.xpLevelUpAnimation.removeEventListener(Event.ENTER_FRAME,this.onXPLevelUpAnimationEnterFrame);
            this.cont.removeChild(this.xpLevelUpAnimation);
            this.xpLevelUpAnimation = null;
            this.xpNewLevelTextBackDrop = null;
            this.xpNewLevelText = null;
            this.updateXPBarAnimation(this.currentLevel);
         }
      }
      
      private function performTitleChange(param1:String) : void {
         this.pokerNameText.text = param1;
      }
      
      public function updateXPUI() : void {
         var partialPercentage:Number = NaN;
         var time:Number = NaN;
         var barScale:Number = NaN;
         this.levelNumText.text = String(this.currentLevel);
         this.levelNumText.x = 20 - Math.round(this.levelNumText.width / 2);
         this.pokerNameText.text = this.xpTitle;
         if(this.xpLevelEnd > 0)
         {
            this.xpTotalText.text = this.currentXP + " / " + this.xpLevelEnd;
         }
         else
         {
            this.xpTotalText.text = "MAX";
         }
         if(this._zpwcEnabled)
         {
            this.pokerNameText.fitInWidth(130 - this.xpTotalText.textWidth);
         }
         partialPercentage = this.xpLevelEnd > 0?this.currentXP / this.xpLevelEnd:1;
         if(partialPercentage > 1)
         {
            partialPercentage = 1;
         }
         if(partialPercentage < 0.33)
         {
            if(!this.userLeveled)
            {
               this.changeXPBarColor(this.xpBarColors.first);
            }
         }
         else
         {
            if(partialPercentage > 0.66)
            {
               this.changeXPBarColor(this.xpBarColors.last);
            }
            else
            {
               this.changeXPBarColor(this.xpBarColors.second);
            }
         }
         if(this._isUserXPBoosting)
         {
            this.drawXPBoostActiveBar();
         }
         var oldPercentage:Number = this.oldXPLevelEnd == 0?0:this.oldXP / this.oldXPLevelEnd;
         if(this.userLeveled)
         {
            finishUp = function():void
            {
               time = partialPercentage * 2;
               var _loc1_:Number = partialPercentage;
               Tweener.addTween(xpBar,
                  {
                     "scaleX":_loc1_,
                     "time":time,
                     "transition":"easeOutSine"
                  });
            };
            time = (1 - oldPercentage) * 2;
            barScale = 1;
            Tweener.addTween(this.xpBar,
               {
                  "scaleX":barScale,
                  "time":time,
                  "transition":"easeInSine",
                  "onComplete":finishUp
               });
         }
         else
         {
            time = partialPercentage * 2;
            Tweener.addTween(this.xpBar,
               {
                  "scaleX":partialPercentage,
                  "time":time,
                  "transition":"easeInOutSine"
               });
         }
         if(UnlockComponentsLevel.shootout > 0)
         {
            if(!this.xpLevelUpAnimation)
            {
               if(!this.unlockTooltipShowedUp)
               {
                  this.unlockTooltipShowedUp = true;
                  this.updateXPBarAnimation(this.currentLevel);
               }
            }
         }
      }
      
      public function set isUserXPBoosting(param1:Boolean) : void {
         this._isUserXPBoosting = param1;
      }
      
      private function updateXPLevelUpAnimation(param1:Number) : void {
         if(param1 == UnlockComponentsLevel.fastTables)
         {
            this.xpLevelUpAnimation.unlockAnimationContainer.visible = true;
            this.xpLevelUpAnimation.unlockAnimationContainer.unlockLogoAnimationContainer.addChild(PokerClassProvider.getObject("unlockLogoAnimation_FastTables_EN"));
         }
         else
         {
            if(param1 == UnlockComponentsLevel.shootout)
            {
               this.xpLevelUpAnimation.unlockAnimationContainer.visible = true;
               this.xpLevelUpAnimation.unlockAnimationContainer.unlockLogoAnimationContainer.addChild(PokerClassProvider.getObject("unlockLogoAnimation_Shootout_EN"));
            }
            else
            {
               if(param1 == UnlockComponentsLevel.sitngo)
               {
                  this.xpLevelUpAnimation.unlockAnimationContainer.visible = true;
                  this.xpLevelUpAnimation.unlockAnimationContainer.unlockLogoAnimationContainer.addChild(PokerClassProvider.getObject("unlockLogoAnimation_SitNGo_EN"));
               }
               else
               {
                  if(param1 == UnlockComponentsLevel.weeklyTourney)
                  {
                     this.xpLevelUpAnimation.unlockAnimationContainer.visible = true;
                     this.xpLevelUpAnimation.unlockAnimationContainer.unlockLogoAnimationContainer.addChild(PokerClassProvider.getObject("unlockLogoAnimation_WeeklyTourney_EN"));
                  }
               }
            }
         }
      }
      
      private function updateXPBarAnimation(param1:Number) : void {
         var _loc4_:EmbeddedFontTextField = null;
         var _loc2_:String = null;
         if(param1 == UnlockComponentsLevel.fastTables-1)
         {
            _loc2_ = LocaleManager.localize("flash.nav.top.xpBarBalloonNextUnlockComponent.fastTables");
         }
         else
         {
            if(param1 == UnlockComponentsLevel.shootout-1)
            {
               _loc2_ = LocaleManager.localize("flash.nav.top.xpBarBalloonNextUnlockComponent.shootout");
            }
            else
            {
               if(param1 == UnlockComponentsLevel.sitngo-1)
               {
                  _loc2_ = LocaleManager.localize("flash.nav.top.xpBarBalloonNextUnlockComponent.sitngo");
               }
               else
               {
                  if(param1 == UnlockComponentsLevel.weeklyTourney-1)
                  {
                     _loc2_ = LocaleManager.localize("flash.nav.top.xpBarBalloonNextUnlockComponent.weeklyTourney");
                  }
               }
            }
         }
         var _loc3_:String = null;
         if(_loc2_)
         {
            _loc3_ = LocaleManager.localize("flash.nav.top.xpBarBalloonNextUnlockComponent",
               {
                  "component":_loc2_,
                  "level":param1 + 1
               });
            if(!this.unlockTooltipAnimation)
            {
               this.unlockTooltipAnimation = PokerClassProvider.getObject("UnlockTooltipAnimation");
               this.unlockTooltipAnimation.x = 93;
               this.unlockTooltipAnimation.y = 34;
               _loc4_ = new EmbeddedFontTextField(_loc3_,"Main",11,0,"center");
               _loc4_.x = 4;
               _loc4_.y = 8;
               _loc4_.wordWrap = true;
               _loc4_.autoSize = TextFieldAutoSize.CENTER;
               _loc4_.width = 120;
               _loc4_.height = 30;
               this.unlockTooltipAnimation.unlockTooltipAnimationContainer.addChild(_loc4_);
               this.unlockTooltipAnimation.addEventListener(Event.ENTER_FRAME,this.onUnlockTooltipAnimationEnterFrame);
               this.xpLeveler.addChild(this.unlockTooltipAnimation);
               this.unlockLevelInfoAnimation = PokerClassProvider.getObject("UnlockLevelInfoAnimation");
               this.unlockLevelInfoAnimation.levelBar.width = this.xpLeveler.xpBarClip.width;
               this.unlockLevelInfoAnimation.x = 10;
               this.unlockLevelInfoAnimation.y = 13;
               this.xpLeveler.addChild(this.unlockLevelInfoAnimation);
            }
            _loc2_ = _loc2_.replace(" ","_");
            PokerStatsManager.DoHitForStat(new PokerStatHit("initUnlockTooltipAnimation",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"TopNav Other UnlockTooltipAnimation o:" + _loc2_ + ":2010-08-02"));
         }
      }
      
      private function onUnlockTooltipAnimationEnterFrame(param1:Event) : void {
         if(this.unlockTooltipAnimation.currentFrame == 300)
         {
            this.unlockTooltipAnimation.removeEventListener(Event.ENTER_FRAME,this.onUnlockTooltipAnimationEnterFrame);
            this.xpLeveler.removeChild(this.unlockTooltipAnimation);
            this.unlockTooltipAnimation = null;
            this.xpLeveler.removeChild(this.unlockLevelInfoAnimation);
            this.unlockLevelInfoAnimation = null;
         }
      }
   }
}
