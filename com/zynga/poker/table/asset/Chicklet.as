package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.interfaces.IUserChicklet;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.pokerscore.models.PokerScoreModel;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.events.Event;
   import com.zynga.utils.timers.PokerTimer;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import com.zynga.draw.Box;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.table.events.TVEvent;
   import flash.display.DisplayObject;
   import com.zynga.poker.table.events.view.TVEPlaySound;
   import flash.filters.DropShadowFilter;
   import flash.display.BlendMode;
   
   public class Chicklet extends MovieClip implements IUserChicklet
   {
      
      public function Chicklet() {
         this.aSitAlign = new Array("left","left","left","right","right","right","right","right","left");
         super();
         this.clock = new Clock();
         this.clock.initClock();
         this.clock.mouseEnabled = false;
         this.clock.mouseChildren = false;
         this.clock.addEventListener(TVEvent.PLAY_SOUND_ONCE,this.onPlaySound,false,0,true);
         addChild(this.clock);
         this.assets = PokerClassProvider.getObject("ChickletAssets");
         addChild(this.assets);
         this.hitter = this.assets.hitter;
         this.chipsBG = this.assets.chipsBG;
         this.playerImg = this.assets.playerImg;
         this.playerBG = this.assets.playerBG;
         this.playerFocus = this.assets.playerFocus;
         this.score = this.assets.score;
         addChild(this.hitter);
         this.titleTF = new EmbeddedFontTextField("","Main",11,16768256);
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.multiline = false;
         this.titleTF.x = -60;
         this.titleTF.y = -49;
         this.titleTF.filters = [new DropShadowFilter(2,135)];
         addChild(this.titleTF);
         this.nameTF = new EmbeddedFontTextField("","Main",14,16777215);
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         this.nameTF.multiline = false;
         this.nameTF.x = -60;
         this.nameTF.y = -39;
         this.nameTF.blendMode = BlendMode.LAYER;
         this.nameTF.filters = [new DropShadowFilter(2,135)];
         addChild(this.nameTF);
         this.chipsTF = new EmbeddedFontTextField("","Main",11,16768256);
         this.chipsTF.autoSize = TextFieldAutoSize.LEFT;
         this.chipsTF.multiline = false;
         this.chipsTF.x = -60;
         this.chipsTF.y = 25;
         addChild(this.chipsTF);
         this.score.x = 17;
         this.score.y = -15;
         this.score.visible = false;
         this.score.enabled = false;
         this.score.buttonMode = true;
         this.score.under100.visible = false;
         this.score.lock.visible = true;
         this.score.glow.stop();
         this.score.glow.visible = false;
         this.scoreTF = new EmbeddedFontTextField("","MainCondensed",13,0);
         this.scoreTF.autoSize = TextFieldAutoSize.CENTER;
         this.scoreTF.multiline = false;
         this.scoreTF.x = 0;
         this.scoreTF.y = -2;
         this.scoreTF.width = 22;
         this.scoreTF.height = 19.7;
         this.scoreTF.filters = [new DropShadowFilter(1,90,16777215,1,1,0,0,0.76)];
         this.score.scoreNum.visible = true;
         this.score.scoreNum.addChild(this.scoreTF);
         this.scoreTF.visible = false;
         this.nameTF.visible = false;
         this.chipsTF.visible = false;
         this.chipsBG.visible = false;
         this.chipsBG.enabled = false;
         this.hitter.visible = false;
         this.playerBG.visible = false;
         this.playerBG.enabled = false;
         this.playerImg.visible = false;
         this.playerImg.enabled = false;
         this.playerFocus.visible = false;
         this.playerFocus.stop();
      }
      
      private static const UPDATE_ANIM_TIME:uint = 8000;
      
      private var assets:MovieClip;
      
      public var scoreTF:EmbeddedFontTextField;
      
      public var score:MovieClip;
      
      private var nameTF:EmbeddedFontTextField;
      
      private var titleTF:EmbeddedFontTextField;
      
      private var chipsTF:EmbeddedFontTextField;
      
      private var hitter:MovieClip;
      
      private var playerBG:MovieClip;
      
      private var playerImg:MovieClip;
      
      private var chipsBG:MovieClip;
      
      private var playerFocus:MovieClip;
      
      private var helpIcon:MovieClip;
      
      private var helpToolTip:Tooltip;
      
      private var statusBubble:MovieClip;
      
      private var _isViewer:Boolean = false;
      
      private var ldrPic:SafeImageLoader;
      
      private var lrgProfilePicLoader:SafeImageLoader;
      
      private var aSitAlign:Array;
      
      private var thisID:int;
      
      private var thisLevel:int;
      
      private var _thisZid:String;
      
      private var overwritingTitleText:String = "";
      
      private var _fadeAlpha:Number = 1.0;
      
      private var _isUnderProtection:Boolean = false;
      
      private var clock:Clock;
      
      private var _configModel:ConfigModel;
      
      private var _psModel:PokerScoreModel;
      
      public function resetTableAceLocation() : void {
      }
      
      public function clearTableAceInformationBox() : void {
      }
      
      public function set isTableAce(param1:Boolean) : void {
      }
      
      public function get tableAceImage() : Sprite {
         return null;
      }
      
      public function get isTableAce() : Boolean {
         return false;
      }
      
      public function set tableAceWinnings(param1:Number) : void {
      }
      
      public function set userTableWinnings(param1:Number) : void {
      }
      
      public function showTableAce() : void {
      }
      
      public function initChicklet(param1:int, param2:Point, param3:DisplayObjectContainer=null, param4:ConfigModel=null, param5:Boolean=false) : void {
         this.thisID = param1;
         this.position = param2;
         this._configModel = param4;
         if((this._configModel.isFeatureEnabled("scoreCard")) && (param3) && !param5)
         {
            this.score.x = this.score.x + this.x;
            this.score.y = this.score.y + this.y;
            this.score.visible = true;
            this.score.enabled = true;
            param3.addChild(this.score);
            this.score.addEventListener(MouseEvent.CLICK,this.onScoreClicked,false,0,true);
         }
      }
      
      private function loadPlayerPic(param1:String, param2:String="") : void {
         var _loc4_:URLRequest = null;
         var _loc5_:LoaderContext = null;
         this.playerBG.visible = true;
         var _loc3_:* = 0;
         while(_loc3_ < this.playerImg.numChildren)
         {
            this.playerImg.removeChildAt(0);
         }
         if(param1 != "")
         {
            if(this.ldrPic != null)
            {
               this.ldrPic = null;
            }
            _loc4_ = new URLRequest(param1);
            _loc5_ = new LoaderContext();
            _loc5_.checkPolicyFile = true;
            this.ldrPic = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
            this.ldrPic.visible = false;
            this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete,false,0,true);
            this.ldrPic.load(_loc4_,_loc5_);
         }
         if(this.lrgProfilePicLoader != null)
         {
            this.lrgProfilePicLoader = null;
         }
         if(param2)
         {
            _loc4_ = new URLRequest(param2);
            _loc5_ = new LoaderContext();
            _loc5_.checkPolicyFile = true;
            this.lrgProfilePicLoader = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
            this.lrgProfilePicLoader.visible = false;
            this.lrgProfilePicLoader.load(_loc4_,_loc5_);
         }
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         var _loc6_:* = NaN;
         this.ldrPic.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicLoadComplete);
         var _loc2_:Number = 27;
         var _loc3_:Number = 27;
         var _loc4_:Number = 54;
         var _loc5_:Number = 54;
         if(this.ldrPic.height > _loc5_ || this.ldrPic.width > _loc4_)
         {
            _loc6_ = 1 / Math.max(this.ldrPic.height / _loc5_,this.ldrPic.width / _loc4_);
            this.ldrPic.scaleY = this.ldrPic.scaleY * _loc6_;
            this.ldrPic.scaleX = this.ldrPic.scaleX * _loc6_;
         }
         this.ldrPic.x = 0 - (this.ldrPic.width >> 1) + _loc2_;
         this.ldrPic.y = 0 - (this.ldrPic.height >> 1) + _loc3_;
         this.ldrPic.visible = true;
         this.playerImg.addChild(this.ldrPic);
         this.playerBG.visible = false;
      }
      
      public function setPlayerInfo(param1:String, param2:String, param3:int, param4:String, param5:Number, param6:String, param7:Boolean=true, param8:String="", param9:Boolean=false) : void {
         this._isViewer = param9;
         this._thisZid = param6;
         if(this._psModel)
         {
            this.updatePokerScore(this._psModel);
         }
         this.updateLevel(param3,param4);
         this.updateChips(param5);
         this.setPlayerName(param2);
         this.loadPlayerPic(param1,param1);
         this.showInfo();
         if(param7)
         {
            this.playerFocus.visible = true;
            this.playerFocus.gotoAndPlay(0);
         }
         else
         {
            this.playerFocus.visible = false;
            this.playerFocus.stop();
         }
      }
      
      public function updatePokerScore(param1:PokerScoreModel) : void {
         var _loc2_:String = null;
         this._psModel = param1;
         this.score.under100.visible = false;
         this.scoreTF.visible = false;
         this.score.lock.visible = true;
         this.score.glow.visible = false;
         if(this._isViewer)
         {
            this.scoreTF.visible = param1.hasScore;
            this.score.under100.visible = (!param1.hasScore) && (!param1.hasScoreRange);
            this.score.lock.visible = (!param1.hasScore) && (param1.hasScoreRange);
            if(this._configModel.getBooleanForFeatureConfig("scoreCard","showFTUE"))
            {
               this.score.glow.visible = true;
               this.score.glow.play();
               this._configModel.getFeatureConfig("scoreCard").showFTUE = false;
            }
            if(this.scoreTF.visible)
            {
               _loc2_ = String(param1.score);
               if((param1.scoreHasChanged) && !this.score.glow.visible)
               {
                  this.score.glow.visible = true;
                  this.score.glow.play();
                  PokerTimer.instance.addAnchor(UPDATE_ANIM_TIME,this.endUpdateGlow);
               }
               this.scoreTF.text = _loc2_;
            }
         }
      }
      
      public function repositionPokerScore() : void {
      }
      
      public function showPokerScore() : void {
      }
      
      public function hidePokerScore() : void {
      }
      
      private function endUpdateGlow() : void {
         this.score.glow.stop();
         this.score.glow.visible = false;
         PokerTimer.instance.removeAnchor(this.endUpdateGlow);
      }
      
      private function setPlayerName(param1:String) : void {
         this.nameTF.text = param1.length > 10?param1.substr(0,8) + "...":param1;
         this.nameTF.x = 0 - Math.round(this.nameTF.width / 2);
         this.nameTF.y = -25 - this.nameTF.textHeight;
         this.titleTF.x = 0 - Math.round(this.titleTF.width / 2);
         this.titleTF.y = this.nameTF.y - this.titleTF.textHeight;
      }
      
      public function updateChips(param1:Number=0) : void {
         this.chipsTF.text = PokerCurrencyFormatter.numberToCurrency(param1,param1 > 999999999);
         this.chipsTF.x = 0 - Math.round(this.chipsTF.width / 2);
         this.chipsTF.y = this.chipsBG.y + Math.round((this.chipsBG.height - this.chipsTF.height) / 2);
      }
      
      public function updateLevel(param1:int=0, param2:String="") : void {
         this.thisLevel = param1;
         this.titleTF.text = param1 + " - " + param2;
         this.titleTF.x = 0 - Math.round(this.titleTF.width / 2);
         this.titleTF.y = this.nameTF.y - this.titleTF.textHeight;
         this.titleTF.visible = param1?true:false;
      }
      
      public function overrideLevelLabel(param1:String) : void {
         this.overwritingTitleText = param1;
         this.titleTF.text = param1;
         this.titleTF.x = 0 - Math.round(this.titleTF.width / 2);
         this.titleTF.y = this.nameTF.y - this.titleTF.textHeight;
      }
      
      public function setUPHelpIcon() : void {
         this.helpIcon = PokerClassProvider.getObject("UPIcon");
         this.helpIcon.visible = true;
         this._isUnderProtection = true;
         this.helpIcon.x = 0;
         this.helpIcon.y = 0;
         this.helpIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHelpIcon,false,0,true);
         this.helpIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHelpIcon,false,0,true);
         addChild(this.helpIcon);
      }
      
      private function onMouseOverHelpIcon(param1:MouseEvent) : void {
         var _loc2_:String = LocaleManager.localize("flash.table.chicklet.status.offline.tooltip.title");
         var _loc3_:String = LocaleManager.localize("flash.table.chicklet.status.offline.tooltip.body");
         this.helpToolTip = new Tooltip(220,_loc3_,_loc2_);
         this.helpToolTip.x = -this.helpToolTip.width / 2;
         this.helpToolTip.y = -this.playerImg.height / 2 - this.helpToolTip.height / 2;
         var _loc4_:Point = localToGlobal(new Point(this.helpToolTip.x,this.helpToolTip.y));
         this.helpToolTip.x = _loc4_.x;
         this.helpToolTip.y = _loc4_.y;
         if(this.thisID == 1 || this.thisID == 0)
         {
            this.helpToolTip.x = this.helpToolTip.x + 20;
         }
         this.helpToolTip.visible = true;
         parent.addChild(this.helpToolTip);
      }
      
      private function onMouseOutHelpIcon(param1:MouseEvent) : void {
         this.helpToolTip.visible = false;
         parent.removeChild(this.helpToolTip);
      }
      
      public function clearUPState() : void {
         if(this.titleTF.text == this.overwritingTitleText)
         {
            this.updateLevel(this.thisLevel);
         }
         if(this.helpIcon)
         {
            this.helpIcon.visible = false;
         }
         if(this.helpToolTip)
         {
            this.helpToolTip.visible = false;
         }
         this._isUnderProtection = false;
      }
      
      private function showInfo() : void {
         this.hitter.useHandCursor = true;
         this.hitter.enabled = true;
         this.hitter.visible = true;
         this.nameTF.visible = true;
         this.chipsTF.visible = true;
         this.chipsBG.visible = true;
         this.playerBG.visible = true;
         this.playerImg.visible = true;
         this.playerImg.visible = true;
         if(this.score.enabled)
         {
            this.score.visible = true;
         }
      }
      
      public function showSit() : void {
         this.nameTF.visible = false;
         this.chipsTF.visible = false;
         this.chipsBG.visible = false;
         this.playerBG.visible = false;
         this.playerImg.visible = false;
         this.playerFocus.visible = false;
         this.titleTF.visible = false;
         this.hitter.useHandCursor = true;
         this.hitter.enabled = true;
         this.hitter.visible = false;
         this.score.visible = false;
         if(this.helpIcon)
         {
            this.helpIcon.visible = false;
         }
      }
      
      public function showLeave() : void {
         this.hitter.useHandCursor = false;
         this.hitter.enabled = false;
         this.hitter.visible = false;
         this.nameTF.visible = false;
         this.chipsTF.visible = false;
         this.chipsBG.visible = false;
         this.playerBG.visible = false;
         this.playerImg.visible = false;
         this.playerFocus.visible = false;
         this.titleTF.visible = false;
         this.score.visible = false;
         if(this.helpIcon)
         {
            this.helpIcon.visible = false;
         }
      }
      
      public function showStatus(param1:String) : void {
         this.removeStatus();
         this.statusBubble = new MovieClip();
         this.statusBubble.x = 0;
         this.statusBubble.y = 47;
         this.statusBubble.alpha = 1;
         var _loc2_:Object = new Object();
         _loc2_.alphas = [1,1];
         _loc2_.ratios = [0,255];
         _loc2_.colors = [0,0];
         var _loc3_:EmbeddedFontTextField = new EmbeddedFontTextField(param1.toUpperCase(),"Main",12,12315135,"center");
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.x = 0 - Math.round(_loc3_.width / 2);
         _loc3_.y = -9;
         var _loc4_:Box = new Box(_loc3_.width + 12,15,_loc2_,true,true,15);
         this.statusBubble.addChild(_loc4_);
         this.statusBubble.addChild(_loc3_);
         addChild(this.statusBubble);
      }
      
      public function removeStatus() : void {
         if(this.statusBubble != null)
         {
            removeChild(this.statusBubble);
            this.statusBubble = null;
         }
      }
      
      private function onScoreClicked(param1:MouseEvent) : void {
         param1.stopPropagation();
         this.score.glow.stop();
         this.score.glow.visible = false;
         if(this._isViewer)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"ScoreCard Other Click o:ChickletMyPokerScore:2013-05-20"));
         }
         else
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"ScoreCard Other Click o:ChickletTheirPokerScore:2013-05-20"));
         }
         parent.parent.dispatchEvent(new TVEvent(TVEvent.POKER_SCORE_PRESSED,{"zid":this._thisZid}));
      }
      
      public function get isDisconnected() : Boolean {
         return this._isUnderProtection;
      }
      
      public function get seatId() : int {
         return this.thisID;
      }
      
      public function get hitbox() : DisplayObject {
         return this.hitter as DisplayObject;
      }
      
      public function get offsetX() : Number {
         return 0;
      }
      
      public function get offsetY() : Number {
         return 0;
      }
      
      public function get position() : Point {
         return new Point(this.x,this.y);
      }
      
      public function set position(param1:Point) : void {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function startClock(param1:Number, param2:Number) : void {
         this.clock.startCount(param1,param2);
      }
      
      public function stopClock() : void {
         this.clock.stopCount();
      }
      
      public function resetClock() : void {
         this.clock.resetClock();
      }
      
      public function onPlaySound(param1:TVEPlaySound) : void {
         parent.parent.dispatchEvent(param1);
      }
      
      public function showWinState() : void {
      }
      
      public function dispose() : void {
         removeChild(this.clock);
         this.clock.removeEventListener(TVEvent.PLAY_SOUND_ONCE,this.onPlaySound);
         this.clock = null;
         if(this.score.enabled)
         {
            this.score.scoreNum.removeChild(this.scoreTF);
            this.score.removeEventListener(MouseEvent.CLICK,this.onScoreClicked);
         }
         this.score = null;
         this.scoreTF = null;
         if(this.ldrPic)
         {
            if(this.playerImg.contains(this.ldrPic))
            {
               this.playerImg.removeChild(this.ldrPic);
            }
            this.ldrPic = null;
         }
         if(this.helpIcon)
         {
            this.playerImg.removeChild(this.helpIcon);
            this.helpIcon = null;
         }
         this.playerImg = null;
         if(this.statusBubble)
         {
            removeChild(this.statusBubble);
            this.statusBubble = null;
         }
         if(this.helpIcon)
         {
            this.helpIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHelpIcon);
            this.helpIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHelpIcon);
            this.helpIcon = null;
         }
         removeChild(this.hitter);
         this.hitter = null;
         removeChild(this.assets);
         this.assets = null;
         this.chipsBG = null;
         this.playerBG = null;
         this.playerFocus = null;
         removeChild(this.nameTF);
         this.nameTF = null;
         removeChild(this.chipsTF);
         this.chipsTF = null;
         removeChild(this.titleTF);
         this.titleTF = null;
         this.lrgProfilePicLoader = null;
      }
      
      public function hideWinState() : void {
      }
   }
}
